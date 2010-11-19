<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" version="1.0">
  <xsl:output method="html"/>
   <xsl:include href="include/html_header.xsl"/>
  <xsl:include href="include/render_html_authority.xsl"/>
  <xsl:variable name="SHOW_UPDATES" select="'true'"/>
  <xsl:variable name="SHOW_COMMENTS" select="'true'"/>
  <xsl:template match="rda:Authority">
  <html>
      <xsl:call-template name="html_header">
        <xsl:with-param name="title" select="'Recent changes'"/>
      </xsl:call-template>
      <body>
      <H1>Recent changes</H1>
      <table width="100%">
        <xsl:call-template name="preview_contents"/>
        <xsl:apply-templates select="//rda:Term[@update] | //rda:Class[@update]">
          <xsl:sort select="@update" order="descending"/>
        </xsl:apply-templates>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
