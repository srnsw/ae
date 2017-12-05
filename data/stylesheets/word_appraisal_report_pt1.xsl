<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:aml="http://schemas.microsoft.com/aml/2001/core" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output indent="yes" method="xml"/>
  <xsl:include href="include/stocks.xsl"/>
  <xsl:include href="include/word_header.xsl"/>
  <xsl:include href="include/word_headers_footers.xsl"/>
  <xsl:include href="include/word_ar_headers_footers.xsl"/>
  <xsl:include href="include/render_word.xsl"/>
  <xsl:include href="include/word_ar1.xsl"/>
  <xsl:variable name="SUBMITTED">
    <xsl:for-each select="rda:Authority/rda:Status/rda:Submitted">
      <xsl:if test="position() &gt;1">
        <xsl:choose>
          <xsl:when test="position()=last()">
            <xsl:text>and </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>, </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      <xsl:value-of select="rda:Officer"/>
      <xsl:text>(</xsl:text>
      <xsl:value-of select="rda:Position"/>
      <xsl:text>, </xsl:text>
      <xsl:value-of select="rda:Agency"/>
      <xsl:text>)</xsl:text>
    </xsl:for-each>
  </xsl:variable>
  <xsl:variable name="SCOPE_TITLE">
    <xsl:choose>
      <xsl:when test="rda:Authority/rda:AuthorityTitle">
        <xsl:call-template name="lower_case">
          <xsl:with-param name="string" select="rda:Authority/rda:AuthorityTitle"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="lower_case">
          <xsl:with-param name="string" select="$SCOPE"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="HASCUSTODY">
    <xsl:value-of select="'false'"/>
  </xsl:variable>
  <xsl:variable name="COLS">
    <xsl:value-of select="'j'"/>
  </xsl:variable>
  <xsl:variable name="ID">
    <xsl:text>AR No: </xsl:text>
    <xsl:value-of select="$ARNO"/>
  </xsl:variable>
  <xsl:variable name="AUTHORITY_HEAD">
    <xsl:text>Appraisal Report Part 2 - </xsl:text>
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
        <xsl:with-param name="keep_next" select="'true'"/>
      </xsl:call-template>
      <w:body>
        <wx:sect>
          <xsl:call-template name="word_ar1"/>
          <w:sectPr>
            <xsl:call-template name="ar_header_footer">
              <xsl:with-param name="header_first" select="'Item '"/>
              <xsl:with-param name="header_first_x" select="'x.x'"/>
              <xsl:with-param name="footer_text" select="'BOARD-IN-CONFIDENCE'"/>
              <xsl:with-param name="footer_first_a" select="'Board meeting of '"/>
              <xsl:with-param name="footer_first_a_x" select="'xxxx'"/>
              <xsl:with-param name="footer_first_b" select="concat('Appraisal Report ', $ARNO)"/>
              <xsl:with-param name="footer_first_c" select="concat('File ref. ', $SRFILENOS)"/>
            </xsl:call-template>
            <w:pgSz w:code="9" w:h="16840" w:w="11907"/>
            <w:pgMar w:bottom="1418" w:footer="720" w:gutter="0" w:header="720" w:left="1418" w:right="1418" w:top="1418"/>
            <w:paperSrc w:first="11" w:other="11"/>
            <w:cols w:space="720"/>
            <w:titlePg/>
          </w:sectPr>
        </wx:sect>
      </w:body>
    </w:wordDocument>
  </xsl:template>
</xsl:stylesheet>