#
# Creates markup areas with markup buttons for the description, justification,
# context content and comments fields of the form.
#
class MarkupText < Gtk::Frame
  def initialize(node, x, y, title, win=nil)
    super()
    @win = win
    set_label_widget(Gtk::Label.new.set_markup("<b>#{title}</b>"))
    vbox = Gtk::VBox.new(false, 0).set_size_request(x, y)
    buttonbox = Gtk::HButtonBox.new.set_layout_style(Gtk::ButtonBox::END)
    # Add emphasis, source, link and list buttons to the button box
    buttonbox.pack_start(@emph_button = create_button(Gtk::Stock::BOLD,
    ' <b>Emp</b>', 'Emphasis', 'Use to emphasise a particular word e.g. <b>not</b>'),
    false, false, 0).pack_start(@src_button = create_button(Gtk::Stock::ITALIC,
    ' <i>Src</i>', 'Source', 'Use to identify titles of sources e.g. <i>Wild Dog Destruction Board Annual Report 1999</i>'),
    false, false, 0).pack_start(@link_button = create_button(Gtk::Stock::CONVERT,
    ' <u>Link</u>', :link, 'Use to identify titles of sources with hyperlinks e.g. <u>Agency Website</u>'),
    false, false, 0).pack_start(@list_button = create_button(Gtk::Stock::INDENT,
    ' List', :list, 'Use to create bulleted lists'), false, false, 0)
    scroll = Gtk::ScrolledWindow.new.set_policy(Gtk::POLICY_AUTOMATIC,
    Gtk::POLICY_AUTOMATIC).set_shadow_type(Gtk::SHADOW_OUT)
    vbox.pack_start(buttonbox, false, false, 2).pack_start(scroll, true, true, 0)
    self << vbox
    # Add the text view
    scroll << @text = Gtk::TextView.new.set_wrap_mode(2).set_pixels_above_lines(
    4).set_pixels_below_lines(4).set_left_margin(4).set_right_margin(
    2).set_tabs(Pango::TabArray.new(1, true).set_tab(0, Pango::TAB_LEFT, 15))
    @buffer = @text.buffer
    # Create two simple tags for emphasis and source, these just bold and italicize
    @emphasis = @buffer.create_tag('Emphasis', {'weight' => Pango::FontDescription::WEIGHT_BOLD})
    @source = @buffer.create_tag('Source', {'style' => Pango::FontDescription::STYLE_ITALIC})
    # Catch right clicks to check for unnamed tags which are used for linked sources
    @text.signal_connect("event-after") do |widget, event| 
      if event.event_type == Gdk::Event::BUTTON2_PRESS
        buffer_x, buffer_y = @text.window_to_buffer_coords(
        Gtk::TextView::WINDOW_TEXT, event.x, event.y)
        iter = @text.get_iter_at_location(buffer_x, buffer_y)
        iter.tags.each {|tag| tag.url = edit_url(tag.url) unless tag.name}
      end
    end
    # The @user_action attribute ensures that only user interactions toggle the buttons
    @buffer.signal_connect("begin_user_action") {@user_action = false}
    @buffer.signal_connect("end_user_action") {@user_action = true}
    buttons = [[@emph_button, 'Emphasis'],[@src_button, 'Source'],[@link_button, nil]]
    # When a user moves the cursor, check for tags and lists and toggle the buttons accordingly
    @buffer.signal_connect("mark-set") do |w, iter, mark|
      if @text.focus? 
        startiter, enditer, selection = @buffer.selection_bounds
        active_tags = startiter.tags
        @buffer.begin_user_action
        # Check startiter for presence of tags and toggle buttons for any tags
        buttons.each do |button|
          if active_tags[0] and button[1] == active_tags[0].name  
            button[0].set_active(true)
          else
            button[0].set_active(false)
          end 
        end
        # Check all lines selected for bullet points
        list = true
        line = startiter.line
        lines = selection_lines(startiter, enditer)
        list = false unless line_contains_list?(line)
        lines.times do 
          line = line + 1
          list = false unless line_contains_list?(line)
        end
        @list_button.set_active(list)                     
        @buffer.end_user_action
      end
    end
    # retrieve and parse paragraphs 
    if node       
      node.xpath('rda:Paragraph', Namespace::RDA).each do |para| 
        format_paragraph(para, nil)
        @buffer.insert(@buffer.end_iter, "\n")
      end
    @buffer.set_modified(false)
    end
  end

  # This method creates the markup buttons.
  # Returns a Gtk::ToggleButton.
  def create_button(image, label, tag, tooltip)
    hbox = Gtk::HBox.new
    hbox.pack_start(Gtk::Image.new(image, Gtk::IconSize::MENU))
    hbox.pack_start(Gtk::Label.new.set_markup(label))
    button = Gtk::ToggleButton.new.set_can_focus(false).set_tooltip_markup(tooltip)
    button.signal_connect('clicked') do |widget|
      if @user_action
        widget.active? ? toggled_callback(tag) : not_toggled_callback(tag)
        @buffer.modified = true
      end 
    end
    button << hbox
  end
  
  # Called when a user toggles a button. Add list, emphasis or source markup
  # to selection, line or word.
  # Returns nil.
  def toggled_callback(tag)
    startiter, enditer, selection = @buffer.selection_bounds
    if tag == :list
      line = startiter.line
      lines = selection_lines(startiter, enditer)
      insert_list(line) unless line_contains_list?(line)
      lines.times do 
        line += 1
        insert_list(line) unless line_contains_list?(line)
      end
    else
      tag = add_link(edit_url("http://")) if tag == :link
      if selection
        if selection_lines(startiter, enditer) > 0
          enditer.backward_lines(selection_lines(startiter, enditer))
          enditer.forward_to_line_end
        end
        if selection_contains_list?(startiter, startiter.line_offset, enditer.line_offset)
          proceed_to_bullet_point(startiter)
          enditer = startiter unless enditer > startiter
        end
        @buffer.remove_all_tags(startiter, enditer)
        @buffer.apply_tag(tag, startiter, enditer)
      elsif startiter.inside_word? or startiter.ends_word?
        startiter.backward_word_start unless startiter.starts_word?
        enditer.forward_word_end unless enditer.ends_word?
        @buffer.remove_all_tags(startiter, enditer)
        @buffer.apply_tag(tag, startiter, enditer) if startiter and enditer
      end
    end
    nil
  end
  
  # Called when a user un-toggles a button. Remove markup from selection,
  # line or word.
  # Returns nil.
  def not_toggled_callback(tag)
    startiter, enditer, selection = @buffer.selection_bounds
    if tag == :list
      line = startiter.line
      lines = selection_lines(startiter, enditer)
      remove_list(line)
      lines.times do 
        line += 1
        remove_list(line)
      end
    else
      if selection
        @buffer.remove_all_tags(startiter, enditer)
      else
        startiter.backward_to_tag_toggle(nil)
        enditer.forward_to_tag_toggle(nil)
        @buffer.remove_all_tags(startiter, enditer) if startiter and enditer
      end
    end
    nil
  end

  # Return the number of lines in a selection.
  def selection_lines(startiter, enditer)
    number = enditer.line - startiter.line
  end

  # Check the first 4 characters of the current line (or less if line is shorter)
  # for the presence of a bullet point character.
  # Returns boolean.
  def line_contains_list?(line)
    iter = @buffer.get_iter_at_line(line)
    iter.forward_to_line_end unless iter.ends_line?
    final = iter.line_offset
    final = 3 if final > 3 
    selection_contains_list?(iter, 0, final)
  end
  
  # Check selection for a bullet point character.
  # Returns boolean.
  def selection_contains_list?(iter, start_offset, end_offset)
    response = false
    start_offset.upto(end_offset) do |offset|
      iter.set_line_offset(offset)
      response = true if iter.char == "\xE2\x80\xA2"
    end
    iter.set_line_offset(start_offset)
    response
  end
  
  # Insert a list at beginning of line. Returns nil.
  def insert_list(line)
    iter = @buffer.get_iter_at_line(line)
    iter.set_line_offset(0)
    @buffer.insert(iter, "\t")
    @buffer.insert(iter, "\xE2\x80\xA2 ")
    nil
  end
  
  # Move iter to the position after a bullet point and its following space.
  # Returns the iter.
  def proceed_to_bullet_point(iter)
    until iter.char == "\xE2\x80\xA2"
      iter.forward_char
      break if iter.end?
    end
    iter.forward_char # move to the character after the bullet point
    iter.forward_char # move an extra character for the space following the bullet point
  end
  
  # Remove a bullet point from a line. Returns nil.
  def remove_list(line)
    enditer = @buffer.get_iter_at_line(line)
    proceed_to_bullet_point(enditer)
    startiter = @buffer.get_iter_at_line(line)
    @buffer.delete(startiter, enditer)
    nil
  end
  
  # Popup a dialogue to allow editing of a source's url.
  # Returns a string (url).
  def edit_url(url)
    dialog = Gtk::Dialog.new("Edit URL", @win, Gtk::Dialog::DESTROY_WITH_PARENT,
    [Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_NONE], [Gtk::Stock::OK, Gtk::Dialog::RESPONSE_OK])
    dialog.vbox.add(Gtk::Label.new('Enter URL:'))
    dialog.vbox.add(entry = Gtk::Entry.new.set_text(url))
    tooltip = Gtk::Tooltips.new.set_tip(dialog, "Enter url e.g. 'http://www.records.nsw.gov.au'", nil)
    dialog.set_window_position(Gtk::Window::POS_MOUSE).show_all
    if dialog.run == Gtk::Dialog::RESPONSE_OK 
      url = entry.text
    end
    dialog.destroy
    url
  end

  # Returns a new LinkTag.
  def add_link(url)
    link = LinkTag.new(url)
    @buffer.tag_table.add(link)
    link
  end
  
  # Render an element and add text to buffer. Returns nil.
  def format_paragraph(node, tag=nil)
    node.children.each do |item|
      if item.element?
        case item.name
          when 'List' then format_list(item)
          when 'Source' 
            if item['url']
              format_paragraph(item, add_link(item['url'])) 
            else format_paragraph(item, 'Source')
            end
          when 'Emphasis' then format_paragraph(item, 'Emphasis')
        end
      else 
        text = clean(item)
        tag ? @buffer.insert(@buffer.end_iter, text, tag) : @buffer.insert(@buffer.end_iter, text)
      end
    end
    nil
  end 

  # Render a list element and add text to buffer. Returns nil.
  def format_list(list)
    list.xpath('rda:Item', Namespace::RDA).each do |item|
      if list.previous_sibling or item.previous_sibling
        @buffer.insert(@buffer.end_iter, "\n\t\xE2\x80\xA2 ")
      else
        @buffer.insert(@buffer.end_iter, "\t\xE2\x80\xA2 ")
      end
      format_paragraph(item)
    end
    @buffer.insert(@buffer.end_iter, "\n") if list.next_sibling
    nil
  end

  # Remove stray newlines from text nodes. Returns a string.
  def clean(text_node)
    string = text_node.content.gsub("\n", '')
  end

  # Remove entities that might break Nokogiri's fragment handler.
  # Returns string. 
  def escape_markup(text)
    text = text.gsub(/&/,'&amp;').gsub(/</, '&lt;').gsub(/>/, '&gt;')
  end
  
  # Convert the buffer's text into an XML string that can be parsed by Nokogiri's
  # fragment handler.
  # Returns a string.
  def retrieve_text
    my_iter = @buffer.start_iter
    array = []
    until my_iter.end?  
      start_tags = my_iter.toggled_tags(true)
      start_tags.each do |tag|
        tag.name ? tagname = tag.name : tagname = "Source url='#{tag.url}'"
        array << '<' + tagname + '>'
      end
      end_tags = my_iter.toggled_tags(false)
      end_tags.each do |tag|
        tag.name ? tagname = tag.name : tagname = "Source"
        array << '</' + tagname + '>'
      end
      array << '<Item>' and my_iter.forward_char if my_iter.char == "\xE2\x80\xA2"
      array << escape_markup(my_iter.char)
      my_iter.forward_char
    end
    string = array.join
    clean_string(string)
  end

  # Fix up the dodgy markup created by the retrieve_text function to make 
  # clean XML that can be parsed. Returns a string.
  # TO DO: "<p>" tags are added because nokogiri 1.3.2 can only cope with 
  # single root nodes for document fragments. Later releases of nokogiri will fix this.
  def clean_string(string)
    string = string.gsub(/<Item>\s+/, "<Item>").gsub(/^.*(<Item>.*)$/, '\1</Item>'
    ).gsub(/<\/Item>\s*<Item>/, '</Item><Item>').gsub(/<\/Item>$/, '</Item></List>'
    ).gsub(/\A<Item>/, '<List><Item>').gsub(/\s+<Item>/, '<List><Item>').gsub(
    /^(.*)$/, '<Paragraph>\1</Paragraph>').gsub(/<Paragraph>\s*<\/Paragraph>/, '')
    string = '<p>' + string + '</p>'
  end
  
  # Test if the buffer is empty. Returns boolean.
  def empty?
    @buffer.text.strip.length > 0 ? false : true
  end
end

#
# Custom text tag to represent for hyperlinked sources. It is an anonymous
# tag with an accessible 'url' attribute.
#
class LinkTag < Gtk::TextTag
  attr_accessor :url
  
  def initialize(url)
    super(nil)
    @url = url
    set_foreground('blue').set_style(Pango::FontDescription::STYLE_ITALIC
    ).set_underline(Pango::AttrUnderline::SINGLE)
  end
end

#
# The StandardMarkup class represents the markup widgets used by rich text fields.
# It adds a focus-out signal to the MarkupText class.
#
class StandardMarkup < MarkupText
  
  def initialize(rdadoc, title, name, update=nil, y=nil)
    y = rdadoc.preferences[:markup_y] unless y
    current_node = rdadoc.current_node
    node = current_node.node.xpath("rda:#{name}", Namespace::RDA)[0]
    super(node, 500, y, title)
    # This signal causes the xml document to be updated with any changed
    # content in the text view when the user moves focus to another widget.
    @text.signal_connect("focus-out-event") do |widget, event|
      if @buffer.modified?
        current_node.update_paragraphs(name, retrieve_text, empty?)
        if update
          update.trigger_update(Date::today.to_s) if rdadoc.preferences[:track_update]
        end
        @buffer.set_modified(false)
      end
      false
    end
  end
end

#
# The Justification class adds an extra method to StandardMarkup that creates
# a popup dialogue to add 'stock' justifications to the buffer.
#
class Justification < StandardMarkup
  
  def initialize(rdadoc, update)
    super(rdadoc, 'Justification', 'Justification', update)
  end

  def sample_justification
    dialog = JustificationDialog.new.show_all
    dialog.run do |response|
      if response == 0
        @buffer.insert_at_cursor(dialog.get_text) if dialog.get_text
      end
      dialog.destroy
    end
    nil
  end
end
