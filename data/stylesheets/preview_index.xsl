<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" version="1.0">
  <xsl:output method="xml"/>
  <xsl:include href="include/utils.xsl"/>
  <xsl:include href="include/index.xsl"/>
  <xsl:include href="include/html_header.xsl"/>
  <xsl:variable name="ANCHOR">
    <xsl:value-of select="'false'"/>
  </xsl:variable>
  <xsl:template match="rda:Authority">
    <xsl:variable name="index">
      <xsl:call-template name="index">
        <xsl:with-param name="authority" select="."/>
      </xsl:call-template>
    </xsl:variable>
    <html>
      <xsl:call-template name="html_header">
        <xsl:with-param name="title" select="'Index'"/>
      </xsl:call-template>
      <body>
        <H1 align="center">Index</H1>
        <table>
          <xsl:for-each select="exslt:node-set($index)/links">
            <xsl:for-each select="broad_term">
              <tr valign="top">
                <td colspan="2">
                  <b>
                    <xsl:value-of select="broad_term_title"/>
                  </b>
                </td>
                <td/>
              </tr>
              <xsl:for-each select="addresses">
                <tr valign="top">
                  <td colspan="2"/>
                  <td>
                    <xsl:for-each select="address">
                      <xsl:sort select="." order="ascending"/>
                      <xsl:if test="position() &gt; 1">
                        <xsl:text>, </xsl:text>
                      </xsl:if>
                      <xsl:value-of select="."/>
                    </xsl:for-each>
                  </td>
                </tr>
              </xsl:for-each>
              <xsl:for-each select="narrow_terms/narrow_term">
                <xsl:sort select="narrow_term_title"/>
                <tr valign="top">
                  <td width="20"/>
                  <td>
                    <xsl:value-of select="narrow_term_title"/>
                  </td>
                  <td>
                    <xsl:for-each select="addresses">
                      <xsl:sort select="address" order="ascending"/>
                      <xsl:for-each select="address[not(. = preceding-sibling::address)]">
                        <xsl:if test="position() &gt; 1">
                          <xsl:text>, </xsl:text>
                        </xsl:if>
                        <xsl:value-of select="."/>
                      </xsl:for-each>
                    </xsl:for-each>
                  </td>
                </tr>
              </xsl:for-each>
            </xsl:for-each>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
