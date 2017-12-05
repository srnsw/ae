<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" version="1.0">
  <xsl:template name="word_consult_pt1">
      <w:p>
        <w:pPr>
          <w:pStyle w:val="Heading1"/>
          <w:spacing w:before="120" w:after="120"/>
          <w:rPr>
            <w:rFonts w:ascii="Verdana" w:h-ansi="Verdana" w:cs="Arial"/>
            <wx:font wx:val="Verdana"/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:t>Request for comment: Draft retention and disposal authority for records documenting the function of <xsl:value-of select="$SCOPE"/></w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
            <w:b/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
            <w:b/>
          </w:rPr>
          <w:t>Background</w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>The State Archives and Records Authority of NSW (State Archives and Records NSW) is responsible for approving the </w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>disposal of records created by NSW government agencies </w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>in accordance with the provisions of Section 21 of the </w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
            <w:i/>
          </w:rPr>
          <w:t>State Records Act 1998</w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>. </w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>It is currently reviewing a retention and disposal authority</w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t> developed by <xsl:value-of select="$AUTHORITY_TITLE"/></w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>.</w:t>
        </w:r>
      </w:p>
      <xsl:choose>
		  <xsl:when test="rda:Context[rda:ContextTitle='Functions']">
			  <xsl:apply-templates select="rda:Context[rda:ContextTitle='Functions']/rda:ContextContent"/>
			</xsl:when>
			<xsl:otherwise>	 
	 <w:p>
        <w:r>
          <w:t>This authority covers records relating to:</w:t></w:r></w:p>		 
      <w:p>
        <w:pPr>
          <w:pStyle w:val="ListBullet1"/>
          <w:listPr>
            <w:ilvl w:val="0"/>
            <w:ilfo w:val="1"/>
            <wx:t wx:val="·"/>
            <wx:font wx:val="Symbol"/>
          </w:listPr>
          <w:tabs>
            <w:tab w:val="clear" w:pos="1515"/>
            <w:tab w:val="list" w:pos="567"/>
          </w:tabs>
          <w:ind w:left="567" w:hanging="567"/>
        </w:pPr>
        <w:r>
          <w:t>[</w:t>
        </w:r>
        <w:proofErr w:type="gramStart"/>
        <w:r>
          <w:rPr>
            <w:i/>
            <w:color w:val="000000"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>a</w:t>
        </w:r>
        <w:proofErr w:type="gramEnd"/>
        <w:r>
          <w:rPr>
            <w:i/>
            <w:color w:val="000000"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t> brief description of the main functions that are covered by the authority</w:t>
        </w:r>
        <w:r>
          <w:t> e.g. as per Functions component of the AR part 1]</w:t>
        </w:r>
        <w:r>
          <w:t>.</w:t>
        </w:r>
      </w:p>
      </xsl:otherwise>
      </xsl:choose>
      <w:p>
        <w:pPr>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>Ret</w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>ention and disposal authorities identify records of enduring value or significance which are required to be permanently kept as State archives and permit the destruction of other records after appropriate retention periods have been met.</w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>As part of its review of this retention and disposal authority, State Archives and Records NSW is seeking feedback from NSW government agencies and other stakeholders who may rely on or have an interest in the records covered by the authority. Stakeholder involvement in the development of retention and disposal authorities helps to ensure that records are retained for as long as they may be required for regulatory, business and community requirements and that the most valuable records are identified for retention as State archives.</w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
            <w:b/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
            <w:b/>
          </w:rPr>
          <w:t>Retention decisions</w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
            <w:b/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
            <w:b/>
          </w:rPr>
          <w:t>Records identified as State archives</w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>State Archives and Records NSW’s policy on records appraisal and the </w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>i</w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>dentification of State archives, </w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
            <w:i/>
          </w:rPr>
          <w:t>Building the archives</w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>, provides the framework that guides this decision-making process.</w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:rStyle w:val="FootnoteReference"/>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:footnote>
            <w:p>
              <w:pPr>
                <w:pStyle w:val="FootnoteText"/>
              </w:pPr>
              <w:r>
                <w:rPr>
                  <w:rStyle w:val="FootnoteReference"/>
                </w:rPr>
                <w:footnoteRef/>
              </w:r>
              <w:r>
                <w:t> </w:t>
              </w:r>
              <w:r>
                <w:rPr>
                  <w:i/>
                </w:rPr>
                <w:t>Building the archives</w:t>
              </w:r>
              <w:r>
                <w:t> is available from State Archives and Records NSW’s website at &lt;http://www.records.nsw.gov.au/recordkeeping/government-recordkeeping-manual/rules/policies/building-the-archives&gt;.</w:t>
              </w:r>
            </w:p>
          </w:footnote>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>The records that have been identified for permanent retention as State archives in the authority document:</w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:listPr>
            <w:ilvl w:val="0"/>
            <w:ilfo w:val="1"/>
            <wx:t wx:val="·"/>
            <wx:font wx:val="Symbol"/>
          </w:listPr>
          <w:spacing w:before="100" w:before-autospacing="on" w:after="100" w:after-autospacing="on"/>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:highlight w:val="yellow"/>
        </w:pPr>
        <w:r>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>[</w:t>
        </w:r>
        <w:proofErr w:type="gramStart"/>
        <w:r>
          <w:rPr>
            <w:i/>
            <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>summary</w:t>
        </w:r>
        <w:proofErr w:type="gramEnd"/>
        <w:r>
          <w:rPr>
            <w:i/>
            <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t> of the appraisal objectives or aspects of the appraisal objectives that the State archives classes in the authority come under</w:t>
        </w:r>
        <w:r>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t> e.g:…</w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:listPr>
            <w:ilvl w:val="0"/>
            <w:ilfo w:val="1"/>
            <wx:t wx:val="·"/>
            <wx:font wx:val="Symbol"/>
          </w:listPr>
          <w:spacing w:before="100" w:before-autospacing="on" w:after="100" w:after-autospacing="on"/>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>the authority of government </w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:listPr>
            <w:ilvl w:val="0"/>
            <w:ilfo w:val="1"/>
            <wx:t wx:val="·"/>
            <wx:font wx:val="Symbol"/>
          </w:listPr>
          <w:spacing w:before="100" w:before-autospacing="on" w:after="100" w:after-autospacing="on"/>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>legal status or rights of individuals</w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:listPr>
            <w:ilvl w:val="0"/>
            <w:ilfo w:val="1"/>
            <wx:t wx:val="·"/>
            <wx:font wx:val="Symbol"/>
          </w:listPr>
          <w:spacing w:before="100" w:before-autospacing="on" w:after="100" w:after-autospacing="on"/>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>formulation and implementation of whole of government/policy with respect to [function</w:t>
        </w:r>
        <w:r>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>/s</w:t>
        </w:r>
        <w:r>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>]</w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:listPr>
            <w:ilvl w:val="0"/>
            <w:ilfo w:val="1"/>
            <wx:t wx:val="·"/>
            <wx:font wx:val="Symbol"/>
          </w:listPr>
          <w:spacing w:before="100" w:before-autospacing="on" w:after="100" w:after-autospacing="on"/>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
        </w:pPr>
        <w:proofErr w:type="gramStart"/>
        <w:r>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>individual</w:t>
        </w:r>
        <w:proofErr w:type="gramEnd"/>
        <w:r>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t> case management where government policy or activities had far reaching impact on individuals or communities</w:t>
        </w:r>
        <w:r>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>]</w:t>
        </w:r>
        <w:r>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>.</w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:spacing w:before="100" w:before-autospacing="on" w:after="100" w:after-autospacing="on"/>
          <w:rPr>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>In addition </w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>to these records, certain records that are commonly created across the NSW public sector are required as State archives under general retention and disposal authorities applying to all NSW public office</w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:rStyle w:val="FootnoteReference"/>
          </w:rPr>
          <w:footnote>
            <w:p>
              <w:pPr>
                <w:pStyle w:val="FootnoteText"/>
              </w:pPr>
              <w:r>
                <w:rPr>
                  <w:rStyle w:val="FootnoteReference"/>
                </w:rPr>
                <w:footnoteRef/>
              </w:r>
              <w:r>
                <w:t> Copies of these authorities are available from State Archives and Records NSW's website at &lt;http://www.records.nsw.gov.au/recordkeeping/government-recordkeeping-manual/rules/general-retention-and-disposal-authorities/general-retention-and-disposal-authorities&gt;.</w:t>
			</w:r>  
            </w:p>
            </w:footnote>
        </w:r>
        <w:r>
          <w:rPr>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>. This includes records of governing bodies </w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>and </w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>boards, inter-government and advisory or consultative committees or Councils, </w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>annual reports, records relating to the development of legislation, reporting to the Minister or Parliament.</w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:rPr>
            <w:b/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
            <w:b/>
          </w:rPr>
          <w:t>Records proposed for destruction:</w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:spacing w:before="100" w:before-autospacing="on" w:after="100" w:after-autospacing="on"/>
          <w:rPr>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>The records that have been proposed for destruction:</w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:listPr>
            <w:ilvl w:val="0"/>
            <w:ilfo w:val="1"/>
            <wx:t wx:val="·"/>
            <wx:font wx:val="Symbol"/>
          </w:listPr>
          <w:spacing w:before="100" w:before-autospacing="on" w:after="100" w:after-autospacing="on"/>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>[</w:t>
        </w:r>
        <w:proofErr w:type="gramStart"/>
        <w:r>
          <w:rPr>
            <w:i/>
            <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>brief</w:t>
        </w:r>
        <w:proofErr w:type="gramEnd"/>
        <w:r>
          <w:rPr>
            <w:i/>
            <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t> summary statement of basis for not requiring the records as State archives</w:t>
        </w:r>
        <w:r>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t> e.g. </w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:listPr>
            <w:ilvl w:val="0"/>
            <w:ilfo w:val="1"/>
            <wx:t wx:val="·"/>
            <wx:font wx:val="Symbol"/>
          </w:listPr>
          <w:spacing w:before="100" w:before-autospacing="on" w:after="100" w:after-autospacing="on"/>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>contain information that is summarised or </w:t>
        </w:r>
        <w:r>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>also</w:t>
        </w:r>
        <w:r>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t> accessible in records recommended for retention as State archives</w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:listPr>
            <w:ilvl w:val="0"/>
            <w:ilfo w:val="1"/>
            <wx:t wx:val="·"/>
            <wx:font wx:val="Symbol"/>
          </w:listPr>
          <w:spacing w:before="100" w:before-autospacing="on" w:after="100" w:after-autospacing="on"/>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
            <w:b/>
          </w:rPr>
        </w:pPr>
        <w:proofErr w:type="gramStart"/>
        <w:r>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>document</w:t>
        </w:r>
        <w:proofErr w:type="gramEnd"/>
        <w:r>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t> low level, procedural, administrative or operational activities.</w:t>
        </w:r>
        <w:r>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>]</w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:spacing w:before="100" w:before-autospacing="on" w:after="100" w:after-autospacing="on"/>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
            <w:b/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>Government agencies</w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t> are responsible for identifying appropriate minimum retention periods </w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>for records proposed for destruction. Retention periods are determined through </w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>an </w:t>
        </w:r>
        <w:r>
          <w:t>analysis of the administrative, legal, social, and recordkeeping contexts within which the organisation operates</w:t>
        </w:r>
        <w:r>
          <w:t> to identify applicable business needs and regulatory and accountability requirements for retaining records</w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:sz w:val="19"/>
            <w:sz-cs w:val="19"/>
          </w:rPr>
          <w:t>. </w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>A brief outline of the basis for the proposed minimum retention periods for records </w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>identified for destruction </w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>is included in the accompanying </w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:b/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>Justification/Remarks</w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:b/>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t> </w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t> row</w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:lang w:fareast="EN-AU"/>
          </w:rPr>
          <w:t>.</w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
            <w:b/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
            <w:b/>
          </w:rPr>
          <w:t>Comments sought</w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>Comments are sought particularly on:</w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:listPr>
            <w:ilvl w:val="0"/>
            <w:ilfo w:val="1"/>
            <wx:t wx:val="·"/>
            <wx:font wx:val="Symbol"/>
          </w:listPr>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>whether any categories of records nominated for eventual destruction should be retained as State archives</w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:listPr>
            <w:ilvl w:val="0"/>
            <w:ilfo w:val="1"/>
            <wx:t wx:val="·"/>
            <wx:font wx:val="Symbol"/>
          </w:listPr>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
        </w:pPr>
        <w:proofErr w:type="gramStart"/>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>the</w:t>
        </w:r>
        <w:proofErr w:type="gramEnd"/>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t> appropriateness of the nominated minimum retention periods where eventual destruction is proposed.</w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
            <w:b/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
            <w:b/>
          </w:rPr>
          <w:t>Making comments</w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>Ultimately State Archives and Records NSW must balance interests in keeping records with the costs of their management and storage. </w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>All decisions to retain records as State archives must be carefully considered and justified. If recommending that additional records be retained as State archives, please give reasons and be as specific as possible in describing the types of records which you are recommending should be retained.</w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>Similarly, if recommending changes to nominated minimum retention periods, please outline the rationale for the proposed changes.</w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>The deadline for comments is</w:t>
        </w:r>
        <w:r>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t> ……</w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>. If you require any further information please contact </w:t>
        </w:r>
        <w:r>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>name</w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>, </w:t>
        </w:r>
        <w:r>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>position title</w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>, Government Recordkeeping via email at </w:t>
        </w:r>
        <w:hlink w:dest="mailto:name@records.nsw.gov.au">
          <w:r>
            <w:rPr>
				<w:highlight w:val="yellow"/>
              <w:rStyle w:val="Hyperlink"/>
              <w:rFonts w:cs="Arial"/>
            </w:rPr>
            <w:t>name@records.nsw.gov.au</w:t>
          </w:r>
        </w:hlink>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t> or by telephone on 02 8247 8</w:t>
        </w:r>
        <w:r>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>ext</w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>.</w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>Comments may be sent by mail to</w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:ind w:left="567"/>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
        </w:pPr>
        <w:proofErr w:type="gramStart"/>
        <w:r>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>name</w:t>
        </w:r>
        <w:proofErr w:type="gramEnd"/>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:br/>
        </w:r>
        <w:r>
          <w:rPr>
			  <w:highlight w:val="yellow"/>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>position title</w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t>, </w:t>
        </w:r>
        <st1:PlaceName w:st="on">
          <w:r>
            <w:rPr>
              <w:rFonts w:cs="Arial"/>
            </w:rPr>
            <w:t>Government</w:t>
          </w:r>
        </st1:PlaceName>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t> </w:t>
        </w:r>
        <st1:PlaceName w:st="on">
          <w:r>
            <w:rPr>
              <w:rFonts w:cs="Arial"/>
            </w:rPr>
            <w:t> Recordkeeping</w:t>
          </w:r>
        </st1:PlaceName>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:br/>
        </w:r>
        <st1:PlaceType w:st="on">
          <w:r>
            <w:rPr>
              <w:rFonts w:cs="Arial"/>
            </w:rPr>
            <w:t>State</w:t>
          </w:r>
        </st1:PlaceType>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:t> Records Authority of </w:t>
        </w:r>
        <st1:place w:st="on">
          <st1:State w:st="on">
            <w:r>
              <w:rPr>
                <w:rFonts w:cs="Arial"/>
              </w:rPr>
              <w:t>New South Wales</w:t>
            </w:r>
          </st1:State>
        </st1:place>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:br/>
        </w:r>
        <st1:address w:st="on">
          <st1:Street w:st="on">
            <w:r>
              <w:rPr>
                <w:rFonts w:cs="Arial"/>
              </w:rPr>
              <w:t>PO Box</w:t>
            </w:r>
          </st1:Street>
          <w:r>
            <w:rPr>
              <w:rFonts w:cs="Arial"/>
            </w:rPr>
            <w:t> 516</w:t>
          </w:r>
        </st1:address>
        <w:r>
          <w:rPr>
            <w:rFonts w:cs="Arial"/>
          </w:rPr>
          <w:br/>
          <w:t>Kingswood NSW 2747</w:t>
        </w:r>
        <w:r>
          <w:t>or</w:t>
        </w:r>
        <w:r>
          <w:t> emailed to </w:t>
        </w:r>
        <w:r>
            <w:rPr>
              <w:rFonts w:cs="Arial"/>
              <w:highlight w:val="yellow"/>
            </w:rPr>
            <w:t>name</w:t>
          </w:r>
          <w:r>
            <w:t>@records.nsw.gov.au.</w:t>
         </w:r>
        </w:p>    
 </xsl:template>
</xsl:stylesheet>
    
