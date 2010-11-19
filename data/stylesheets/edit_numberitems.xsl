<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" version="1.0">
  <xsl:output method="xml" indent="yes"/>
  <xsl:variable name="maxdepth">
    <xsl:for-each select="descendant::*[self::rda:Class or self::rda:Term]">
      <xsl:sort select="count(ancestor::*)" data-type="number"/>
      <xsl:if test="position()=last()">
        <xsl:value-of select="count(ancestor::*)"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:variable>
  <xsl:template match="*|text()|@*">
    <xsl:copy>
      <xsl:apply-templates select="*|text()|@*"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="rda:Authority">
    <xsl:copy>
      <xsl:apply-templates select="*|text()|@*"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="rda:Term">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:attribute name="itemno">
        <xsl:call-template name="termnumber">
          <xsl:with-param name="node" select="."/>
        </xsl:call-template>
      </xsl:attribute>
      <xsl:apply-templates select="*|text()"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="rda:Class">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:attribute name="itemno">
        <xsl:call-template name="classnumber">
          <xsl:with-param name="node" select="."/>
        </xsl:call-template>
      </xsl:attribute>
      <xsl:apply-templates select="*|text()"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template name="termnumber">
    <xsl:param name="node"/>
    <xsl:for-each select="$node">
      <xsl:variable name="siblings">
        <xsl:number value="count(preceding-sibling::rda:Term) + 1"/>
      </xsl:variable>
      <xsl:variable name="currentdepth">
        <xsl:value-of select="count(ancestor::*)"/>
      </xsl:variable>
      <xsl:variable name="parents">
        <xsl:call-template name="prepend_parents">
          <xsl:with-param name="node" select=".."/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="zeros">
        <xsl:call-template name="append_zeros">
          <xsl:with-param name="currentdepth" select="$currentdepth"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:value-of select="concat($parents, $siblings, $zeros)"/>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="classnumber">
    <xsl:param name="node"/>
    <xsl:for-each select="$node">
      <xsl:variable name="currentdepth">
        <xsl:value-of select="count(ancestor::*)"/>
      </xsl:variable>
      <xsl:variable name="siblings">
        <xsl:number value="count(preceding-sibling::rda:Class) + 1"/>
      </xsl:variable>
      <xsl:variable name="parents">
        <xsl:call-template name="prepend_parents">
          <xsl:with-param name="node" select=".."/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="zeros">
        <xsl:call-template name="prepend_zeros">
          <xsl:with-param name="currentdepth" select="$currentdepth"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:value-of select="concat($parents, $zeros, $siblings)"/>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="prepend_parents">
    <xsl:param name="node"/>
    <xsl:param name="parents" select="''"/>
    <xsl:choose>
      <xsl:when test="$node[self::rda:Authority]">
        <xsl:value-of select="$parents"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="$node">
          <xsl:variable name="siblings">
            <xsl:number value="count(preceding-sibling::rda:Term) + 1"/>
            <xsl:text>.</xsl:text>
          </xsl:variable>
          <xsl:call-template name="prepend_parents">
            <xsl:with-param name="node" select=".."/>
            <xsl:with-param name="parents" select="concat($siblings, $parents)"/>
          </xsl:call-template>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="append_zeros">
    <xsl:param name="currentdepth"/>
    <xsl:param name="zeros" select="''"/>
    <xsl:choose>
      <xsl:when test="$currentdepth &gt;= $maxdepth">
        <xsl:value-of select="$zeros"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="append_zeros">
          <xsl:with-param name="currentdepth" select="$currentdepth + 1"/>
          <xsl:with-param name="zeros" select="concat('.0', $zeros)"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="prepend_zeros">
    <xsl:param name="currentdepth"/>
    <xsl:param name="zeros" select="''"/>
    <xsl:choose>
      <xsl:when test="$currentdepth &gt;= $maxdepth">
        <xsl:value-of select="$zeros"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="prepend_zeros">
          <xsl:with-param name="currentdepth" select="$currentdepth + 1"/>
          <xsl:with-param name="zeros" select="concat($zeros, '0.')"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
