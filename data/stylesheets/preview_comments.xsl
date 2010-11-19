<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" version="1.0">
  <xsl:output method="html"/>
  <xsl:include href="include/html_header.xsl"/>
  <xsl:include href="include/render_html.xsl"/>
  <xsl:include href="include/stocks.xsl"/>
  <xsl:template match="rda:Authority">
     <html>
      <xsl:call-template name="html_header">
        <xsl:with-param name="title" select="'Comments'"/>
      </xsl:call-template>
      <body>
      <H1 align="center">Authority</H1>
        <p/>
        <p><xsl:text>Comments on </xsl:text><xsl:value-of select="$DRAFT_AGENCIES"/><xsl:text> draft </xsl:text><xsl:value-of select="AUTHORITY_TYPE_LC"/><xsl:text> (version </xsl:text><xsl:value-of select="$DRAFT_VERSION"/><xsl:text>, submitted </xsl:text><xsl:value-of select="$DRAFT_DATE"/><xsl:text>)</xsl:text></p>
        <p/>
        <xsl:if test="rda:Comment">
              <p>
                <H3>GENERAL COMMENTS</H3>
                </p>
            </xsl:if>
            <xsl:apply-templates select="rda:Comment"/>
            <xsl:if test="rda:Context/rda:Comment">
              <p>
              <H3>SPECIFIC COMMENTS – CONTEXT</H3>
                </p>
            </xsl:if>
            <xsl:for-each select="rda:Context[rda:Comment]">
              <p>
                  <b><xsl:value-of select="rda:ContextTitle"/></b>
               </p>
              <xsl:apply-templates select="rda:Comment"/>
            </xsl:for-each>
            <xsl:if test="//rda:Term/rda:Comment or //rda:Class/rda:Comment">
              <p>
              <H3>SPECIFIC COMMENTS – FUNCTIONS AND ACTIVITIES</H3>
               </p>
            </xsl:if>
            <xsl:apply-templates select="//rda:Term[rda:Comment] | //rda:Class[rda:Comment]"/>
        </body>
        </html>
</xsl:template>
  
<xsl:template match="rda:Term | rda:Class">
    <p>
    <b>
    <xsl:call-template name="build_address_with_itemno"><xsl:with-param name="node" select="."/></xsl:call-template>
    </b>
    </p>
    <xsl:for-each select="rda:Comment">
    <xsl:apply-templates select="."/>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
