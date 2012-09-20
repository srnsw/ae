<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" version="1.0">
  <xsl:template name="word_header">
    <xsl:param name="tab" select="'567'"/>
    <!--controls default spacing for Normal Paragraphs-->
    <xsl:param name="spacing" select="'120'"/>
    <xsl:param name="keep_next" select="'false'"/>
    <xsl:param name="gaadmin" select="'false'"/>
    <o:DocumentProperties>
      <o:Title/>
      <o:Author/>
      <o:Created/>
    </o:DocumentProperties>
    <w:fonts>
      <w:defaultFonts w:ascii="Portugal" w:fareast="Times New Roman" w:h-ansi="Portugal" w:cs="Times New Roman"/>
      <w:font w:name="Verdana">
        <w:panose-1 w:val="020B0604030504040204"/>
        <w:charset w:val="00"/>
        <w:family w:val="Swiss"/>
        <w:pitch w:val="variable"/>
        <w:sig w:usb-0="20000287" w:usb-1="00000000" w:usb-2="00000000" w:usb-3="00000000" w:csb-0="0000019F" w:csb-1="00000000"/>
      </w:font>
      <w:font w:name="Portugal">
        <w:altName w:val="Book Antiqua"/>
        <w:charset w:val="00"/>
        <w:family w:val="Roman"/>
        <w:pitch w:val="variable"/>
        <w:sig w:usb-0="00000003" w:usb-1="00000000" w:usb-2="00000000" w:usb-3="00000000" w:csb-0="00000001" w:csb-1="00000000"/>
      </w:font>
    </w:fonts>
    <w:lists>
      <w:listDef w:listDefId="0">
        <w:lsid w:val="FFFFFF83"/>
        <w:plt w:val="SingleLevel"/>
        <w:tmpl w:val="C85CED16"/>
        <w:lvl w:ilvl="0">
          <w:start w:val="1"/>
          <w:nfc w:val="23"/>
          <w:pStyle w:val="ListBullet1"/>
          <w:lvlText w:val=""/>
          <w:lvlJc w:val="left"/>
          <w:pPr>
            <w:tabs>
              <w:tab w:val="list" w:pos="643"/>
            </w:tabs>
            <w:ind w:left="643" w:hanging="360"/>
          </w:pPr>
          <w:rPr>
            <w:rFonts w:ascii="Symbol" w:h-ansi="Symbol" w:hint="default"/>
          </w:rPr>
        </w:lvl>
      </w:listDef>
      <w:list w:ilfo="1">
        <w:ilst w:val="0"/>
      </w:list>
    </w:lists>
    <w:styles>
      <w:versionOfBuiltInStylenames w:val="4"/>
      <w:latentStyles w:defLockedState="off" w:latentStyleCount="156"/>
      <w:style w:type="paragraph" w:default="on" w:styleId="Normal">
        <w:name w:val="Normal"/>
        <w:pPr>
          <w:spacing w:before="{$spacing}" w:after="{$spacing}"/>
          <xsl:if test="$keep_next = 'true'">
            <w:keepNext/>
          </xsl:if>
        </w:pPr>
        <w:rPr>
          <w:rFonts w:ascii="Verdana" w:h-ansi="Verdana"/>
          <wx:font wx:val="Verdana"/>
          <w:lang w:val="EN-AU" w:fareast="EN-US" w:bidi="AR-SA"/>
        </w:rPr>
      </w:style>
      <xsl:choose>
        <xsl:when test="$gaadmin = 'true'">
          <w:style w:type="paragraph" w:styleId="Heading1">
            <w:name w:val="heading 1"/>
            <wx:uiName wx:val="Heading 1"/>
            <w:basedOn w:val="Normal"/>
            <w:next w:val="Normal"/>
            <w:pPr>
              <w:keepNext/>
              <w:spacing w:before="240"/>
              <w:ind w:left="709" w:hanging="709"/>
              <w:outlineLvl w:val="0"/>
            </w:pPr>
            <w:rPr>
              <wx:font wx:val="Verdana"/>
              <w:b/>
              <w:sz w:val="24"/>
            </w:rPr>
          </w:style>
        </xsl:when>
        <xsl:otherwise>
          <w:style w:type="paragraph" w:styleId="Heading1">
            <w:name w:val="heading 1"/>
            <wx:uiName wx:val="Heading 1"/>
            <w:basedOn w:val="Normal"/>
            <w:next w:val="Normal"/>
            <w:pPr>
              <w:pStyle w:val="Heading1"/>
              <w:spacing w:before="240"/>
              <w:outlineLvl w:val="0"/>
            </w:pPr>
            <w:rPr>
              <wx:font wx:val="Verdana"/>
              <w:b/>
            </w:rPr>
          </w:style>
        </xsl:otherwise>
      </xsl:choose>
      <w:style w:type="paragraph" w:styleId="Heading2">
        <w:name w:val="heading 2"/>
        <wx:uiName wx:val="Heading 2"/>
        <w:basedOn w:val="Normal"/>
        <w:next w:val="Normal"/>
        <w:pPr>
          <w:pStyle w:val="Heading2"/>
          <w:keepNext/>
          <w:spacing w:before="180"/>
          <w:outlineLvl w:val="1"/>
        </w:pPr>
        <w:rPr>
          <wx:font wx:val="Verdana"/>
          <w:b/>
          <w:sz w:val="22"/>
        </w:rPr>
      </w:style>
      <w:style w:type="paragraph" w:styleId="Heading3">
        <w:name w:val="heading 3"/>
        <wx:uiName wx:val="Heading 3"/>
        <w:basedOn w:val="Normal"/>
        <w:next w:val="Normal"/>
        <w:pPr>
          <w:pStyle w:val="Heading3"/>
          <w:keepNext/>
          <w:outlineLvl w:val="2"/>
        </w:pPr>
        <w:rPr>
          <wx:font wx:val="Verdana"/>
          <w:b/>
        </w:rPr>
      </w:style>
      <w:style w:type="paragraph" w:styleId="Heading4">
        <w:name w:val="heading 4"/>
        <wx:uiName wx:val="Heading 4"/>
        <w:basedOn w:val="Normal"/>
        <w:next w:val="Normal"/>
        <w:pPr>
          <w:pStyle w:val="Heading4"/>
          <w:keepNext/>
          <w:outlineLvl w:val="3"/>
        </w:pPr>
        <w:rPr>
          <wx:font wx:val="Verdana"/>
          <w:b/>
        </w:rPr>
      </w:style>
      <w:style w:type="character" w:default="on" w:styleId="DefaultParagraphFont">
        <w:name w:val="Default Paragraph Font"/>
        <w:semiHidden/>
      </w:style>
      <w:style w:type="table" w:default="on" w:styleId="TableNormal">
        <w:name w:val="Normal Table"/>
        <wx:uiName wx:val="Table Normal"/>
        <w:semiHidden/>
        <w:rPr>
          <wx:font wx:val="Portugal"/>
        </w:rPr>
        <w:tblPr>
          <w:tblInd w:w="0" w:type="dxa"/>
          <w:tblCellMar>
            <w:top w:w="0" w:type="dxa"/>
            <w:left w:w="108" w:type="dxa"/>
            <w:bottom w:w="0" w:type="dxa"/>
            <w:right w:w="108" w:type="dxa"/>
          </w:tblCellMar>
        </w:tblPr>
      </w:style>
      <w:style w:type="list" w:default="on" w:styleId="NoList">
        <w:name w:val="No List"/>
        <w:semiHidden/>
      </w:style>
      <w:style w:type="paragraph" w:styleId="ChapterHeading">
        <w:name w:val="Chapter Heading"/>
        <w:basedOn w:val="Normal"/>
        <w:pPr>
          <w:pStyle w:val="ChapterHeading"/>
          <w:pBdr>
            <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="1" w:color="auto"/>
          </w:pBdr>
          <w:ind w:left="709" w:hanging="709"/>
        </w:pPr>
        <w:rPr>
          <wx:font wx:val="Verdana"/>
          <w:b/>
          <w:sz w:val="40"/>
        </w:rPr>
      </w:style>
      <w:style w:type="paragraph" w:styleId="Footer">
        <w:name w:val="footer"/>
        <wx:uiName wx:val="Footer"/>
        <w:basedOn w:val="Normal"/>
        <w:pPr>
          <w:pStyle w:val="Footer"/>
          <w:tabs>
            <w:tab w:val="right" w:pos="9072"/>
          </w:tabs>
          <w:spacing w:before="60" w:after="60"/>
        </w:pPr>
        <w:rPr>
          <wx:font wx:val="Verdana"/>
          <w:sz w:val="18"/>
        </w:rPr>
      </w:style>
      <w:style w:type="paragraph" w:styleId="FooterA4Shell">
        <w:name w:val="Footer A4 Shell"/>
        <w:basedOn w:val="Normal"/>
        <w:pPr>
          <w:pStyle w:val="FooterA4Shell"/>
          <w:tabs>
            <w:tab w:val="right" w:pos="7655"/>
          </w:tabs>
        </w:pPr>
        <w:rPr>
          <wx:font wx:val="Verdana"/>
          <w:sz w:val="18"/>
        </w:rPr>
      </w:style>
      <w:style w:type="character" w:styleId="FootnoteReference">
        <w:name w:val="footnote reference"/>
        <wx:uiName wx:val="Footnote Reference"/>
        <w:basedOn w:val="DefaultParagraphFont"/>
        <w:semiHidden/>
        <w:rPr>
          <w:rFonts w:ascii="Verdana" w:h-ansi="Verdana"/>
          <w:sz w:val="18"/>
          <w:vertAlign w:val="superscript"/>
        </w:rPr>
      </w:style>
      <w:style w:type="paragraph" w:styleId="FootnoteText">
        <w:name w:val="footnote text"/>
        <wx:uiName wx:val="Footnote Text"/>
        <w:basedOn w:val="Normal"/>
        <w:semiHidden/>
        <w:pPr>
          <w:pStyle w:val="FootnoteText"/>
          <w:spacing w:before="0" w:after="0"/>
          <w:ind w:left="709" w:hanging="709"/>
        </w:pPr>
        <w:rPr>
          <wx:font wx:val="Verdana"/>
          <w:sz w:val="18"/>
        </w:rPr>
      </w:style>
      <w:style w:type="paragraph" w:styleId="Header">
        <w:name w:val="header"/>
        <wx:uiName wx:val="Header"/>
        <w:basedOn w:val="Normal"/>
        <w:pPr>
          <w:pStyle w:val="Header"/>
          <w:tabs>
            <w:tab w:val="right" w:pos="9072"/>
          </w:tabs>
          <w:spacing w:before="0" w:after="0"/>
        </w:pPr>
        <w:rPr>
          <wx:font wx:val="Verdana"/>
          <w:sz w:val="18"/>
        </w:rPr>
      </w:style>
      <w:style w:type="paragraph" w:styleId="InternalHeader">
        <w:name w:val="Internal Header"/>
        <w:basedOn w:val="Normal"/>
        <w:pPr>
          <w:pStyle w:val="InternalHeader"/>
          <w:jc w:val="center"/>
        </w:pPr>
        <w:rPr>
          <wx:font wx:val="Verdana"/>
          <w:b/>
        </w:rPr>
      </w:style>
      <w:style w:type="paragraph" w:styleId="InternalListNumber">
        <w:name w:val="Internal List Number"/>
        <w:basedOn w:val="Normal"/>
        <w:pPr>
          <w:pStyle w:val="InternalListNumber"/>
          <w:listPr>
            <w:ilfo w:val="5"/>
          </w:listPr>
          <w:spacing w:before="240"/>
        </w:pPr>
        <w:rPr>
          <wx:font wx:val="Verdana"/>
        </w:rPr>
      </w:style>
      <w:style w:type="paragraph" w:styleId="InternalSubheading">
        <w:name w:val="Internal Subheading"/>
        <w:basedOn w:val="Normal"/>
        <w:pPr>
          <w:pStyle w:val="InternalSubheading"/>
          <w:jc w:val="center"/>
        </w:pPr>
        <w:rPr>
          <wx:font wx:val="Verdana"/>
          <w:b/>
        </w:rPr>
      </w:style>
      <w:style w:type="paragraph" w:styleId="ListBullet1">
        <w:name w:val="List Bullet 1"/>
        <w:basedOn w:val="Normal"/>
        <w:pPr>
          <w:pStyle w:val="ListBullet1"/>
          <w:tabs>
            <w:tab w:val="list" w:pos="709"/>
          </w:tabs>
          <w:spacing w:before="0"/>
          <w:ind w:left="709" w:hanging="709"/>
        </w:pPr>
        <w:rPr>
          <wx:font wx:val="Verdana"/>
        </w:rPr>
      </w:style>
      <w:style w:type="paragraph" w:styleId="Normalsingle">
        <w:name w:val="Normal single"/>
        <w:basedOn w:val="Normal"/>
        <w:pPr>
          <w:pStyle w:val="Normalsingle"/>
          <w:spacing w:before="0" w:after="0"/>
        </w:pPr>
        <w:rPr>
          <wx:font wx:val="Verdana"/>
        </w:rPr>
      </w:style>
      <w:style w:type="character" w:styleId="PageNumber">
        <w:name w:val="page number"/>
        <wx:uiName wx:val="Page Number"/>
        <w:basedOn w:val="DefaultParagraphFont"/>
        <w:rPr>
          <w:rFonts w:ascii="Verdana" w:h-ansi="Verdana"/>
          <w:sz w:val="18"/>
        </w:rPr>
      </w:style>
      <w:style w:type="paragraph" w:styleId="Subtitle">
        <w:name w:val="Subtitle"/>
        <w:basedOn w:val="Normal"/>
        <w:pPr>
          <w:pStyle w:val="Subtitle"/>
          <w:jc w:val="center"/>
        </w:pPr>
        <w:rPr>
          <w:rFonts w:cs="Arial"/>
          <wx:font wx:val="Verdana"/>
          <w:b/>
          <w:sz w:val="24"/>
          <w:sz-cs w:val="24"/>
        </w:rPr>
      </w:style>
      <w:style w:type="paragraph" w:styleId="Title">
        <w:name w:val="Title"/>
        <w:basedOn w:val="Normal"/>
        <w:pPr>
          <w:pStyle w:val="Title"/>
          <w:jc w:val="center"/>
        </w:pPr>
        <w:rPr>
          <w:rFonts w:cs="Arial"/>
          <wx:font wx:val="Verdana"/>
          <w:b/>
          <w:b-cs/>
          <w:sz w:val="32"/>
          <w:sz-cs w:val="32"/>
        </w:rPr>
      </w:style>
      <w:style w:type="paragraph" w:styleId="TOC1">
        <w:name w:val="toc 1"/>
        <wx:uiName wx:val="TOC 1"/>
        <w:basedOn w:val="Normal"/>
        <w:next w:val="Normal"/>
        <w:autoRedefine/>
        <w:semiHidden/>
        <w:pPr>
          <w:pStyle w:val="TOC1"/>
          <w:tabs>
            <w:tab w:val="right" w:pos="9072"/>
          </w:tabs>
          <w:spacing w:before="80" w:after="80"/>
        </w:pPr>
        <w:rPr>
          <wx:font wx:val="Verdana"/>
          <w:b/>
        </w:rPr>
      </w:style>
      <w:style w:type="paragraph" w:styleId="TOC2">
        <w:name w:val="toc 2"/>
        <wx:uiName wx:val="TOC 2"/>
        <w:basedOn w:val="Normal"/>
        <w:next w:val="Normal"/>
        <w:autoRedefine/>
        <w:semiHidden/>
        <w:pPr>
          <w:pStyle w:val="TOC2"/>
          <w:tabs>
            <w:tab w:val="right" w:pos="9072"/>
          </w:tabs>
          <w:spacing w:before="80" w:after="80"/>
        </w:pPr>
        <w:rPr>
          <wx:font wx:val="Verdana"/>
        </w:rPr>
      </w:style>
      <w:style w:type="table" w:styleId="TableGrid">
        <w:name w:val="Table Grid"/>
        <w:basedOn w:val="TableNormal"/>
        <w:pPr>
          <w:spacing w:before="60" w:after="60"/>
        </w:pPr>
        <w:rPr>
          <wx:font wx:val="Times New Roman"/>
        </w:rPr>
        <w:tblPr>
          <w:tblInd w:w="0" w:type="dxa"/>
          <w:tblBorders>
            <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            <w:left w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            <w:right w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            <w:insideH w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            <w:insideV w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          </w:tblBorders>
          <w:tblCellMar>
            <w:top w:w="0" w:type="dxa"/>
            <w:left w:w="108" w:type="dxa"/>
            <w:bottom w:w="0" w:type="dxa"/>
            <w:right w:w="108" w:type="dxa"/>
          </w:tblCellMar>
        </w:tblPr>
      </w:style>
      <w:style w:type="character" w:styleId="Emphasis">
        <w:name w:val="Emphasis"/>
        <w:basedOn w:val="DefaultParagraphFont"/>
        <w:rPr>
          <w:i/>
          <w:i-cs/>
        </w:rPr>
      </w:style>
      <w:style w:type="character" w:styleId="Hyperlink">
        <w:name w:val="Hyperlink"/>
        <w:basedOn w:val="DefaultParagraphFont"/>
        <w:rPr>
          <w:rFonts w:ascii="Verdana" w:h-ansi="Verdana"/>
          <w:color w:val="0000FF"/>
          <w:sz w:val="20"/>
          <w:u w:val="single"/>
        </w:rPr>
      </w:style>
      <w:style w:type="paragraph" w:styleId="Hidden">
        <w:name w:val="Hidden"/>
        <wx:uiName wx:val="HIDDEN"/>
        <w:basedOn w:val="Normal"/>
        <w:link w:val="HiddenChar"/>
        <w:pPr>
          <w:pStyle w:val="Hidden"/>
        </w:pPr>
        <w:rPr>
          <wx:font wx:val="Verdana"/>
          <w:vanish/>
        </w:rPr>
      </w:style>
      <w:style w:type="character" w:styleId="HiddenChar">
        <w:name w:val="Hidden Char"/>
        <wx:uiName wx:val="HIDDEN CHAR"/>
        <w:basedOn w:val="DefaultParagraphFont"/>
        <w:link w:val="Hidden"/>
        <w:rPr>
          <w:rFonts w:ascii="Verdana" w:h-ansi="Verdana"/>
          <w:color w:val="FFFFFF"/>
          <w:sz w:val="1"/>
        </w:rPr>
      </w:style>
    </w:styles>
    <w:docPr>
      <w:view w:val="print"/>
      <w:zoom w:percent="90"/>
      <w:printFractionalCharacterWidth/>
      <w:doNotEmbedSystemFonts/>
      <w:hideGrammaticalErrors/>
      <w:activeWritingStyle w:lang="EN-AU" w:vendorID="8" w:dllVersion="513" w:optionSet="0"/>
      <w:defaultTabStop w:val="{$tab}"/>
      <w:doNotHyphenateCaps/>
      <w:displayHorizontalDrawingGridEvery w:val="0"/>
      <w:displayVerticalDrawingGridEvery w:val="0"/>
      <w:useMarginsForDrawingGridOrigin/>
      <w:doNotShadeFormData/>
      <w:characterSpacingControl w:val="DontCompress"/>
      <w:optimizeForBrowser/>
      <w:validateAgainstSchema/>
      <w:saveInvalidXML w:val="off"/>
      <w:ignoreMixedContent w:val="off"/>
      <w:alwaysShowPlaceholderText w:val="off"/>
      <w:footnotePr>
        <w:footnote w:type="separator">
          <w:p>
            <w:r>
              <w:separator/>
            </w:r>
          </w:p>
        </w:footnote>
        <w:footnote w:type="continuation-separator">
          <w:p>
            <w:r>
              <w:continuationSeparator/>
            </w:r>
          </w:p>
        </w:footnote>
      </w:footnotePr>
      <w:endnotePr>
        <w:endnote w:type="separator">
          <w:p>
            <w:r>
              <w:separator/>
            </w:r>
          </w:p>
        </w:endnote>
        <w:endnote w:type="continuation-separator">
          <w:p>
            <w:r>
              <w:continuationSeparator/>
            </w:r>
          </w:p>
        </w:endnote>
      </w:endnotePr>
      <w:compat>
        <w:printColBlack/>
        <w:showBreaksInFrames/>
        <w:suppressSpBfAfterPgBrk/>
        <w:swapBordersFacingPages/>
        <w:convMailMergeEsc/>
        <w:ww6BorderRules/>
        <w:footnoteLayoutLikeWW8/>
        <w:shapeLayoutLikeWW8/>
        <w:alignTablesRowByRow/>
        <w:forgetLastTabAlignment/>
        <w:noSpaceRaiseLower/>
        <w:doNotUseHTMLParagraphAutoSpacing/>
        <w:layoutRawTableWidth/>
        <w:layoutTableRowsApart/>
        <w:useWord97LineBreakingRules/>
        <w:dontAllowFieldEndSelect/>
        <w:useWord2002TableStyleRules/>
      </w:compat>
    </w:docPr>
  </xsl:template>
</xsl:stylesheet>
