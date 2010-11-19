<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" version="1.0">
  <xsl:include href="html_header.xsl"/>
  <xsl:include href="render_html.xsl"/>
  <xsl:include href="stocks.xsl"/>
  <xsl:template match="rda:Authority">
    <html>
      <xsl:call-template name="html_header">
        <xsl:with-param name="title" select="$CONTEXT_TITLE"/>
      </xsl:call-template>
      <body>
        <H1 align="center">
          <xsl:value-of select="$CONTEXT_TITLE"/>
        </H1>
        <table width="70%">
          <tr>
            <td>
              <b>AR Number</b>
            </td>
            <td class="grey">
              <xsl:value-of select="$ARNO"/>
            </td>
          </tr>
          <tr>
            <td>
              <b>SRNSW File Number</b>
            </td>
            <td class="grey">
              <xsl:value-of select="$SRFILENOS"/>
            </td>
          </tr>
          <tr>
            <td>
              <b>Public Office</b>
            </td>
            <td class="grey">
              <xsl:value-of select="$AGENCY_NAMES"/>
            </td>
          </tr>
          <tr>
            <td>
              <b>Type of authority</b>
            </td>
            <td class="grey">
              <xsl:value-of select="$AUTHORITY_TYPE"/>
            </td>
          </tr>
          <tr>
            <td>
              <b>Dates of Coverage</b>
            </td>
            <td class="grey">
              <xsl:value-of select="$DATE_RANGE"/>
            </td>
          </tr>
        </table>
        <H2>Context</H2>
        <xsl:for-each select="rda:Context[@type=$CONTEXT_TYPE]">
          <H3>
            <xsl:value-of select="rda:ContextTitle"/>
          </H3>
          <xsl:for-each select="rda:ContextContent/rda:Paragraph">
            <p>
              <xsl:apply-templates/>
            </p>
          </xsl:for-each>
          <xsl:if test="rda:ContextContent/rda:Source">
            <H4>Sources used:</H4>
            <ul>
              <xsl:for-each select="rda:ContextContent/rda:Source">
                <li>
                  <xsl:apply-templates select="."/>
                </li>
              </xsl:for-each>
            </ul>
          </xsl:if>
          <xsl:if test="$SHOW_COMMENTS='true'">
            <xsl:for-each select="rda:Comment">
              <xsl:apply-templates select="."/>
            </xsl:for-each>
          </xsl:if>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
