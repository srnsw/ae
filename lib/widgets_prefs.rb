#
# PreferencesDialog is the dialogue in which a user sets their default preferences.
#
class PreferencesDialog < Gtk::Dialog
  def initialize(prefs, window)
    super("Preferences", window, Gtk::Dialog::MODAL, [Gtk::Stock::APPLY, 0],
    [Gtk::Stock::CANCEL, 1])
    @preferences, @window = prefs, window
    @comment_author = Gtk::Entry.new.set_text(@preferences[:comment_author])
    comment = PlainFrame.new('Comments author', 'Set a default author for comments') << @comment_author
    @context_type = Gtk::Entry.new.set_text(@preferences[:context_type])
    context = PlainFrame.new('Context type', 'Set a default type for context entries') << @context_type
    @capitalize = Gtk::CheckButton.new('Capitali_ze top-level terms', true).set_active(
    @preferences[:capitalize_top_term])
    @auto_expand = Gtk::CheckButton.new('Auto _expand tree menu', true).set_active(
    @preferences[:auto_expand])
    @term_set_only = Gtk::CheckButton.new(Domain::TERMSET1[:pref], true).set_active(
    @preferences[:term_set_only])
    defaults = BoldFrame.new('Defaults') << VBox.new(0, comment, context, @capitalize, @auto_expand, @term_set_only)
    @single_page_view = Gtk::CheckButton.new('_Single page view', true).set_active(
    @preferences[:single_page_view])
    @context_y = Gtk::SpinButton.new(50,1000,10).set_value(@preferences[:context_y].to_f)
    context_dimensions = PlainFrame.new('Context height', 'Customise the height of the context rich text fields') << @context_y
    @markup_y = Gtk::SpinButton.new(50,1000,10).set_value(@preferences[:markup_y].to_f)
    markup_dimensions = PlainFrame.new('Markup height', 'Customise the height of description and justification fields') << @markup_y
    dimensions = HBox.new(0, context_dimensions, markup_dimensions)
    @comment_x = Gtk::SpinButton.new(50,1000,10).set_value(@preferences[:comment_x].to_f)
    @comment_y = Gtk::SpinButton.new(50,1000,10).set_value(@preferences[:comment_y].to_f)
    comment_box = HBox.new(2, @comment_x, Gtk::Label.new('by'), @comment_y)
    comment_dimensions = PlainFrame.new('Comments dimensions', 'Customise the width and height of comments dialogues') << comment_box
    @pagewidth = Gtk::SpinButton.new(50,2000,10).set_value(@preferences[:pagewidth].to_f)
    pagewidth = PlainFrame.new('Page width', 'This setting controls text-wrapping for see references, status events, etc. By adjusting it, you may be able to fit more on the page.') << @pagewidth
    layout = BoldFrame.new('Layout') << VBox.new(0, @single_page_view, dimensions, comment_dimensions, pagewidth)
    @track_update = Gtk::CheckButton.new('_Track updates', true).set_active(@preferences[:track_update])
    @hilite = Gtk::Entry.new.set_width_chars(10).set_text(@preferences[:hilite_updates_since])
    button = Gtk::Button.new('Select')
    button.signal_connect("clicked") {|widget| show_calendar(self)}
    clear = Gtk::Button.new('Clear')
    clear.signal_connect("clicked") {|widget| @hilite.set_text('')}
    hilite = PlainFrame.new('Highlight updates since') << HBox.new(0, @hilite, button, clear)
    updates = BoldFrame.new('Updates') << VBox.new(0, @track_update, hilite)
    vbox.add(defaults).add(layout).add(updates)
  end
  
  # Commit a user's changes to the @preferences variable. Returns nil.
  def update_preferences
    @preferences[:comment_author] = sanitize(@comment_author.text)
    @preferences[:context_type] = sanitize(@context_type.text)
    @preferences[:capitalize_top_term] = @capitalize.active?
    @preferences[:auto_expand] = @auto_expand.active?
    @preferences[:term_set_only] = @term_set_only.active?
    @preferences[:single_page_view] = @single_page_view.active?
    @preferences[:context_y] = @context_y.value.to_i
    @preferences[:markup_y] = @markup_y.value.to_i
    @preferences[:comment_x] = @comment_x.value.to_i
    @preferences[:comment_y] = @comment_y.value.to_i
    @preferences[:pagewidth] = @pagewidth.value.to_i
    @preferences[:track_update] = @track_update.active?
    if Utils::valid_date?(@hilite.text)
      @preferences[:hilite_updates_since] = @hilite.text
    else
      Utils::error_dialog('Date must be in format YYYY-MM-DD', @window)
    end
    update_xml
  end
  
  # Match 'true', 'false' and integers and where found add whitespace to the string.
  # This prevents errors in main.rb when the preferences are loaded.
  # Returns a string.
  def sanitize(text)
    case text
      when 'true', 'false', /\A\d+\z/
        text + ' '
      else
        text
    end
  end

  # Commit a user's changes to the preferences.xml file. Returns nil.
  def update_xml
    path = APPPATH + '/preferences.xml'
    xml_doc = Nokogiri::XML(File.open(path) {|f| f.read})
    xml_doc.root.xpath('*').each do |child|
      text = @preferences[child.name.to_sym]
      if text == true
        text = 'true'
      elsif text == false
        text = 'false'
      elsif text.kind_of? Integer
        text = text.to_s
      end 
      child.content = text 
    end
    File.open(path, 'w') {|f| xml_doc.write_to(f)}
    nil
  end

  # Pop a calendar widget (defined in widgets_multi.rb). Returns nil.
  def show_calendar(parent)
    dialog = CalendarDialog.new(parent)
    dialog.run do |response|
      @hilite.set_text(dialog.date) if response == 0
      dialog.destroy
    end
    nil
  end
end



    
    
