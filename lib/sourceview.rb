#
# The SourceView class represents the application's source view. This view
# allows de-bugging, checking of the underlying XML, and hand edits.
#
class SourceView < Gtk::ScrolledWindow
  
  def initialize(rdadoc)
    super()
    set_policy(Gtk::POLICY_AUTOMATIC, Gtk::POLICY_ALWAYS)
    @rdadoc = rdadoc
    @path = nil
    @init = true
    @buffer = Gtk::SourceBuffer.new
    if @rdadoc.xml_doc
      xml_string = @rdadoc.xml_doc.to_xml
      language_manager = Gtk::SourceLanguagesManager.new
      @buffer.language = language_manager.get_language("text/xml")
      @buffer.highlight = true
      @buffer.check_brackets = true
      if @rdadoc.current_node
        @path = @rdadoc.current_node.node.path  
        @new_doc  = Nokogiri::XML(xml_string)   
        current_line(@path)
      end
    else
      xml_string = File.open(@rdadoc.file_path) {|f| f.read}
    end
    @buffer.set_text(xml_string)
    @source_window = Gtk::SourceView.new(@buffer)
    @source_window.set_show_line_numbers(true).set_highlight_current_line(true)
    add(@source_window)
    @buffer.signal_connect('mark-set') {|buffer, i, m| scroll_to_current_line if @init}
    @buffer.set_modified(false)
    @source_window.signal_connect("focus-out-event") do |widget, event|
      trigger_reparse if @buffer.modified?
      false
    end
  end
  
  # Re-load rdadoc's xmldoc variable from the current buffer. This allows users
  # to update the XML document from the sourceview.
  # Returns nil.  
  def trigger_reparse
    @rdadoc.trigger_change
    @rdadoc.reparse(@buffer.text, @path)
    @new_doc  = Nokogiri::XML(@buffer.text) if @rdadoc.current_node
    @buffer.set_modified(false)
    nil
  end
  
  # Used by the file_write method of main to allow users to save their work
  # even if they don't have a well-formed XML document to save.
  # Returns a string.   
  def buffer_text
    @buffer.text
  end
  
  # Only called when source view initialized, necessary to attach this to
  # mark-set signal because of a ruby GTK sourceview bug that prevents scrolling
  # working properly on initial startup.
  # Returns nil.  
  def scroll_to_current_line 
    @init = false
    unless @rdadoc.errors
      iter = @buffer.get_iter_at_line(@current_line)
      @buffer.place_cursor(iter)
      @source_window.scroll_to_mark(@buffer.get_mark("insert"), 0.0, true, 0.0, 0.5)
    end
    nil
  end
    
  # To get a current line number: 1) get the current node's xpath, 
  # 2) reparse the xml document, 3) search for the node in the re-parsed
  # document and 4) get its up-to-date line number.
  # Returns nil
  def current_line(path)
    @current_line = @new_doc.xpath(path)[0].line - 1
    nil
  end
    
  # Implementation of navigate methods (home, forwards, backwards and search)
  # for this view.
  # Returns nil.
  def navigate(direction, path=nil)
    trigger_reparse if @buffer.modified?
    if @rdadoc.current_node
      @rdadoc.current_node.navigate(direction, path)
      path = @rdadoc.current_node.node.path
      current_line(path)
      scroll_to_current_line
    end
  end
end
