<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.records.nsw.gov.au/schemas/RDA" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" version="1.0">
  <xsl:output method="xml" indent="yes"/>
  <xsl:include href="include/add_authorised_disposal.xsl"/>
  <xsl:template match="*|text()|@*">
    <xsl:copy>
      <xsl:apply-templates select="*|text()|@*"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="@update"/>
  <xsl:template match="rda:Comment"/>
  <xsl:template match="rda:Context[@type='appraisal report']"/>
  <xsl:template match="rda:Context[@type='supporting documentation']"/>
  <xsl:template match="rda:Justification"/>
</xsl:stylesheet>
