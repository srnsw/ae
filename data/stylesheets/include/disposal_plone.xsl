<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" version="1.0">
  <xsl:template name="standard_action">
    <xsl:param name="disposal"/>
    <xsl:param name="condition"/>
    <xsl:for-each select="$disposal">
      <xsl:choose>
        <xsl:when test="rda:CustomAction">
          <xsl:if test="$condition">
            <strong>
                <xsl:value-of select="$condition"/>
                <xsl:text>:</xsl:text>
              </strong>
            <br/>
          </xsl:if>
          <xsl:for-each select="rda:CustomAction">
            <xsl:apply-templates/>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="rda:DisposalAction='Destroy'">
              <xsl:if test="$condition">
                <strong>
                <xsl:value-of select="$condition"/>
                <xsl:text>:</xsl:text>
              </strong>
              <br/>
              </xsl:if>
                <xsl:call-template name="standard_string">
                  <xsl:with-param name="disposal" select="."/>
                </xsl:call-template>
              </xsl:when>
            <xsl:when test="rda:DisposalAction='Transfer'">
              <xsl:if test="$condition">
                <strong>
                <xsl:value-of select="$condition"/>
                <xsl:text>:</xsl:text>
              </strong>
              <br/>
              </xsl:if>
               <xsl:call-template name="standard_string">
                  <xsl:with-param name="disposal" select="."/>
                </xsl:call-template>
               </xsl:when>
            <xsl:otherwise>
              <xsl:if test="$condition">
                <strong>
                <xsl:value-of select="$condition"/>
                <xsl:text>:</xsl:text>
              </strong>
            <br/>
              </xsl:if>
              <xsl:value-of select="rda:DisposalAction"/>
              </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="multiple_action">
    <xsl:param name="disposals"/>
    <xsl:choose>
      <xsl:when test="$disposals[1]/rda:DisposalAction='Destroy'">
        <xsl:call-template name="multiple_string">
            <xsl:with-param name="disposals" select="$disposals"/>
          </xsl:call-template>
       </xsl:when>
      <xsl:when test="$disposals[1]/rda:DisposalAction='Transfer'">
         <xsl:call-template name="multiple_string">
            <xsl:with-param name="disposals" select="$disposals"/>
          </xsl:call-template>
        </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$disposals[1]/rda:DisposalAction"/>
        </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="standard_custody">
    <xsl:param name="disposal"/>
    <xsl:param name="condition"/>
    <xsl:for-each select="$disposal">
    <xsl:if test="not(position() = 1)"><br/></xsl:if>
      <xsl:choose>
        <xsl:when test="rda:CustomCustody">
          <xsl:if test="$condition">
            <strong>
                <xsl:value-of select="$condition"/>
                <xsl:text>:</xsl:text>
              </strong>
            <br/>
          </xsl:if>
          <xsl:for-each select="rda:CustomCustody">
            <xsl:apply-templates/>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="rda:DisposalAction='Required as State archives'">
              <xsl:if test="$condition">
               <strong>
                <xsl:value-of select="$condition"/>
                <xsl:text>:</xsl:text>
              </strong>
            <br/>
              </xsl:if>
               <xsl:call-template name="standard_string">
                  <xsl:with-param name="disposal" select="."/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="multiple_custody">
    <xsl:param name="disposals"/>
    <xsl:choose>
      <xsl:when test="$disposals[1]/rda:DisposalAction='Required as State archives'">
          <xsl:call-template name="multiple_string">
            <xsl:with-param name="disposals" select="$disposals"/>
          </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
