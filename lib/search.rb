#
# The Search module contains a search method that recieves a search string
# and returns an array of sorted results.
#
module Search
  # Common words are deleted from search strings
  STOPWORDS = ['a', 'an', 'at', 'by', 'for', 'in', 'is', 'it', 'of', 'on', 'or', 'that', 'the',
  'this', 'to']
  # The following arrays contain the names of elements to be included in
  # searches and relevancy scores for those elements. You can play with these
  # arrays to customise what elements are included and how hits are boosted. 
  TERM_ELEMENTS = [['TermTitle', 10], ['TermDescription', 7], ['LinkedTo', 8]]
  TERM_ATTRIBUTES = [['itemno', 10]]
  CLASS_ELEMENTS = [['ClassTitle', 8], ['ClassDescription', 6], ['Disposal', 5],
  ['LinkedTo', 8]]
  CLASS_ATTRIBUTES = [['itemno', 10]]

  module_function
  
  # Returns an array of search results.
  def search(root, search_string)
    search_string = search_string.gsub('"', '').gsub("'", '').gsub("&", '').gsub("/", '').gsub(/\//, '')
    search_terms = search_string.split(' ') - STOPWORDS
    raw_results = Array.new
    search_terms.each do |search_term|
      TERM_ELEMENTS.each do |ary|
        nodes = custom_search(root, 'Term', ary[0], search_term)
        nodes.each {|node| raw_results << [Navigate::node_to_treepath(node),
        Navigate::get_breadcrumb(node), Navigate::get_snippet(node), ary[1], true]}
      end
      TERM_ATTRIBUTES.each do |ary|
        nodes = attr_search(root, 'Term', ary[0], search_term)
        nodes.each {|node| raw_results << [Navigate::node_to_treepath(node),
        Navigate::get_breadcrumb(node), Navigate::get_snippet(node), ary[1], true]}
      end
      CLASS_ELEMENTS.each do |ary|
        nodes = custom_search(root, 'Class', ary[0], search_term)
        nodes.each {|node| raw_results << [Navigate::node_to_treepath(node),
        Navigate::get_breadcrumb(node), Navigate::get_snippet(node), ary[1], false]}
      end
      CLASS_ATTRIBUTES.each do |ary|
        nodes = attr_search(root, 'Class', ary[0], search_term)
        nodes.each {|node| raw_results << [Navigate::node_to_treepath(node),
        Navigate::get_breadcrumb(node), Navigate::get_snippet(node), ary[1], false]}
      end
    end
    final_results = Array.new
    # Clean up results by filtering multiple hits and adding together the
    # relevance scores for those hits
    raw_results.each do |raw|
      index = final_results.assoc(raw[0])
      if index
        index[3] += raw[3]
      else
        final_results << raw
      end
    end
    # Sort by relevance score. If you prefer to sort by authority, uncomment
    # the next line and comment the line following. 
    # final_results = final_results.sort {|a, b| a[0] <=> b[0]}
    final_results = final_results.sort {|a, b| b[3] <=> a[3]}
  end

  def attr_search(root, el, attr, search_term)
    root.xpath("//rda:#{el}[@#{attr}='#{search_term}']", Namespace::RDA)
  end

  # Use Nokogiri's custom search feature.
  def custom_search(root, el, el_name, search_term)
    root.xpath("//rda:#{el}[regexp(., '#{el_name}', '#{search_term}')]",
    Namespace::RDA, CustomSearch.new)
  end
  
  # Define a class to hold the regexp method.
  class CustomSearch
    def regexp(node_set, el_name, search_term)
      node_set.find_all do |node| 
        elements = node.xpath("rda:#{el_name}", Namespace::RDA)
        array = elements.find_all do |element|
          element.content =~ /\w*#{search_term}\w*/ix ? true : false
        end
        array[0]
      end
    end
  end
end
