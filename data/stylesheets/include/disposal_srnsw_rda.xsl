<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.records.nsw.gov.au/schemas/RDA" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" version="1.0">
  <xsl:template name="standard_action">
    <xsl:param name="disposal"/>
    <xsl:param name="condition"/>
    <xsl:for-each select="$disposal">
      <xsl:choose>
        <xsl:when test="rda:CustomAction">
          <xsl:if test="$condition">
            <xsl:element name="Paragraph">
              <xsl:element name="Emphasis">
                <xsl:value-of select="$condition"/>
                <xsl:text>:</xsl:text>
              </xsl:element>
            </xsl:element>
          </xsl:if>
          <xsl:for-each select="rda:CustomAction">
            <xsl:apply-templates/>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="rda:DisposalAction='Destroy'">
              <xsl:if test="$condition">
            <xsl:element name="Paragraph">
              <xsl:element name="Emphasis">
                <xsl:value-of select="$condition"/>
                <xsl:text>:</xsl:text>
              </xsl:element>
            </xsl:element>
          </xsl:if>
              <xsl:element name="Paragraph">
                <xsl:call-template name="standard_string">
                  <xsl:with-param name="disposal" select="."/>
                </xsl:call-template>
              </xsl:element>
            </xsl:when>
            <xsl:when test="rda:DisposalAction='Transfer'">
              <xsl:if test="$condition">
            <xsl:element name="Paragraph">
              <xsl:element name="Emphasis">
                <xsl:value-of select="$condition"/>
                <xsl:text>:</xsl:text>
              </xsl:element>
            </xsl:element>
          </xsl:if>
              <xsl:element name="Paragraph">
                <xsl:call-template name="standard_string">
                  <xsl:with-param name="disposal" select="."/>
                </xsl:call-template>
              </xsl:element>
            </xsl:when>
            <xsl:otherwise>
              <xsl:if test="$condition">
            <xsl:element name="Paragraph">
              <xsl:element name="Emphasis">
                <xsl:value-of select="$condition"/>
                <xsl:text>:</xsl:text>
              </xsl:element>
            </xsl:element>
          </xsl:if>
              <xsl:element name="Paragraph">
                <xsl:value-of select="rda:DisposalAction"/>
              </xsl:element>
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
        <xsl:element name="Paragraph">
          <xsl:call-template name="multiple_string">
            <xsl:with-param name="disposals" select="$disposals"/>
          </xsl:call-template>
        </xsl:element>
      </xsl:when>
      <xsl:when test="$disposals[1]/rda:DisposalAction='Transfer'">
        <xsl:element name="Paragraph">
          <xsl:call-template name="multiple_string">
            <xsl:with-param name="disposals" select="$disposals"/>
          </xsl:call-template>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="Paragraph">
          <xsl:value-of select="$disposals[1]/rda:DisposalAction"/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="standard_custody">
    <xsl:param name="disposal"/>
    <xsl:param name="condition"/>
    <xsl:for-each select="$disposal">
      <xsl:choose>
        <xsl:when test="rda:CustomCustody">
          <xsl:if test="$condition">
            <xsl:element name="Paragraph">
              <xsl:element name="Emphasis">
                <xsl:value-of select="$condition"/>
                <xsl:text>:</xsl:text>
              </xsl:element>
            </xsl:element>
          </xsl:if>
          <xsl:for-each select="rda:CustomCustody">
            <xsl:apply-templates/>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:if test="rda:DisposalAction='Required as State archives'">
            <xsl:if test="$condition">
              <xsl:element name="Paragraph">
                <xsl:element name="Emphasis">
                  <xsl:value-of select="$condition"/>
                  <xsl:text>:</xsl:text>
                </xsl:element>
              </xsl:element>
            </xsl:if>
            <xsl:element name="Paragraph">
              <xsl:call-template name="standard_string">
                <xsl:with-param name="disposal" select="."/>
              </xsl:call-template>
            </xsl:element>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="multiple_custody">
    <xsl:param name="disposals"/>
    <xsl:if test="$disposals[1]/rda:DisposalAction='Required as State archives'">
      <xsl:element name="Paragraph">
        <xsl:call-template name="multiple_string">
          <xsl:with-param name="disposals" select="$disposals"/>
        </xsl:call-template>
      </xsl:element>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
