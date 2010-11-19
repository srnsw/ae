#
# The MainWindow class represents the program's main window.
#
# This class sets up the menu, toolbar and statusbar, contains file methods
# (open, save, close, quit), and holds the XML schema and the user's preferences.
#
class MainWindow < Gtk::Window
  attr_reader :srnsw_xsd, :preferences

  def initialize(path)
    super('XML Retention and Disposal Authority Editor')
    signal_connect("delete-event") {|a, b| file_quit; true}
    Gtk::Window.set_default_icon(Gdk::Pixbuf.new('data/xmlicon.png'))
    set_default_size(1000, 750).maximize
    @user_action = false
    # the docs array contains all open XML documents
    @docs = Array.new
    @notebook = Gtk::Notebook.new.set_scrollable(true)
    @notebook.signal_connect('switch-page') do |book, page, pagenum|
      page_change(@docs[pagenum])
    end
    # create statusbar, file menu, and toolbar
    @statusbar = Gtk::Statusbar.new
    @ui = Gtk::UIManager.new
    add_actions_to_ui
    add_accel_group(@ui.accel_group)
    @ui.add_ui('data/ui.xml')
    # populate the transform menu from the xml manifest file in data directory
    make_manifest_menu
    # add CTRL-J as a shortcut for sample justification popup
    sample_just = Gtk::AccelGroup.new
    sample_just.connect(Gdk::Keyval::GDK_J, Gdk::Window::CONTROL_MASK, Gtk::ACCEL_VISIBLE) {
      widget = focus
      0.upto(2) {widget = widget.parent if widget.parent} if widget
      widget.sample_justification if widget.respond_to?(:sample_justification)
    }
    add_accel_group(sample_just)
    filemenu = @ui.get_widget('/menubar')
    toolbar = @ui.get_widget('/toolbar')
    vbox = Gtk::VBox.new(false, 0)
    vbox.pack_start(filemenu, false, false, 0)
    vbox.pack_start(toolbar, false, false, 0)
    vbox.pack_start(@notebook, true, true, 0)
    vbox.pack_start(@statusbar, false, false, 0)
    self << vbox
    # load preferences from XML file in data directory
    @preferences = load_preferences
    # load XSD schema
    if Domain::VALIDATE
      @srnsw_xsd = Nokogiri::XML::Schema(File.read(Domain::SCHEMALOCATION))
    else
      @srnsw_xsd = false
    end
    # open paths given as arguments to the program or a new file if no path given 
    path[0] ? path.each {|path| read_file(path)} :  file_new
  end

  # Post messages to the statusbar. Returns nil.
  def update_statusbar(message)
    id = @statusbar.get_context_id('text')
    @statusbar.pop(id)
    @statusbar.push(id, message)
    nil
  end

  # Add action groups to the UI manager. Returns nil.
  def add_actions_to_ui
    fileactions = [
    ['File', nil, '_File'], 
    ['New', Gtk::Stock::NEW, nil, nil, nil, lambda {|a,b| file_new}], 
    ['Open', Gtk::Stock::OPEN, nil, nil, nil, lambda {|a,b| file_open}],
    ['Save', Gtk::Stock::SAVE, nil, nil, nil, lambda {|a,b| file_save}], 
    ['SaveAs', Gtk::Stock::SAVE_AS, nil, nil, nil, lambda {|a,b| file_save_as}],
    ['Close', Gtk::Stock::CLOSE, nil, nil, nil, lambda {|a,b| file_close(@notebook.page)}], 
    ['Quit', Gtk::Stock::QUIT, nil, nil, nil, lambda {|a,b| file_quit}]
    ]
    viewchoices = [
    ['Form', Gtk::Stock::EXECUTE, '_Edit form', nil, nil, 0],
    ['Review', Gtk::Stock::DND_MULTIPLE, '_Review', nil, nil, 1],
    ['Source', Gtk::Stock::MISSING_IMAGE, '_Source', nil, nil, 2]
    ]
    viewactions = [
    ['View', nil, '_View'],
    ['Search', Gtk::Stock::FIND, '_Search', "<Control>f", nil, lambda {|a,b| search}],
    ['Details', Gtk::Stock::HOME, '_Details', "<Control>Home", nil, lambda {|a,b| navigate(:home)}],
    ['GoForward', Gtk::Stock::GO_FORWARD, nil, "<Control>Page_Down", nil, lambda {|a,b| navigate(:forward)}],
    ['GoBackward', Gtk::Stock::GO_BACK, nil, "<Control>Page_Up", nil, lambda {|a,b| navigate(:backward)}],
    ['ExpandTree', Gtk::Stock::ADD, 'E_xpand Tree', "<Control>equal", nil, lambda {|a,b| view_expand}],
    ['CollapseTree', Gtk::Stock::REMOVE, '_Collapse Tree', "<Control>minus", nil, lambda {|a,b| view_collapse}],
    ['Preferences', Gtk::Stock::PREFERENCES, nil, nil, nil, lambda {|a,b| edit_preferences}]
    ]
    helpactions = [
    ['HelpMenu', nil, '_Help'],
    ['About', Gtk::Stock::ABOUT, nil, nil, nil, lambda {|a,b| about}],
    ['Help', Gtk::Stock::HELP, nil, nil, nil, lambda {|a,b| help}]
    ]
    transformtop = [
    ['Transform', nil, '_Transform'],
    ['Edit', nil, '_Edit'],
    ['Preview', nil, '_Preview'],
    ['Word', nil, '_Word'],
    ['Export', nil, 'E_xport']
    ]
    maingroup = Gtk::ActionGroup.new('Main').add_actions(fileactions).add_actions(
    viewactions).add_actions(helpactions).add_actions(transformtop)
    maingroup.add_radio_actions(viewchoices) do |previous, current| 
      unless @user_action or @notebook.page == -1
        refresh
        doc = current_page
        new_view = current.current_value
        old_view = doc.view_no
        doc.update_view(new_view) unless old_view == new_view
      end
    end
    @ui.insert_action_group(maingroup, 0)
    nil
  end

  # Populate the transform menu from the XSL files listed in the manifest file
  # in data directory. Returns nil.
  def make_manifest_menu
    xslmenuitems = XSLMenuItems.new(self)
    edit = xslmenuitems.edit
    editui = @ui.get_widget('/menubar/Transform/Edit')
    editui.set_submenu(edit.show_all)
    preview = xslmenuitems.preview
    previewui = @ui.get_widget('/menubar/Transform/Preview')
    previewui.set_submenu(preview.show_all)
    transform = xslmenuitems.transform
    wordui = @ui.get_widget('/menubar/Transform/Word')
    wordui.set_submenu(transform.show_all)
    export = xslmenuitems.export
    exportui = @ui.get_widget('/menubar/Transform/Export')
    exportui.set_submenu(export.show_all)
    nil
  end

  # Determine which XML doc in the @docs array is currently selected by
  # matching against the currently selected @notebook page
  def current_page
    @docs.empty? ? nil : @docs.at(@notebook.page)
  end

  # Swap focus between active widget and notebook in order to force the
  # active widget to update.
  #
  # Many of the form widgets update the underlying XML when a user leaves
  # that widget. It is sometimes necessary to manually force this signal by
  # refreshing because it won't otherwise be given (e.g. when shortcut keys
  # are used for saving etc.)
  # Returns nil.
  def refresh
    widget = focus
    set_focus(@notebook)
    set_focus(widget)
    nil
  end

  # 'File - Save as' method. Returns nil.
  def file_save_as
    doc = current_page
    return unless doc # in case user tries to save on a blank page
    xml_filter = Gtk::FileFilter.new.set_name('XML files').add_pattern("*.xml")
    all_filter = Gtk::FileFilter.new.set_name('All files').add_pattern("*")
    dialog = Gtk::FileChooserDialog.new("Save as", self, Gtk::FileChooser::ACTION_SAVE,
    nil, [Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_CANCEL],
    [Gtk::Stock::SAVE_AS, Gtk::Dialog::RESPONSE_ACCEPT]).add_filter(
    xml_filter).add_filter(all_filter).set_current_name(".xml")
    if dialog.run == Gtk::Dialog::RESPONSE_ACCEPT
      filename = dialog.filename
    end
    dialog.destroy
    if filename
      doc.file_path = filename
      file_write(doc)
      update_label(filename)
    end
  end

  # 'File - Save' method. Returns nil.
  def file_save
    refresh
    doc = current_page
    return unless doc # in case user tries to save on a blank page
    if doc.file_path == :new
      file_save_as
    else 
      if doc.file_changed? # check if another user has altered file by comparing checksums
        label = File.basename(GLib.filename_to_utf8(doc.file_path))
        return nil unless Utils::confirm_dialog("#{label} has been changed by another user.\nBy saving you will overwrite their changes.\nDo you still wish to proceed?", self)
      end
      file_write(doc)
    end
  end

  # During a 'File - Save' or 'Save as' operation, write the xml to the target file.
  # Returns nil.
  def file_write(doc)
    doc.xml_changed = false
    xml = doc.xml_doc
    if xml
      begin
        File.open(doc.file_path, 'w') {|f| xml.write_xml_to(f, :encoding => 'UTF-8',
        :indent => 2)}
      rescue
        Utils::error_dialog("Error writing to file:\n#{$!}")
        error = true
      end
    else
      begin
        File.open(doc.file_path, 'w') {|f| f.write(doc.page.buffer_text)}
      rescue
        Utils::error_dialog("Error writing to file:\n#{$!}")
        error = true
      end
    end
    if error
      nil
    else
      doc.on_save # update the document's checksum
      update_statusbar("Saved to #{doc.file_path}")
    end
  end

  # Prompt user if file changed then close file.
  # Returns boolean (true if page successfully removed, false otherwise).
  def file_close(number)
    refresh
    return true if number == -1
    doc = @docs.at(number)
    if doc.xml_changed
      if doc.file_path == :new
        label = 'new.xml'
      else
        label = File.basename(GLib.filename_to_utf8(doc.file_path))
      end
      response = Utils::confirm_dialog("#{label} has been changed.\nBy closing you will lose these changes.\nDo you still wish to proceed?", self) 
      response ? remove_page(number) : false
    else 
      remove_page(number)
    end
  end

  # Complete a close operation by removing the notebook page and then
  # removing the document from the docs array.
  # Returns true.
  def remove_page(number)
    doc = @docs.at(number)
    @notebook.remove_page(number)
    @docs.delete_at(number)
    current_page ? current_page.update_status_message : update_statusbar('')
    @notebook.queue_draw
    true
  end

  # Tidy up the tmp directory (contains outputs of XSL transforms) on exit.
  # Returns nil.
  def clear_temp
    entries = Dir.new(TMPPATH).entries
    entries.each {|entry| FileUtils.remove_file("#{TMPPATH}/#{entry}", true)}
    nil 
  end

  # 'File - Quit' method. Close all documents (current first and the remainder
  # in reverse order), clear tmp directory, then exit.
  # Returns true (to intercept the GTK destroy signal).
  def file_quit
    continue = file_close(@notebook.page)
    return true unless continue
    array = @docs.dup.reverse
    array.each do |doc| 
      continue = file_close(@docs.index(doc))
      break unless continue
    end
    if @docs.empty?
      clear_temp
      Gtk.main_quit
    end
    true
  end

  # 'File - new' method. Call read_file with :new as the param. Returns nil.
  def file_new
    read_file(:new)
  end

  # 'File - open' method. Get a filename from user then call read_file. Returns nil.
  def file_open
    xml_filter = Gtk::FileFilter.new.set_name('XML files').add_pattern("*.xml")
    all_filter = Gtk::FileFilter.new.set_name('All files').add_pattern("*")
    dialog = Gtk::FileChooserDialog.new("Open an XML file", self,
    Gtk::FileChooser::ACTION_OPEN, nil, [Gtk::Stock::CANCEL,
    Gtk::Dialog::RESPONSE_CANCEL],[Gtk::Stock::OPEN,
    Gtk::Dialog::RESPONSE_ACCEPT]).add_filter(xml_filter).add_filter(all_filter)
    if dialog.run == Gtk::Dialog::RESPONSE_ACCEPT
      filename = dialog.filename
    end
    dialog.destroy
    if filename
      close_new
      if File.file?(filename)
        read_file(filename)
      else
        Utils::error_dialog("Unable to read file (#{filename})", self)
      end
    end
  end

  # When opening a file, remove the current page if it is an unchanged new file.
  # Returns nil.
  def close_new
    if @docs.length == 1
      doc = @docs[0]
      if doc.file_path == :new
        remove_page(0) unless doc.xml_changed
      end
    end
    nil
  end

  # Create a new RDADoc and then append it to the notebook.
  # Returns nil.
  def read_file(path)
    path == :new ?  label = 'new.xml' : label = File.basename(GLib.filename_to_utf8(path))
    doc = RDADoc.new(path, self)
    append_page(doc, label)
  end

  # Create a notebook label combining a 'file close' button with the document's
  # filename. Returns a Gtk::Hbox.
  def make_label(label, page)
    label = Gtk::Label.new(label)
    button = Gtk::Button.new.add(Gtk::Image.new(Gtk::Stock::CLOSE,
    Gtk::IconSize::MENU)).set_border_width(0).set_relief(Gtk::RELIEF_NONE)
    button.signal_connect('clicked') {file_close(@notebook.page_num(page))}
    box = Gtk::HBox.new(false, 4).pack_start(label, true, true, 0).pack_start(
    button, false, false, 0).show_all
  end

  # Update the notebook label during a 'File - Save as' operation. Returns nil.
  def update_label(path)
    page = @notebook.get_nth_page(@notebook.page)
    label = make_label(File.basename(GLib.filename_to_utf8(path)), page)
    @notebook.set_tab_label(page, label)
    nil
  end

  # Create a new notebook page and append the RDADoc's view to that page.
  # Returns nil.
  def append_page(doc, label)
    @docs.push(doc)
    page = doc.view
    @notebook.append_page(page, nil)
    number = @notebook.page_num(page)
    label = make_label(label, page)
    @notebook.set_tab_label(page, label)
    @notebook.show_all
    @notebook.page = number
    nil
  end

  # When a user switches between notepad pages, reset the radio buttons
  # and update the statusbar message. Returns nil.
  def page_change(rdadoc)
    toggle_view(rdadoc.view_no)
    rdadoc.current_node ? rdadoc.update_status_message :  update_statusbar("")
  end

  # When a user switches between notepad pages, reset the radio buttons.
  # Returns nil.
  def toggle_view(view_no)
    @user_action = true
    form = @ui.get_action('/menubar/View/Form')
    form.set_current_value(view_no)
    @user_action = false
    nil
  end

  # Create a search dialogue (see widgets_search.rb). Returns nil.
  def search
    doc = current_page
    return unless doc
    refresh unless doc.view_no == 1
    return unless doc.current_node
    dialog = SearchDialog.new(doc.xml_doc.root, doc.page, self).show_all
    dialog.run {|response| dialog.destroy}
    nil
  end

  # Home, forwards and backwards navigation methods are implemented 
  # differently by each of the program views (edit, review and source).
  # This method passes the navigate signal on to the currently selected view.
  # Returns nil.
  def navigate(direction)
    doc = current_page
    return unless doc
    refresh if doc.view_no == 0
    doc.page.navigate(direction)
  end

  # Expand the tree menu in edit form view. Returns nil.
  def view_expand
    doc = current_page
    return unless doc
    doc.view_no == 0 ? doc.page.treemenu.expand_all : nil 
  end

  # Collapse the tree menu in edit form view. Returns nil.
  def view_collapse
    doc = current_page
    return unless doc
    doc.view_no == 0 ? doc.page.treemenu.collapse_all : nil
  end

  # Load the user preferences from the preferences file in data directory.
  # Returns a Hash.
  def load_preferences
    hash = Hash.new
    xml_doc = Nokogiri::XML(File.new(APPPATH + '/preferences.xml'))
    xml_doc.root.xpath('*').each do |child|
      if child.text == 'true'
        text = true
      elsif child.text == 'false'
        text = false
      elsif child.text =~ /\A\d+\z/
        text = child.text.to_i
      else 
        text = child.text
      end
      hash[child.name.to_sym] = text 
    end
    hash
  end

  # Load 'Preferences' dialogue (see widgets_prefs.rb). Returns nil.
  def edit_preferences
    dialog = PreferencesDialog.new(@preferences, self).show_all
    dialog.run do |response|
      if response == 0
        dialog.update_preferences
      end
      dialog.destroy
    end
    nil
  end

  # Load 'Help' dialogue (see widgets_help.rb). Returns nil.
  def help
    dialog = HelpDialog.new(self)
    dialog.run {|response| dialog.destroy}
    nil
  end

  # Load 'About' dialogue. 
  def about
    license = File.open('COPYING') {|f| f.read}
    Gtk::AboutDialog.show(self, 
    :name => 'XML Retention and Disposal Authority Editor', 
    :comments => "This program is a full implementation of State Records New South Wales' XML schema for retention and disposal authorities.",
    :version => '1.0',
    :copyright => 'Copyright (c) State of New South Wales through the State Records Authority of New South Wales, 2009',
    :license => license,
    :authors => ['Richard Lehane'],
    :documenters => ["Kama Gabara", "Emma Harris", "Angela McGing", "Peri Stewart"],
    :logo => Gdk::Pixbuf.new('data/xmlicon.png'),
    :program_name => 'XML RDA Editor',
    :website => 'http://www.records.nsw.gov.au'
    )
    nil
  end
end



