<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.records.nsw.gov.au/schemas/RDA" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" version="1.0">
  <xsl:output method="xml" indent="yes"/>
  <xsl:template match="rda:Authority">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="rda:ID"/>
      <xsl:apply-templates select="rda:AuthorityTitle"/>
      <xsl:apply-templates select="rda:RDANo"/>
      <xsl:apply-templates select="rda:ARNo"/>
      <xsl:apply-templates select="rda:SRFileNo"/>
      <xsl:apply-templates select="rda:Scope"/>
      <xsl:apply-templates select="rda:DateRange"/>
      <xsl:apply-templates select="rda:Status"/>
      <xsl:apply-templates select="rda:LinkedTerm"/>
      <xsl:apply-templates select="rda:Comment"/>
      <xsl:apply-templates select="rda:Context"/>
      <xsl:apply-templates select="rda:Term | rda:Class"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="*|text()|@*">
    <xsl:copy>
      <xsl:apply-templates select="*|text()|@*"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="rda:RDANo">
    <xsl:element name="ID">
      <xsl:attribute name="control">
        <xsl:value-of select="@type"/>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="rda:ARNo">
    <xsl:element name="ID">
      <xsl:attribute name="control">
        <xsl:text>AR</xsl:text>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="rda:SRFileNo">
    <xsl:element name="ID">
      <xsl:attribute name="control">
        <xsl:text>SRFileNo</xsl:text>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="rda:Applying/rda:Date">
    <xsl:element name="StartDate">
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="rda:LinkedTerm">
    <xsl:element name="LinkedTo">
      <xsl:attribute name="type">
        <xsl:value-of select="@control"/>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="rda:Context">
    <xsl:element name="Context">
      <xsl:attribute name="type">
        <xsl:choose>
          <xsl:when test="@author='agency'">
            <xsl:text>supporting documentation</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>appraisal report</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="@control"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="rda:SeeReference | rda:Supersedes | rda:PartSupersedes | rda:SupersededBy | rda:PartSupersededBy">
    <xsl:copy>
      <xsl:apply-templates select="rda:IDRef | rda:AuthorityTitleRef | rda:TermTitleRef | rda:ItemNoRef"/>
      <xsl:for-each select="rda:RDANo">
        <xsl:element name="IDRef">
          <xsl:attribute name="control">
            <xsl:value-of select="@type"/>
          </xsl:attribute>
          <xsl:value-of select="."/>
        </xsl:element>
      </xsl:for-each>
      <xsl:for-each select="rda:RDATitle">
        <xsl:element name="AuthorityTitleRef">
          <xsl:value-of select="."/>
        </xsl:element>
      </xsl:for-each>
      <xsl:for-each select="rda:TermTitle">
        <xsl:element name="TermTitleRef">
          <xsl:value-of select="."/>
        </xsl:element>
      </xsl:for-each>
      <xsl:for-each select="rda:ClassNo">
        <xsl:element name="ItemNoRef">
          <xsl:value-of select="."/>
        </xsl:element>
      </xsl:for-each>
      <xsl:apply-templates select="rda:SeeText | rda:PartText | rda:Date"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="rda:DisposalAction[.='']"/>
  <xsl:template match="rda:DisposalTrigger">
    <xsl:copy>
      <xsl:choose>
        <xsl:when test="starts-with(., 'after ')">
          <xsl:value-of select="substring-after(., 'after ')"/>
        </xsl:when>
        <xsl:when test="starts-with(., 'until ')">
          <xsl:value-of select="substring-after(., 'until ')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="rda:Term | rda:Class">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="rda:ID"/>
      <xsl:apply-templates select="rda:RDANo"/>
      <xsl:apply-templates select="rda:TermTitle"/>
      <xsl:apply-templates select="rda:ClassTitle"/>
      <xsl:apply-templates select="rda:TermDescription"/>
      <xsl:apply-templates select="rda:ClassDescription"/>
      <xsl:apply-templates select="rda:Disposal"/>
      <xsl:apply-templates select="rda:Justification"/>
      <xsl:apply-templates select="rda:DateRange"/>
      <xsl:apply-templates select="rda:Status"/>
      <xsl:apply-templates select="rda:LinkedTerm"/>
      <xsl:apply-templates select="rda:Comment"/>
      <xsl:apply-templates select="rda:Term | rda:Class"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
