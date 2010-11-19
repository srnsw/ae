#
# SearchDialog pops when a user selects 'Search'. See search.rb.
#
class SearchDialog < Gtk::Dialog
  def initialize(root, current_page, window)
    super("Search terms and classes", window, Gtk::Dialog::MODAL,
    [Gtk::Stock::CLOSE, 0])
    set_default_size(500, 250)
    search_entry = Gtk::Entry.new.set_width_chars(50)
    search_entry.signal_connect("activate") {|widget| search(root, widget.text)}
    search_button = Gtk::Button.new('Search')
    search_button.signal_connect("clicked") {|widget| search(root, search_entry.text)}
    search_box = MHBox.new(search_entry, search_button)
    @result_store = Gtk::ListStore.new(Gdk::Pixbuf, String, String, String, Integer)
    result_tree = Gtk::TreeView.new(@result_store).set_headers_visible(false)
    result_tree.signal_connect('row-activated') do |a, b, c|
      iter = @result_store.get_iter(b)
      path = iter.get_value(3)
      current_page.navigate(:path, path) unless path.empty?
    end
    pix = Gtk::CellRendererPixbuf.new
    text_1 = Gtk::CellRendererText.new
    column_1 = Gtk::TreeViewColumn.new
    column_1.title = 'Breadcrumb'
    column_1.pack_start(pix, false)
    column_1.set_cell_data_func(pix) do |column, cell, model, iter|
      cell.pixbuf = iter.get_value(0)
    end
    column_1.pack_start(text_1, true)
    column_1.set_cell_data_func(text_1) do |column, cell, model, iter|
      cell.text = iter.get_value(1)
    end
    text_2 = Gtk::CellRendererText.new
    column_2 = Gtk::TreeViewColumn.new('Snippet', text_2, :text => 2)
    result_tree.append_column(column_1)
    result_tree.append_column(column_2)
    scroll = Gtk::ScrolledWindow.new.set_policy(Gtk::POLICY_AUTOMATIC,
    Gtk::POLICY_AUTOMATIC)
    scroll << result_tree
    v_box = Gtk::VBox.new(false, 0).pack_start(search_box, false, false,
    0).pack_start(Gtk::HSeparator.new, false, false, 5).pack_start(scroll,
    true, true, 0)
    vbox.add(v_box)
    update_store("Search results")
  end

  def search(root, search_string)
    results = Search::search(root, search_string)
    results = "No results" if results.empty?
    update_store(results)
  end

  # Clear and fill the @results_store model. Returns nil.
  def update_store(values)
    @result_store.clear
    if values.class == String
      iter = @result_store.append
      iter.set_value(0, self.render_icon(Gtk::Stock::FIND, Gtk::IconSize::MENU))
      iter.set_value(1, values)
      iter.set_value(2, String.new)
      iter.set_value(3, String.new)
      iter.set_value(4, 1)
    else
      values.each do |result|
        iter = @result_store.append
        if result[4]
          iter.set_value(0, self.render_icon(Gtk::Stock::INDEX, Gtk::IconSize::MENU))
        else
          iter.set_value(0, self.render_icon(Gtk::Stock::EDIT, Gtk::IconSize::MENU))
        end
        iter.set_value(1, result[1])
        iter.set_value(2, result[2])
        iter.set_value(3, result[0])
        iter.set_value(4, result[3])
      end
    end
    nil
  end
end



    
    
