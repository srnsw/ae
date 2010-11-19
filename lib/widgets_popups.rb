#
# PopupMenu represents the pop-up menus for the tree menu in edit form view.
# See formview_treemenu.rb.
#
class PopupMenu < Gtk::Menu
attr_accessor :path

  def initialize(rdadoc)
    super()
    @path = nil
    @context_items = Domain::CONTEXTSETS.collect do |set|
       [Gtk::ImageMenuItem.new(set[:menu_text],
      false).set_image(Gtk::Image.new(Gtk::Stock::ADD, Gtk::IconSize::MENU)),
      lambda {rdadoc.context_set([set[:type], set[:titles]])}]
    end
    @menu_items = [
      [Gtk::ImageMenuItem.new('Add context', false).set_image(
      Gtk::Image.new(Gtk::Stock::ADD, Gtk::IconSize::MENU)),
      lambda {rdadoc.context_child}],
      [Gtk::ImageMenuItem.new('Add context', false).set_image(
      Gtk::Image.new(Gtk::Stock::ADD, Gtk::IconSize::MENU)),
      lambda {rdadoc.context_sibling(@path)}],
      [Gtk::ImageMenuItem.new(Domain::TERMSET1[:menu_text],
      false).set_image(Gtk::Image.new(Gtk::Stock::ADD, Gtk::IconSize::MENU)),
      lambda {rdadoc.term_set(Domain::TERMSET1[:terms], nil)}],
      [Gtk::ImageMenuItem.new(Domain::TERMSET2[:menu_text],
      false).set_image(Gtk::Image.new(Gtk::Stock::ADD, Gtk::IconSize::MENU)),
      lambda {rdadoc.term_set(Domain::TERMSET2[:terms], @path)}],
      [Gtk::ImageMenuItem.new('Add child term', false).set_image(
      Gtk::Image.new(Gtk::Stock::INDEX, Gtk::IconSize::MENU)),
      lambda {rdadoc.new_child('Term', @path)}],
      [Gtk::ImageMenuItem.new('Add sibling term', false).set_image(
      Gtk::Image.new(Gtk::Stock::INDEX, Gtk::IconSize::MENU)),
      lambda {rdadoc.new_sibling('Term', @path)}],
      [Gtk::ImageMenuItem.new('Add child class', false).set_image(
      Gtk::Image.new(Gtk::Stock::EDIT, Gtk::IconSize::MENU)),
      lambda {rdadoc.new_child('Class', @path)}],
      [Gtk::ImageMenuItem.new('Add sibling class', false).set_image(
      Gtk::Image.new(Gtk::Stock::EDIT, Gtk::IconSize::MENU)),
      lambda {rdadoc.new_sibling('Class', @path)}],
      [Gtk::SeparatorMenuItem.new, false],
      [Gtk::ImageMenuItem.new('Paste child', false).set_image(
      Gtk::Image.new(Gtk::Stock::PASTE, Gtk::IconSize::MENU)),
      lambda {rdadoc.paste_child(@path)}],
      [Gtk::ImageMenuItem.new('Paste sibling', false).set_image(
      Gtk::Image.new(Gtk::Stock::PASTE, Gtk::IconSize::MENU)),
      lambda {rdadoc.paste_sibling(@path)}],
      [Gtk::SeparatorMenuItem.new, false],
      [Gtk::ImageMenuItem.new(Gtk::Stock::CUT, nil), lambda {rdadoc.cut(@path)}],
      [Gtk::ImageMenuItem.new(Gtk::Stock::COPY, nil), lambda {rdadoc.copy(@path)}],
      [Gtk::SeparatorMenuItem.new, false],
      [Gtk::ImageMenuItem.new('Move up', false).set_image(
      Gtk::Image.new(Gtk::Stock::GO_UP, Gtk::IconSize::MENU)),
      lambda {rdadoc.move_up(@path)}],
      [Gtk::ImageMenuItem.new('Move down', false).set_image(
      Gtk::Image.new(Gtk::Stock::GO_DOWN, Gtk::IconSize::MENU)),
      lambda {rdadoc.move_down(@path)}],
      [Gtk::SeparatorMenuItem.new, false],
      [Gtk::ImageMenuItem.new(Gtk::Stock::DELETE, nil), lambda {rdadoc.delete(@path)}]
    ] 
    @context_items.each {|item| self.append(item[0])}
    @context_items.each {|item| item[0].signal_connect('activate') {|menu| item[1].call}}
    @menu_items.each {|item| self.append(item[0])}
    @menu_items.each {|item| item[0].signal_connect('activate') {|menu| item[1].call} if item[1]}
  end
  
  # First reset the menu by hiding all options. Then show the appropriate options
  # for the currently selected element.
  # Returns self.
  def show_items(context_set, items)
    context_set ? @context_items.each {|item| item[0].show} : @context_items.each {|item| item[0].hide}
    @menu_items.each {|item| item[0].hide}
    items.each {|number|  @menu_items[number][0].show}
    self
  end
end

#
# CommentsPopup represents the pop-up menu to add comments in review view.
# See reviewview.rb.
#
class CommentsPopup < Gtk::Menu
  def initialize(rdadoc, reviewview)
     super()
     item =  Gtk::ImageMenuItem.new('Add comment', false).set_image(
     Gtk::Image.new(Gtk::Stock::ADD, Gtk::IconSize::MENU))
     append(item)
     item.signal_connect('activate') {|menu| add_comment(rdadoc, reviewview)}
     item.show
  end
  
  # Popup up a comments dialogue (defined in widgets_multi.rb) and add a comment.
  # Returns nil.
  def add_comment(rdadoc, reviewview)
    current_node = rdadoc.current_node
    xml_doc = rdadoc.xml_doc
    parent = rdadoc.main
    dialog = CommentsDialog.new(xml_doc, parent, current_node, rdadoc, nil,
    rdadoc.preferences[:comment_author])
    dialog.run do |response|
    if response == 0
      new_element = dialog.create_element
      current_node.multi_add_element(new_element, nil)
      reviewview.update_comment
    end
    dialog.destroy
    end
    nil
  end
end

#
# MultiPopup represents the pop-up menu used by the multi-list elements.
# See widgets_multi.rb.
#
class MultiPopup < Gtk::Menu
  attr_accessor :context, :name, :pos
  def initialize(list, current_node)
    super()
    @context, @name, @pos = nil, nil, nil
    @menu_items = [
      [Gtk::ImageMenuItem.new('Move up', false).set_image(
      Gtk::Image.new(Gtk::Stock::GO_UP, Gtk::IconSize::MENU)),
      lambda {current_node.multi_move_up(list, @context, @name, @pos)}],
      [Gtk::ImageMenuItem.new('Move down', false).set_image(
      Gtk::Image.new(Gtk::Stock::GO_DOWN, Gtk::IconSize::MENU)),
      lambda {current_node.multi_move_down(list, @context, @name, @pos)}],
      [Gtk::SeparatorMenuItem.new, false],
      [Gtk::ImageMenuItem.new(Gtk::Stock::DELETE, nil),
      lambda {current_node.multi_delete(list, @context, @name, @pos)}]
     ]
     @menu_items.each {|item| self.append(item[0])}
     @menu_items.each {|item| item[0].signal_connect('activate') {|menu| item[1].call} if item[1]}
  end
  
  # First reset the menu by hiding all options. Then show the appropriate options
  # for the currently selected element.
  # Returns self.
  def show_items(items)
    @menu_items.each {|item| item[0].hide}
    items.each {|number| @menu_items[number][0].show}
    self
  end
end
