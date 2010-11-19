<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" version="1.0">
  <xsl:template match="rda:Paragraph">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  <xsl:template match="rda:List">
    <ul>
      <xsl:apply-templates/>
    </ul>
  </xsl:template>
  <xsl:template match="rda:Item">
    <li>
      <xsl:apply-templates/>
    </li>
  </xsl:template>
  <xsl:template match="rda:Emphasis">
    <b>
      <xsl:apply-templates/>
    </b>
  </xsl:template>
  <xsl:template match="rda:Source">
    <xsl:choose>
      <xsl:when test="@url">
        <xsl:choose>
          <xsl:when test="(contains(@url, 'http://'))">
            <a href="{@url}" target="_blank">
              <xsl:apply-templates/>
            </a>
          </xsl:when>
          <xsl:otherwise>
            <a href="http://{@url}" target="_blank">
              <xsl:apply-templates/>
            </a>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <i>
          <xsl:apply-templates/>
        </i>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="rda:SeeReference">
    <p>
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
        <i>
          <xsl:value-of select="rda:AuthorityTitleRef"/>
        </i>
        <xsl:text> </xsl:text>
      </xsl:if>
      <b>
        <xsl:for-each select="rda:TermTitleRef">
          <xsl:if test="position() &gt;1">
            <xsl:text>- </xsl:text>
          </xsl:if>
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </b>
      <xsl:if test="rda:ItemNoRef">        
          <xsl:value-of select="concat(rda:ItemNoRef, ' ')"/>
      </xsl:if>
      <xsl:value-of select="rda:SeeText"/>
    </p>
  </xsl:template>
  <xsl:template match="rda:Comment">
    <div class="{@author}">
      <p>
        <i>
          <xsl:value-of select="@author"/>
          <xsl:text>:</xsl:text>
        </i>
      </p>
      </div>
      <xsl:apply-templates/>
   </xsl:template>
</xsl:stylesheet>
