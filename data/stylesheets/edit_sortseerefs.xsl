<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" version="1.0">
  <xsl:output method="xml" indent="yes"/>
  <xsl:template match="*|text()|@*">
    <xsl:copy>
      <xsl:apply-templates select="*|text()|@*"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="rda:TermDescription | rda:ClassDescription">
    <xsl:copy>
      <xsl:apply-templates>
        <xsl:sort select="rda:IDRef/@control"/>
        <xsl:sort select="rda:AuthorityTitleRef"/>
        <xsl:sort select="rda:IDRef"/>
        <xsl:sort select="rda:TermTitleRef"/>
        <xsl:sort select="rda:TermTitleRef[2]"/>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
