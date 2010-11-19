<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" version="1.0">
<xsl:output method="text" encoding="UTF-8"/>
<xsl:include href="include/stocks.xsl"/>
<xsl:include href="include/render_txt.xsl"/>
<xsl:include href="include/disposal_txt.xsl"/>
<xsl:include href="include/disposal_common.xsl"/>
<xsl:variable name="newline"><xsl:text>&#xa;</xsl:text></xsl:variable>
<xsl:variable name="tab"><xsl:text>&#x09;</xsl:text></xsl:variable>
<xsl:template match="rda:Authority">
<xsl:call-template name="field_titles"/>
<xsl:apply-templates select="//rda:Class"/>
</xsl:template>
<xsl:template name="field_titles">
<xsl:text>NUMBER</xsl:text>
<xsl:value-of select="$tab"/>
<xsl:text>TERMS</xsl:text>
<xsl:value-of select="$tab"/>
<xsl:text>DESCRIPTION</xsl:text>
<xsl:value-of select="$tab"/>
<xsl:text>AUTHORISED ACTION</xsl:text>
<xsl:value-of select="$tab"/>
<xsl:text>CUSTODY</xsl:text>
<xsl:value-of select="$tab"/>
<xsl:text>DISPOSAL ACTION</xsl:text>
<xsl:value-of select="$tab"/>
<xsl:text>RETENTION YEARS</xsl:text>
<xsl:value-of select="$tab"/>
<xsl:text>RETENTION MONTHS</xsl:text>
<xsl:value-of select="$tab"/>
<xsl:text>RETENTION TRIGGER</xsl:text>
<xsl:value-of select="$newline"/>
</xsl:template>
<xsl:template match="rda:Class">
<xsl:variable name="id">
<xsl:call-template name="local_id">
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</xsl:variable>
<xsl:variable name="no">
<xsl:call-template name="pad_itemno">
<xsl:with-param name="suffix" select="@itemno"/>
</xsl:call-template>
</xsl:variable>
<xsl:value-of select="concat($id, '-', $no)"/>
<xsl:value-of select="$tab"/>
<xsl:call-template name="build_address">
<xsl:with-param name="node" select="."/>
</xsl:call-template>
<xsl:value-of select="$tab"/>
<xsl:for-each select="rda:ClassDescription"><xsl:apply-templates/></xsl:for-each>
<xsl:value-of select="$tab"/>
<xsl:call-template name="disposal_action">
<xsl:with-param name="disposals" select="rda:Disposal"/>
<xsl:with-param name="is_text" select="'true'"/>
</xsl:call-template>
<xsl:value-of select="$tab"/>
<xsl:call-template name="custody">
<xsl:with-param name="disposals" select="rda:Disposal"/>
<xsl:with-param name="is_text" select="'true'"/>
</xsl:call-template>
<xsl:value-of select="$tab"/>
<xsl:call-template name="simple">
<xsl:with-param name="disposals" select="rda:Disposal"/>
<xsl:with-param name="action" select="'simple_action'"/>
</xsl:call-template>
<xsl:value-of select="$tab"/>
<xsl:call-template name="simple">
<xsl:with-param name="disposals" select="rda:Disposal"/>
<xsl:with-param name="action" select="'simple_years'"/>
</xsl:call-template>
<xsl:value-of select="$tab"/>
<xsl:call-template name="simple">
<xsl:with-param name="disposals" select="rda:Disposal"/>
<xsl:with-param name="action" select="'simple_months'"/>
</xsl:call-template>
<xsl:value-of select="$tab"/>
<xsl:call-template name="simple">
<xsl:with-param name="disposals" select="rda:Disposal"/>
<xsl:with-param name="action" select="'simple_trigger'"/>
</xsl:call-template>
<xsl:value-of select="$tab"/>
<xsl:value-of select="$newline"/>
</xsl:template>
</xsl:stylesheet>
