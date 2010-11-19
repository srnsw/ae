#
# This file contains SRNSW-specific customisations
#

# Redefine Domain constants
module Domain
CONTEXTTYPES << 'appraisal report' << 'guidelines for use'
CONTEXTSETS << {
    :menu_text => 'Add appraisal report',
    :type => 'appraisal report',
    :titles => ['Public office', 'Functions', 'Additional information', 'Justification']
    } << {
    :menu_text => 'Add guidelines for use',
    :type => 'guidelines for use',
    :titles => ['Overview', 'Structure and components', 'Guidelines for implementation']
    } 
end

# Redefine MainWindow to include a plone menu item
class MainWindow
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
    plone_item = Gtk::MenuItem.new("Create Plone pages")
    plone_item.signal_connect('activate') do
      doc = current_page
      if doc
        refresh
        dialog = Plone.new(self, doc.xml_doc).show_all
        dialog.run {|response| dialog.destroy}
      end
    end
    export.append(plone_item)
    exportui = @ui.get_widget('/menubar/Transform/Export')
    exportui.set_submenu(export.show_all)
    nil
  end
end

# A custom dialog to generate plone pages
class Plone < Gtk::Dialog
  
  def initialize(parent, xml)
    super('Create Plone pages', parent, Gtk::Dialog::DESTROY_WITH_PARENT, [ Gtk::Stock::CLOSE, Gtk::Dialog::RESPONSE_NONE ])
    set_default_size(400, 400).set_border_width(10).set_window_position(Gtk::Window::POS_CENTER_ALWAYS)
    go = Gtk::Button.new('Generate')
    dup_xml = xml.dup
    go.signal_connect('clicked') {|button| generate(dup_xml)}
    vbox.pack_start(set_output_location, false, false, 0)
    vbox.pack_start(status, true, true, 0)
    vbox.pack_start(Gtk::HBox.new(false,0).pack_start(go, false, false, 0), false, false, 5)
  end
  
  def set_output_location
    frame = Gtk::Frame.new('Select output destination')
    @destination = Gtk::FileChooserButton.new("Select output destination", Gtk::FileChooser::ACTION_SELECT_FOLDER)
    @destination.filename = ENV['HOME']
    @destination.set_width_chars(20)
    frame << @destination
   end
  
  def status
    @buffer = Gtk::TextBuffer.new
    text_window = Gtk::TextView.new(@buffer).set_wrap_mode(2)
    text_window.set_pixels_above_lines(2).set_pixels_below_lines(2)
    text_window.set_left_margin(2).set_right_margin(2).set_editable(false)
    scroll = Gtk::ScrolledWindow.new
    scroll.set_policy(Gtk::POLICY_AUTOMATIC, Gtk::POLICY_AUTOMATIC)
    scroll.set_shadow_type(Gtk::SHADOW_OUT)
    scroll << text_window
    frame = Gtk::Frame.new('Message:')
    frame << scroll
  end
  
  def authority_title(xml)
    root = xml.root
    title = root.xpath("rda:AuthorityTitle | rda:Scope", Namespace::RDA)[0]
    rdano = root.xpath("rda:ID[@control='FA'] | rda:ID[@control='GA']", Namespace::RDA)[0]
    title ? authority_title = titleise(title.content) : authority_title = String.new
    if rdano
     authority_title = [rdano['control'], rdano.content, authority_title].join("-") 
    else 
     authority_title.empty? ? authority_title = 'authority' : authority_title
    end
  end
   
   def create_filename(node)
     filename = String.new
     itemno = node['itemno']
     filename << itemno + '-' if itemno
     title = node.xpath("rda:TermTitle | rda:ClassTitle", Namespace::RDA)[0]
     if title 
      filename << titleise(title.content) 
     end
     filename
   end
   
   def titleise(title)
     title = title.downcase.gsub(/\s/, '-').gsub(',', '').gsub('&', 'and').gsub('(','').gsub(')','')
     crop = title.index('-', 35)
     crop ? title[0, crop] : title 
   end
   
   def create_anchor_text(term)
     anchor_text = []
     term_title = term.xpath("rda:TermTitle", Namespace::RDA)[0]
     itemno = term['itemno']
     anchor_text << itemno if itemno
     anchor_text << titleise(term_title.content) if term_title
     return anchor_text.join("-")
   end
   
   def create_anchors(xml)
     terms = xml.root.xpath("//rda:Term", Namespace::RDA)
     terms.each do |term|
       anchor = Nokogiri::XML::Node.new("anchor", xml)
       anchor.content = create_anchor_text(term)
       term << anchor
     end
     xml
   end
   
   def create_hrefs(xml)
   root = xml.root
   seerefs = root.xpath("//rda:SeeReference[not(rda:IDRef) and not(rda:AuthorityTitleRef)]", Namespace::RDA)
   seerefs.each do |seeref|
      terms = seeref.xpath("rda:TermTitleRef", Namespace::RDA)
      first_term = terms.shift
      if first_term
        top_term = root.xpath("rda:Term[rda:TermTitle='#{first_term.content}']", Namespace::RDA)[0]
        if top_term
          function = seeref.xpath("ancestor::rda:Term/rda:TermTitle", Namespace::RDA)[0]
          if function
            function.content == first_term.content ? href_text = String.new : href_text = create_filename(top_term)
          else
             href_text = create_filename(top_term)  
          end
          last_term = terms.pop
          if last_term
            bottom_term = top_term.xpath("//rda:Term[rda:TermTitle='#{last_term.content}']", Namespace::RDA)[0]
            if bottom_term
              href_text = href_text + "#" + create_anchor_text(bottom_term)
            else
              href_text = href_text + "#" + create_anchor_text(top_term)
            end
          else
          href_text = href_text + "#" + create_anchor_text(top_term)
         end
         href = Nokogiri::XML::Node.new("href", xml)
         href.content = href_text
         seeref << href
        end
      end
    end
    return xml
   end
   
   def report(text)
     @buffer.insert(@buffer.end_iter, "\n") if @following
     @following = true
     @buffer.insert(@buffer.end_iter, text)   
   end
  
  def generate(xml)
    dirname = @destination.filename + "\\" + authority_title(xml)
    Dir.mkdir(dirname) unless File.exist?(dirname)
    report("Target directory..." + dirname)
    xml = create_hrefs(create_anchors(xml))
    xslt = Nokogiri::XSLT::Stylesheet.parse_stylesheet_doc(
      Nokogiri::XML(File.new("data/stylesheets/plone_pages.xsl")))
    chunks = xml.root.xpath("rda:Term | rda:Class", Namespace::RDA)
    chunks.each do |node|
      filename = create_filename(node)  + ".txt"
      node.default_namespace="http://www.records.nsw.gov.au/schemas/RDA"
      chunk = Nokogiri::XML(node.to_s)
      report("Writing..." + filename)
      output = xslt.transform(chunk).root.children.to_s
      File.open(dirname + "\\" + filename, "w") {|f| f.write(output)}
    end
  end
 end



