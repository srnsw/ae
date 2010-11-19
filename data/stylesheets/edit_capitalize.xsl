<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" version="1.0">
  <xsl:output method="xml" indent="yes"/>
  <xsl:include href="include/utils.xsl"/>
  <xsl:template match="*|text()|@*">
    <xsl:copy>
      <xsl:apply-templates select="*|text()|@*"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="rda:TermTitle">
    <xsl:copy>
    <xsl:choose>
      <xsl:when test="../parent::rda:Authority">  
        <xsl:value-of select="translate(., $lowerCaseChars, $upperCaseChars)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="camel_case">
          <xsl:with-param name="string" select="."/>
          <xsl:with-param name="strict" select="'true'"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="rda:TermTitleRef">
    <xsl:copy>
    <xsl:choose>
      <xsl:when test="position()=1">  
        <xsl:value-of select="translate(., $lowerCaseChars, $upperCaseChars)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="camel_case">
          <xsl:with-param name="string" select="."/>
          <xsl:with-param name="strict" select="'true'"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
