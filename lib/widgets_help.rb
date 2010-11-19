#
# The HelpDialog class repersents the help widget. Help text is generated 
# from an xml file in the data directory, 'help.xml'. This file is parsed to create
# sections, pages, and text.
#
class HelpDialog < Gtk::Dialog
  
  def initialize(parent)
    super('Help Menu', parent, Gtk::Dialog::MODAL|Gtk::Dialog::NO_SEPARATOR,
    [Gtk::Stock::CANCEL, 0])
    set_size_request(800, 500)
    @xml_doc = Nokogiri::XML(File.new('data/help.xml'))
    @helptree = HelpTreeview.new(@xml_doc)
    @helptree.signal_connect('row-activated') {|view, path, column| select_page(
    path.indices.dup)}
    @helptree.selection.signal_connect('changed') {|selection| on_select(selection)}
    scroll = Gtk::ScrolledWindow.new.set_policy(Gtk::POLICY_AUTOMATIC,
    Gtk::POLICY_AUTOMATIC).add(@helptree)
    @hpane = Gtk::HPaned.new.add1(scroll.set_size_request(200, -1))
    @helptree.remote_select([0])
    vbox.add(@hpane)
    show_all
  end
  
  # When a user selects an item in the tree menu, change the help page.
  # Returns nil.
  def on_select(selection)
    iter = selection.selected
    if iter
      path = iter.path
      select_page(path.indices.dup)
    end
  end
  
  # Change the help page.
  # Returns nil.
  def select_page(path)
    @helppage.destroy if @helppage  
    if path.length < 2
      @helptree.expand_row(Gtk::TreePath.new(path[0]), false)
      path = path.push(0)
    end
    @helppage = HelpPage.new(@xml_doc, path)
    @hpane.add2(@helppage)
    show_all
    nil
  end
end

#
# HelpTreeView represents the help widget's tree menu.
#
class HelpTreeview < Gtk::TreeView
  
  def initialize(xml_doc)
    @xml_doc = xml_doc
    @model = Gtk::TreeStore.new(String)
    super(@model)
    set_headers_visible(false)
    build_tree
    text = Gtk::CellRendererText.new
    @column = Gtk::TreeViewColumn.new('', text, :text => 0)
    append_column(@column)
  end
  
  # Construct the treemenu by parsing the XML file.
  # Returns nil.
  def build_tree
    sections = @xml_doc.root.search("section")
    sections.each {|sect| make_tree(sect)}
    nil
  end
  
  # Returns nil.
  def make_tree(sect)
    parent = add_iter(nil, sect["heading"])
    pages = sect.search("page")
    pages.each {|page| add_iter(parent, page["heading"])}
    nil
  end
  
  # Returns a tree iter.
  def add_iter(parent, text)
    iter = @model.append(parent)
    iter.set_value(0, text)
  end
  
  # Called during initialization of the help dialogue to load a new page.
  # Returns nil.
  def remote_select(path)
    iter = @model.get_iter(Gtk::TreePath.new(path.join(':')))
    selection.select_iter(iter)
    nil
  end
end

#
# The HelpPage class represents the actual page of help text. It contains
# section and page labels and paragraphs of text.
# 
class HelpPage < Gtk::VBox
  
  def initialize(xml_doc, path)
    super(false, 0)
    contents = get_help_contents(xml_doc, path)
    pack_start(contents[0], false, false, 5)
    pack_start(contents[1], false, false, 10)
    pack_start(contents[2], true, true, 0)
  end
  
  # Returns an array containing two Gtk::Label widgets and a Gtk::TextView.
  def get_help_contents(xml_doc, path)
    sections = xml_doc.root.search("section")
    section = sections[path[0]]
    pages = section.search("page")
    page = pages[path[1]]
    section_label = Gtk::Label.new.set_markup("<big>#{section["heading"]}</big>")
    page_label = Gtk::Label.new.set_markup("<b>#{page["heading"]}</b>")
    paras = page.search("para")
    text = paras.to_a.collect {|para| para.text + "\n"}
    buffer = Gtk::TextBuffer.new.set_text(text.join)
    view = Gtk::ScrolledWindow.new.set_policy(Gtk::POLICY_AUTOMATIC,
    Gtk::POLICY_AUTOMATIC).add(Gtk::TextView.new(buffer).set_editable(
    false).set_wrap_mode(2).set_pixels_above_lines(5).set_pixels_below_lines(
    5).set_left_margin(5).set_right_margin(5))
    [section_label, page_label, view]
  end
end


  


