#
# This module contains common functions for keeping views (edit, review
# and source) in sync. This is achieved by translating tree view and review
# view paths to nodes, and back again. Also includes breadcrumb and snippet
# methods and navigation methods (backwards and forwards).
#
module Navigate
  module_function
  
  # Translate a review path (an array of two integers) to a node.
  # Returns a Nokogiri::XML::Node.
  def reviewpath_to_node(root, reviewpath)
    top, body = reviewpath[0], reviewpath[1]
    elements = root.xpath("rda:Term | rda:Class", Namespace::RDA)
    top_element = elements[top]
    body_elements = top_element.xpath("descendant-or-self::*[self::rda:Term or self::rda:Class]", Namespace::RDA)
    body_elements[body]
  end
  
  # Translate a node to a review path.
  # Returns an array of two integers.
  def node_to_reviewpath(node)
    if node.name == 'Authority' or node.name == 'Context'
      [0, 0]
    else
      top = get_top_position(node)
      body = 0
      unless top?(node)
        body += node_count(node)
        body += count_parents(node)
        parents = get_parents(node)
        parents.each {|parent| body += node_count(parent)}
      end
      [top, body]
    end
  end
  
  def get_top_position(node)
    top_node = node.xpath('ancestor-or-self::*[parent::rda:Authority]', Namespace::RDA)[0]  
    count_siblings(top_node)
  end

  def top?(node)
    node.parent.name == 'Authority' ? true : false
  end

  def count_parents(node)
    parents = node.xpath('ancestor::rda:Term', Namespace::RDA).length
  end
  
  def get_parents(node)
    parents = node.xpath('ancestor::rda:Term[parent::rda:Term]', Namespace::RDA)
  end

  def node_count(node)
    number = count_siblings(node) + count_nephews(node)
  end

  def count_siblings(node)
    number = node.xpath('preceding-sibling::*[self::rda:Class or self::rda:Term]', Namespace::RDA).length
  end

  def count_nephews(node)
    nephews = 0
    siblings = get_siblings(node)
    siblings.each {|node| nephews = nephews + count_children(node)}
    nephews
  end

  def get_siblings(node)
    siblings = node.xpath('preceding-sibling::rda:Term', Namespace::RDA)
  end
  
  def count_children(node)
    number = node.xpath('descendant::*[self::rda:Class or self::rda:Term]', Namespace::RDA).length
  end
  
  # Translate a tree path (an array corresponding to a node's position in 
  # a tree menu) to a node.
  # Returns a Nokogiri::XML::Node.
  def treepath_to_node(root, treepath)
    type, parents, node = treepath[0], treepath[1..-2], treepath[-1]
    if treepath.length == 1
      root
    elsif type == 1
      get_context(root, node)
    else
      get_term(root, parents, node)
    end
  end
  
  def get_context(root, node)
    context = root.xpath("rda:Context[#{node + 1}]", Namespace::RDA)[0]
  end

  # Although labelled 'get_term' this method will actually return either a term
  # or a class.
  # Returns a Nokogiri::XML::Node.
  def get_term(root, parents, node)
    context = root
    parents.each do |parent|
      ancestors = context.xpath("rda:Term | rda:Class", Namespace::RDA)
      context = ancestors[parent]
    end
    elements = context.xpath("rda:Term | rda:Class", Namespace::RDA)
    elements[node]
  end
  
  # Translate a node to a tree path (e.g. '1:3:5').
  # Returns a string.
  def node_to_treepath(node)
    case node.name
      when 'Authority' then treepath = [0]
      when 'Context' then treepath = context_to_treepath(node)
      else treepath = term_to_treepath(node)
    end
    treepath = treepath.join(':')
  end
  
  def context_to_treepath(node)
    number = node.xpath('preceding-sibling::rda:Context', Namespace::RDA).length
    [1, number]
  end
  
  def term_to_treepath(node)
    treepath = Array.new
    treepath.unshift(count_siblings(node))
    until top?(node)
      node = node.parent
      treepath.unshift(count_siblings(node))
    end
    treepath.unshift(2)
  end
  
  # Used by get_breadcrumb method. Returns a string.
  def get_node_title(node)
    case node.name
      when 'Authority' then name = 'Authority'
      when 'Context'
        title = node.xpath('rda:ContextTitle', Namespace::RDA)[0]
        title ? name = title.content : name = String.new
      when 'Term'
        title = node.xpath('rda:TermTitle', Namespace::RDA)[0]
        title ? name = title.content : name = String.new
      else
        title = node.xpath('rda:ClassTitle', Namespace::RDA)[0]
        if title
          name = title.content
        elsif node['itemno']
          name = node['itemno']
        else
          name = 'Class'
        end
    end
  end
  
  # Create a breadcrumb path for display in the status bar.
  # Returns a string.
  def get_breadcrumb(node)
    parents = node.xpath('ancestor::rda:Term', Namespace::RDA)
    term_titles = parents.collect do |p|
      title = p.xpath('rda:TermTitle', Namespace::RDA)[0]
      name = title.content if title
    end
    breadcrumb = term_titles.join(' - ')
    breadcrumb << ' - ' unless breadcrumb.empty?
    breadcrumb << get_node_title(node)
  end
  
  # Used by the search module. Return the first words of the first paragraph
  # for a particular context, term or class node.
  # Returns a string.
  def get_snippet(node)
    case node.name
      when 'Context' then content_element = node.xpath('rda:ContextContent', Namespace::RDA)[0]
      when 'Term' then content_element = node.xpath('rda:TermDescription', Namespace::RDA)[0]
      when 'Class' then content_element = node.xpath('rda:ClassDescription', Namespace::RDA)[0]
      else content_element = nil
    end
    if content_element
      paragraph = content_element.xpath('rda:Paragraph', Namespace::RDA)[0]
      if paragraph
        snippet = format_paragraph(paragraph)
        crop = snippet.index(' ', 75)
        snippet = snippet[0, crop] if crop
        crop ? snippet += '...' : snippet
      else
        snippet = String.new
      end
    else
      snippet = String.new
    end
  end
  
  # Used by the 'get_snippet' method. Parses paragraphs and returns just
  # the text content, ignoring markup elements e.g. lists or emphasis.
  # Returns a string.
  def format_paragraph(para, snippet=String.new)
    para.children.each do |child|
      if child.element?
        snippet = format_paragraph(child, snippet)
      else
        snippet += child.content
      end 
    end
    snippet
  end
  
  # Employed by the 'navigate' method of CurrentNode to go forward in a document.
  # Returns a Nokogiri::XML::Node.
  def node_after(node)
    following = first_child(node)
    following = following_sibling(node) unless following
    while following.nil?
      if node.name == 'document'
        following = node.root
      else
        node = node.parent
        following = following_sibling(node) unless node.name == 'document'
      end
    end
    following  
  end
  
  def first_child(node)
    node.xpath('rda:Context | rda:Class | rda:Term', Namespace::RDA)[0]
  end
  
  def following_sibling(node)
    node.xpath('following-sibling::*')[0]
  end
  
  # Employed by the 'navigate' method of CurrentNode to go backwards in a document.
  # Returns a Nokogiri::XML::Node.
  def node_before(node)
    preceding = node.xpath('preceding-sibling::*[self::rda:Context or self::rda:Class or self::rda:Term]', Namespace::RDA)[-1]
    previous = preceding.xpath("descendant::*[self::rda:Class or self::rda:Term]", Namespace::RDA)[-1] if preceding
    previous = preceding unless previous
    unless previous
      parent = node.parent
      if parent.name == 'document'
        previous = node.xpath('descendant::*[self::rda:Context or self::rda:Class or self::rda:Term]', Namespace::RDA)[-1]
        previous = node unless previous
      else
        previous = parent
      end
    end
    previous
  end
  
  # Find the first term or class within a given context. If none, return the original node.
  # Used by first_term_class method of CurrentNode.
  # Returns a Nokogiri::XML::Node.
  def node_term_class(node)
    term_class = node.xpath('rda:Class | rda:Term', Namespace::RDA)[0]
    node = term_class if term_class
    node
  end
end
