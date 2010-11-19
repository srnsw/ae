<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:sl="http://schemas.microsoft.com/schemaLibrary/2003/core" xmlns:aml="http://schemas.microsoft.com/aml/2001/core" xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:dt="uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:wsp="http://schemas.microsoft.com/office/word/2003/wordml/sp2" xmlns:st1="urn:schemas-microsoft-com:office:smarttags" version="1.0">
  <xsl:output method="xml" indent="yes"/>
  <xsl:include href="include/stocks.xsl"/>
  <xsl:include href="include/word_header.xsl"/>
  <xsl:include href="include/word_headers_footers.xsl"/>
  <xsl:include href="include/render_word.xsl"/>
  <xsl:include href="include/word_ar1.xsl"/>
  <xsl:variable name="SUBMITTED">
    <xsl:for-each select="rda:Authority/rda:Status/rda:Submitted">
      <xsl:if test="position() &gt;1">
        <xsl:choose>
          <xsl:when test="position()=last()">
            <xsl:text> and </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>, </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      <xsl:value-of select="rda:Officer"/>
      <xsl:text> (</xsl:text>
      <xsl:value-of select="rda:Position"/>
      <xsl:text>, </xsl:text>
      <xsl:value-of select="rda:Agency"/>
      <xsl:text>)</xsl:text>
    </xsl:for-each>
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
      <xsl:text>progid="Word.Document"</xsl:text>
    </xsl:processing-instruction>
    <w:wordDocument w:macrosPresent="no" w:embeddedObjPresent="no" w:ocxPresent="no" xml:space="preserve">
				<xsl:call-template name="word_header">
				  <xsl:with-param name="keep_next" select="'true'"/>
        </xsl:call-template>
				<w:body>
        <wx:sect>
        <xsl:call-template name="word_ar1"/>
          <w:sectPr>
              <xsl:call-template name="portrait_header_footer">
                <xsl:with-param name="header_first" select="'Board of the State Records Authority of New South Wales'"/>
                <xsl:with-param name="header_text" select="concat('Appraisal Report ', $ARNO)"/>
                <xsl:with-param name="footer_text" select="'BOARD-IN-CONFIDENCE'"/>
              </xsl:call-template>
              <w:pgSz w:w="11907" w:h="16840" w:code="9"/>
              <w:pgMar w:top="1418" w:right="1418" w:bottom="1418" w:left="1418" w:header="720" w:footer="720" w:gutter="0"/>
              <w:paperSrc w:first="11" w:other="11"/>
              <w:cols w:space="720"/>
              <w:titlePg/>
            </w:sectPr>
         </wx:sect>
        </w:body>
			</w:wordDocument>
  </xsl:template>
</xsl:stylesheet>
