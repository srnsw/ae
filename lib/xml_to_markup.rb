#
# XMLtoMarkup module parses the contents of XML elements for display in various 
# widgets of the application.
#
module XMLtoMarkup
  module_function

  # Escape entities that may cause parsing problems
  def escape_markup(text)
    text = text.gsub(/&/,'&amp;').gsub(/</, '&lt;').gsub(/>/, '&gt;').gsub("\n", '')
  end

  # Return contents of an element or an empty string.
  def el_content(node, el_name)
    element = node.xpath("rda:#{el_name}", Namespace::RDA)[0]
    element ? escape_markup(element.content) : String.new
  end

  # Return contents of an attribute or an empty string.
  def att_content(element, att_name)
    att = element[att_name]
    att ? escape_markup(att) : String.new
  end
  
  # Return an array consisting of an element's and its attribute's content or empty strings.
  def el_att_content(node, el_name, att_name)
    element = node.xpath("rda:#{el_name}", Namespace::RDA)[0]
    if element
      el_text = escape_markup(element.content)
      att_text = att_content(element, att_name)
    else
      el_text, att_text = String.new, String.new
    end
    [att_text, el_text]
  end

  # Contents of an item number attribute. Returns a string.
  def render_itemno(node)
    att_content(node, 'itemno')
  end
   
  # Contents of an update attribute. Returns a string. 
  def render_update(node)
    att_content(node, 'update')
  end

  # Contents of a title element. Returns a string.
  def render_title(node, type)
    if type
      title = el_content(node, 'ClassTitle')
    else
      element = node.xpath("rda:TermTitle", Namespace::RDA)[0]
      if element
        title = escape_markup(element.content) 
        title = "<b>" + title + "</b>"
      else
        title = String.new
      end
    end
  end

  # Contents of term and class descriptions. Returns a string.
  def render_description(elem, type)
    if type
      node = elem.xpath('rda:ClassDescription', Namespace::RDA)[0]
    else
      node = elem.xpath('rda:TermDescription', Namespace::RDA)[0]
    end
    if node
      paragraphs = node.xpath('rda:Paragraph', Namespace::RDA)
      seereferences = node.xpath('rda:SeeReference', Namespace::RDA)
      paras = paragraphs.collect {|paragraph| format_paragraph(paragraph)}
      seerefs = seereferences.collect {|seeref| render_see_references(seeref)}
      description = paras.concat(seerefs).join("\n")
    else
      String.new
    end
  end

  # Contents of justification. Returns a string.
  def render_justification(elem)
    node = elem.xpath('rda:Justification', Namespace::RDA)[0]
    if node
      paragraphs = node.xpath('rda:Paragraph', Namespace::RDA)
      paras = paragraphs.collect {|para| format_paragraph(para)}
      justification = paras.join("\n")
    else
      String.new
    end
  end

  # Render a paragraph element into a marked-up string.  Returns a string.
  def format_paragraph(node, text=String.new, tag=nil)
    node.children.each do |item|
      if item.element?
        case item.name
          when 'List' then text += format_list(item, String.new)
          when 'Source' 
            if item['url']
              text = format_paragraph(item, text,
              ['<span foreground="#0000FF" underline="single">', '</span>'])
            else
              text = format_paragraph(item, text,
              ['<span style="italic">', '</span>'])  
            end
          when 'Emphasis' then text = format_paragraph(item, text,
          ['<b>','</b>'])
        end
      else 
        item = escape_markup(item.content)
        tag ? text += tag[0] + item + tag[1] : text += item
      end
    end
    text
  end 

  # Render a list element into a marked up string.  Returns a string.
  def format_list(list, text)
    list.xpath('rda:Item', Namespace::RDA).each do |item|
      if list.previous_sibling or item.previous_sibling
        text += "\n   \xE2\x80\xA2 "
      else
        text += "   \xE2\x80\xA2 "
      end
      text += format_paragraph(item, String.new)
    end
    list.next_sibling ? text += "\n" : text
  end

  # Contents of a see reference. Returns a string.
  def render_see_references(seeref)
    see = ["See"]   
    idref = el_att_content(seeref, "IDRef", "control").join
    see << idref unless idref.empty?
    rdatitle = el_content(seeref, "AuthorityTitleRef")
    see << "<i>#{rdatitle}</i>" unless rdatitle.empty?
    terms = seeref.xpath('rda:TermTitleRef', Namespace::RDA)
    seeterms = terms.collect {|term| "<b>#{escape_markup(term.content)}</b>"}
    itemref = el_content(seeref, "ItemNoRef")
    seeterms << "<b>#{itemref}</b>" unless itemref.empty?
    see << seeterms.join(" - ")
    seetext = el_content(seeref, "SeeText")
    see << seetext unless seetext.empty?
    see = see.join(" ")
  end

  # Contents of multiple disposal elements. Returns an array of two strings.
  def render_disposals(node)
    disposals = node.xpath('rda:Disposal', Namespace::RDA)
    actions, custodies = Array.new, Array.new
    disposals.each do |disposal|
      action_custody = make_disposal(disposal)
      actions << [action_custody[0]]
      custodies << [action_custody[1]]
    end
    action, custody = actions.join("\n"), custodies.join("\n")
    [action, custody]
  end

  # Contents of a single disposal element. Returns an array of two strings.
  def make_disposal(disposal)
    # First generate action and custody from the standard fields.
    action, custody = String.new, String.new
    retention = el_att_content(disposal, "RetentionPeriod", "unit").reverse
    retention[1] = retention[1].chop if retention[0] == '1'
    retentiontext = Array.new
    trigger = el_content(disposal, "DisposalTrigger")
    if retention.join.empty?
      retentiontext << "until" unless trigger.empty?
    else
      retentiontext << "minimum of #{retention.join(" ")}" 
      retentiontext << "after" unless trigger.empty?
    end
    retentiontext << trigger unless trigger.empty?
    retentiontext = retentiontext.join(" ")
    transfer = el_content(disposal, "TransferTo")  
    transfer = transfer.insert(0, " to ") unless transfer.empty?
    disposalaction = el_content(disposal, "DisposalAction")
    case disposalaction
      when Domain::DISPOSALACTIONS[0]
        action << disposalaction
        custody = "Retain #{retentiontext}, then transfer" unless retentiontext.empty?
      when Domain::DISPOSALACTIONS[1]
        if retentiontext.empty?
          action << disposalaction
        else
          action << "Retain #{retentiontext}, then destroy"
        end
      when Domain::DISPOSALACTIONS[3]
        if retentiontext.empty?
          action << disposalaction << transfer
        else
          action << "Retain #{retentiontext}, then transfer#{transfer}"
        end
      else
        action << disposalaction
    end
    # then add custom text if exists
    custom_action = disposal.xpath('rda:CustomAction', Namespace::RDA)[0]
    custom_custody = disposal.xpath('rda:CustomCustody', Namespace::RDA)[0]
    if custom_action
      action << "\n"  unless action.empty?
      paragraphs = custom_action.xpath('rda:Paragraph', Namespace::RDA)
      array = paragraphs.collect {|paragraph| format_paragraph(paragraph)}
      action << array.join("\n")
    end
    if custom_custody
      custody << "\n" unless custody.empty?
      paragraphs = custom_custody.xpath('rda:Paragraph', Namespace::RDA)
      array = paragraphs.collect {|paragraph| format_paragraph(paragraph)}
      custody << array.join("\n")
    end
    # Finally, if there is a disposal condition, stick it at the beginning of the
    # action and the custody
    condition = el_content(disposal, "DisposalCondition")
    unless condition.empty?
      condition = "<b>#{condition}:<\/b>\n"
      action =  condition + action
      custody = condition + custody unless custody.empty?
    end
    [action, custody]
  end

  # Contents of a status element. Returns a string.
  def render_status(node)
    if node.name == 'PartSupersededBy'
      event = 'Partsuperseded by'
    elsif node.name == 'PartSupersedes'
      event = 'Partially supersedes'
    elsif node.name == 'SupersededBy'
      event = 'Superseded by'
    else
      event = node.name
    end
    case node.name
      when 'Draft'
        version = att_content(node, "version")
        event << " v.#{version}" unless version.empty?
        agency = render_agency(node)
        event << ", #{agency}" unless agency.empty?
        date = el_content(node, "Date")
      when 'Submitted'
        officer = el_content(node, "Officer")
        event << " by #{officer}" unless officer.empty?
        position = el_content(node, "Position")
        event << ", #{position}" unless position.empty?
        agency = render_agency(node)
        event << ", #{agency}" unless agency.empty?
        date = el_content(node, "Date")
      when 'Issued'
        agency = render_agency(node)
        event << " to #{agency}" if agency.length > 0
        date = el_content(node, "Date")
      when 'Applying'
        event << " (#{node['extent']})" if node['extent']
        agency = render_agency(node)
        event << ", #{agency}" if agency.length > 0
        date = el_content(node, "StartDate")
        enddate = el_content(node, "EndDate")
        date += " to #{enddate}" unless enddate.empty?
      when 'PartSupersedes'
        text = render_supersedes(node)
        event << " #{text}" if text
        date = el_content(node, "Date")
      when 'Supersedes'
        text = render_supersedes(node)
        event << " #{text}" if text
        date = el_content(node, "Date")
      when 'PartSupersededBy'
        text = render_supersedes(node)
        event << " #{text}" if text
        date = el_content(node, "Date")
      when 'SupersededBy'
        text = render_supersedes(node)
        event << " #{text}" if text
        date = el_content(node, "Date")
      else 
        date = escape_markup(node.content)
    end
    [event, date]
  end

  # Contents of a status event's agency element. Returns a string.
  def render_agency(node)
    agency = el_att_content(node, "Agency", "agencyno")
    text = agency[1]
    text << " (#{agency[0]})" unless agency[0].empty?
    text
  end

  # Contents of a supersede status event. Returns a string.
  def render_supersedes(node)
    text = Array.new
    idref = el_att_content(node, "IDRef", "control").join
    text << idref unless idref.empty?
    rdatitle = el_content(node, "AuthorityTitleRef")
    text << "<i>#{rdatitle}</i>" unless rdatitle.empty?
    terms = node.xpath('rda:TermTitleRef', Namespace::RDA)
    terms_text = terms.collect {|term| "<b>#{escape_markup(term.content)}</b>"}
    itemref = el_content(node, 'ItemNoRef')
    terms_text << "<b>#{itemref}</b>" unless itemref.empty?
    text << terms_text.join(" - ")
    parttext = el_content(node, "PartText")
    text << parttext unless parttext.empty?
    text = text.join(" ")
  end

  # Contents of multiple comments elements. Returns a string.
  def render_comments(node)
    comments = node.xpath('rda:Comment', Namespace::RDA)
    array = comments.collect {|comment| render_comment(comment)}
    text = array.join("\n")
  end

  # Contents of a single comments element. Returns a string.
  def render_comment(node)
    text = String.new
    author = att_content(node, "author")
    unless author.empty?
      case author
        when Domain::SHORTNAME
          text << "<span foreground='red'>#{author}</span>"
        when 'agency'
          text << "<span foreground='green'>agency</span>"
        else
          text << "<span foreground='orange'>#{author}</span>"
      end
      text << "\n"
    end
    paragraphs = node.xpath('rda:Paragraph', Namespace::RDA)
    array = paragraphs.collect {|paragraph| format_paragraph(paragraph)}
    text << array.join("\n")
  end
end
