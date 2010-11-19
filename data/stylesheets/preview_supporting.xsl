<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" version="1.0">
  <xsl:output method="html"/>
  <xsl:include href="include/preview_ar.xsl"/>
  <xsl:variable name="SHOW_COMMENTS" select="'false'"/>
  <xsl:variable name="CONTEXT_TITLE" select="'Agency supporting documentation'"/>
  <xsl:variable name="CONTEXT_TYPE" select="'supporting documentation'"/>
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>
</xsl:stylesheet>
