<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" version="1.0">
  <xsl:output method="html"/>
  <xsl:include href="include/render_plone.xsl"/>
  <xsl:include href="include/stocks.xsl"/>
  <xsl:include href="include/disposal_plone.xsl"/>
  <xsl:include href="include/disposal_common.xsl"/>
  <xsl:template match="rda:Term">
    <html>
      <a name="{rda:anchor}"/>
      <xsl:for-each select="rda:TermDescription">
        <xsl:call-template name="first_term"><xsl:with-param name="node" select="rda:Paragraph[1]"/></xsl:call-template>
        <xsl:apply-templates select="rda:Paragraph[position()>1] | rda:SeeReference"/>
      </xsl:for-each>
      <xsl:for-each select="rda:Term">
      <h2><a name="{rda:anchor}"></a><xsl:value-of select="concat(translate(rda:TermTitle, $lowerCaseChars, $upperCaseChars), ' ', @itemno)"/></h2>
      <xsl:for-each select="rda:TermDescription"><xsl:apply-templates/></xsl:for-each>
      <xsl:if test="rda:Class">
        <xsl:call-template name="class_table">
        <xsl:with-param name="node" select="."/>
        </xsl:call-template>
      </xsl:if>
      </xsl:for-each>
      <xsl:if test="rda:Class">
      <xsl:call-template name="class_table">
        <xsl:with-param name="node" select="."/>
      </xsl:call-template>
      </xsl:if>
    </html>
  </xsl:template>

  <xsl:template name="class_table">
    <xsl:param name="node"/>
    <table class="plain">
      <tbody>
        <tr>
          <th>No</th>
          <th>Description of records</th>
          <th>Disposal action</th>
        </tr>
        <xsl:for-each select="$node/rda:Class">
          <tr>
            <td><xsl:value-of select="@itemno"/></td>
            <td><xsl:for-each select="rda:ClassDescription"><xsl:apply-templates/></xsl:for-each></td>
            <td><xsl:call-template name="disposal_action"><xsl:with-param name="disposals" select="rda:Disposal"/><xsl:with-param name="is_text" select="'plone'"/></xsl:call-template></td>
          </tr>
        </xsl:for-each>
      </tbody>
    </table>
  </xsl:template>

  <xsl:template name="first_term">
    <xsl:param name="node"/>
    <xsl:for-each select="$node">
      <div class="alert alert-info"><xsl:apply-templates/></div>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
