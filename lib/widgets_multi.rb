#
# The Multi class is a base class from which all of the 'multi-list' widgets are 
# derived. 'Multi-list' widgets are used whenever a user is allowed to include
# multiple elements on a node (e.g. multiple comments, status events, etc.).
# 
# This class constructs a tree model depending on the columns provided as parameters
# and has a method for generating the 'multi-list' pop-up (that allows delete
# and move operations).
# 
class Multi < Gtk::VBox
  def initialize(rdadoc, action_widget, columns, model)
    super(false, 0)
    @current_node = rdadoc.current_node
    @xml_doc = rdadoc.xml_doc
    @parent = rdadoc.main
    @model = model
    pagewidth = rdadoc.preferences[:pagewidth]
    update_model
    # @context is for "Status" child widgets, "Source" and "SeeReference"
    # widgets where the list is nested within a node that isn't rdadoc.current_node
    @context = nil unless @context
    # set up treeview
    @list_view = Gtk::TreeView.new(@model)
    columns.each do |col|
      # if a simple list
      if col[1]
        renderer = Gtk::CellRendererText.new.set_yalign(0).set_wrap_width(
        Integer(col[2]*pagewidth)).set_wrap_mode(Pango::WRAP_WORD_CHAR)
        column = Gtk::TreeViewColumn.new(col[0], renderer, 
        :text => columns.index(col))
        @list_view.append_column(column)
      # if markup is needed 
      else
        text = Gtk::CellRendererText.new.set_yalign(0).set_wrap_width(
        col[2]*pagewidth).set_wrap_mode(Pango::WRAP_WORD_CHAR)
        column = Gtk::TreeViewColumn.new(col[0], text)
        column.set_cell_data_func(text) do |a, cell, model, iter|
          value = iter.get_value(columns.index(col))
          if value
            Pango.parse_markup(value)
            cell.markup = value
          else
            cell.text = String.new
          end
        end
        @list_view.append_column(column)
      end
    end
    # Set up popup
    @popup = MultiPopup.new(self, @current_node)
    # Popup the menu on right click
    @list_view.signal_connect("button_press_event") do |widget, event|
      if event.kind_of? Gdk::EventButton and event.button == 3
        path = @list_view.get_path_at_pos(event.x, event.y)
        if path
          selection = @list_view.selection
          selection.select_iter(@model.get_iter(path[0]))
          activate_menu(path[0], event.button, event.time)
        end
      end
    end
    # Popup the menu on Shift-F10
    @list_view.signal_connect("popup_menu") do
      selection = @list_view.selection
      iter = selection.selected
      if iter
        path = iter.path
        activate_menu(path, 0, Gdk::Event::CURRENT_TIME)
      end
    end
    @list_view.signal_connect('row-activated') {|list, path, col| show_dialog(
    path.indices.dup[0])}
    pack_start(@list_view, false, false, 0)
    pack_start(action_widget, false, false, 0)
  end
  
  # Clears the tree model and calls update_model (which is defined separately
  # for every inherited class).
  # Returns nil.
  def update
    @model.clear
    update_model
  end

  # Test node at path and pop the appropriate menu. Returns nil.
  def activate_menu(path, button, time)
    iter = @model.get_iter(path)
    move_down = true if iter.next!
    pos = path.indices.dup[0]
    move_up = true unless pos == 0
    items = Array.new
    items << 0 if move_up
    items << 1 if move_down
    items << 2 if move_up or move_down
    items << 3
    @popup.pos = pos
    @popup.context = @context
    @popup.show_items(items).show.popup(nil, nil, button, time)
    nil
  end
  
  # Popup the dialog for this multi-list. Multi_dialog is defined for each inherited
  # class. If the response is "OK", create a new element (defined separately
  # for each inherited class) and either add it to the current node or replace
  # an existing element. Then update the list.
  # Returns nil.
  def show_dialog(pos)
    dialog = multi_dialog(pos)
    dialog.run do |response|
      if response == 0
        new_element = dialog.create_element
        if pos
          @current_node.multi_replace_element(new_element, @context, 
          @popup.name,  pos)
        else
          @current_node.multi_add_element(new_element, @context)
        end
        update
      end
      dialog.destroy
    end
    nil
  end

  # Shared method for Status and SeeReference classes. Return term titles or nil.
  def get_terms(node)
    titles = node.xpath('rda:TermTitleRef', Namespace::RDA)
    terms = titles.collect {|title| title.content}
    terms.empty? ? nil : terms
  end
  
  # Shared method for Status and SeeReference classes. Return IDRef or nil.
  def get_idref(node)
    idref = node.xpath('rda:IDRef', Namespace::RDA)[0]
    idref ? [idref['control'], idref.content] : [nil, nil]
  end
end

#
# The MultiDialog class is a super class for each of the multi-list dialogues.
#
class MultiDialog < Gtk::Dialog
  def initialize(title, parent)
    super(title, parent, Gtk::Dialog::MODAL, [ Gtk::Stock::APPLY, 0], [ Gtk::Stock::CANCEL, 1])
  end
end

#
# The ID class is a widget for entering ID numbers. 
#
class ID < Multi
  def initialize(rdadoc)
    columns = [["Control", true, 0.5], ["ID number", true, 0.5]]
    model = Gtk::ListStore.new(String, String)
    add = Gtk::Button.new(Gtk::Stock::ADD)
    add.signal_connect('clicked') {|widget| show_dialog(nil)}
    super(rdadoc, HBox.new(0, add), columns, model)
    @popup.name = "ID"
  end

  # Custom update_model method. Returns nil.
  def update_model
    nodes = @current_node.node.xpath('rda:ID', Namespace::RDA)
    nodes.each do |node|
      item = @model.append
      item[0], item[1] = node['control'], node.content
    end
    nil
  end
  
  # Custom multi_dialog method. Returns an ID dialogue.
  def multi_dialog(pos)
    if pos
      node = @current_node.node.xpath("rda:ID", Namespace::RDA)[pos]
      content, attr = node.content, node['control']
    else
      content, attr = nil, nil
    end
    IDDialog.new(@xml_doc, @parent, content, attr)
  end
end

#
# Dialogue for ID elements.
#
class IDDialog < MultiDialog
  def initialize(xml_doc, parent, content, attr)
    super('Add or edit ID', parent)
    stocks = Domain::IDCONTROLS
    @xml_doc = xml_doc
    @content = Gtk::Entry.new
    @content.set_text(content) if content
    @attr = Gtk::ComboBox.new(true)
    stocks.each {|stock| @attr.append_text(stock)}
    @attr.set_active(stocks.index(attr)) if attr and stocks.index(attr)
    content_frame = PlainFrame.new('ID number') << @content
    attr_frame = PlainFrame.new('Control') << @attr
    hbox = HBox.new(2, attr_frame, content_frame)
    frame = BoldFrame.new('ID number') << hbox
    vbox.add(frame)
    show_all
  end

  # Returns a Nokogiri::XML::Node
  def create_element
    element = Nokogiri::XML::Node.new('ID', @xml_doc)
    element.content = @content.text.strip if @content.text.strip.length > 0
    element['control'] = @attr.active_text if @attr.active_text
    element
  end
end

#
# Multi-list widget to represent Status events.
#
class Status < Multi
  def initialize(rdadoc)
    @term_cap = rdadoc.preferences[:capitalize_top_term]
    @new_status_type = 0
    columns = [["Event", false, 0.8], ["Date", true, 0.2]]
    model = Gtk::ListStore.new(String, String)
    @status_events = ['Draft', 'Submitted', 'Approved', 'Issued', 'Applying',
    'PartSupersedes', 'Supersedes', 'PartSupersededBy', 'SupersededBy',
    'Review', 'Expired', 'Revoked']
    widget = Gtk::ComboBox.new(true)
    @status_events.each {|event| widget.append_text(event)}
    widget.set_active(0)
    widget.signal_connect('changed') {|widget| @new_status_type = widget.active}
    add = Gtk::Button.new(Gtk::Stock::ADD)
    add.signal_connect('clicked') {|widget| show_dialog(nil)}
    status_widget = MHBox.new(widget, add)
    super(rdadoc, status_widget, columns, model)
    @context = 'Status'
    @popup.name = nil
  end

  # Custom update_model method. Returns nil.
  def update_model
    status = @current_node.node.xpath('rda:Status', Namespace::RDA)[0]
    if status
      nodes = status.xpath('*')
      nodes.each do |node|
        item = @model.append
        item[0], item[1] = XMLtoMarkup::render_status(node)
      end
      nil
    end
  end
  
  # Custom multi_dialog method. Returns a different status dialogue depending
  # on a) whether a position paramater is given (when a user double clicks 
  # an existing item) or b) what status event is currently selected in the 
  # combo drop-down (stored in the @new_status_type variable).
  def multi_dialog(pos)
    if pos
      status = @current_node.node.xpath('rda:Status', Namespace::RDA)[0]
      node = status.xpath("*")[pos]
      case node.name
        when 'Draft'
          DraftDialog.new(@xml_doc, @parent, node['version'], get_agency(node),
          get_date(node))
        when 'Submitted'
          officer = node.xpath('rda:Officer', Namespace::RDA)[0]
          officer = officer.content if officer
          position = node.xpath('rda:Position', Namespace::RDA)[0]
          position = position.content if position
          SubmittedDialog.new(@xml_doc, @parent, officer, position, get_agency(node),
          get_date(node))
        when 'Issued'
          IssuedDialog.new(@xml_doc, @parent, get_agency(node), get_date(node))
        when 'Applying'
          startdate = node.xpath('rda:StartDate', Namespace::RDA)[0]
          startdate = startdate.content if startdate
          enddate = node.xpath('rda:EndDate', Namespace::RDA)[0]
          enddate = enddate.content if enddate
          ApplyingDialog.new(@xml_doc, @parent, node['extent'], get_agency(node),
          startdate, enddate)
        when 'PartSupersedes'
          SuperDialog.new(@xml_doc, @parent, node.name, @term_cap,
          get_supersede_contents(node))
        when 'Supersedes'
          SuperDialog.new(@xml_doc, @parent, node.name, @term_cap,
          get_supersede_contents(node))
        when 'PartSupersededBy'
          SuperDialog.new(@xml_doc, @parent, node.name, @term_cap,
          get_supersede_contents(node))
        when 'SupersededBy'
          SuperDialog.new(@xml_doc, @parent, node.name, @term_cap,
          get_supersede_contents(node))
        else 
          StatusDialog.new(@xml_doc, @parent, node.name, node.content)
      end
    else
      case @new_status_type
        when 0
          DraftDialog.new(@xml_doc, @parent, nil, [nil, nil], nil)
        when 1
          SubmittedDialog.new(@xml_doc, @parent, nil, nil, [nil, nil], nil)
        when 3
          IssuedDialog.new(@xml_doc, @parent, [nil, nil], nil)
        when 4
          ApplyingDialog.new(@xml_doc, @parent, nil, [nil, nil], nil, nil)
        when 5..8
          SuperDialog.new(@xml_doc, @parent, @status_events[@new_status_type],
          @term_cap, [nil, nil, nil, nil, nil, nil, nil])
        else
        StatusDialog.new(@xml_doc, @parent, @status_events[@new_status_type], nil)
      end
    end
  end

  # Common method for retrieving a date shared by different status dialogues.
  # Returns a string or nil.
  def get_date(node)
    date = node.xpath('rda:Date', Namespace::RDA)[0]
    date = date.content if date
  end
  
  # Common method for retrieving an agency name and number shared by
  # different status dialogues.
  # Returns an array.
  def get_agency(node)
    agency = node.xpath('rda:Agency', Namespace::RDA)[0]
    agency ? [agency.content, agency['agencyno']] : [nil, nil]
  end
  
  # Common method for retrieving contents for all four supersede status events.
  # Returns an array.
  def get_supersede_contents(node)
    idref = get_idref(node)
    title = node.xpath('rda:AuthorityTitleRef', Namespace::RDA)[0]
    title = title.content if title
    itemno = node.xpath('rda:ItemNoRef', Namespace::RDA)[0]
    itemno = itemno.content if itemno
    parttext = node.xpath('rda:PartText', Namespace::RDA)[0]
    parttext = parttext.content if parttext
    [idref[0], idref[1], title, get_terms(node), itemno, parttext, get_date(node)]
  end
end

#
# Custom dialogue for simple status events that only contain a date
# (e.g. approved, revoked, expired).
#
class StatusDialog < MultiDialog
  def initialize(xml_doc, parent, title, content)
    super(title, parent)
    @xml_doc, @node_name = xml_doc, title
    @date = DateWidget.new(@xml_doc, self, content)
    frame = BoldFrame.new(title + " date") << @date
    vbox.add(frame)
    show_all
  end
  
  # Check if a date is entered and whether it is valid.
  # Returns a Nokogiri::XML::Node
  def create_element
    element = Nokogiri::XML::Node.new(@node_name, @xml_doc)
    unless @date.date.text.empty?
      if Utils::valid_date?(@date.date.text)
        element.content = @date.date.text.strip
      else
        Utils::error_dialog('Date must be in format YYYY-MM-DD', self)
      end
    end
    element
  end
end

#
# Shared widget to represent date entry (used by all status events). Contains
# a Gtk::Entry widget and a button to pop up a calendar.
#
class DateWidget < Gtk::HBox
  attr_accessor :date
  
  def initialize(xml_doc, parent, content, name='Date')
    super(false, 0)
    @xml_doc, @parent, @name = xml_doc, parent, name
    @date = Gtk::Entry.new.set_width_chars(10)
    @date.set_text(content) if content
    button = Gtk::Button.new('Select')
    button.signal_connect("clicked") {|widget| show_calendar(@parent)}
    pack_start(@date, false, false, 2).pack_start(button, false, false, 2)
  end

  # Pops up a calendar widget. If user selects a date, update the date.
  # Returns nil.
  def show_calendar(parent)
    dialog = CalendarDialog.new(parent)
    dialog.run do |response|
      if response == 0
        @date.set_text(dialog.date)
      end
      dialog.destroy
    end
    nil
  end
  
  # Check if a date is entered and whether it is valid.
  # Returns a Nokogiri::XML::Node or nil.
  def date_element
    if @date.text.empty?
      nil
    elsif Utils::valid_date?(@date.text)
      element = Nokogiri::XML::Node.new(@name, @xml_doc)
      element.content = @date.text.strip
      element
    else
      Utils::error_dialog('Date must be in format YYYY-MM-DD', @parent)
    end
  end
end

#
# Represents a popup calendar. Used by Date widget.
#
class CalendarDialog < MultiDialog
  def initialize(parent)
    super('Select date', parent)
    @calendar = Gtk::Calendar.new
    @calendar.signal_connect('day-selected-double-click') {|widget| response(0)}
    vbox.add(@calendar)
    show_all
  end
  
  # Returns a string in format YYYY-MM-DD.
  def date
    year = @calendar.year.to_s
    month = @calendar.month + 1
    month = month.to_s
    month = "0" + month if month.length == 1
    day = @calendar.day.to_s
    day = "0" + day if day.length == 1
    date = year + '-' + month + '-' + day
  end
end

#
# Shared widget to represent agency name and number entry (used by a
# number of status events).
#
class Agency < Gtk::HBox
  def initialize(xml_doc, agency_details)
    super(false, 0)
    @xml_doc = xml_doc
    agency, agencyno = agency_details
    @agency = Gtk::Entry.new
    @agencyno = Gtk::Entry.new.set_width_chars(4)
    # Following sets up auto-completion for agency and agencyno entries
    agencies = xml_doc.root.xpath('//rda:Agency', Namespace::RDA)
    agency_titles, agency_nos = Array.new, Array.new
    agencies.each do |node|
      agency_titles << node.content
      agency_nos << node['agencyno'] if node['agencyno']
    end
    @agency.set_completion(Completion.new(agency_titles.uniq))
    @agencyno.set_completion(Completion.new(agency_nos.uniq))
    # Following completes set up of Agency widget
    @agency.set_text(agency) if agency
    agency_frame = PlainFrame.new('Agency', 'Official name of agency') << @agency
    @agencyno.set_text(agencyno) if agencyno
    agencyno_frame = PlainFrame.new('Number', "This element supplied by #{Domain::SHORTNAME}") << @agencyno
    pack_start(agency_frame, false, false, 0).pack_start(agencyno_frame, false, false, 0)
  end

  # Returns a Nokogiri::XML::Node
  def agency_element
    agency, agencyno = @agency.text.strip, @agencyno.text.strip
    if agency.empty? && agencyno.empty?
      nil 
    else
      element = Nokogiri::XML::Node.new('Agency', @xml_doc)
      element.content = agency unless agency.empty?
      element['agencyno'] = agencyno unless agencyno.empty?
      element
    end
  end
end

#
# DraftDialog widget is the dialogue used for the draft status event.
#
class DraftDialog < MultiDialog
  def initialize(xml_doc, parent, version, agency, date)
    super('Draft', parent)
    @xml_doc = xml_doc
    @agency = Agency.new(xml_doc, agency)
    version ? version = version.to_f : version = 1.0
    @version = Gtk::SpinButton.new(1,99,1).set_value(version)
    version_frame = PlainFrame.new('Version', 'Draft number') << @version
    @date = DateWidget.new(xml_doc, self, date)
    date_frame = PlainFrame.new('Date', 'Date of finalisation of draft. In format YYYY-MM-DD') << @date
    hbox = HBox.new(0, version_frame, date_frame)
    v_box = VBox.new(0, @agency, hbox)
    frame = BoldFrame.new('Draft') << v_box
    vbox.add(frame)
    show_all
  end

  # Returns a Nokogiri::XML::Node.
  def create_element
    element = Nokogiri::XML::Node.new('Draft', @xml_doc)
    element['version'] = @version.value.to_i.to_s
    element << @agency.agency_element if @agency.agency_element
    element << @date.date_element if @date.date_element
    element
  end
end

#
# SubmittedDialog widget is the dialogue used for the submitted status event.
#
class SubmittedDialog < MultiDialog
  def initialize(xml_doc, parent, officer, position, agency, date)
    super('Submitted', parent)
    @xml_doc = xml_doc
    @officer, @position = Gtk::Entry.new, Gtk::Entry.new
    @officer.set_text(officer) if officer
    @position.set_text(position) if position
    officer_frame = PlainFrame.new('Officer', "Name of officer responsible for submitting draft. Usually an agency's CEO") << @officer
    position_frame = PlainFrame.new('Position', 'Position title of officer submitting draft. E.g. Chief Executive Officer') << @position
    officer_box = HBox.new(0, officer_frame, position_frame)
    @agency = Agency.new(xml_doc, agency)
    @date = DateWidget.new(xml_doc, self, date)
    date_frame = PlainFrame.new('Date', 'Date of submission. In format YYYY-MM-DD') << @date
    v_box = VBox.new(0, officer_box, @agency, date_frame)
    frame = BoldFrame.new('Submitted') << v_box
    vbox.add(frame)
    show_all
  end

  # Returns a Nokogiri::XML::Node.
  def create_element
    officer_text, position_text = @officer.text.strip, @position.text.strip
    element = Nokogiri::XML::Node.new('Submitted', @xml_doc)
    unless officer_text.empty?
      officer = Nokogiri::XML::Node.new('Officer', @xml_doc)
      officer.content = officer_text
      element << officer
    end
    unless position_text.empty?
      position = Nokogiri::XML::Node.new('Position', @xml_doc)
      position.content = position_text
      element << position
    end
    element << @agency.agency_element if @agency.agency_element
    element << @date.date_element if @date.date_element
    element
  end
end

#
# IssuedDialog widget is the dialogue used for the issued status event.
#
class IssuedDialog < MultiDialog
  def initialize(xml_doc, parent, agency, date)
    super('Issued', parent)
    @xml_doc = xml_doc
    @agency = Agency.new(xml_doc, agency)
    @date = DateWidget.new(xml_doc, self, date)
    date_frame = PlainFrame.new('Date', "Date of issue by #{Domain::SHORTNAME}") << @date
    v_box = VBox.new(0, @agency, date_frame)
    frame = BoldFrame.new('Issued') << v_box
    vbox.add(frame)
    show_all
  end

  # Returns a Nokogiri::XML::Node.
  def create_element
    element = Nokogiri::XML::Node.new('Issued', @xml_doc)
    element << @agency.agency_element if @agency.agency_element
    element << @date.date_element if @date.date_element
    element
  end
end

#
# ApplyingDialog widget is the dialogue used for the applying status event.
#
class ApplyingDialog < MultiDialog
  def initialize(xml_doc, parent, extent, agency, startdate, enddate)
    super('Applying', parent)
    @xml_doc = xml_doc
    @agency = Agency.new(xml_doc, agency)
    @extent = Gtk::ComboBox.new(true).append_text('').append_text('whole').append_text('part')
    if extent == 'whole'
      @extent.set_active(1)
    elsif extent == 'part'
      @extent.set_active(2)
    else
      @extent.set_active(0)
    end
    extent_frame = PlainFrame.new('Extent', "Extent of coverage. 'Whole' means at least 80% of an agency's functional records") << @extent
    @startdate = DateWidget.new(xml_doc, self, startdate, 'StartDate')
    start_frame = PlainFrame.new('Start Date', 'Date an agency commenced applying an authority') << @startdate
    @enddate = DateWidget.new(xml_doc, self, enddate, 'EndDate')
    end_frame = PlainFrame.new('End Date', 'Date an agency ceased applying an authority') << @enddate
    hbox1 = HBox.new(0, @agency, extent_frame)
    hbox2 = HBox.new(0, start_frame, end_frame)
    v_box = VBox.new(0, hbox1, hbox2)
    frame = BoldFrame.new('Applying') << v_box
    vbox.add(frame)
    show_all
  end

  # Returns a Nokogiri::XML::Node.
  def create_element
    element = Nokogiri::XML::Node.new('Applying', @xml_doc)
    element['extent'] = @extent.active_text unless @extent.active_text.empty?
    element << @agency.agency_element if @agency.agency_element
    element << @startdate.date_element if @startdate.date_element
    element << @enddate.date_element if @enddate.date_element
    element
  end
end

#
# SuperDialog widget is the dialogue used for the superseding status events.
#
class SuperDialog < MultiDialog
  def initialize(xml_doc, parent, name, term_cap, super_contents)
    super(name, parent)
    @xml_doc, @name = xml_doc, name
    idcontrol, idno, title, terms, itemno, parttext, date = super_contents
    @idref = IDRef.new(xml_doc, idcontrol, idno)
    @title = AuthorityTitle.new(xml_doc, title)
    @terms = Terms.new(xml_doc, term_cap, terms)
    @itemno = Gtk::Entry.new.set_width_chars(8)
    @itemno.set_text(itemno) if itemno
    classframe = PlainFrame.new('Item number', 'Item number for a superseded or superseding class') << @itemno
    @parttext = Gtk::Entry.new
    @parttext.set_text(parttext) if parttext
    partframe = PlainFrame.new('Part text', 'Use where only some records are affected, e.g. records of patients under the age of 25') << @parttext
    @date = DateWidget.new(xml_doc, self, date)
    date_frame = PlainFrame.new('Date', 'Date of superseding') << @date
    topbox = HBox.new(0, @idref, @title)
    hbox = HBox.new(0, classframe, partframe)
    v_box = VBox.new(0, topbox, @terms, hbox, date_frame)
    frame = BoldFrame.new(@name) << v_box
    vbox.add(frame)
    show_all
  end

  # Returns a Nokogiri::XML::Node.
  def create_element
    element = Nokogiri::XML::Node.new(@name, @xml_doc)
    element << @idref.idref_element if @idref.idref_element
    element << @title.title_element if @title.title_element
    @terms.terms_elements.each {|term| element << term} 
    itemno_text, parttext_text = @itemno.text.strip, @parttext.text.strip
    unless itemno_text.empty?
      itemno = Nokogiri::XML::Node.new('ItemNoRef', @xml_doc)
      itemno.content = itemno_text
      element << itemno
    end
    unless parttext_text.empty?
      parttext = Nokogiri::XML::Node.new('PartText', @xml_doc)
      parttext.content = parttext_text
      element << parttext
    end
    element << @date.date_element if @date.date_element
    element
  end
end

#
# IDRef widget is a common widget used by the superseding status
# events and see references.
#
class IDRef < Gtk::Frame
  def initialize(xml_doc, idcontrol, idno)
    super('ID reference')
    set_shadow_type(Gtk::SHADOW_NONE)
    set_tooltip_text('ID control and number')
    @xml_doc = xml_doc
    controls = [''] + Domain::RDACONTROLS
    @idcontrol = Gtk::ComboBox.new(true)
    controls.each {|control| @idcontrol.append_text(control)}
    idcontrol ? idx = controls.index(idcontrol) : idx = 0
    @idcontrol.set_active(idx) if idx
    @idno = Gtk::Entry.new.set_width_chars(4)
    @idno.set_text(idno) if idno
    hbox = HBox.new(2, @idcontrol, @idno)
    self << hbox
  end

  # Returns a Nokogiri::XML::Node or nil
  def idref_element
    if @idcontrol.active_text.empty? && @idno.text.strip.empty?
      nil 
    else
      element = Nokogiri::XML::Node.new('IDRef', @xml_doc)
      element.content = @idno.text.strip unless @idno.text.strip.empty?
      element['control'] = @idcontrol.active_text unless @idcontrol.active_text.empty?
      element
    end
  end
end

#
# AuthorityTitle widget is a common widget used by the superseding status
# events and see references.
#
class AuthorityTitle < Gtk::Frame
  def initialize(xml_doc, title)
    super('Authority Title')
    @xml_doc = xml_doc
    set_shadow_type(Gtk::SHADOW_NONE)
    set_tooltip_text("Authority's formal title e.g. Administrative Records")
    @title = Gtk::Entry.new.set_width_chars(20)
    @title.set_text(title) if title
    titles = @xml_doc.root.xpath("//rda:AuthorityTitleRef", Namespace::RDA)
    array = titles.collect {|title| title.content}
    @title.set_completion(Completion.new(array.uniq))
    self << @title
  end
  
  def title_element
    if @title.text.strip.empty?
      nil
    else
      title = Nokogiri::XML::Node.new('AuthorityTitleRef', @xml_doc)
      title.content = @title.text.strip
      title
    end
  end
end

#
# The Terms widget is a common widget used by the superseding status
# events and see references.
#
class Terms < Gtk::Frame
  def initialize(xml_doc, term_cap, terms)
    super('Terms')
    set_shadow_type(Gtk::SHADOW_NONE)
    set_tooltip_text("Term title e.g. Construction")
    @xml_doc, @term_cap = xml_doc, term_cap
    @hbox = Gtk::HBox.new(false, 2)
    @terms = Array.new
    terms ? terms.each {|term| addterm(term)} : addterm(nil)
    add = Gtk::Button.new(Gtk::Stock::ADD)
    add.signal_connect("clicked") {|widget| addterm(nil); show_all}
    del = Gtk::Button.new(Gtk::Stock::DELETE)
    del.signal_connect("clicked") {|widget| delterm}
    @hbox.pack_end(add, false, false, 0).pack_end(del, false, false, 0)
    self << @hbox 
  end

  # Pack a new Gtk::Entry into @hbox. Add that widget to the @terms array.
  # Set text to term unless term is nil.
  # Returns nil.
  def addterm(term)
    newterm = Gtk::Entry.new
    newterm.set_text(term) if term
    @terms << newterm
    @hbox.pack_start(newterm, false, false, 0)
    nil
  end
  
  # Remove the last Gtk::Entry from the @terms array and destroy it.
  # Returns nil.
  def delterm
    term = @terms.pop
    term.destroy
    nil
  end

  # Returns an array of Nokogiri::XML::Nodes or an empty array
  def terms_elements
    elements = Array.new
    @terms.each_with_index do |term_entry, idx|
      text = term_entry.text.strip
      unless text.empty?
        text.upcase! if idx == 0 && @term_cap
        element = Nokogiri::XML::Node.new('TermTitleRef', @xml_doc)
        element.content = text
        elements << element
      end
    end
    elements
  end
end

#
# Custom Terms widget for internal see references (InternalDialog).
#
class ThisTerms < Terms

  # Redefined addterm method. Sets up Entry Completion by building up a list
  # of terms already in the authority.
  # Returns nil.
  def addterm(term)
    newterm = Gtk::Entry.new
    context = @xml_doc.root
    @terms.each do |entry|
      new_context = context.xpath("rda:Term[rda:TermTitle='#{entry.text}']",
      Namespace::RDA)[0]
      context = new_context if new_context
    end
    terms = context.xpath('rda:Term/rda:TermTitle', Namespace::RDA)
    term_titles = terms.collect {|title| title.content}
    newterm.set_completion(Completion.new(term_titles))
    newterm.set_text(term) if term
    @terms << newterm
    @hbox.pack_start(newterm, false, false, 0)
    nil
  end
end

#
# GATerms is a custom terms widget for general authority see references.
#
class GATerms < Gtk::Frame
  def initialize(xml_doc, terms)
    super('Terms')
    set_shadow_type(Gtk::SHADOW_NONE)
    @xml_doc = xml_doc
    @terms = terms
    @function = Gtk::ComboBox.new(true)
    @terms.keys.sort.each {|function| @function.append_text(function)}
    @activity_list = Gtk::ListStore.new(String)
    @activity = Gtk::ComboBox.new(@activity_list)
    cell = Gtk::CellRendererText.new
    @activity.pack_start(cell, true)
    @activity.add_attribute(cell, :text, 0)
    @function.signal_connect('changed') {|widget| reset_activity_list}
    @function.set_active(0)
    vbox = Gtk::VBox.new(false, 2)
    vbox.pack_start(@function, false, false, 0).pack_start(@activity, false, false, 0)
    self << vbox
  end

  # Update the activity combo box when a function is selected. Returns nil.
  def reset_activity_list
    @activity_list.clear
    activities = @terms[@function.active_text]
    activities.each {|activity| item = @activity_list.append; item[0] = activity}
    nil
  end
  
  # Returns an array of Nokogiri::XML::Nodes
  def terms_elements
    elements = Array.new
    function = Nokogiri::XML::Node.new('TermTitleRef', @xml_doc)
    function.content = @function.active_text
    elements << function
    activity_content = @activity.active_text
    if activity_content
      unless activity_content.empty?
      activity = Nokogiri::XML::Node.new('TermTitleRef', @xml_doc)
      activity.content = activity_content
      elements << activity
      end
    end
    elements
  end
end

#
# SeeText widget is a common widget used by see references.
#
class SeeText < Gtk::Frame
  def initialize(xml_doc, seetext=nil)
    super('See Text')
    set_shadow_type(Gtk::SHADOW_NONE)
    set_tooltip_text('Defines records covered by the see reference. E.g. for records relating to...')
    @xml_doc = xml_doc
    @seetext = Gtk::Entry.new
    @seetext.set_completion(Completion.new(['for records relating to ']))
    @seetext.set_text(seetext) if seetext
    self << @seetext
  end
  
  def seetext_element
    if @seetext.text.strip.empty?
      nil
    else
      seetext = Nokogiri::XML::Node.new('SeeText', @xml_doc)
      seetext.content = @seetext.text.strip
      seetext
    end
  end
end

#
# Multi-list widget to represent Status events.
#
class SeeReference < Multi
  attr_reader :contents
  def initialize(rdadoc, context='TermDescription')
    @term_cap = rdadoc.preferences[:capitalize_top_term]
    @contents = false
    @context = context
    @ref_index = 0
    @ref_types = ['Internal'] 
    @ref_types += Domain::GENERALAUTHORITIES.collect {|authority| authority[:short_title]}
    @ref_types << 'Another authority'
    columns = [["SeeReference", false, 1]]
    model = Gtk::ListStore.new(String)
    widget = Gtk::ComboBox.new(true)
    @ref_types.each {|type| widget.append_text(type)}
    widget.set_active(0)
    widget.signal_connect('changed') {|widget| @ref_index = widget.active}
    add = Gtk::Button.new(Gtk::Stock::ADD)
    add.signal_connect('clicked') {|widget| show_dialog(nil)}
    seeref_widget = MHBox.new(widget, add)
    super(rdadoc, seeref_widget, columns, model)
    @popup.name = 'SeeReference'
    @list_view.set_headers_visible(false)
  end

  # Custom update_model method. Returns nil.
  def update_model
    context = @current_node.node.xpath("rda:#{@context}", Namespace::RDA)[0]
    if context
      nodes = context.xpath('rda:SeeReference', Namespace::RDA)
      @contents = true if nodes[0]
      nodes.each do |node|
        item = @model.append
        item[0] = XMLtoMarkup::render_see_references(node)
      end
      nil
    end
  end

  # Custom multi_dialog method. Returns a different see reference dialogue depending
  # on a) whether a position paramater is given (when a user double clicks 
  # an existing item)  - in which case just return a standard SeeRefDialog
  # or b) what see reference type is currently selected in the combo drop-down.
  def multi_dialog(pos)
    if pos
      context = @current_node.node.xpath("rda:#{@context}", Namespace::RDA)[0]
      seeref = context.xpath("rda:SeeReference", Namespace::RDA)[pos]
      title = seeref.xpath("rda:AuthorityTitleRef", Namespace::RDA)[0]
      title = title.content if title
      itemno = seeref.xpath("rda:ItemNoRef", Namespace::RDA)[0]
      itemno = itemno.content if itemno
      seetext = seeref.xpath("rda:SeeText", Namespace::RDA)[0]
      seetext = seetext.content if seetext
      idref = get_idref(seeref)
      SeeRefDialog.new(@xml_doc, @parent, @term_cap, idref[0], idref[1],
      title, get_terms(seeref), itemno, seetext)
    else
      case @ref_types[@ref_index]
        when 'Internal' then InternalDialog.new(@xml_doc, @parent, @term_cap)
        when 'Another authority' then SeeRefDialog.new(@xml_doc, @parent, @term_cap, nil, nil, nil, nil, nil, nil)
        else GADialog.new(@xml_doc, @parent, Domain::GENERALAUTHORITIES[@ref_index - 1])
      end
    end
  end
end

#
# Dialogue for regular see references.
#
class SeeRefDialog < MultiDialog
  def initialize(xml_doc, parent, term_cap, idcontrol, idno, title, terms, itemno, seetext)
    super('See reference', parent)
    @xml_doc = xml_doc
    @idref = IDRef.new(xml_doc, idcontrol, idno)
    @title = AuthorityTitle.new(xml_doc, title)
    @terms = Terms.new(xml_doc, term_cap, terms)
    @itemno = Gtk::Entry.new.set_width_chars(8)
    @itemno.set_text(itemno) if itemno
    itemnoframe = PlainFrame.new('Item number', 'Use to reference a particular class') << @itemno
    @seetext = SeeText.new(xml_doc, seetext)
    hbox = HBox.new(0, @idref, @title)
    v_box = VBox.new(0, hbox, @terms, HBox.new(0, itemnoframe), @seetext)
    frame = BoldFrame.new('See reference') << v_box
    vbox.add(frame)
    show_all
  end

  # Returns a Nokogiri::XML::Node
  def create_element
    element = Nokogiri::XML::Node.new('SeeReference', @xml_doc)
    element << @idref.idref_element if @idref.idref_element
    element << @title.title_element if @title.title_element
    @terms.terms_elements.each {|term| element << term} 
    unless @itemno.text.strip.empty?
      itemno = Nokogiri::XML::Node.new('ItemNoRef', @xml_doc)
      itemno.content = @itemno.text.strip
      element << itemno
    end
    element << @seetext.seetext_element if @seetext.seetext_element
    element
  end
end

#
# Dialogue for internal see references.
#
class InternalDialog < MultiDialog
  def initialize(xml_doc, parent, term_cap)
    super('Internal see reference', parent)
    @xml_doc = xml_doc
    @terms = ThisTerms.new(xml_doc, term_cap, nil)
    @seetext = SeeText.new(xml_doc)
    v_box = VBox.new(0, @terms, @seetext)
    frame = BoldFrame.new('Internal see reference') << v_box
    vbox.add(frame)
    show_all
  end

  # Returns a Nokogiri::XML::Node
  def create_element
    element = Nokogiri::XML::Node.new('SeeReference', @xml_doc)
    @terms.terms_elements.each {|term| element << term} 
    element << @seetext.seetext_element if @seetext.seetext_element
    element
  end
end

#
# Dialogue for general authority see references.
#
class GADialog < MultiDialog
  def initialize(xml_doc, parent, general_authority)
    @ga = general_authority
    title = @ga[:short_title] + " see reference"
    super(title, parent)
    @xml_doc = xml_doc
    @terms = GATerms.new(xml_doc, @ga[:terms])
    @seetext = SeeText.new(xml_doc)
    v_box = VBox.new(0, @terms, @seetext)
    frame = BoldFrame.new(title) << v_box
    vbox.add(frame)
    show_all
  end

  # Returns a Nokogiri::XML::Node
  def create_element
    element = Nokogiri::XML::Node.new('SeeReference', @xml_doc)
    idref = Nokogiri::XML::Node.new('IDRef', @xml_doc)
    idref.content = @ga[:id_number]
    idref['control'] = @ga[:id_control]
    element << idref
    title = Nokogiri::XML::Node.new('AuthorityTitleRef', @xml_doc)
    title.content = @ga[:long_title]
    element << title
    @terms.terms_elements.each {|term| element << term} 
    element << @seetext.seetext_element if @seetext.seetext_element
    element
  end
end

#
# Multi-list widget to represent Linked To elements.
#
class LinkedTo < Multi
  def initialize(rdadoc)
    columns = [["Type", true, 0.5], ["Link", true, 0.5]]
    model = Gtk::ListStore.new(String, String)
    add = Gtk::Button.new(Gtk::Stock::ADD)
    add.signal_connect('clicked') {|widget| show_dialog(nil)}
    super(rdadoc, HBox.new(0, add), columns, model)
    @popup.name = "LinkedTo"
  end

  # Custom update_model method. Returns nil.
  def update_model
    nodes = @current_node.node.xpath("rda:LinkedTo", Namespace::RDA)
    nodes.each do |node|
      item = @model.append
      item[0], item[1] = node['type'], node.content
    end
    nil
  end
  
  # Custom multi_dialog method. Returns a LinkedTo dialogue.
  def multi_dialog(pos)
    if pos
      node = @current_node.node.xpath("rda:LinkedTo", Namespace::RDA)[pos]
      content, attr = node.content, node['type']
    else
      content, attr = nil, nil
    end
    LinkedToDialog.new(@xml_doc, @parent, content, attr)
  end
end

#
# Dialogue for 'linked to' elements.
#
class LinkedToDialog < MultiDialog
  def initialize(xml_doc, parent, content, attr)
    super('Add or edit links', parent)
    stocks = Domain::LINKEDTOTYPES
    @xml_doc = xml_doc
    @content = Gtk::Entry.new.set_width_chars(30)
    @content.set_text(content) if content
    @attr = Gtk::ComboBoxEntry.new(true)
    @attr.signal_connect("changed") {|attr| setup_completion(attr.active_text)}
    stocks.each {|stock| @attr.append_text(stock)}
    if attr
      index = stocks.index(attr)
      if index
        @attr.set_active(index)
      else
        @attr.prepend_text(attr)
        @attr.set_active(0)
      end
    end
    content_frame = PlainFrame.new('Link') << @content
    attr_frame = PlainFrame.new('Type') << @attr
    hbox = HBox.new(0, attr_frame, content_frame)
    frame = BoldFrame.new('Linked to...') << hbox
    vbox.add(frame)
    show_all
  end

  # When a linked term control is selected, set up a customised completion
  # for the @content Gtk::Entry.
  # Returns nil.
  def setup_completion(text)
    if text.length > 0
    links = @xml_doc.root.xpath("//rda:LinkedTo[@type='#{text}']", Namespace::RDA)
    linked_tos = links.collect {|link| link.content}
    @content.set_completion(Completion.new(linked_tos.uniq))
    end
    nil
  end

  # Returns a Nokogiri::XML::Node
  def create_element
    element = Nokogiri::XML::Node.new('LinkedTo', @xml_doc)
    element.content = @content.text.strip if @content.text.strip.length > 0
    element['type'] = @attr.active_text.strip if @attr.active_text.strip.length > 0
    element
  end
end

#
# Multi-list widget to represent source lists for context entries.
#
class Sources < Multi
  def initialize(rdadoc)
    columns = [["Source", true, 0.5], ["Web address", true, 0.5]]
    model = Gtk::ListStore.new(String, String)
    add = Gtk::Button.new(Gtk::Stock::ADD)
    add.signal_connect('clicked') {|widget| show_dialog(nil)}
    super(rdadoc, HBox.new(0, add), columns, model)
    @context = 'ContextContent'
    @popup.name = "Source"
  end

  # Custom update_model method. Returns nil.
  def update_model
    context_content = @current_node.node.xpath("rda:ContextContent", Namespace::RDA)[0]
    if context_content
      nodes = context_content.xpath('rda:Source', Namespace::RDA)
      nodes.each do |node|
        item = @model.append
        item[0], item[1] = node.content, node['url']
      end
      nil
    end
  end
  
  # Custom multi_dialog method. Returns a SourcesDialog.
  def multi_dialog(pos)
    if pos
      context_content = @current_node.node.xpath("rda:ContextContent", Namespace::RDA)[0]
      node = context_content.xpath('rda:Source', Namespace::RDA)[pos]
      content, attr = node.content, node['url']
    else
      content, attr = nil, nil
    end
    SourcesDialog.new(@xml_doc, @parent, content, attr)
  end
end

#
# Dialogue for sources.
#
class SourcesDialog < MultiDialog
  def initialize(xml_doc, parent, content, attr)
    super('Add or edit source', parent)
    @xml_doc = xml_doc
    @content = Gtk::Entry.new.set_width_chars(40)
    @content.set_text(content) if content
    @attr = Gtk::Entry.new
    @attr.set_text(attr) if attr
    content_frame = PlainFrame.new('Source title') << @content
    attr_frame = PlainFrame.new('Web address (opt)') << @attr
    hbox = VBox.new(2, content_frame, attr_frame)
    frame = BoldFrame.new('Source') << hbox
    vbox.add(frame)
    show_all
  end
  
  # Returns a Nokogiri::XML::Node
  def create_element
    element = Nokogiri::XML::Node.new('Source', @xml_doc)
    element.content = @content.text.strip if @content.text.strip.length > 0
    element['url'] = @attr.text if @attr.text.strip.length > 0
    element
  end
end

#
# Multi-list widget to represent comments.
#
class Comments < Multi
  def initialize(rdadoc)
    columns = [["Comments", false, 1]]
    model = Gtk::ListStore.new(String)
    add = Gtk::Button.new(Gtk::Stock::ADD)
    add.signal_connect('clicked') {|widget| show_dialog(nil)}
    @rdadoc = rdadoc
    super(rdadoc, HBox.new(0, add), columns, model)
    @popup.name = "Comment"
    @list_view.set_headers_visible(false)
  end

  # Custom update_model method. Returns nil.
  def update_model
    nodes = @current_node.node.xpath('rda:Comment', Namespace::RDA)
    nodes.each {|node| item = @model.append; item[0] = XMLtoMarkup::render_comment(node)}
    nil
  end

  # Custom multi_dialog method. Returns a CommentsDialog.
  def multi_dialog(pos)
    if pos
      node = @current_node.node.xpath('rda:Comment', Namespace::RDA)[pos]
      content, attr = node, node['author']
    else
      content, attr = nil, @rdadoc.preferences[:comment_author]
    end
    CommentsDialog.new(@xml_doc, @parent, @current_node, @rdadoc, content, attr)
  end
end

#
# Dialogue for comments.
#
class CommentsDialog < MultiDialog
  def initialize(xml_doc, parent, current_node, rdadoc, content, attr)
    super('Add or edit comment', parent)
    @xml_doc = xml_doc
    @current_node = current_node
    @attr = Gtk::Entry.new
    @attr.set_text(attr) if attr
    attr_frame = BoldFrame.new('Author') << @attr
    @content = MarkupText.new(content, rdadoc.preferences[:comment_x], rdadoc.preferences[:comment_y], "Comment", self)
    vbox.add(attr_frame).add(@content)
    show_all
  end

  # Returns a Nokogiri::XML::Node
  def create_element
    element = Nokogiri::XML::Node.new('Comment', @xml_doc)
    element['author'] = @attr.text.strip if @attr.text.strip.length > 0
    content = @content.retrieve_text
    unless @content.empty?
      node = @current_node.create_paragraphs(content)
      node.xpath('*').each {|paragraph| element << paragraph}
    end
    element
  end
end

#
# Multi-list widget to represent disposal elements.
#
class Disposals < Multi
  def initialize(rdadoc, update)
    columns = [["Action", false, 0.5], ["Custody", false, 0.5]]
    model = Gtk::ListStore.new(String, String)
    add = Gtk::Button.new(Gtk::Stock::ADD)
    add.signal_connect('clicked') {|widget| show_dialog(nil)}
    @rdadoc, @update = rdadoc, update
    @init = true
    super(rdadoc, HBox.new(0, add), columns, model)
    @popup.name = "Disposal"
  end

  # Custom update_model method. Returns nil.
  def update_model
    nodes = @current_node.node.xpath('rda:Disposal', Namespace::RDA)
    nodes.each do |node|
      item = @model.append
      item[0], item[1] = XMLtoMarkup::make_disposal(node)
    end
    unless @init
      @update.trigger_update(Date::today.to_s) if @rdadoc.main.preferences[:track_update]
    end
    @init = false
    nil
  end
  
  # Custom multi_dialog method. Returns a DisposalsDialog.
  def multi_dialog(pos)
    if pos
      node = @current_node.node.xpath('rda:Disposal', Namespace::RDA)[pos]
      content = [
      node.xpath('rda:DisposalCondition', Namespace::RDA)[0],
      node.xpath('rda:RetentionPeriod', Namespace::RDA)[0],
      node.xpath('rda:DisposalTrigger', Namespace::RDA)[0],
      node.xpath('rda:DisposalAction', Namespace::RDA)[0],
      node.xpath('rda:TransferTo', Namespace::RDA)[0],
      node.xpath('rda:CustomAction', Namespace::RDA)[0],
      node.xpath('rda:CustomCustody', Namespace::RDA)[0]
      ]
    else
      content = [nil, nil, nil, nil, nil, nil, nil]
    end
    DisposalsDialog.new(@xml_doc, @parent, @current_node, content)
  end
end

#
# Dialogue for disposal elements.
#
class DisposalsDialog < MultiDialog
  def initialize(xml_doc, parent, current_node, content)
    super('Add or edit disposal element', parent)
    @xml_doc, @current_node = xml_doc, current_node
    @disposal_condition = Gtk::ComboBoxEntry.new(true)
    @disposal_condition.set_tooltip_text('Where multiple disposal elements are used, include a disposal condition to define which one to use')
    Domain::DISPOSALCONDITIONS.each {|stock| @disposal_condition.append_text(stock)}
    if content[0]
      index = Domain::DISPOSALCONDITIONS.index(content[0].content)
      if index
        @disposal_condition.set_active(index)
      else
        @disposal_condition.prepend_text(content[0].content)
        @disposal_condition.set_active(0)
      end
    end
    @retention_period = Gtk::Entry.new.set_width_chars(3)
    @retention_period.set_text(content[1].content) if content[1]
    unit = content[1]['unit'] if content[1]
    @retention_unit = Gtk::ComboBox.new(true).append_text('years').append_text('months')
    if unit
      unit == "months" ?  @retention_unit.set_active(1) : @retention_unit.set_active(0)
    else
      @retention_unit.set_active(0)
    end
    @disposal_trigger = Gtk::ComboBoxEntry.new(true)
    Domain::DISPOSALTRIGGERS.each {|stock| @disposal_trigger.append_text(stock)}
    if content[2]
      index = Domain::DISPOSALTRIGGERS.index(content[2].content)
      if index
        @disposal_trigger.set_active(index)
      else
        @disposal_trigger.prepend_text(content[2].content)
        @disposal_trigger.set_active(0)
      end
    end
    @disposal_action = Gtk::ComboBox.new(true).append_text('')
    Domain::DISPOSALACTIONS.each {|action| @disposal_action.append_text(action)}
    if content[3]
      index = Domain::DISPOSALACTIONS.index(content[3].content)
      index ? @disposal_action.set_active(index + 1) : @disposal_action.set_active(0)
    else
      @disposal_action.set_active(0)
    end
    @transfer_to = Gtk::Entry.new
    @transfer_to.set_text(content[4].content) if content[4]
    @custom_action = MarkupText.new(content[5], 400, 100, 'Custom action', self)
    @custom_custody = MarkupText.new(content[6], 400, 100, 'Custom custody', self)
    condition_exp = Expander.new('Disposal Condition', expand?(content[0])) << @disposal_condition
    period_frame = PlainFrame.new('Retention period', 'Period of years or months records should be retained before disposal action is carried out') << MHBox.new(@retention_period, @retention_unit)
    trigger_frame = PlainFrame.new('Disposal trigger', 'An event which triggers either a disposal action or the commencement of a retention period') << @disposal_trigger
    retention_frame = BoldFrame.new('Retention')<<  Gtk::HBox.new(false,
    5).pack_start(period_frame, false, false, 0).pack_start(trigger_frame, true, true, 0)
    action_frame = BoldFrame.new('Disposal Action') << @disposal_action
    transfer_frame = BoldFrame.new('Transfer to', "Use with 'Transfer' disposal action e.g. new owner. Do not use for transferring records as State archives - just select the 'Required as State archives' action") << @transfer_to
    custom_box = VBox.new(5, transfer_frame, @custom_action, @custom_custody)
    custom_exp = Expander.new('Custom', expand?(content[4], content[5], content[6])) << custom_box
    vbox.pack_start(condition_exp, false, false, 0).pack_start(retention_frame,
    false, false, 0).pack_start(action_frame, false, false, 0).pack_start(
    custom_exp, false, false, 0)
    if Domain::DISPOSALACTIONS[3] == 'Transfer'
      @disposal_action.signal_connect('changed') do |combo| 
        custom_exp.set_expanded(true) if combo.active == 4
      end
    end
    set_resizable(false) # to resize window when expanders are collapsed
    show_all
  end

  # Test if an expander should expand (if it has content). Returns boolean.
  def expand?(*contents)
    expand = false
    contents.each {|content| expand = true if content}
    expand
  end

  # Returns a Nokogiri::XML::Node.
  def create_element
    element = Nokogiri::XML::Node.new('Disposal', @xml_doc)
    if @disposal_condition.active_text.strip.length > 0
      disposal_condition_element = Nokogiri::XML::Node.new('DisposalCondition', @xml_doc)
      disposal_condition_element.content = @disposal_condition.active_text.strip
      element << disposal_condition_element
    end
    if @retention_period.text.strip.length > 0
      retention_period_element = Nokogiri::XML::Node.new('RetentionPeriod', @xml_doc)
      retention_period_element.content = @retention_period.text.strip
      retention_period_element['unit'] = @retention_unit.active_text
      element << retention_period_element
    end
    if @disposal_trigger.active_text.strip.length > 0
      disposal_trigger_element = Nokogiri::XML::Node.new('DisposalTrigger', @xml_doc)
      disposal_trigger_element.content = @disposal_trigger.active_text.strip
      element << disposal_trigger_element
    end
    if @disposal_action.active_text.length > 0
      disposal_action_element = Nokogiri::XML::Node.new('DisposalAction', @xml_doc)
      disposal_action_element.content = @disposal_action.active_text
      element << disposal_action_element
    end
    if @transfer_to.text.strip.length > 0
      transfer_to_element = Nokogiri::XML::Node.new('TransferTo', @xml_doc)
      transfer_to_element.content = @transfer_to.text.strip
      element << transfer_to_element
    end
    custom_action_content = @custom_action.retrieve_text
    unless @custom_action.empty?
      custom_action_element = Nokogiri::XML::Node.new('CustomAction', @xml_doc)
      node = @current_node.create_paragraphs(custom_action_content)
      node.xpath('*').each {|paragraph| custom_action_element << paragraph}
      element << custom_action_element
    end
    custom_custody_content = @custom_custody.retrieve_text
    unless @custom_custody.empty?
      custom_custody_element = Nokogiri::XML::Node.new('CustomCustody', @xml_doc)
      node = @current_node.create_paragraphs(custom_custody_content)
      node.xpath('*').each {|paragraph| custom_custody_element << paragraph}
      element << custom_custody_element
    end
    element
  end
end




