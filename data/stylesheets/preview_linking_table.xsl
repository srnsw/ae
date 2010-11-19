<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" version="1.0">
  <xsl:output method="xml"/>
  <xsl:include href="include/linking_table.xsl"/>
  <xsl:include href="include/html_header.xsl"/>
  <!-- if you want to always link to the same previous authority set a default prefix (e.g. GDA10) on the variable below-->
  <!-- e.g. <xsl:variable name="DEFAULT_PREFIX" select="'GDA10'"/>-->
  <xsl:variable name="DEFAULT_PREFIX"/>
  <xsl:template match="rda:Authority">
    <xsl:variable name="linked_terms">
      <xsl:element name="links">
        <xsl:call-template name="linking_table">
          <xsl:with-param name="terms" select="//rda:LinkedTo[@type='linking table']"/>
          <xsl:with-param name="default_prefix" select="$DEFAULT_PREFIX"/>
        </xsl:call-template>
      </xsl:element>
    </xsl:variable>
    <html>
      <xsl:call-template name="html_header">
        <xsl:with-param name="title" select="'Linking table'"/>
      </xsl:call-template>
      <body>
        <H1 align="center">Linking table</H1>
        <table width="100%">
          <tr>
            <td>
              <b>Old reference</b>
            </td>
            <td>
              <b>New reference</b>
            </td>
            <td>
              <b>Function / Activity</b>
            </td>
            <td>
              <b>Comments</b>
            </td>
          </tr>
          <xsl:for-each select="exslt:node-set($linked_terms)/links">
            <xsl:for-each select="link_term">
              <xsl:sort select="old_ref/prefix" order="ascending"/>
              <xsl:sort select="old_ref/f" data-type="number" order="ascending"/>
              <xsl:sort select="old_ref/a" data-type="number" order="ascending"/>
              <xsl:sort select="old_ref/c" data-type="number" order="ascending"/>
              <tr>
                <td>
                  <xsl:choose>
                    <xsl:when test="old_ref/f"><xsl:if test="old_ref/prefix"><xsl:value-of select="concat(old_ref/prefix, ' ')"/></xsl:if><xsl:value-of select="old_ref/f"/>.<xsl:value-of select="old_ref/a"/><xsl:if test="old_ref/c">.<xsl:value-of select="old_ref/c"/></xsl:if></xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="old_ref"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </td>
                <td>
                  <xsl:value-of select="new_ref"/>
                </td>
                <td>
                  <xsl:value-of select="func_ac"/>
                </td>
                <td>
                  <xsl:value-of select="comment"/>
                </td>
              </tr>
            </xsl:for-each>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
