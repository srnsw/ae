<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" version="1.0">
  <xsl:output method="xml"/>
  <xsl:include href="include/html_header.xsl"/>
  <xsl:include href="include/render_html.xsl"/>
  <xsl:include href="include/utils.xsl"/>
  <xsl:template match="rda:Authority">
    <html>
      <xsl:call-template name="html_header">
        <xsl:with-param name="title" select="'Disposal classes'"/>
      </xsl:call-template>
      <body>
        <H1 align="center">Disposal classes sorted by retention period</H1>
        <table width="100%">
          <tr valign="top">
            <td>
              <b>Function/ Activity</b>
            </td>
            <td align="center">
              <b>Disposal class description</b>
            </td>
            <td>
              <b>Disposal Action/ Retention period</b>
            </td>
          </tr>
          <xsl:for-each select="//rda:Class[rda:Disposal/rda:DisposalAction='Required as State archives']">
            <tr valign="top" bgcolor="#F3F3F3">
              <td>
                <i>
                  <xsl:call-template name="build_address">
                    <xsl:with-param name="node" select="."/>
                  </xsl:call-template>
                </i>
              </td>
              <td>
                <xsl:for-each select="rda:ClassDescription">
                  <xsl:for-each select="rda:Paragraph[1]">
                    <xsl:apply-templates/>
                  </xsl:for-each>
                </xsl:for-each>
              </td>
              <td>
                <xsl:text>Required as State archives</xsl:text>
              </td>
            </tr>
          </xsl:for-each>
          <xsl:for-each select="//rda:Class[rda:Disposal/rda:DisposalAction='Retain in agency']">
            <tr valign="top" bgcolor="#F3F3F3">
              <td>
                <i>
                  <xsl:call-template name="build_address_with_itemno">
                    <xsl:with-param name="node" select="."/>
                  </xsl:call-template>
                </i>
              </td>
              <td>
                <xsl:for-each select="rda:ClassDescription">
                  <xsl:for-each select="rda:Paragraph[1]">
                    <xsl:apply-templates/>
                  </xsl:for-each>
                </xsl:for-each>
              </td>
              <td>
                <xsl:text>Retain in agency</xsl:text>
              </td>
            </tr>
          </xsl:for-each>
          <xsl:for-each select="//rda:Class[rda:Disposal/rda:DisposalAction='Destroy' or rda:Disposal/rda:DisposalAction='Transfer']">
            <xsl:sort select="rda:Disposal/rda:RetentionPeriod/@unit" order="descending"/>
            <xsl:sort select="rda:Disposal/rda:RetentionPeriod" order="descending" data-type="number"/>
            <tr valign="top" bgcolor="#F3F3F3">
              <td>
                <i>
                  <xsl:call-template name="build_address_with_itemno">
                    <xsl:with-param name="node" select="."/>
                  </xsl:call-template>
                </i>
              </td>
              <td>
                <xsl:for-each select="rda:ClassDescription">
                  <xsl:for-each select="rda:Paragraph[1]">
                    <xsl:apply-templates/>
                  </xsl:for-each>
                </xsl:for-each>
              </td>
              <td>
                <xsl:value-of select="rda:Disposal/rda:RetentionPeriod"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="rda:Disposal/rda:RetentionPeriod/@unit"/>
              </td>
            </tr>
          </xsl:for-each>
          <xsl:for-each select="//rda:Class[not(rda:Disposal/rda:DisposalAction)]">
            <xsl:sort select="rda:Disposal/rda:RetentionPeriod/@unit" order="descending"/>
            <xsl:sort select="rda:Disposal/rda:RetentionPeriod" order="descending" data-type="number"/>
            <tr valign="top" bgcolor="#F3F3F3">
              <td>
                <i>
                  <xsl:call-template name="build_address_with_itemno">
                    <xsl:with-param name="node" select="."/>
                  </xsl:call-template>
                </i>
              </td>
              <td>
                <xsl:for-each select="rda:ClassDescription">
                  <xsl:for-each select="rda:Paragraph[1]">
                    <xsl:apply-templates/>
                  </xsl:for-each>
                </xsl:for-each>
              </td>
              <td>
                <xsl:for-each select="rda:Disposal/rda:CustomAction">
                  <xsl:for-each select="rda:Paragraph[1]">
                    <xsl:apply-templates/>
                  </xsl:for-each>
                </xsl:for-each>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
