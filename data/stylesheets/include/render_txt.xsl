<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" version="1.0">
  <xsl:template match="text()">
   <xsl:variable name="firstpass" select="translate(.,'&#8220;&#8221;&#8211;&#8212;&#x09;','&quot;&quot;-- ')"/>
   <xsl:value-of select='translate($firstpass,"&#8216;&#8217;","&apos;&apos;")'/>
  </xsl:template>
  <xsl:template match="rda:Paragraph">
    <xsl:if test="position() &gt; 1">
      <xsl:text>\n</xsl:text>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="rda:List">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="rda:Item">
    <xsl:text>\n - </xsl:text><xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="rda:Emphasis">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="rda:Source">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="rda:SeeReference">
    <xsl:if test="position() &gt; 1">
      <xsl:text>\n</xsl:text>
    </xsl:if>
    <xsl:text>See </xsl:text>
      <xsl:if test="rda:IDRef">
        <xsl:choose>
          <xsl:when test="rda:IDRef/@control='GA' or rda:IDRef/@control='GDA'">
            <xsl:text>General Retention and Disposal Authority </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>Functional Retention and Disposal Authority </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      <xsl:if test="rda:AuthorityTitleRef">        
          <xsl:value-of select="rda:AuthorityTitleRef"/>
       <xsl:text> </xsl:text>
      </xsl:if>
        <xsl:for-each select="rda:TermTitleRef">
          <xsl:if test="position() &gt;1">
            <xsl:text>- </xsl:text>
          </xsl:if>
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
        <xsl:if test="rda:ItemNoRef">        
          <xsl:value-of select="concat(rda:ItemNoRef, ' ')"/>
      </xsl:if>
      <xsl:value-of select="rda:SeeText"/>
  </xsl:template>
</xsl:stylesheet>
