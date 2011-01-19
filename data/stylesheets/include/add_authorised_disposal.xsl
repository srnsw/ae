<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.records.nsw.gov.au/schemas/RDA" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" version="1.0">
  <xsl:include href="disposal_srnsw_rda.xsl"/>
  <xsl:include href="disposal_common.xsl"/>
  <xsl:template match="rda:Class">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="rda:ID"/>
      <xsl:apply-templates select="rda:RDANo"/>
      <xsl:apply-templates select="rda:ClassTitle"/>
      <xsl:apply-templates select="rda:ClassDescription"/>
      <xsl:apply-templates select="rda:Disposal"/>
      <xsl:if test="rda:Disposal and not(rda:Disposal/rda:DisposalCondition='Authorised')">
        <xsl:variable name="CustomCustody">
          <xsl:call-template name="custody">
            <xsl:with-param name="disposals" select="rda:Disposal"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:element name="Disposal">
          <xsl:element name="DisposalCondition">
            <xsl:text>Authorised</xsl:text>
          </xsl:element>
          <xsl:element name="CustomAction">
            <xsl:call-template name="disposal_action">
              <xsl:with-param name="disposals" select="rda:Disposal"/>
            </xsl:call-template>
          </xsl:element>
          <xsl:if test="$CustomCustody != ''">
            <xsl:element name="CustomCustody">
              <xsl:call-template name="custody">
                <xsl:with-param name="disposals" select="rda:Disposal"/>
              </xsl:call-template>
            </xsl:element>            
          </xsl:if>
        </xsl:element>
      </xsl:if>
      <xsl:apply-templates select="rda:Justification"/>
      <xsl:apply-templates select="rda:DateRange"/>
      <xsl:apply-templates select="rda:Status"/>
      <xsl:apply-templates select="rda:LinkedTerm"/>
      <xsl:apply-templates select="rda:Comment"/>
    </xsl:copy>
   </xsl:template>
</xsl:stylesheet>
