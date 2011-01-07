#
# XSLMenuItems represents the 'Transform' menu items. When the program is
# loaded, these are dynamically generated from the xsl_manifest.xml file.
#
class XSLMenuItems
  # Accessors for each top-level menu item
  attr_reader :edit, :preview, :transform, :export

  def initialize(mainwindow)
    manifest = Nokogiri::XML(File.new(APPPATH + "/xsl_manifest.xml"))
    root = manifest.root
    @edit = Gtk::Menu.new
    get_items(root.at('edit_menu'), @edit) do |item|
      doc = mainwindow.current_page
      if doc
        mainwindow.refresh
        doc.xml_doc = XSLTransform::edit_xml(doc.xml_doc, item)
        doc.trigger_change
        if doc.xml_doc
          doc.errors ? path = nil : path = doc.current_node.node.path 
          doc.create_current_node(path) 
        end
        doc.update_view(doc.view_no, true)
      end
    end
    @preview = Gtk::Menu.new
    get_items(root.at('view_menu'), @preview) do |item|
      doc = mainwindow.current_page
      if doc
        mainwindow.refresh
        XSLTransform::preview_html(doc.xml_doc, item)
      end
    end
    @transform = Gtk::Menu.new
    get_items(root.at('word_transform_menu'), @transform) do |item|
      doc = mainwindow.current_page
      if doc
        mainwindow.refresh
        XSLTransform::word_transform(doc.xml_doc, item)
      end
    end
    @export = Gtk::Menu.new
    get_items(root.at('export_transform_menu'), @export) do |item, ext|
      doc = mainwindow.current_page
      if doc
        mainwindow.refresh
        new_file = XSLTransform::export_transform(doc.xml_doc, item, ext)
        doc.main.read_file(new_file) if new_file
      end
    end
  end

  # Appends Gtk::Items for each child element of the stylesheets element.
  # Expects a block which is called when the item is selected.
  # Returns nil.
  def get_items(stylesheets, menu)
    stylesheets.children.each do |child|
      if child.elem?
        text = child.at('text').content
        file = child.at('file').content
        extension = child.at('extension')
        menuitem = Gtk::MenuItem.new(text)
        if extension
          ext = extension.content
          menuitem.signal_connect("activate") {yield(file, ext)}
        else
          menuitem.signal_connect("activate") {yield(file)}
        end
        menu.append(menuitem)
      end
    end
    nil
  end
end

#
# XSLTransform contains functions called by the 'Transform' menu items. 
#
module XSLTransform
  module_function
  
  # Apply a transform to create an HTML document. Open in IE if a Windows user.
  # Returns nil.  
  def preview_html(xml_file, xsl_file)
    result = xslt(xml_file, xsl_file)
    return nil unless result
    newfile = Utils::unique_file_name("html_output_", ".html")
    File.open(newfile, "w") {|f| f.write(result)}
    open_browser(newfile) if Utils::os_mswin?
  end

  # Apply a transform to edit the currently selected XML document. Returns 
  # a new XML document.
  def edit_xml(xml_file, xsl_file)
    new_xml = xslt(xml_file, xsl_file, false)
  end

  # Apply a transform to create a document in Word ML format. Open in Word 
  # if an MS Word user. Returns nil.
  def word_transform(xml_file, xsl_file)
    result = xslt(xml_file, xsl_file)
    return nil unless result
    newfile = Utils::unique_file_name("word_output_")
    File.open(newfile, "w") {|f| f.write(result)}
    open_msword(newfile) if Utils::os_mswin?
  end

  # Apply a transform to create an 'export' file in an unspecified text format
  # e.g. to create an EDRMS uploadable csv file.
  # Returns a path to a transformed file or nil.
  def export_transform(xml_file, xsl_file, ext)
    ext = "." + ext
    result = xslt(xml_file, xsl_file)
    return nil unless result
    exportfile = Utils::unique_file_name("export_output_", ext)
    File.open(exportfile, "w") {|f| f.write(result)}
    exportfile
  end

  # PDF output not used by SRNSW. This method applies a transform to
  # create a "*.fo" file which is then converted to a PDF by Apache Fop.
  # def pdf_transform(xml_file, xsl_file)
  # new_xml = xslt(xml_file, xsl_file)
  # newfile = Utils::unique_file_name("pdf_output_", ".fo")
  # File.open(newfile, "w") {|f| new_xml.write_to(f)}
  # newpdf = Utils::unique_file_name("pdf_output_", ".pdf")
  # system("fop #{newfile} #{newpdf}")
  # system("evince #{newpdf}") #this is a system specific call
  # end
  
  # Execute a stylesheet transform on an XML document. 
  # For the regular transform, the xml_doc is duped because otherwise
  # errors result when nodes or elements are subsequently moved around.
  # Returns string or an XML document or, if error, nil.
  def xslt(xml_doc, stylesheet, to_s=true)
    begin
      xslt = Nokogiri::XSLT::Stylesheet.parse_stylesheet_doc(
      Nokogiri::XML(File.new("data/stylesheets/#{stylesheet}")))
      to_s ? result = xslt.apply_to(xml_doc.dup) : result = xslt.transform(xml_doc)
     rescue
      Utils::error_dialog("Bad stylesheet:\n#{$!}")
    end
  end

# Windows methods follow

  # Opens an MS Word window and displays the file. Returns nil.
  def open_msword(newfile)
    begin
      word = WIN32OLE.connect('Word.Application')
    rescue RuntimeError
      begin
        word = WIN32OLE.new('Word.Application')
      rescue
        Utils::error_dialog("Unable to open MS Word:\n#{$!}")
      end
    end
    if word
      begin
        word.Documents.Open(newfile)
      rescue RuntimeError
        Utils::error_dialog("MS Word is unable to open the transformed document:\n#{$!}")
      end
      word.Visible = true
      word.Activate
      nil
    end
  end

  # Opens a new Internet Explorer window and displays the file. Returns nil.
  def open_browser(newfile)
    begin
      ie = WIN32OLE.connect('InternetExplorer.Application')
    rescue RuntimeError
      begin
        ie = WIN32OLE.new('InternetExplorer.Application')
      rescue
        Utils::error_dialog("Unable to open Internet Explorer:\n#{$!}")
      end
    end
    if ie
      ie.Navigate(newfile)
      ie.Visible = true
      nil
    end
  end
end



