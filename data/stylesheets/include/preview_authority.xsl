<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" version="1.0">
  <xsl:include href="html_header.xsl"/>
  <xsl:include href="render_html_authority.xsl"/>
  <xsl:variable name="SHOW_UPDATES" select="'false'"/>
  <xsl:template match="rda:Authority">
    <html>
      <xsl:call-template name="html_header">
        <xsl:with-param name="title" select="'Authority view'"/>
      </xsl:call-template>
      <body>
        <H1 align="center">Authority</H1>
        <p/>
        <H3>Contents</H3>
        <table>
          <tr valign="top">
            <td>
              <b>Function</b>
            </td>
            <td>
              <b>Activity</b>
            </td>
          </tr>
          <xsl:for-each select="//rda:Term">
            <tr>
              <xsl:for-each select="ancestor::rda:Term">
                <td/>
              </xsl:for-each>
              <td>
                <a href="#{generate-id(.)}">
                  <xsl:value-of select="rda:TermTitle"/>
                </a>
              </td>
              <xsl:for-each select="descendant::rda:Term">
                <td/>
              </xsl:for-each>
            </tr>
          </xsl:for-each>
        </table>
        <p/>
        <p>
          <b>Authority</b>
        </p>
        <table width="100%">
        <xsl:call-template name="preview_contents"/>
        <xsl:apply-templates select="rda:Term | rda:Class"/>
        </table>
      </body>
    </html>
  </xsl:template>
  </xsl:stylesheet>
