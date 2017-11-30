<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:aml="http://schemas.microsoft.com/aml/2001/core" xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" xmlns:o="urn:schemas-microsoft-com:office:office" version="1.0">
  <xsl:output method="xml" indent="yes"/>
  <xsl:include href="include/stocks.xsl"/>
  <xsl:include href="include/word_header.xsl"/>
  <xsl:include href="include/word_headers_footers.xsl"/>
  <xsl:include href="include/render_word_authority_classic.xsl"/>
  <xsl:include href="include/render_word_contents.xsl"/>
  <xsl:variable name="HASCUSTODY">
    <xsl:call-template name="hascustody">
      <xsl:with-param name="classes" select="descendant::rda:Class"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="SHOWARCHIVESJUST">
    <xsl:value-of select="'true'"/>  
  </xsl:variable>
    <xsl:variable name="SHOWSEEREF">
	<xsl:value-of select="'true'"/>  
  </xsl:variable>
  <xsl:variable name="JUSTIFICATION">
    <xsl:choose>
      <xsl:when test="rda:Authority/rda:LinkedTo[@type='justification' and .='column']">
        <xsl:value-of select="'column'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'row'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="COLS">
    <xsl:choose>
      <xsl:when test="$HASCUSTODY='true'">
        <xsl:choose>
          <xsl:when test="$JUSTIFICATION='row'">
            <xsl:value-of select="'c'"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="'j_c'"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$JUSTIFICATION='row'">
            <xsl:value-of select="'no_j_c'"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="'j'"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="ORIENTATION">
    <xsl:choose>
      <xsl:when test="rda:Authority/rda:LinkedTo[@type='orientation' and .='portrait']">
        <xsl:value-of select="'portrait'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'landscape'"/>
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
      <xsl:text>progid="Word.Document"</xsl:text>
    </xsl:processing-instruction>
    <w:wordDocument w:macrosPresent="no" w:embeddedObjPresent="no" w:ocxPresent="no" xml:space="preserve">
    <xsl:call-template name="word_header"/>
    <w:body>
      <wx:sect>
        <xsl:if test="count(//rda:Term)&gt;5">
          <xsl:call-template name="TOC"/>
        </xsl:if>
        <xsl:call-template name="render_authority"/>
         <w:sectPr>
           <xsl:call-template name="headers_footers"/>
           <xsl:if test="$ORIENTATION='portrait'">
                <w:pgSz w:w="11907" w:h="16840" w:code="9"/>
                <w:pgMar w:top="1418" w:right="1418" w:bottom="1418" w:left="1418" w:header="567" w:footer="567" w:gutter="0"/>
              </xsl:if>
              <xsl:if test="$ORIENTATION='landscape'">
                <w:pgSz w:w="16840" w:h="11907" w:orient="landscape" w:code="9"/>
                <w:pgMar w:top="1418" w:right="1134" w:bottom="1418" w:left="1134" w:header="567" w:footer="567" w:gutter="0"/>
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
