<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:aml="http://schemas.microsoft.com/aml/2001/core" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output indent="yes" method="xml"/>
  <xsl:include href="include/stocks_asa.xsl"/>
  <xsl:include href="include/word_header.xsl"/>
  <xsl:include href="include/word_headers_footers_asa.xsl"/>
  <xsl:include href="include/render_word_authority_classic_asa.xsl"/>
  <xsl:include href="include/render_word_contents_asa.xsl"/>
  <xsl:variable name="ORIENTATION">
    <xsl:value-of select="'landscape'"/>
  </xsl:variable>
  <xsl:variable name="CUSTOWN">
    <xsl:value-of select="'false'"/>
  </xsl:variable>
  <xsl:variable name="SHOWSEEREF">
    <xsl:value-of select="'true'"/>
  </xsl:variable>
    <xsl:variable name="ADJUST_PGNO">
    <xsl:value-of select="'0'"/>
  </xsl:variable>
  <xsl:template match="rda:Authority">
    <xsl:processing-instruction name="mso-application">
      <xsl:text>progid=&quot;Word.Document&quot;</xsl:text>
    </xsl:processing-instruction>
    <w:wordDocument w:embeddedObjPresent="no" w:macrosPresent="no" w:ocxPresent="no" xml:space="preserve">
      <xsl:call-template name="word_header"/>
      <w:body>
        <wx:sect>
          <xsl:if test="count(//rda:Term)&gt;5">
            <xsl:call-template name="TOC"/>
          </xsl:if>
          <xsl:call-template name="render_authority"/>
          <w:sectPr>
            <xsl:call-template name="headers_footers"/>
            <w:pgSz w:code="9" w:h="11907" w:orient="landscape" w:w="16840"/>
            <w:pgMar w:bottom="1418" w:footer="567" w:gutter="0" w:header="567" w:left="1134" w:right="1134" w:top="1418"/>
            <w:paperSrc w:first="11" w:other="11"/>
            <w:cols w:space="720"/>
            <w:titlePg/>
          </w:sectPr>
        </wx:sect>
      </w:body>
    </w:wordDocument>
  </xsl:template>
</xsl:stylesheet>