#
# This class represents the review view. It comprises a Gkt::HPaned widget
# into which are packed a menu (@nav - a ReviewNav object) and a review 
# pane (@nav.view - a Review object).
#
class ReviewView < Gtk::HPaned
  def initialize(rdadoc)
    super()
    @rdadoc = rdadoc
    scroll_a = Gtk::ScrolledWindow.new.set_policy(Gtk::POLICY_AUTOMATIC,
    Gtk::POLICY_AUTOMATIC)
    scroll_b = Gtk::ScrolledWindow.new.set_policy(Gtk::POLICY_AUTOMATIC,
    Gtk::POLICY_AUTOMATIC)
    @nav = ReviewNav.new(@rdadoc)
    scroll_a << @nav
    pack1(scroll_a, false, true)
    review = @nav.view
    scroll_b << review
    pack2(scroll_b, true, true)
    # Remember the pane width if a user switches between two or more documents
    # by storing it as an instance variable in RDADoc class.
    scroll_a.set_size_request(@rdadoc.review_pane, -1)
    signal_connect('size-request') {|pane, request| @rdadoc.review_pane = pane.position}
  end

  # Pass navigate calls to @nav.
  # Returns nil.
  def navigate(direction, path=nil)
    case direction
      when :home then @nav.home
      when :forward then @nav.forward
      when :backward then @nav.backward
      when :path
        @rdadoc.current_node.navigate(:path, path)
        reviewpath = @rdadoc.current_node.reviewpath
        @nav.remote_activate(reviewpath)
      end
  end
end

#
# The ReviewNav class represents the tree menu of a review view.
# Review panes (the main portion of a review view) are stored in the @view
# variable of this class.
#
# This class contains methods for populating the tree menu, navigation, and
# selection of nodes in the review pane.
#
class ReviewNav < Gtk::TreeView
  attr_reader :view
  
  def initialize(rdadoc)
    @rdadoc = rdadoc
    @root = @rdadoc.xml_doc.root
    reviewpath = @rdadoc.current_node.reviewpath
    @termpath, @classpath = reviewpath
    @store = Gtk::ListStore.new(Gdk::Pixbuf, String)
    super(@store)
    pix = Gtk::CellRendererPixbuf.new
    text = Gtk::CellRendererText.new
    @column = Gtk::TreeViewColumn.new
    @column.title = "Function menu"
    @column.pack_start(pix, false)
    @column.set_cell_data_func(pix) do |column, cell, model, iter|
      cell.pixbuf = iter.get_value(0)
    end
    @column.pack_start(text, true)
    @column.set_cell_data_func(text) do |column, cell, model, iter|
      cell.text = iter.get_value(1)
    end
    append_column(@column)
    selection.signal_connect('changed') {|selection| on_select}
    # Initialize the review pane
    @view = Review.new
    @view.set_hilite(@rdadoc.preferences[:hilite_updates_since])
    @view.signal_connect('row-activated') {|a, b, c| on_view_select(b)}
    # Initialize the 'add comment' popup
    @popup = CommentsPopup.new(@rdadoc, self)
    # Popup the comments menu on right click
    @view.signal_connect("button_press_event") do |widget, event|
      if event.kind_of? Gdk::EventButton and event.button == 3
        path = @view.get_path_at_pos(event.x, event.y)
        if path
          selection = @view.selection
          selection.select_iter(@view.store.get_iter(path[0]))
          activate_comments_menu(path[0], event.button, event.time)
        end
      end
    end
    # Popup the comments menu on Shift-F10
    @view.signal_connect("popup_menu") do
      selection = @view.selection
      iter = selection.selected
      if iter
        path = iter.path
        activate_comments_menu(path, 0, Gdk::Event::CURRENT_TIME)
      end
    end
    refill_store
    if @store.iter_first
      go_to_term
      term = true if @rdadoc.current_node.node.name == 'Term' or @rdadoc.current_node.node.name == 'Class'
      go_to_class(term)
    end
  end
  
  # Popup an 'add comment' menu.
  # Returns nil
  def activate_comments_menu(path, button, time)
    array = path.indices.dup
    @classpath = array[0]
    reviewpath = [@termpath, @classpath]
    @rdadoc.current_node.node = Navigate::reviewpath_to_node(@root, reviewpath)
    @rdadoc.update_status_message
    @popup.show.popup(nil, nil, button, time)
    nil
   end
   
   # When a user adds a comment, update the view accordingly.
   # Returns nil
   def update_comment
    @view.store.get_iter(Gtk::TreePath.new(@classpath)).set_value(6,
    XMLtoMarkup::render_comments(@rdadoc.current_node.node))
    nil
   end
  
  # Select the tree menu item stored in the @termpath variable.
  # Returns nil.
  def go_to_term
    term_path = Gtk::TreePath.new(@termpath)
    scroll_to_cell(term_path, nil, true, 0.5, 0.0)
    selection.select_iter(@store.get_iter(term_path))
    nil
  end
  
  # Select the review pane item stored in the @classpath variable.
  # Returns nil
  def go_to_class(term=false)
    class_path = Gtk::TreePath.new(@classpath)
    @view.activate(view.store.get_iter(class_path)) if term
    @view.scroll_to_cell(class_path, nil, true, 0.5, 0.0)
    nil
  end
  
  # Clear the tree menu and reload it.
  # Returns nil.
  def refill_store
    @store.clear
    build_list
  end
  
  # Build the list of children of root (terms or classes) that comprises the 
  # tree menu.
  # Returns nil.
  def build_list
    @root.children.each do |el|
      if el.name == 'Term'
        iter = @store.append
        iter.set_value(0, self.render_icon(Gtk::Stock::INDEX, Gtk::IconSize::MENU))
        termtitlenode = el.xpath('rda:TermTitle', Namespace::RDA)[0]
        if termtitlenode
          title = termtitlenode.content 
          title.upcase!
          iter[1] = title
        end 
      elsif el.name == 'Class'
        iter = @store.append
        iter.set_value(0, self.render_icon(Gtk::Stock::EDIT, Gtk::IconSize::MENU))
        iter.set_value(1, "Class")
      end
    end
    nil
  end
  
  # Called by the ReviewView navigate method.
  # Returns nil.
  def remote_activate(reviewpath)
    @termpath, @classpath = reviewpath
    go_to_term
    go_to_class(true)
  end
  
  # When a user selects an item in the tree menu, update the review pane
  # and scroll to the first item in the new view.
  # Returns nil.
  def on_select
    iter = selection.selected
    if iter
      path = iter.path
      array = path.indices.dup
      @termpath = array[0]
      reviewpath = [@termpath, 0]
      node = Navigate::reviewpath_to_node(@root, reviewpath)
      @view.refill_store(node)
      @view.scroll_to_cell(Gtk::TreePath.new('0'), nil, true, 0.5, 0.0)
      nil
    end
  end
  
  # When a user activates (double-clicks) an item in the review pane, change
  # to edit form view.
  # Returns nil.
  def on_view_select(b)
    array = b.indices.dup
    reviewpath = [@termpath, array[0]]
    @rdadoc.current_node.node = Navigate::reviewpath_to_node(@root, reviewpath)
    @rdadoc.update_view(0)
    @rdadoc.main_page_change
  end
  
  # Check if a particular path exists in the review pane.
  # Returns boolean.
  def class_path_exists?(path) 
    @view.store.get_iter(Gtk::TreePath.new(path)) ? true : false
  end
  
  # Check if a particular path exists in the tree menu.
  # Returns boolean.
  def term_path_exists?(path) 
    @store.get_iter(Gtk::TreePath.new(path)) ? true : false
  end

  # If there is any content in the review view, go to the first node.
  # Returns nil.
  def home
    if @store.iter_first
      @termpath, @classpath = 0, 0
      go_to_term
      go_to_class(false)
    end
  end

  # Go forwards in the view.
  # Returns nil.
  def forward
    classpath = @classpath + 1
    if class_path_exists?(classpath)
      @classpath = classpath
      go_to_class(true)
    else
      termpath = @termpath + 1
      if term_path_exists?(termpath)
        @termpath = termpath
        @classpath = 0
        go_to_term
        go_to_class(true)
      else
        home
      end
    end
  end
  
  # Go backwards in the view.
  # Returns nil.    
  def backward
      classpath = @classpath - 1
      if classpath > -1
      @classpath = classpath
        go_to_class(true)
      else
        termpath = @termpath - 1
        if termpath > -1
          @termpath = termpath
          go_to_term
          go_deepest
          go_to_class(true)
        else
          last_term = @root.xpath('rda:Class | rda:Term', Namespace::RDA)
          if last_term[0]
            @termpath = last_term.length - 1
            go_deepest
            go_to_term
            go_to_class(true)
          end
        end
      end
  end
  
  # Called by backward method (above). This allows a user to go to the very
  # last node if they move backwards from the very first node.
  # Returns nil.    
  def go_deepest
    node = Navigate::reviewpath_to_node(@root, [@termpath, 0]) 
    @classpath = Navigate::count_children(node)
    nil
   end
 end

#
# The Review class represents the review pane of a review view (the main bit).
#
class Review < Gtk::TreeView
  attr_accessor :store
  
  def initialize
    @store = Gtk::ListStore.new(String, String, String, String, String,
    String, String, String, Integer, Integer)
    @blue = Gdk::Color.new(40545, 48705, 56865)
    @aqua = Gdk::Color.new(57885, 63240, 65025)
    @grey = Gdk::Color.new(61965, 61965, 61965)
    @pink = Gdk::Color.new(65535, 45875, 49150)
    super(@store)
    columns = [['No', 0, 50], ['Term title', 1, 120], ['Description', 2, 200],
    ['Disposal action', 3, 120],['Justification', 4, 200], ['Custody', 5, 120],
    ['Comments', 6, 200], ['Update', 7, 120]]
    columns.each do |column|
      text = Gtk::CellRendererText.new.set_yalign(0)
      treecolumn = Gtk::TreeViewColumn.new(column[0], text)
      treecolumn.set_cell_data_func(text) do |col, cell, model, iter|
        cell.set_wrap_width(column[2]).set_wrap_mode(Pango::WRAP_WORD_CHAR)
        value = iter.get_value(column[1])
        if value
          Pango.parse_markup(value)
          cell.markup = value
        else
          cell.text = String.new
        end
        case iter.get_value(8)
          when 1 then colour = @blue
          when 2 then colour = @aqua
          when 3 then colour = @grey
        end
        if column[1] == 7 # only highlight Update column
          colour = @pink if iter.get_value(9) == 1
        end
        cell.set_background_gdk(colour)
      end
      append_column(treecolumn)
    end
    set_enable_grid_lines(GRID_LINES_BOTH)
  end
  
  # Clear and reload the review pane's list store. Returns nil.
  def refill_store(element)
    @store.clear
    element.name == 'Term' ? build_list(element, false) : build_list(element, true)
  end
  
  # Select a particular item in the review pane. Returns nil.     
  def activate(iter)
    selection.select_iter(iter)
    nil
  end
  
  # Build the review pane's list store. Returns nil.
  def build_list(element, type)
    add_element(element, type)
    element.children.each do |el|
      if el.name == 'Class'
        add_element(el, true)
      elsif el.name == 'Term'
        build_list(el, false)
      end
    end
    nil
  end
  
  # Add an item to the review pane's list store. Returns nil
  def add_element(el, type)
    iter = @store.append
    iter[0] = XMLtoMarkup::render_itemno(el)
    iter[1] = XMLtoMarkup::render_title(el, type)
    iter[2] = XMLtoMarkup::render_description(el, type)
    if type
      disposal = XMLtoMarkup::render_disposals(el)
      justification = XMLtoMarkup::render_justification(el)
    else
      disposal, justification = [String.new, String.new], String.new
    end
    iter[3], iter[5] = disposal
    iter[4] = justification
    iter[6] = XMLtoMarkup::render_comments(el)
    update = XMLtoMarkup::render_update(el)
    iter[7] = update
    iter[8] = get_colour(el, type)
    iter[9] = hilite?(update)
    nil
  end
  
  # If disposal class, return 3 for colour. If a term, if it is immediately below
  # the root node (i.e. a function or equivalent) return 1, else 2.
  def get_colour(node, type)
    if type
      3
    else
      node.parent.name == 'Authority' ? 1 : 2
    end
  end
  
  # Called by ReviewNav. Sets the @hilite variable to the hilite date 
  # specified in the user's preferences. Returns nil.
  def set_hilite(hilite=nil)
    if hilite.empty?
      @hilite = nil
    else 
      ymd = hilite.split('-').collect {|a| a.to_i}
      @hilite = Date.civil(ymd[0], ymd[1], ymd[2])
     end
     nil
  end
  
  # Check for a hilite date (stored in preferences) and, if the update date is
  # greater, mark this iter to be highlighted in the view.
  # Returns 1 or 0 (would be boolean but no boolean datatype for the tree model).
  def hilite?(update)
    hilite = 0
    if @hilite
      if update.length > 0
        ymd = update.split('-').collect {|a| a.to_i}
        update_date = Date.civil(ymd[0], ymd[1], ymd[2])
        hilite = 1 if update_date >= @hilite
      end
    end
    hilite
  end
end



