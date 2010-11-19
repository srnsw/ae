#
# A Gtk::Frame with a simple label and no border
#
class PlainFrame < Gtk::Frame
  def initialize(label, tip=nil)
    super(label)
    set_tooltip_text(tip) if tip
    set_shadow_type(Gtk::SHADOW_NONE)
  end
end

#
# A Gtk::Frame with a bold label and no border
#
class BoldFrame < Gtk::Frame
  def initialize(label, tip=nil)
    super()
    set_label_widget(Gtk::Label.new.set_markup("<b>#{label}</b>"))
    set_tooltip_text(tip) if tip
    set_shadow_type(Gtk::SHADOW_NONE)
  end
end
  
#
# A Gtk::HBox packed with widgets.
#
class HBox < Gtk::HBox
  def initialize(separator, *widgets)
    super(false, 0)
    widgets.each {|widget| pack_start(widget, false, false, separator)}
  end
end

#
# Slight variant on HBox class used by multi-list widgets. I probably should
# have been more consistent with the layout than this!
#
class MHBox < Gtk::HBox
  def initialize(*widgets)
    super(false, 5)
    widgets.each {|widget| pack_start(widget, false, false, 0)}
  end
end

#
# A Gtk::VBox packed with widgets.
#
class VBox < Gtk::VBox
  def initialize(separator, *widgets)
    super(false, 0)
    widgets.each {|widget| pack_start(widget, false, false, separator)}
  end
end

#
# A Gtk::EntryCompletion loaded with an array of strings.
#
class Completion < Gtk::EntryCompletion
  def initialize(array)
    super()
    list = Gtk::ListStore.new(String)
    array.each {|string| iter = list.append; iter.set_value(0, string)}
    set_text_column(0).set_model(list)
  end
end

#
# A Gtk::Expander that is expanded or not.
#
class Expander < Gtk::Expander
  def initialize(label, expanded=false)
    super(label, false)
    set_expanded(expanded)
  end
end

#
# CustomEntry represents a simple entry field. This class expects a block,
# which it calls when a user leaves the widget (this is what triggers updates).
#
class CustomEntry < Gtk::Entry
  def initialize(name, content, length=nil)
    super()
    set_width_chars(length) if length
    set_text(content) if content
    changed = false
    signal_connect("changed") {changed = true}
    signal_connect("focus-out-event") do |widget, event|
      if changed
        yield(name, widget.text.strip)
        changed = false
      end
      false
    end
  end
end

#
# CustomCombo represents simple drop down boxes. This class expects a block,
# which it calls when a user makes a selection.
#
class CustomCombo < Gtk::ComboBox
  def initialize(items, content)
    super(true)
    items.each {|item| append_text(item)}
    set_active(items.index(content)) if content and items.index(content)
    signal_connect("changed") {|combo| yield(items[active])}
  end
end


#
# CustomCombo represents simple drop down boxes. This class expects a block,
# which it calls when a user makes a selection.
#
class CustomComboEntry < Gtk::ComboBoxEntry
  def initialize(items, content)
    super(true)
    items.each {|item| append_text(item)}
    if content
      index = items.index(content)
      if index
        set_active(index)
      else
        prepend_text(content)
        set_active(0)
      end
    end
    signal_connect("changed") {|combo| yield(active_text)}
  end
end

#
# CustomCheck represents simple check button fields. This class expects a block,
# which it calls when a user toggles the widget.
#
class CustomCheck < Gtk::CheckButton
  def initialize(label, state)
    super(label)
    set_active(true) if state
    signal_connect("toggled") {|check| yield(check.active?)}
  end
end

#
# Publish represents the "Publish" drop down. 
#
class Publish < PlainFrame
  attr_reader :contents
  
  def initialize(current_node)
    super('Publish')
    publish_content = current_node.get_attribute(nil, 'publish')
    publish_content ? @contents = true : @contents = false
    self << CustomCombo.new(['', 'true', 'false'], publish_content) do |content|
      current_node.update_attribute(nil, 'publish', content)
    end
  end
end

#
# Date range represents the start and end date fields. 
#
class DateRange < BoldFrame
def initialize(current_node)
  if current_node.node.name == 'Authority'
    label = 'Authority date range'
    tip = 'Date range of records covered by this authority'
  else
    label = 'Local date range'
    tip = 'Date range of records covered by this term or class'
  end
  super(label, tip)
  start_year = Year.new('Start', current_node, 0) 
  end_year = Year.new('End', current_node, 1)
  self << HBox.new(0, start_year, end_year)
end
end

#
# Year is used by DateRange widget for start and end date fields. 
#
class Year < PlainFrame
def initialize(name, current_node, position)
  super(name)
  circa = CustomCheck.new('circa', current_node.get_state(name, 'circa',
  'DateRange')) do |state|
    state ? content = "true" : content = String.new
    current_node.update_nested_attribute('DateRange', name, 'circa', content, position)
  end
  year = CustomEntry.new(name, current_node.get_content(name, 'DateRange'),
  4) {|el_name, text| current_node.update_nested_element('DateRange', el_name, text, position)}
  self << HBox.new(0, year, circa)
end
end

#
# TypeWidget represents the term type selection drop down. 
#
class TypeWidget < BoldFrame
  def initialize(current_node)
    type_array = [''] + Domain::TERMTYPES
    super('Term Type', "Select term type e.g. '#{type_array[1]}'")
    combo = CustomCombo.new(type_array, current_node.get_attribute(nil,
    'type')) {|content| current_node.update_attribute(nil, 'type', content)}
    self << combo
  end
end

#
# Update represents the update field. 
#
class Update < BoldFrame
  def initialize(rdadoc)
    super('Last updated', 'Date of last update')
    @current_node = rdadoc.current_node
    button = Gtk::Button.new('Select')
    button.signal_connect("clicked") {|widget| show_calendar(rdadoc.main)}
    @date = CustomEntry.new('update', @current_node.get_attribute(nil, 'update'), 
    10) do |at_name, text|
      if Utils::valid_date?(text)
        @current_node.update_attribute(nil, at_name, text)
      else
        Utils::error_dialog('Date must be in format YYYY-MM-DD', rdadoc.main)
        @date.text = ''
      end
    end
    self << HBox.new(2, @date, button)
  end

  # Pops a calendar. Returns nil.
  def show_calendar(parent)
    dialog = CalendarDialog.new(parent)
    dialog.run do |response|
      if response == 0
        trigger_update(dialog.date)
      end
      dialog.destroy
    end
    nil
  end

  # Populates the update field and updates the XML. Returns nil.
  def trigger_update(date)
    @date.set_text(date)
    @current_node.update_attribute(nil, 'update', date)
    nil
  end
end





