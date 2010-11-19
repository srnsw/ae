<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" version="1.0">
  <xsl:output method="xml"/>
  <xsl:include href="include/html_header.xsl"/>
  <xsl:include href="include/render_html.xsl"/>
  <xsl:include href="include/stocks.xsl"/>
  <xsl:template match="rda:Authority">
    <xsl:variable name="totalactivities" select="count(rda:Term/rda:Term)"/>
    <xsl:variable name="totalclasses" select="count(//rda:Class)"/>
    <xsl:variable name="totalarchives" select="count(//rda:Class[rda:Disposal/rda:DisposalAction='Required as State archives'])"/>
    <xsl:variable name="totalproportion" select="round($totalarchives div $totalclasses * 100)"/>
    <html>
      <xsl:call-template name="html_header">
        <xsl:with-param name="title" select="'Summary view'"/>
      </xsl:call-template>
      <body>
        <H1 align="center">Summary view</H1>
        <p/>
        <table width="100%">
          <tr>
            <td>
              <b>RDA Number</b>
            </td>
            <td>
              <b>AR Number</b>
            </td>
            <td>
              <b>SRNSW File Number</b>
            </td>
            <td>
              <b>Functional scope</b>
            </td>
            <td>
              <b>Date range</b>
            </td>
          </tr>
          <tr bgcolor="#F3F3F3">
            <td>
              <xsl:value-of select="$RDANO"/>
            </td>
            <td>
              <xsl:value-of select="$ARNO"/>
            </td>
            <td>
              <xsl:value-of select="$SRFILENOS"/>
            </td>
            <td>
              <xsl:value-of select="rda:Scope"/>
            </td>
            <td>
              <xsl:value-of select="$DATE_RANGE"/>
            </td>
          </tr>
        </table>
        <table width="100%">
          <tr>
            <td colspan="4">
              <b>Status</b>
            </td>
          </tr>
          <xsl:for-each select="rda:Status/rda:Draft">
            <tr bgcolor="#F3F3F3">
              <td>
                <i>
                  <xsl:value-of select="name(.)"/>
                </i>
              </td>
              <td>
                <xsl:text>v. </xsl:text>
                <xsl:value-of select="@version"/>
              </td>
              <td>
                <xsl:value-of select="rda:Agency"/>
              </td>
              <td>
                <xsl:value-of select="rda:Date"/>
              </td>
            </tr>
          </xsl:for-each>
          <xsl:for-each select="rda:Status/rda:Submitted">
            <tr bgcolor="#F3F3F3">
              <td>
                <i>
                  <xsl:value-of select="name(.)"/>
                </i>
              </td>
              <td>
                <xsl:value-of select="rda:Officer"/>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="rda:Position"/>
              </td>
              <td>
                <xsl:value-of select="rda:Agency"/>
              </td>
              <td>
                <xsl:value-of select="rda:Date"/>
              </td>
            </tr>
          </xsl:for-each>
          <xsl:for-each select="rda:Status/rda:Approved">
            <tr bgcolor="#F3F3F3">
              <td colspan="3">
                <i>
                  <xsl:value-of select="name(.)"/>
                </i>
              </td>
              <td>
                <xsl:value-of select="."/>
              </td>
            </tr>
          </xsl:for-each>
          <xsl:for-each select="rda:Status/rda:Issued">
            <tr bgcolor="#F3F3F3">
              <td colspan="2">
                <i>
                  <xsl:value-of select="name(.)"/>
                </i>
              </td>
              <td>
                <xsl:value-of select="rda:Agency"/>
              </td>
              <td>
                <xsl:value-of select="rda:Date"/>
              </td>
            </tr>
          </xsl:for-each>
          <xsl:for-each select="rda:Status/rda:Applying">
            <tr bgcolor="#F3F3F3">
              <td>
                <i>
                  <xsl:value-of select="name(.)"/>
                </i>
              </td>
              <td>
                <xsl:text>Coverage - </xsl:text>
                <xsl:value-of select="@extent"/>
              </td>
              <td>
                <xsl:value-of select="rda:Agency"/>
              </td>
              <td>
                <xsl:value-of select="rda:Date"/>
              </td>
            </tr>
          </xsl:for-each>
        </table>
        <hr/>
        <h3>Functions</h3>
        <table width="100%">
          <tr>
            <td>
              <b>Function</b>
            </td>
            <td colspan="4">
              <b>Function description</b>
            </td>
          </tr>
          <xsl:for-each select="rda:Term">
            <xsl:sort select="rda:TermTitle" order="ascending"/>
            <xsl:variable name="activities" select="count(rda:Term)"/>
            <xsl:variable name="classes" select="count(.//rda:Class)"/>
            <xsl:variable name="archives" select="count(.//rda:Class[rda:Disposal/rda:DisposalAction='Required as State archives'])"/>
            <xsl:variable name="proportion" select="round($archives div $classes * 100)"/>
            <tr valign="top" bgcolor="#9FBFDF">
              <td>
                <i>
                  <xsl:value-of select="rda:TermTitle"/>
                </i>
              </td>
              <td colspan="4">
                <xsl:for-each select="rda:TermDescription">
                  <xsl:for-each select="rda:Paragraph">
                    <p>
                      <xsl:apply-templates/>
                    </p>
                  </xsl:for-each>
                </xsl:for-each>
              </td>
            </tr>
            <tr>
              <td/>
              <td>
                <b>No. activities</b>
              </td>
              <td>
                <b>No. classes</b>
              </td>
              <td>
                <b>No. classes required as archives</b>
              </td>
              <td>
                <b>Proportion required as archives</b>
              </td>
            </tr>
            <tr bgcolor="#F3F3F3">
              <td/>
              <td>
                <xsl:value-of select="$activities"/>
              </td>
              <td>
                <xsl:value-of select="$classes"/>
              </td>
              <td>
                <xsl:value-of select="$archives"/>
              </td>
              <td><xsl:value-of select="$proportion"/>%</td>
            </tr>
          </xsl:for-each>
        </table>
        <hr/>
        <H3>Totals</H3>
        <table width="100%">
          <tr>
            <td>
              <b>Activities</b>
            </td>
            <td>
              <b>Classes</b>
            </td>
            <td>
              <b>Classes required as archives</b>
            </td>
            <td>
              <b>Proportion required as archives</b>
            </td>
          </tr>
          <tr bgcolor="#F3F3F3">
            <td>
              <xsl:value-of select="$totalactivities"/>
            </td>
            <td>
              <xsl:value-of select="$totalclasses"/>
            </td>
            <td>
              <xsl:value-of select="$totalarchives"/>
            </td>
            <td><xsl:value-of select="$totalproportion"/>%</td>
          </tr>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
