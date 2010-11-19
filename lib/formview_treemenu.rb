#
# The TreeMenu class represents the tree menu in the form view. This menu
# presents a hierarchical view of context, term and class elements in the authority.
# These elements can be selected for individual editing. By right-clicking, users
# can also access pop-up menus for adding, deleting or moving elements.
#
# The @treeview variable points to the Gtk::TreeView itself. The @model
# variable points to the Gtk::TreeStore that holds the data presented in @treeview.
#
class TreeMenu
  attr_reader :treeview
  
  def initialize(rdadoc, formview)
    @rdadoc, @formview = rdadoc, formview
    @popup = PopupMenu.new(@rdadoc)
    @treeview = Gtk::TreeView.new 
    @model = Gtk::TreeStore.new(Gdk::Pixbuf, String)
    @column = Gtk::TreeViewColumn.new("Tree menu")
    pix, text = Gtk::CellRendererPixbuf.new, Gtk::CellRendererText.new
    @column.pack_start(pix, false)
    @column.set_cell_data_func(pix) do |column, cell, model, iter|
      cell.pixbuf = iter.get_value(0)
    end
    @column.pack_start(text, true)
    @column.set_cell_data_func(text) do |column, cell, model, iter|
      cell.text = iter.get_value(1)
    end
    @treeview.append_column(@column)
    # Add the three top nodes to the model
    toplevel, @context, authority = @model.append(nil), @model.append(nil),
    @model.append(nil)
    toplevel.set_value(0, @treeview.render_icon(Gtk::Stock::HOME,
    Gtk::IconSize::MENU)).set_value(1, "Details")
    @context.set_value(0, @treeview.render_icon(Gtk::Stock::ORIENTATION_PORTRAIT,
    Gtk::IconSize::MENU)).set_value(1, "Context")
    authority.set_value(0, @treeview.render_icon(Gtk::Stock::PASTE,
    Gtk::IconSize::MENU)).set_value(1, "Authority")
    @treeview.set_model(@model)
    # Construct the rest of the model based on the XML document
    @root = @rdadoc.xml_doc.root
    maketree(@root, authority)
    # Capture signals
    @treeview.signal_connect('row-activated') {|a, b, c| on_activate(b)}
    @treeview.selection.signal_connect('changed') {|selection| on_select(selection)}
    # Popup the menu on right click
    @treeview.signal_connect("button_press_event") do |widget, event|
      if event.kind_of? Gdk::EventButton and event.button == 3
        path = @treeview.get_path_at_pos(event.x, event.y)
        if path
          selection = @treeview.selection
          selection.select_iter(@model.get_iter(path[0]))
          @treeview.set_cursor(path[0], @column, false)
          activate_menu(path[0], event.button, event.time)
        end
      end
    end
    # Popup the menu on Shift-F10
    @treeview.signal_connect("popup_menu") do
      iter = @treeview.selection.selected
      activate_menu(iter.path, 0, Gdk::Event::CURRENT_TIME) if iter
    end
    # Activate the currently selected node
    treepath = Gtk::TreePath.new(@rdadoc.current_node.treepath)
    @rdadoc.preferences[:auto_expand] ?  expand_all : @treeview.expand_to_path(treepath)
    @treeview.scroll_to_cell(treepath, nil, true, 0.5, 0.0)
    activate(@model.get_iter(treepath))
  end
  
  # Build the tree menu from the XML document. Returns nil.
  def maketree(element, parent)
    element.xpath('*').each {|element| append_child(element, parent)}
    nil
  end

  def append_child(element, parent)
    case element.name 
      when 'Context'
        item = @model.append(@context)
        create_context(element, item) 
      when 'Class'
        item = @model.append(parent)
        create_class(element, item)
      when 'Term'
        item = @model.append(parent)
        create_term(element, item)
        maketree(element, item)
      end
  end

  def append_sibling(element, sibling)
    case element.name 
      when 'Context'
        item = @model.insert_after(nil, sibling)
        create_context(element, item) 
      when 'Class'
        item = @model.insert_after(nil, sibling)
        create_class(element, item)
      when 'Term'
        item = @model.insert_after(nil, sibling)
        create_term(element, item)
        maketree(element, item)
      end
  end

  def create_context(element, item)
    if element['type'] == Domain::CONTEXTTYPES[0]
      item.set_value(0, @treeview.render_icon(Gtk::Stock::ORIENTATION_PORTRAIT,
      Gtk::IconSize::MENU))
    else
      item.set_value(0, @treeview.render_icon(Gtk::Stock::ABOUT,
      Gtk::IconSize::MENU))
    end
      title = element.xpath('rda:ContextTitle', Namespace::RDA)[0]
      title ? text = title.content : text = String.new
      item.set_value(1, text)
      nil
  end

  def create_class(element, item)
    item.set_value(0, @treeview.render_icon(Gtk::Stock::EDIT, Gtk::IconSize::MENU))
    text = element['itemno'] if element['itemno']
    title = element.xpath('rda:ClassTitle', Namespace::RDA)[0]
    if title
      if text
        text = text + ' ' + title.content
      else
        text = title.content
      end
    end
    text = 'Class' unless text
    item.set_value(1, text)
    nil
  end

  def create_term(element, item)
    item.set_value(0, @treeview.render_icon(Gtk::Stock::INDEX, Gtk::IconSize::MENU))
    title = element.xpath('rda:TermTitle', Namespace::RDA)[0]
    title ? text = title.content : text = String.new
    item.set_value(1, text)
    nil
  end

  def expand_current_row
    @treeview.expand_row(Gtk::TreePath.new(@rdadoc.current_node.treepath), true)
    nil
  end

  def expand_all
    @treeview.expand_row(Gtk::TreePath.new("1"), true)
    @treeview.expand_row(Gtk::TreePath.new("2"), true)
    nil
  end

  def collapse_all
    @treeview.collapse_row(Gtk::TreePath.new("1"))
    @treeview.collapse_row(Gtk::TreePath.new("2"))
    nil
  end
  
  # Handle tree menu selections (single click). Change page in form view to
  # match new selection. Force update first by grabbing focus (editing
  # widgets update XML on focus-out signal). Don't change view if user
  # selects the top node of the context or authority menus. Returns nil.
  def on_select(selection)
    @treeview.grab_focus unless @treeview.focus? # force form to update before changing page
    iter = selection.selected
    if iter
      array = iter.path.indices.dup
      change_node(array) unless array.length == 1 and array[0] > 0
    end
  end
  
  # Handle double-clicks on tree menu. These are treated like single-clicks
  # unless the double-click is on the top node of the context or authority menus.
  # In that case, attempt to drill down to a child of those nodes. Returns nil.
  def on_activate(treepath)
    array = treepath.indices.dup
    if array.length == 1 and array[0] > 0
      @treeview.expand_row(treepath, false)
      iter = @model.get_iter(treepath)
      iter.has_child? ? activate(iter.first_child) : activate(@model.iter_first)
    end
  end
  
  # Change the current node and replace the editing page. Returns nil.
  def change_node(array)
    @rdadoc.current_node.node = Navigate::treepath_to_node(@root, array)
    @formview.update_form_view(@rdadoc)
  end

  # Place cursor and select an element in the model. Returns nil.
  def activate(iter)
    @treeview.set_cursor(iter.path, @column, false)
    @treeview.selection.select_iter(iter)
    nil
  end

  # Test node at path and pop the appropriate menu. The items array determines
  # which items of the popup menu will be displayed to the user.
  # Returns nil.
  def activate_menu(path, button, time)
    array = path.indices.dup
    iter = @model.get_iter(path)
    move_down = true if iter.next!
    move_up = true unless array.at(-1) == 0
    menu_type = menu_type(array)
    context_set = false
    return nil unless menu_type
    copy_name = @rdadoc.copy_node.name if @rdadoc.copy_node
    items = Array.new
    case menu_type
      when :context_top
        context_set = true
        items << 0
        items.push(8,9) if copy_name == 'Context'
      when :authority_top 
        if Domain::TERMSET1[:show]
          items << 2
          items.push(4,6) unless @rdadoc.preferences[:term_set_only]
        else
          items.push(4,6)
        end
        items.push(8,9) if copy_name == 'Term' or copy_name == 'Class'
      when :context_item
        items << 1
        items.push(8,10) if copy_name == 'Context'
        items.push(11,12,13)
        items << 14 if move_up or move_down
        items << 15 if move_up
        items << 16 if move_down
        items.push(17,18)
      when :term
        if @rdadoc.preferences[:term_set_only]
          array.length == 2 && Domain::TERMSET2[:show] ? items << 3 : items << 6
        else
          items << 2 if array.length == 2 && Domain::TERMSET2[:show]
          items.push(4,5,6,7)
        end
        items.push(8,9,10) if copy_name == 'Term' or copy_name == 'Class'
        items.push(11,12,13)
        items << 14 if move_up or move_down
        items << 15 if move_up
        items << 16 if move_down
        items.push(17,18)
      when :class
        items << 7
        items.push(8,10) if copy_name == 'Class'
        items.push(11,12,13)
        items << 14 if move_up or move_down
        items << 15 if move_up
        items << 16 if move_down
        items.push(17,18)
    end
    @popup.path = array
    @popup.show_items(context_set, items).show.popup(nil, nil, button, time)
    nil
  end

  def menu_type(path)
    if path.length == 1
      case path[0]
        when 0 then nil
        when 1 then :context_top
        when 2 then :authority_top
      end
    else
      node = Navigate::treepath_to_node(@root, path)
      case node.name
        when 'Context' then :context_item
        when 'Term' then :term
        when 'Class' then :class
      end
    end
  end
  
  # Method for updating names of iters e.g. when a user enters a term name
  # into a form. Returns nil.
  def update_iter(current_node, text, disposal_class)
    if disposal_class
      text = String.new if text.nil?
      text = current_node.node['itemno'] + ' ' + text if current_node.node['itemno']
      text = 'Class' unless text.strip.length > 0
    end
    @model.get_iter(Gtk::TreePath.new(current_node.treepath)).set_value(1, text)
    nil
  end
  
  # Method for deleting an iter. This does not change the XML but means that 
  # when an element is deleted it is not necessary to rebuild the whole tree menu.
  # Returns nil.
  def delete_iter(node)
    @model.remove(@model.get_iter(Gtk::TreePath.new(Navigate::node_to_treepath(node))))
    nil
  end

  # Method for swapping iters when a user moves an element. This does not 
  # change the XML but means it is not necessary to rebuild the whole tree menu.
  # Returns nil.
  def swap(path, up)
    swap_path = path.dup
    if up
      up_path = swap_path[-1] - 1
      swap_path[-1] = up_path
    else
      down_path = swap_path[-1] + 1
      swap_path[-1] = down_path
    end
    @model.swap(@model.get_iter(Gtk::TreePath.new(path.join(':'))),
    @model.get_iter(Gtk::TreePath.new(swap_path.join(':'))))
    nil
  end
  
  # Method for adding iters when a user adds a new element. This does not 
  # change the XML but means it is not necessary to rebuild the whole tree menu.
  # Returns nil.
  def add_child(element, parent_path)
    parent = @model.get_iter(Gtk::TreePath.new(parent_path.join(':'))) if parent_path
    append_child(element, parent)
  end
  
  # Method for adding iters when a user adds a new element. This does not 
  # change the XML but means it is not necessary to rebuild the whole tree menu.
  # Returns nil.
  def add_sibling(element, sibling_path)
    sibling = @model.get_iter(Gtk::TreePath.new(sibling_path.join(':')))
    append_sibling(element, sibling)
  end

  # Method for external classes or modules to select a child element in the tree view.
  # Returns nil.
  def remote_child_activate(current_node)
    treepath = Gtk::TreePath.new(current_node.treepath)
    @treeview.expand_to_path(treepath)
    @treeview.expand_row(treepath, true) if @rdadoc.preferences[:auto_expand]
    activate(@model.get_iter(treepath))
  end

  # Method for external classes or modules to select an element in the tree view.
  # Returns nil.
  def remote_activate(current_node, scroll=false)
    treepath = Gtk::TreePath.new(current_node.treepath)
    if @rdadoc.preferences[:auto_expand]
      @treeview.expand_row(treepath, true)
    end
    if scroll
      @treeview.expand_to_path(treepath)
      @treeview.scroll_to_cell(treepath, nil, true, 0.5, 0.0)
    end
    activate(@model.get_iter(treepath))
  end
  
  # Handle navigate actions (home, backwards, forwards, search) by passing
  # them on to CurrentNode and then activating the appropriate element.
  # Returns nil.
  def navigate(direction, path=nil)
    @rdadoc.current_node.navigate(direction, path)
    remote_activate(@rdadoc.current_node, true)
  end
end

