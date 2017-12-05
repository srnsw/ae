<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:aml="http://schemas.microsoft.com/aml/2001/core" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output indent="yes" method="xml"/>
  <xsl:include href="include/stocks.xsl"/>
  <xsl:include href="include/word_header.xsl"/>
  <xsl:include href="include/word_headers_footers.xsl"/>
  <xsl:include href="include/render_word_authority.xsl"/>
  <xsl:include href="include/render_word_contents.xsl"/>
  <xsl:include href="include/word_consult_pt1.xsl"/>
  <xsl:variable name="HASCUSTODY">
    <xsl:call-template name="hascustody">
      <xsl:with-param name="classes" select="descendant::rda:Class"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="SHOWARCHIVESJUST">
    <xsl:value-of select="'false'"/>
  </xsl:variable>
  <xsl:variable name="SHOWSEEREF">
    <xsl:value-of select="'false'"/>
  </xsl:variable>
  <xsl:variable name="JUSTIFICATION">
    <xsl:value-of select="'row'"/>
  </xsl:variable>
  <xsl:variable name="COLS">
    <xsl:value-of select="'no_j_c'"/>
  </xsl:variable>
  <xsl:variable name="ORIENTATION">
    <xsl:choose>
      <xsl:when test="rda:Authority/rda:LinkedTo[@type='orientation' and .='landscape']">
        <xsl:value-of select="'landscape'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'portrait'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="ID">
    <xsl:text>Authority number: </xsl:text>
    <xsl:value-of select="$RDANO"/>
  </xsl:variable>
  <xsl:variable name="AUTHORITY_HEAD">
    <xsl:text>DRAFT - </xsl:text>
    <xsl:value-of select="$AUTHORITY_TYPE"/>
  </xsl:variable>
  <xsl:variable name="AUTHORITY_TITLE">
    <xsl:value-of select="$AGENCY_NAMES"/>
  </xsl:variable>
  <xsl:variable name="SHORT_TITLE">
    <xsl:value-of select="$AGENCY_NAMES"/>
  </xsl:variable>
  <xsl:variable name="ADJUST_PGNO">
    <xsl:value-of select="'0'"/>
  </xsl:variable>
  <xsl:template match="rda:Authority">
    <xsl:processing-instruction name="mso-application">
      <xsl:text>progid=&quot;Word.Document&quot;</xsl:text>
    </xsl:processing-instruction>
    <w:wordDocument w:embeddedObjPresent="no" w:macrosPresent="no" w:ocxPresent="no" xml:space="preserve">
      <xsl:call-template name="word_header">
        <xsl:with-param name="gaadmin" select="'true'"/>
        <xsl:with-param name="keep_next" select="'true'"/>
      </xsl:call-template>
      <w:body>
        <wx:sect>
          <xsl:call-template name="word_consult_pt1"/>
          <w:p>
            <w:pPr>
              <w:rPr>
                <w:smallCaps/>
              </w:rPr>
              <w:sectPr>
                <xsl:call-template name="portrait_header_footer">
                  <xsl:with-param name="header_first" select="'State Archives and Records Authority of New South Wales'"/>
                  <xsl:with-param name="footer_text" select="'CONSULTATION DRAFT'"/>
                </xsl:call-template>
                <w:pgSz w:code="9" w:h="16840" w:w="11907"/>
                <w:pgMar w:bottom="1418" w:footer="720" w:gutter="0" w:header="720" w:left="1418" w:right="1418" w:top="1418"/>
                <w:paperSrc w:first="11" w:other="11"/>
                <w:cols w:space="720"/>
                <w:titlePg/>
              </w:sectPr>
            </w:pPr>
          </w:p>
          <xsl:if test="count(//rda:Term)&gt;5">
            <xsl:call-template name="TOC"/>
          </xsl:if>
          <xsl:call-template name="render_authority"/>
          <w:sectPr>
            <xsl:call-template name="headers_footers">
              <xsl:with-param name="gaadmin" select="'true'"/>
            </xsl:call-template>
            <xsl:if test="$ORIENTATION='portrait'">
              <w:pgSz w:code="9" w:h="16840" w:w="11907"/>
              <w:pgMar w:bottom="1418" w:footer="567" w:gutter="0" w:header="567" w:left="1418" w:right="1418" w:top="1418"/>
            </xsl:if>
            <xsl:if test="$ORIENTATION='landscape'">
              <w:pgSz w:code="9" w:h="11907" w:orient="landscape" w:w="16840"/>
              <w:pgMar w:bottom="1418" w:footer="567" w:gutter="0" w:header="567" w:left="1134" w:right="1134" w:top="1418"/>
            </xsl:if>
            <w:paperSrc w:first="11" w:other="11"/>
            <w:cols w:space="720"/>
            <w:titlePg/>
          </w:sectPr>
        </wx:sect>
      </w:body>
    </w:wordDocument>
  </xsl:template>
</xsl:stylesheet>