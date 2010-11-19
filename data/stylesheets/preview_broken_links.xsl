<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" version="1.0">
  <xsl:include href="include/html_header.xsl"/>
  <xsl:include href="include/render_html_authority.xsl"/>
  <xsl:variable name="SHOW_UPDATES" select="'false'"/>
  <xsl:variable name="SHOW_COMMENTS" select="'false'"/>
  <xsl:template match="rda:Authority">
    <html>
      <xsl:call-template name="html_header">
        <xsl:with-param name="title" select="'Broken internal see references'"/>
      </xsl:call-template>
      <body>
        <H1 align="center">Broken links</H1>
        <p/>
        <table>
          <xsl:for-each select="//rda:SeeReference[not(rda:IDRef or rda:AuthorityTitleRef)]">
            <xsl:for-each select="rda:TermTitleRef[position()=1]">
              <xsl:variable name="good_link">
                <xsl:call-template name="check_link">
                  <xsl:with-param name="term_title" select="."/>
                  <xsl:with-param name="children" select="following-sibling::rda:TermTitleRef"/>
                  <xsl:with-param name="context" select="/rda:Authority"/>
                </xsl:call-template>  
              </xsl:variable>
              <xsl:if test="$good_link!='true'">
                <tr>
                <td><b>Broken link at</b></td>
                <td><i><xsl:call-template name="build_address_with_itemno"><xsl:with-param name="node" select="../../.."/></xsl:call-template></i></td>
                <td><xsl:apply-templates select=".."/></td>
                 </tr>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
  <xsl:template name="check_link">
  <xsl:param name="term_title"/>
  <xsl:param name="children"/>
  <xsl:param name="context"/>
    <xsl:choose>
      <xsl:when test="not($children)">
        <xsl:choose>
          <xsl:when test="$context/rda:Term[rda:TermTitle=$term_title]">
            <xsl:value-of select="'true'"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="'false'"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$context/rda:Term[rda:TermTitle=$term_title]">
            <xsl:for-each select="$children[position()=1]">
              <xsl:call-template name="check_link">
                <xsl:with-param name="term_title" select="."/>
                <xsl:with-param name="children" select="$children[position() &gt; 1]"/>
                <xsl:with-param name="context" select="$context/rda:Term[rda:TermTitle=$term_title]"/>
              </xsl:call-template>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="'false'"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  </xsl:stylesheet>
