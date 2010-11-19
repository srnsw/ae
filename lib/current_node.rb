#
# The CurrentNode class represents the document node (top level, 
# context, term or class) currently selected by the user. 
#
# The @node variable is a pointer to the underlying XML element for the 
# current node. The @elements variable is a register of sub-elements 
# contained by the node and is primarily used to ensure valid ordering
# of XML elements.
#
class CurrentNode
  attr_reader :node
  
  # CurrentNodes are initialized by the reparse method of the RDADoc class.
  # A path will only be given if an XML document is edited manually in the
  # source view.
  def initialize(rdadoc, path)
    @rdadoc = rdadoc
    @xml_doc = @rdadoc.xml_doc
    path = @xml_doc.xpath(path)[0] if path
    path ? @node = path : @node = @xml_doc.root
    update_elements
  end

  # Custom attr_writer for @node. When a user changes node, 
  # change the current node and update the elements list.
  def node=(node)
    @node = node
    update_elements
  end

  def reviewpath
    Navigate::node_to_reviewpath(@node)
  end
  
  def treepath
    Navigate::node_to_treepath(@node) 
  end
  
  # Used for updating status bar. Returns string.
  def breadcrumb
    breadcrumb = "Path:  " + Navigate::get_breadcrumb(@node)
  end
  
  # The update_elements method keeps track of the sub-elements within a node in
  # the @elements array. This is allows quick checking of contents of nodes
  # and enables correct placement of new sub-elements within a node.
  # Returns nil.
  def update_elements
    case @node.name
      when 'Context'
        @elements = [['ContextTitle', false], ['ContextContent', false], 
        ['Comment', false]]
      when 'Term'
        @elements =  [['ID', false], ['TermTitle', false], ['TermDescription', false],
        ['DateRange', false], ['Status', false],  ['LinkedTo', false], ['Comment', false]]
      when 'Class'
        @elements = [['ID', false], ['ClassTitle', false], ['ClassDescription', false], 
        ['Disposal', false], ['Justification', false], ['DateRange', false], ['Status', false],
        ['LinkedTo', false], ['Comment', false]]
      else 
        @elements = [['ID', false], ['AuthorityTitle', false], ['Scope', false],
        ['DateRange', false], ['Status', false],  ['LinkedTo', false], ['Comment', false],
        ['Context', false]]
    end
    @node.xpath('*').each do |child| 
      match = @elements.assoc(child.name)
      match[1] = true if match
    end
    nil
  end

  def exists?(element_name)
    @elements.assoc(element_name)[1]
  end

  def multiple_exists?(*element_names)
    response = false
    element_names.each {|name| response = true if @elements.assoc(name)[1]}
    response
  end

  # Test where to insert new sub-element by checking against the 
  # @elements array. Returns string (name of a sub-element) or false.
  def insert_before?(element_name)
    loc = @elements.index(@elements.assoc(element_name))
    new_array = @elements.values_at(loc..-1)
    insert_loc = new_array.rassoc(true)
    insert_loc ? insert_loc[0] : false
  end
  
  # Retrieve content of a sub-element (that either has the node as its parent
  # or is the child of another sub-element). Returns string or nil.
  def get_content(el_name, parent_name=nil)
    if parent_name.nil?
      el = @node.xpath("rda:#{el_name}", Namespace::RDA)[0]
    else
      parent = @node.xpath("rda:#{parent_name}", Namespace::RDA)[0]
      el = parent.xpath("rda:#{el_name}", Namespace::RDA)[0] if parent
    end
    el ? el.text : nil
  end

  # Retrieve content of an attribute (either of the node itself, one of the
  # node's sub-elements, or a child element of one of the node's sub-elements).
  # Returns string or nil.
  def get_attribute(el_name, attr_name, parent_name=nil)
    if el_name.nil?
      el = @node
    elsif parent_name.nil?
      el = @node.xpath("rda:#{el_name}", Namespace::RDA)[0]
    else
      parent = @node.xpath("rda:#{parent_name}", Namespace::RDA)[0]
      el = parent.xpath("rda:#{el_name}", Namespace::RDA)[0] if parent
    end
    el ? el[attr_name] : nil
  end
  
  # Retrieve content of a boolean attribute (e.g. 'circa' attribute on a date range).
  # Returns boolean.
  def get_state(el_name, attr_name, parent_name=nil)
    attribute = get_attribute(el_name, attr_name, parent_name)
    attribute == 'true' or attribute == '1' ? true : false
  end

  # Custom empty test for Nokgorigi XML::Node. A node is considered empty if it 
  # has no content (ignoring whitespace) and no attributes. Returns boolean. 
  def empty?(node)
    if node.content.strip.length + node.xpath('*').length + node.attribute_nodes.length > 0
      false
    else
      true
    end
  end
  
  # Add a new Nokogiri XML::Node to a document. If a context parameter is
  # given then the new element is added under that sub-element, otherwise
  # the current @node is context. Position is either 0 or 1 (first or last) - this
  # paramater is only used for correct ordering of start and end dates within
  # the DateRange widget.
  # Returns the new Nokogiri XML::Node.
  def add_element(el_name, context=nil, position=nil)
    context = @node unless context
    new_element = Nokogiri::XML::Node.new(el_name, @xml_doc)
    if position
      if position == 0 && context.xpath("*")[0]
        element = context.xpath("*")[0].add_previous_sibling(new_element)
      else
        element = context << new_element
      end
    else
      loc = insert_before?(el_name)
      if loc
        loc = context.xpath("rda:#{loc}", Namespace::RDA)[0]
        element = loc.add_previous_sibling(new_element)
      elsif context.xpath("rda:Term | rda:Class", Namespace::RDA)[0]
        element = context.xpath("rda:Term | rda:Class", 
        Namespace::RDA)[0].add_previous_sibling(new_element)
      else
        element = context << new_element
      end
    end
  end

  # Update method for simple fields such as TermTitle and ItemNo.
  # If there is content, add the element if it doesn't exist, then update its
  # content. If an empty string is given as content, check if the element
  # exists and if so delete. Finally, update the @elements array and mark
  # the current document as changed. Returns nil.
  def update_element(el_name, content)
    if content.length > 0
      if exists?(el_name)
        element = @node.xpath("rda:#{el_name}", Namespace::RDA)[0]
        element.content = content
      else
        element = add_element(el_name)
        element.content = content
      end
    else
      if exists?(el_name)
        element = @node.xpath("rda:#{el_name}", Namespace::RDA)[0]
        element.content = content
        element.unlink if empty?(element)
      end
    end
    update_elements
    @rdadoc.trigger_change
  end

  # Simple update. If no 'el_name' parameter is given, then the attribute
  # belongs on the @node (e.g. 'publish' attribute). If there is content, add
  # the attribute (and element) if it doesn't exist, then update its content.
  # If an empty string, delete attribute/element as necessary. Finally, update
  # the @elements array and mark the current document as changed.
  # Returns nil.
  def update_attribute(el_name, attr_name, content)
    if content.length > 0 
      if el_name.nil? 
        element = @node
      elsif exists?(el_name)
        element = @node.xpath(el_name.insert(0, 'rda:'), Namespace::RDA)[0]
      else
        element = add_element(el_name)
      end
      element[attr_name] = content
    else  
      if el_name.nil?
        @node.remove_attribute(attr_name) if @node[attr_name]
      elsif exists?(el_name)
        element = @node.xpath("rda:#{el_name}", Namespace::RDA)[0]
        element.remove_attribute(attr_name) if element[attr_name]
        element.unlink if empty?(element)
      end
    end
    update_elements
    @rdadoc.trigger_change
  end

  # Update elements that do not sit directly beneath the @node (e.g. start
  # date elements sit under date range elements). Same as regular update, 
  # but add or delete parent element where necessary.
  # Returns nil.
  def update_nested_element(parent_name, el_name, content, position)
    if content.length > 0
      if exists?(parent_name)
        parent = @node.xpath("rda:#{parent_name}", Namespace::RDA)[0]
        element = parent.xpath("rda:#{el_name}", Namespace::RDA)[0]
        if element
          element.content = content
        else
          element = add_element(el_name, parent, position)
          element.content = content
        end
      else
        parent = add_element(parent_name)
        element = add_element(el_name, parent, position)
        element.content = content
      end
    else
      if exists?(parent_name)
        parent = @node.xpath("rda:#{parent_name}", Namespace::RDA)[0]
        element = parent.xpath("rda:#{el_name}", Namespace::RDA)[0]
        if element
          element.content = content
          element.unlink if empty?(element)
        end
        parent.unlink if empty?(parent)
      else
        return nil
      end
    end
    update_elements
    @rdadoc.trigger_change
  end

  # Update attributes on elements that do not sit directly beneath the @node
  # (e.g. circa attribute on start and end dates). Same as regular update, 
  # but add or delete parent element where necessary.
  # Returns nil.
  def update_nested_attribute(parent_name, el_name, attr_name, content, position)
    if content.length > 0
      if exists?(parent_name)
        parent = @node.xpath("rda:#{parent_name}", Namespace::RDA)[0]
        element = parent.xpath("rda:#{el_name}", Namespace::RDA)[0]
        element = add_element(el_name, parent, position) unless element
        element[attr_name] = content
      else
        parent = add_element(parent_name)
        element = add_element(el_name, parent, position)
      end
      element[attr_name] = content
    else  
      if exists?(parent_name)
        parent = @node.xpath("rda:#{parent_name}", Namespace::RDA)[0]
        element = parent.xpath("rda:#{el_name}", Namespace::RDA)[0]
        if element
        element.remove_attribute(attr_name) if element[attr_name]
        element.unlink if empty?(element)
        end
        parent.unlink if empty?(parent)
      else
        return nil
      end
    end
    update_elements
    @rdadoc.trigger_change
  end
  
  # Create a Nokogiri::XML::DocumentFragment on the current document.
  # Returns the fragment's element e.g. <p><Paragraph>1</P...><P...>2</P...></p>
  def create_paragraphs(content)
    fragment = Nokogiri::XML::DocumentFragment.new(@xml_doc)
    parser = Nokogiri::XML::SAX::Parser.new(Nokogiri::XML::FragmentHandler.new(fragment, content))
    parser.parse(content)
    fragment.xpath('*')[0]
  end
  
  # Update method for elements that contain paragraphs (e.g. TermDescription).
  # If no content given, delete any paragraphs and then delete element if it is empty.
  # Otherwise, check if the parent element already exists, if it does, delete
  # any existing paragraphs and then add new paragraphs before any other 
  # content (this is because Context elements contain source elements and
  # Description elements have see reference elements, both of which come
  # after paragraphs). Returns nil. 
  def update_paragraphs(el_name, content, empty)
    if empty
      if exists?(el_name)
        element = @node.xpath("rda:#{el_name}", Namespace::RDA)[0]
        paragraphs = element.xpath("rda:Paragraph", Namespace::RDA)
        paragraphs.unlink
        element.unlink if empty?(element)
      else
        return nil
      end
    else
      node = create_paragraphs(content)
      if exists?(el_name)
        element = @node.xpath("rda:#{el_name}", Namespace::RDA)[0]
        paragraphs = element.xpath("rda:Paragraph", Namespace::RDA)
        paragraphs.unlink
        loc = element.xpath("*")[0]
        if loc
           node.xpath('*').each {|paragraph| loc.add_previous_sibling(paragraph)}
        else
           node.xpath('*').each {|paragraph| element << paragraph}
        end
      else
        element = add_element(el_name)
        node.xpath('*').each {|paragraph| element << paragraph}
      end 
    end
    update_elements
    @rdadoc.trigger_change
  end
  
  # Used by multi-list widgets to add new elements either directly under
  # the current node or beneath a sub-element (the context parameter).
  # Returns nil.
  def multi_add_element(new_element, context)
    if context
      node = @node.xpath("rda:#{context}", Namespace::RDA)[0]
      node = add_element(context) unless node
      el = node << new_element
    else
      name = new_element.name
      if exists?(name)
        loc = @node.xpath("rda:#{name}", Namespace::RDA)[-1]
        el = loc.add_next_sibling(new_element)
      else
        loc = insert_before?(name)
        if loc
          el = @node.xpath("rda:#{loc}", 
          Namespace::RDA)[0].add_previous_sibling(new_element)
        elsif @node.xpath("rda:Term | rda:Class", Namespace::RDA)[0]
          el = @node.xpath("rda:Term | rda:Class", 
          Namespace::RDA)[0].add_previous_sibling(new_element)
        else
          el = @node << new_element
        end
      end
    end
    update_elements
    @rdadoc.trigger_change
  end
  
  # Shared by the multi-list widget methods for replacing and moving nodes. 
  # Returns a Nokogiri XML::Node.
  def get_multi_node(context, name, pos)
    if context
      context = @node.xpath("rda:#{context}", Namespace::RDA)[0]
    else
      context = @node
    end
    if name
      node = context.xpath("rda:#{name}", Namespace::RDA)[pos]
    else
      node = context.xpath("*")[pos]
    end
  end
  
  # Used by multi-list widgets to swap elements when a user updates content.
  # Returns nil.
  def multi_replace_element(new_element, context, name, pos)
    old_node = get_multi_node(context, name, pos)
    old_node.replace(new_element)
    @rdadoc.trigger_change
  end
  
  # Used by multi-list widgets to re-order elements. Returns nil.
  def multi_move_up(list, context, name, pos)
    node = get_multi_node(context, name, pos)
    node_before = node.xpath('preceding-sibling::*')[-1]
    return nil unless node_before
    # The following test is included because testing revealed that moving
    # sometimes results in badly ordered xml and crashing.
    # An alternative may be to add or subtract one from the pos variable 
    # and thereby avoid the troublesome 'preceding-sibling'/'following-sibling' axes.
    if node.name == node_before.name or context == 'Status'
      node_before.add_previous_sibling(node)
      list.update
      @rdadoc.trigger_change
    end
  end

  # Used by multi-list widgets to re-order elements. Returns nil.
  def multi_move_down(list, context, name, pos)
    node = get_multi_node(context, name, pos)
    node_after = node.xpath('following-sibling::*')[0]
    return nil unless node_after
    if node.name == node_after.name or context == 'Status'
      node_after.add_next_sibling(node)
      list.update
      @rdadoc.trigger_change
    end
  end

  # Used by multi-list widgets to re-order elements. Returns nil.
  def multi_delete(list, context, name, pos)
    node = get_multi_node(context, name, pos)
    node.unlink
    list.update
    update_elements
    @rdadoc.trigger_change
  end

  # Navigation (home, forwards, backwards, and searching) is handled
  # separately by each view. This method is shared by the navigation methods
  # of the source and edit form views. Returns nil.
  def navigate(direction, path=nil)
    case direction
      when :home then @node = @xml_doc.root
      when :forward then @node = Navigate::node_after(@node)
      when :backward then @node = Navigate::node_before(@node)
      when :path then @node = Navigate::treepath_to_node(@xml_doc.root, 
      path.split(":").collect {|ary|ary.to_i})
    end
    update_elements
  end
  
  # Sets @node to the first term or class within the previously selected node.
  # If no terms or classes, node won't be changed. Returns nil.
  def first_term_class
    @node = Navigate::node_term_class(@node)
    update_elements
  end
end
