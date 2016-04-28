<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" version="1.0">
  <xsl:template match="rda:Paragraph">
    <xsl:choose>
      <xsl:when test="child::node()[1]=rda:Emphasis and count(ancestor::*)=2"><div class="alert alert-info"><xsl:apply-templates/></div></xsl:when>
      <xsl:otherwise><p><xsl:apply-templates/></p></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="rda:List"><ul><xsl:apply-templates/></ul></xsl:template>
  <xsl:template match="rda:Item"><li><xsl:apply-templates/></li></xsl:template>
  <xsl:template match="rda:Emphasis"><strong><xsl:apply-templates/></strong></xsl:template>
  <xsl:template match="rda:Source"><em><xsl:choose>
    <xsl:when test="@url">
      <xsl:choose>
        <xsl:when test="(contains(@url, 'http://'))"><a title="external-link" href="{@url}"><xsl:apply-templates/></a></xsl:when>
        <xsl:otherwise><a title="external-link" href="http://{@url}"><xsl:apply-templates/></a></xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
    </xsl:choose></em>
  </xsl:template>
  <xsl:template match="rda:SeeReference">
    <p><xsl:text>See </xsl:text>
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
      <xsl:if test="rda:AuthorityTitleRef"><em><xsl:value-of select="rda:AuthorityTitleRef"/></em><xsl:text> </xsl:text></xsl:if>
      <xsl:choose>
      <xsl:when test="rda:href">
      <a title="{rda:TermTitleRef}" class="internal-link" href="{rda:href}" >
         <xsl:for-each select="rda:TermTitleRef">
          <xsl:if test="position() &gt;1"><xsl:text>- </xsl:text></xsl:if>
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
       </a>
      </xsl:when>
      <xsl:otherwise>
      <strong>
        <xsl:for-each select="rda:TermTitleRef">
          <xsl:if test="position() &gt;1"><xsl:text>- </xsl:text></xsl:if>
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </strong>
      </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="rda:ItemNoRef"><xsl:value-of select="concat(rda:ItemNoRef, ' ')"/></xsl:if>
      <xsl:value-of select="rda:SeeText"/>
    </p>
  </xsl:template>
  <xsl:template match="rda:ClassDescription/rda:SeeReference">
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
      <xsl:if test="rda:AuthorityTitleRef"><em><xsl:value-of select="rda:AuthorityTitleRef"/></em><xsl:text> </xsl:text></xsl:if>
      <xsl:choose>
        <xsl:when test="rda:href">
        <a title="{rda:TermTitleRef}" class="internal-link" href="{rda:href}" >
         <xsl:for-each select="rda:TermTitleRef">
          <xsl:if test="position() &gt;1"><xsl:text>- </xsl:text></xsl:if>
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
       </a>
      </xsl:when>
      <xsl:otherwise>
      <strong>
        <xsl:for-each select="rda:TermTitleRef">
          <xsl:if test="position() &gt;1"><xsl:text>- </xsl:text></xsl:if>
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </strong>
      </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="rda:ItemNoRef"><xsl:value-of select="concat(rda:ItemNoRef, ' ')"/></xsl:if>
      <xsl:value-of select="rda:SeeText"/>
  </xsl:template>
  <xsl:template match="rda:ClassDescription/rda:Paragraph"><xsl:apply-templates/><xsl:if test="following-sibling::*"><br/></xsl:if></xsl:template>
 </xsl:stylesheet>
