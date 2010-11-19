#
# The Utils module contains shared methods to create error and confirm dialogs,
# generate a unique file name, sniff the OS, and check that dates are in
# the correct format.
#
module Utils
  module_function

  # Create one of two types of error dialog:
  #
  # * a simple message dialog for short messages
  # * and a message dialog with text view packed in for longer messages.
  #
  # Returns nil.
  def error_dialog(text, parent=nil)
    if text.length > 400
      long_error = text.dup
      text = nil
    end
    dialog = Gtk::MessageDialog.new(parent, Gtk::Dialog::DESTROY_WITH_PARENT, 
    Gtk::MessageDialog::ERROR, Gtk::MessageDialog::BUTTONS_CLOSE, text)
    if long_error
      buffer = Gtk::TextBuffer.new.set_text(long_error)
      text_window = Gtk::TextView.new(buffer).set_wrap_mode(2)
      text_window.set_pixels_above_lines(2).set_pixels_below_lines(2)
      text_window.set_left_margin(2).set_right_margin(2).set_editable(false)
      scroll = Gtk::ScrolledWindow.new
      scroll.set_policy(Gtk::POLICY_AUTOMATIC, Gtk::POLICY_AUTOMATIC)
      scroll.set_shadow_type(Gtk::SHADOW_OUT)
      scroll << text_window
      dialog.vbox.add(scroll)
      dialog.set_size_request(400, 250).set_resizable(true)
      dialog.show_all
    end
    dialog.run
    dialog.destroy
    nil
  end

  # Confirmation dialog. Returns a boolean.  
  def confirm_dialog(text, parent=nil)
    response = false
    dialog = Gtk::MessageDialog.new(parent, Gtk::Dialog::DESTROY_WITH_PARENT,
    Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_OK_CANCEL, text)
    dialog.run do |dialog_response|
      response = true if dialog_response == Gtk::Dialog::RESPONSE_OK 
      dialog.destroy
    end
    response
  end

  # Create a unique file name by adding an incremented number to a base file name.
  # Returns a string.  
  def unique_file_name(file_name, ext = '.xml')
    base = TMPPATH + '/' + file_name
    x = 0
    newfile = nil
    while newfile == nil
      newfile_name = base + x.to_s + ext
      newfile = newfile_name unless File.exist?(newfile_name)
      x = x + 1
    end
    newfile
  end

  # Check that the OS is MS Windows. Returns boolean.
  def os_mswin?
    RUBY_PLATFORM.downcase.include?("mswin")
  end

  # Check that a date field contains YYYY-MM-DD or is empty. Returns boolean.  
  def valid_date?(date)
    if date =~ /(19|20)\d\d-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])/ or date.empty?
      true  
    else
      false
    end  
  end
end
