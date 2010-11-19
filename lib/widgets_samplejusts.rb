#
# JustificationDialog pops when a user hits CTR-J in a disposal class field
# It allows selection of a stock disopsal class (drawn from the samplejustifications.xml
# file).
#
class JustificationDialog < Gtk::Dialog
  def initialize
    super("Sample Justifications", nil, Gtk::Dialog::MODAL|Gtk::Dialog::NO_SEPARATOR,
    [Gtk::Stock::APPLY, 0], [Gtk::Stock::CANCEL, 1])
    @treeview = JustificationTreeview.new
    vbox.add(Gtk::ScrolledWindow.new.add(@treeview))
    set_size_request(570, 400)
    set_window_position(Gtk::Window::POS_MOUSE)
  end
  
  # Returns a String.
  def get_text
    @treeview.get_text  
  end
end

#
# JustificationTreeview builds the tree view for the sample justification dialogue.
#
class JustificationTreeview < Gtk::TreeView
  def initialize
    @model = Gtk::TreeStore.new(String)
    build_tree
    super(@model)
    text = Gtk::CellRendererText.new.set_wrap_width(500).set_wrap_mode(Pango::WRAP_WORD_CHAR)
    @column = Gtk::TreeViewColumn.new('Sample Justifications', text, :text => 0)
    append_column(@column)
    set_rules_hint(true)
    selection.set_mode(Gtk::SELECTION_MULTIPLE)
  end
  
  # Build the justifications tree view. Returns nil.
  def build_tree
    xml_doc = Nokogiri::XML(File.new('data/samplejustifications.xml'))
    categories = xml_doc.root.search('category')
    categories.each {|cat| make_tree(cat)}
    nil
  end
  
  # Returns nil.
  def make_tree(cat)
    parent = add_iter(nil, cat["name"])
    justifications = cat.search('justification')
    justifications.each {|just| add_iter(parent, just.text)}
    nil
  end
  
  # Returns Gtk::TreeIter.
  def add_iter(parent, text)
    iter = @model.append(parent)
    iter.set_value(0, text)
  end
  
  # Returns a String.
  def get_text
    texts = Array.new
    selection.selected_each {|model, path, iter| texts << iter[0] if path.indices.length > 1}
    texts.empty? ? nil : texts.join("\n")
  end
end



 





