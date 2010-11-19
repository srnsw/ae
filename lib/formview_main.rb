#
# The FormView class is a Gtk::Hpaned widget that contains a tree menu
# and one of four forms (Details, Context, Term or Class).
#
class FormView < Gtk::HPaned
  attr_reader :treemenu

  def initialize(rdadoc)
    super()
    @treemenu = TreeMenu.new(rdadoc, self)
    treeview = @treemenu.treeview
    scroll = Gtk::ScrolledWindow.new.set_policy(Gtk::POLICY_AUTOMATIC,
    Gtk::POLICY_AUTOMATIC)
    scroll << treeview
    pack1(scroll, false, true)
    update_form_view(rdadoc)
    # Remember the pane width if a user switches between two or more documents
    # by storing it as an instance variable in RDADoc class.
    scroll.set_size_request(rdadoc.tree_pane, -1)
    signal_connect('size-request') {|pane, request| rdadoc.tree_pane = pane.position}
  end
  
  # When a user changes view (for example, by activating the tree menu),
  # destroy the old form in view and create a new one.
  # Returns nil.
  def update_form_view(rdadoc)
    old_page = child2
    remove(old_page) if old_page
    old_page.destroy if old_page
    case rdadoc.current_node.node.name
      when 'Context' then form = ContextView.new(rdadoc, @treemenu)
      when 'Term' then form = TermView.new(rdadoc, @treemenu)
      when 'Class' then form = ClassView.new(rdadoc, @treemenu)
      else form = DetailsView.new(rdadoc)
    end
    if rdadoc.preferences[:single_page_view]
      page = Gtk::ScrolledWindow.new.set_policy(Gtk::POLICY_AUTOMATIC,
      Gtk::POLICY_AUTOMATIC).add_with_viewport(form)
    else
      page = form
    end
    pack2(page, true, true)
    show_all
    rdadoc.update_status_message
  end
  
  # Pass navigate method (invoked from MainWindow) to the treemenu.
  # Returns nil.
  def navigate(direction, path=nil)
    @treemenu.navigate(direction, path)
  end
end

#
# The StandardView class is a super-class for the four form views: Details,
# Context, Term and Class. This class contains widget-packing methods
# common to the four views. 
#
class StandardView < Gtk::VBox
  def initialize(title)
    super(false, 0)
    main_label = Gtk::Label.new.set_markup("<big><b>#{title}</b></big>")
    pack_start(main_label, false, false, 2)
  end
  
  # Packs widgets onto main page. Returns nil.
  def pack_single(comments, *widgets)
    widgets.each {|widget| pack_start(widget, false, false, 5)}
    pack_start(Gtk::HSeparator.new, false, false, 10)
    pack_start(comments, false, false, 5)
    set_border_width(4)
    nil
  end
  
  # Creates a notebook and packs widgets onto two pages. Returns nil.
  def pack_multi(page_one, page_two, bool)
    page_one.set_border_width(4)
    page_two.set_border_width(4)
    notebook = Gtk::Notebook.new.set_scrollable(true)
    page_one_label = Gtk::Label.new('Main')
    if bool
      page_two_image = Gtk::Image.new(Gtk::Stock::YES, Gtk::IconSize::MENU)
    else
      page_two_image = Gtk::Image.new(Gtk::Stock::NO, Gtk::IconSize::MENU)
    end
    page_two_label = Gtk::HBox.new(false, 4).pack_start(Gtk::Label.new('Additional'),
    true, true, 0).pack_start(page_two_image, false, false, 0).show_all
    notebook.append_page(Gtk::ScrolledWindow.new.set_policy(Gtk::POLICY_AUTOMATIC,
    Gtk::POLICY_AUTOMATIC).add_with_viewport(page_one), page_one_label)
    notebook.append_page(Gtk::ScrolledWindow.new.set_policy(Gtk::POLICY_AUTOMATIC,
    Gtk::POLICY_AUTOMATIC).add_with_viewport(page_two), page_two_label)
    pack_start(notebook, true, true, 0)
    nil
  end
end

#
# DetailsView makes and packs widgets for the Details view.
#
class DetailsView < StandardView
  def initialize(rdadoc)
    super('Authority Details')
    current_node = rdadoc.current_node
    # Initialize widgets
    id = PlainFrame.new('ID numbers') << ID.new(rdadoc)
    title = PlainFrame.new('Authority Title', "The authority's formal title e.g. Administrative Records (#{Domain::SHORTNAME} use only).")
    title << CustomEntry.new('AuthorityTitle', current_node.get_content('AuthorityTitle'),
    25) {|el_name, text| current_node.update_element(el_name, text)}
    scope = PlainFrame.new('Functional Scope', "Functional scope of authority e.g. Wild Dog Control (#{Domain::SHORTNAME} use only).")
    scope << CustomEntry.new('Scope', current_node.get_content('Scope'),
    50)  {|el_name, text| current_node.update_element(el_name, text)}
    publish = Publish.new(current_node)
    daterange = DateRange.new(current_node)
    status = BoldFrame.new('Status events', 'Records key events in the life of the authority') << Status.new(rdadoc)
    linkto = BoldFrame.new('Linked to...', 'Use to link authority to other resources') << LinkedTo.new(rdadoc)
    comments = BoldFrame.new('Comments') << Comments.new(rdadoc)
    # Pack widgets
    tophbox = HBox.new(0, title, scope).pack_end(publish, false, false, 0)
    topvbox = VBox.new(2, tophbox, id)
    expander = Expander.new("#{Domain::NAME}' use")
    expander << topvbox
    # Pack single page
    if rdadoc.preferences[:single_page_view]
      pack_single(comments, expander, daterange, status, linkto)
    else
      # Pack multi page
      page_one = VBox.new(5, daterange, status)
      page_two = VBox.new(5, expander, linkto)
      page_two.pack_start(Gtk::HSeparator.new, false, false, 10).pack_start(
      comments, false, false, 5)
      if current_node.multiple_exists?('ID', 'AuthorityTitle', 'Scope', 'LinkedTo',
      'Comment') or publish.contents
        bool = true
      else
        bool = false
      end     
      pack_multi(page_one, page_two, bool)
    end
  end
end

#
# ContextView makes and packs widgets for the Context view.
#
class ContextView < StandardView
  def initialize(rdadoc, treemenu)
    super('Context')
    current_node = rdadoc.current_node
    # Initialize widgets
    type = BoldFrame.new('Context Type', 'Enter type of contextual element e.g. supporting documentation')
    type << CustomComboEntry.new(Domain::CONTEXTTYPES, current_node.get_attribute(
    nil, 'type')) {|text| current_node.update_attribute(nil, 'type', text)}
    title = BoldFrame.new('Context Title', 'Enter title e.g. About the public office')
    title << CustomEntry.new('ContextTitle', current_node.get_content('ContextTitle'),
    50) do |el_name, text|
      current_node.update_element(el_name, text)
      treemenu.update_iter(current_node, text, false)
    end
    content = StandardMarkup.new(rdadoc, 'Context content', 'ContextContent',
    nil, rdadoc.preferences[:context_y])
    sources = BoldFrame.new('Sources', 'Use to cite sources referenced in this contextual element') << Sources.new(rdadoc)
    comments = BoldFrame.new('Comments') << Comments.new(rdadoc)
    # Pack single page
    if rdadoc.preferences[:single_page_view]
      pack_single(comments, HBox.new(0, type), title, content, sources)
    else
      # Pack multi page
      page_one = VBox.new(5, HBox.new(0, type), title, content, sources)
      page_two = comments
      pack_multi(page_one, page_two, current_node.exists?('Comment'))
    end
end
end

#
# TermView makes and packs widgets for the Term view.
#
class TermView < StandardView
  def initialize(rdadoc, treemenu)
    super('Term')
    current_node = rdadoc.current_node
    # Initialize widgets
    publish = Publish.new(current_node)
    id = PlainFrame.new('ID numbers') << ID.new(rdadoc)
    status = PlainFrame.new('Status events') << Status.new(rdadoc)
    daterange = DateRange.new(current_node)
    type = TypeWidget.new(current_node)
    itemno = BoldFrame.new('Item number', 'Enter item number in the format 1.1.0')
    itemno << CustomEntry.new('itemno', current_node.get_attribute(nil, 'itemno'),
    20) {|at_name, text| current_node.update_attribute(nil, at_name, text)}
    update = Update.new(rdadoc)
    itembox = HBox.new(0, type, itemno).pack_end(update, false, false, 0)
    title = BoldFrame.new('Term Title', 'Enter title e.g. Construction')
    title << CustomEntry.new('TermTitle', current_node.get_content('TermTitle'), 20) do |el_name, text|
      text.upcase! if Navigate::top?(current_node.node) && rdadoc.preferences[:capitalize_top_term]
      current_node.update_element(el_name, text)
      treemenu.update_iter(current_node, text, false)
      update.trigger_update(Date::today.to_s) if rdadoc.preferences[:track_update]
    end
    description = StandardMarkup.new(rdadoc, 'Description', 'TermDescription',
    update)
    seeref = BoldFrame.new('See references') << SeeReference.new(rdadoc)
    linkto = BoldFrame.new('Linked to...', 'Use to link term to other resources') << LinkedTo.new(rdadoc)
    comments = BoldFrame.new('Comments') << Comments.new(rdadoc)
    # Pack widgets
    tophbox = HBox.new(0, publish)
    topvbox = VBox.new(2, tophbox, id, status)
    expander = Expander.new("#{Domain::NAME}' use")
    expander << topvbox
    # Pack single page
    if rdadoc.preferences[:single_page_view]
      topvbox.pack_start(daterange, false, false, 2)
      pack_single(comments, expander, itembox, title, description, seeref, linkto)
    else
      # Pack multi page
      page_one = VBox.new(5, itembox, title, description, seeref)
      page_two = VBox.new(5, expander, daterange, linkto).pack_start(
      Gtk::HSeparator.new, false, false, 10).pack_start(comments, false, false, 5)
      if current_node.multiple_exists?('ID', 'DateRange', 'Status', 'LinkedTo',
      'Comment') or publish.contents
        bool = true
      else
        bool = false
      end
      pack_multi(page_one, page_two, bool)
    end
  end
end

#
# ClassView makes and packs widgets for the Class view.
#
class ClassView < StandardView
  def initialize(rdadoc, treemenu)
    super('Class')
    current_node = rdadoc.current_node
    # Initialize widgets
    publish = Publish.new(current_node)
    id = PlainFrame.new('ID numbers') << ID.new(rdadoc)
    status = PlainFrame.new('Status events') << Status.new(rdadoc)
    daterange = DateRange.new(current_node)
    itemno = BoldFrame.new('Item number', 'Enter item number in the format 1.1.0')
    itemno << CustomEntry.new('itemno', current_node.get_attribute(nil, 'itemno'), 20) do |at_name, text|
      current_node.update_attribute(nil, at_name, text)
      treemenu.update_iter(current_node, current_node.get_content('ClassTitle'), true)
    end
    update = Update.new(rdadoc)
    itembox = HBox.new(0, itemno).pack_end(update, false, false, 0)
    title = BoldFrame.new('Class Title', 'In most case, use of a class title is not recommended')
    title << CustomEntry.new('ClassTitle', current_node.get_content('ClassTitle'), 20) do |el_name, text|
      current_node.update_element(el_name, text)
      treemenu.update_iter(current_node, text, true)
      update.trigger_update(Date::today.to_s) if rdadoc.preferences[:track_update]
    end
    description = StandardMarkup.new(rdadoc, 'Description', 'ClassDescription', update)
    seeref = SeeReference.new(rdadoc, 'ClassDescription')
    seeref_exp = Expander.new('See references (not recommended at class level)',
    seeref.contents) << seeref
    disposal = BoldFrame.new('Disposal') << Disposals.new(rdadoc, update)
    justification = Justification.new(rdadoc, update)
    linkto = BoldFrame.new('Linked to...', 'Use to link class to other resources') << LinkedTo.new(rdadoc)
    comments = BoldFrame.new('Comments') << Comments.new(rdadoc)
    # Pack widgets
    tophbox = HBox.new(0, publish)
    topvbox = VBox.new(2, tophbox, id, status)
    expander = Expander.new("#{Domain::NAME}' use")
    expander << topvbox
    # Pack single page
    if rdadoc.preferences[:single_page_view]
      topvbox.pack_start(daterange, false, false, 2).pack_start(title, false,
      false, 2)
      pack_single(comments, expander, itembox, description, seeref_exp, disposal,
      justification, linkto)
    else
      # Pack multi page
      page_one = VBox.new(5, itembox, description, seeref_exp, disposal, justification)
      page_two = VBox.new(5, expander, daterange, title, linkto).pack_start(
      Gtk::HSeparator.new, false, false, 10).pack_start(comments, false, false, 5)
      if current_node.multiple_exists?('ID', 'ClassTitle', 'DateRange', 'Status', 'LinkedTo',
      'Comment') or publish.contents
        bool = true
      else
        bool = false
      end
      pack_multi(page_one, page_two, bool)
    end
  end
end
