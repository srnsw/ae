#
# The RDADoc class represents the currently selected XML document.
#
# This class has methods for parsing XML documents, refreshing the current
# view (edit form, review or source), and editing the node tree of XML documents
# (i.e. adding, deleting, and moving context, term and class nodes).
#
# The @xml_doc variable is a pointer to the underlying Nokogiri::XML::Document.
# The @current_node variable points to the currently selected document node.
# The @page variable points to the current view (edit form, review or source), 
# which is packed into the @view variable (a Gtk::HBox).
#
class RDADoc
  attr_accessor :xml_doc, :file_path, :xml_changed, :tree_pane, :review_pane 
  attr_reader :main, :current_node, :view, :page, :view_no, :errors

  @@copy_node = nil

  def initialize(path, main)
    @file_path, @main = path, main
    @xml_changed = false
    on_save
    @view = Gtk::HBox.new
    @file_path == :new ? file = Namespace::NEW : file = File.open(@file_path) {|f| f.read}
    reparse(file)
    @tree_pane = 200
    @review_pane = 200
    @status_message = ''
    update_view(0)
  end
  
  # Returns nil.
  def refresh
    @main.refresh
  end
  
  # Returns a hash of preferences.
  def preferences
    @main.preferences
  end
  
  # When a user switches between notepad pages, reset the radio buttons
  # and update the statusbar message. Returns nil.
  def main_page_change
    @main.page_change(self)
  end
  
  # Read and write methods for the @@copy_node class variable. This variable
  # allows copying and pasting of nodes between documents.
  def copy_node
    @@copy_node
  end
  
  # Returns nil.
  def copy_node=(copy_node)
    @@copy_node = copy_node
    nil
  end

  # Mark the XML document as having been changed. This allows prompting
  # users when they attempt to close without saving an altered document.
  # Returns nil.
  def trigger_change
    @xml_changed = true
    nil
  end
  
  # Check an MD5 checksum of a file against a stored checksum. This checks
  # whether another user or process has altered the file a user is working on.
  # Returns boolean.
  def file_changed?
    if @file_path == :new
      false
    else
      if File.readable?(@file_path)
        checksum = Digest::MD5.hexdigest(File.read(@file_path))
        checksum == @checksum ? false : true
      else
        true
      end
    end
  end
  
  # Store a checksum for the current XML file. Do this on init and whenever
  # file is saved. Returns nil.
  def on_save
    @checksum = Digest::MD5.hexdigest(File.read(@file_path)) unless @file_path == :new
    nil
  end
  
  # When a user changes view check first whether there is a valid
  # @current_node - if not the XML is either corrupt or does not validate.
  # Force page to be replaced during XML edit transform even if does not validate.
  # Returns nil.
  def update_view(view_no, force=false)
    if @current_node
      @view_no = view_no
      replace_page  
    else
      if @view_no #if document is already open and user is already in sourceview
        if force # force a page change during XML edit transform even if invalid
          replace_page
        else
          show_errors
          @main.toggle_view(2)
        end
      else
        @view_no = 2  #on opening a non-valid file, open file in sourceview
        replace_page
      end
    end
  end
  
  # Pages are either form, review or source views and are appended as 
  # the only child of @view (a Gtk::HBox).
  # When a user changes view, destroy the old page and append the new.
  # Returns nil.
  def replace_page
    old_page = @view.children[0]
    if old_page
      @view.remove(old_page)
      old_page.destroy
    end
    case @view_no
      when 0 then @page = FormView.new(self)
      when 1 then @page = ReviewView.new(self)
      when 2 then @page = SourceView.new(self)
    end
    @view << @page
    @view.show_all
    nil
  end
  
  # Popup XML or validation errors. Returns nil.
  def show_errors
    return nil unless @errors
    if @errors[0]
      errors = @errors[1].join("\n")
      Utils::error_dialog("This XML file has validation errors:\n#{errors}", @main)
    else
      errors = @errors[1].join("")
      Utils::error_dialog("This is not a well-formed XML file:\n#{errors}", @main)
    end
  end

  # Update the status bar message. Returns nil.
  def update_status_message
    if @current_node
      @status_message = @current_node.breadcrumb
      @main.update_statusbar(@status_message)
    end
  end

  # Parse an XML document.
  # Returns nil
  def reparse(obj, path = nil)
    @xml_doc = parse_xml(obj)
    if @xml_doc
       create_current_node(path)
    else
      @current_node = nil
    end
    nil
  end
  
  # Validate and, if valid, create a new current_node object.
  # Returns nil.
  def create_current_node(path)
    if valid?
      @current_node = CurrentNode.new(self, path)
      @errors = nil
    else
      @current_node = nil
    end
    nil
  end

  # Parse an XML document. Return a Nokogiri::XML::Document or false.
  def parse_xml(obj)
    xmldoc = Nokogiri::XML(obj, nil, nil,
    Nokogiri::XML::ParseOptions::RECOVER | Nokogiri::XML::ParseOptions::NOBLANKS)
    if xmldoc.errors
      if xmldoc.errors.length > 0
        @errors = [false, xmldoc.errors]
        xmldoc = false 
      end
    else
      @errors = [false, ['cannot parse file']]
      xmldoc = false
    end
    xmldoc  
  end

  # If validation is turned on (domain.rb), validate against a schema and store
  # errors. Otherwise, check if the document has the right root node.
  # Returns boolean.
  def valid?
    if @main.srnsw_xsd
      errors = @main.srnsw_xsd.validate(@xml_doc).collect do |error|
        'Line: ' + error.line.to_s + "\n" + 'Error: ' + error.message
      end
      if errors.empty?
        true
      else
        @errors = [true, errors]
        false
      end
    else
      if @xml_doc.root.name == 'Authority'
        true
      else
        @errors = [true, ["The root element must be named 'Authority'."]]
        false
      end
    end
  end
  
  # Called by the pop-up menu belonging to the edit form's tree menu.
  # Add a set of terms (defined in domain.rb) and a disposal class to the XML
  # document.
  # Returns nil.
  def term_set(terms, path)
    terms = terms.dup
    if path
      context = Navigate::treepath_to_node(@xml_doc.root, path)
    else
      context = @xml_doc.root
      path = [2]
    end
    top_term = terms.shift
    if top_term
      top_element = Nokogiri::XML::Node.new('Term', @xml_doc)
      top_element = context << top_element
      top_element['type'] = top_term
      context = top_element
    end
    terms.each do |term|
      element = Nokogiri::XML::Node.new('Term', @xml_doc)
      context = context << element
      context['type'] = term    
    end
    disposal_class = Nokogiri::XML::Node.new('Class', @xml_doc)
    context << disposal_class
    trigger_change
    @current_node.node = top_element
    @page.treemenu.add_child(@current_node.node, path)
    @page.treemenu.remote_child_activate(@current_node)
    @page.treemenu.expand_current_row
  end

  # Called by the pop-up menu belonging to the edit form's tree menu.
  # Add a set of context elements (defined in domain.rb) to the XML document.
  # Returns nil.
  def context_set(set)
    set[1].each do |title|
      context = Nokogiri::XML::Node.new('Context', @xml_doc)
      context['type'] = set[0]
      context_title = Nokogiri::XML::Node.new('ContextTitle', @xml_doc)
      context_title.content = title
      context << context_title
      element = add_context_node(context)
      @page.treemenu.add_child(element, nil)
    end
    trigger_change
    @current_node.node = @xml_doc.root.xpath(
    "rda:Context[rda:ContextTitle='#{set[1][0]}']", Namespace::RDA)[0]
    @page.treemenu.remote_child_activate(@current_node)
  end
  
  # Add a new context element to a document. Add before any term or class
  # or, otherwise, as the last node.
  # Returns a Nokogiri::XML::Node.
  def add_context_node(node)
    loc = @xml_doc.root.xpath('rda:Class | rda:Term', Namespace::RDA)[0]
    loc ? loc.add_previous_sibling(node) : @xml_doc.root << node
  end
  
  # Called by the pop-up menu belonging to the edit form's tree menu.
  # Add a new context element to the XML document. Add before any term
  # or class or, otherwise, as the last node.
  # Returns nil.
  def context_child
    context = Nokogiri::XML::Node.new('Context', @xml_doc)
    context['type'] = @main.preferences[:context_type] unless @main.preferences[:context_type].empty?
    @current_node.node = add_context_node(context)
    trigger_change
    @page.treemenu.add_child(@current_node.node, nil)
    @page.treemenu.remote_child_activate(@current_node)
  end

  # Called by the pop-up menu belonging to the edit form's tree menu.
  # Add a new context element to the XML document as a sibling to path.
  # Returns nil.
  def context_sibling(path)
    sibling = Navigate::treepath_to_node(@xml_doc.root, path)
    context = Nokogiri::XML::Node.new('Context', @xml_doc)
    context['type'] = @main.preferences[:context_type] unless @main.preferences[:context_type].empty?
    sibling.add_next_sibling(context)
    @current_node.node = context
    trigger_change
    @page.treemenu.add_sibling(@current_node.node, path)
    @page.treemenu.remote_activate(@current_node)
  end

  # Called by the pop-up menu belonging to the edit form's tree menu.
  # Add a new element (term or class) to the XML document as a child to path.
  # Returns nil.
  def new_child(name, path)
    parent = Navigate::treepath_to_node(@xml_doc.root, path)
    child = Nokogiri::XML::Node.new(name, @xml_doc)
    child = parent << child
    trigger_change
    @current_node.node = child
    @page.treemenu.add_child(@current_node.node, path)
    @page.treemenu.remote_child_activate(@current_node)
  end

  # Called by the pop-up menu belonging to the edit form's tree menu.
  # Add a new element (term or class) to the XML document as a sibling to path.
  # Returns nil.
  def new_sibling(name, path)
    new_node = Nokogiri::XML::Node.new(name, @xml_doc)
    sibling = Navigate::treepath_to_node(@xml_doc.root, path)
    sibling.add_next_sibling(new_node)
    @current_node.node = new_node
    trigger_change
    @page.treemenu.add_sibling(@current_node.node, path)
    @page.treemenu.remote_activate(@current_node)
  end
  
  # Called by the pop-up menu belonging to the edit form's tree menu.
  # Copy and delete a node (context, term or class). Returns nil.
  def cut(path)
    cut_node = Navigate::treepath_to_node(@xml_doc.root, path)
    @@copy_node = cut_node.dup
    delete_node(cut_node)
  end
  
  # Called by the pop-up menu belonging to the edit form's tree menu.
  # Copy a node (context, term or class). Returns nil.
  def copy(path)
    copy_node = Navigate::treepath_to_node(@xml_doc.root, path)
    @@copy_node = copy_node.dup
    nil
  end

  # Called by the pop-up menu belonging to the edit form's tree menu.
  # Paste a node (context, term or class) as a child to path. Re-set the 
  # copy node variable to a duplicate to allow multiple pastes.
  # Returns nil.
  def paste_child(path)
    parent = Navigate::treepath_to_node(@xml_doc.root, path)
    if @@copy_node.name == 'Context'
      child = add_context_node(@@copy_node)
    else
      child = parent << @@copy_node
    end
    @current_node.node = child
    @@copy_node = child.dup
    trigger_change
    @page.treemenu.add_child(child, path)
    @page.treemenu.remote_child_activate(@current_node)
  end

  # Called by the pop-up menu belonging to the edit form's tree menu.
  # Paste a node (context, term or class) as a sibling to path. Re-set the 
  # copy node variable to a duplicate to allow multiple pastes.
  # Returns nil.
  def paste_sibling(path)
    sibling = Navigate::treepath_to_node(@xml_doc.root, path)
    brother = sibling.add_next_sibling(@@copy_node)
    @current_node.node = brother
    @@copy_node = brother.dup
    trigger_change
    @page.treemenu.add_sibling(brother, path)
    @page.treemenu.remote_activate(@current_node)
  end
  
  # Called by the pop-up menu belonging to the edit form's tree menu.
  # Move a node (context, term or class) up.
  # Returns nil.
  def move_up(path)
    node = Navigate::treepath_to_node(@xml_doc.root, path)
    node_before = node.xpath('preceding-sibling::*')[-1]
    return unless node_before
    # During testing, it was found that moving nodes with these methods can cause badly ordered xml.
    # I've found it hard to trace this down. Hence the conditional test that follows this comment.
    # An alternative may be:
    # path[-1] = path[-1] - 1 
    # node_before = Navigate::treepath_to_node(@xml_doc.root, path)
    if ['Context', 'Term', 'Class'].index(node_before.name)
      @page.treemenu.swap(path, true)
      @current_node.node = node_before.add_previous_sibling(node)
      trigger_change
      @page.treemenu.remote_activate(@current_node)
    end
  end

  # Called by the pop-up menu belonging to the edit form's tree menu.
  # Move a node (context, term or class) down.
  # Returns nil.
  def move_down(path)
    node = Navigate::treepath_to_node(@xml_doc.root, path)
    node_after = node.xpath('following-sibling::*')[0]
    return unless node_after
    if ['Context', 'Term', 'Class'].index(node_after.name)
      @page.treemenu.swap(path, false)
      @current_node.node = node_after.add_next_sibling(node)
      trigger_change
      @page.treemenu.remote_activate(@current_node)
    end
  end
  
  # Confirm before deleting a node. Returns nil.
  def delete(path)
    if Utils::confirm_dialog("Deleting removes this element along with all of its content.\nPlease confirm that you would like to proceed.", @main)
      node = Navigate::treepath_to_node(@xml_doc.root, path)
      delete_node(node)
    end
  end

  # Delete a node and reset the current node. Returns nil.
  def delete_node(node)
    if node.name == 'Context'
      node_before = node.xpath('preceding-sibling::*[self::rda:Context]', Namespace::RDA)[-1]
      node_after = node.xpath('following-sibling::*[self::rda:Context]', Namespace::RDA)[0]
    else
      node_before = node.xpath('preceding-sibling::*[self::rda:Term or self::rda:Class]', Namespace::RDA)[-1]
      node_after = node.xpath('following-sibling::*[self::rda:Term or self::rda:Class]', Namespace::RDA)[0]
    end
    if node_before
      @current_node.node = node_before
    elsif node_after
      @current_node.node = node_after
    else
      @current_node.node = node.parent
    end
    @page.treemenu.delete_iter(node)
    node.unlink
    trigger_change
    @page.treemenu.remote_activate(@current_node)
  end
end 


