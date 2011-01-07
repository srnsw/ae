<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" version="1.0">
  <xsl:output method="html"/>
  <xsl:param name="prefix"/>
  <xsl:include href="include/utils.xsl"/>
  <xsl:include href="include/index.xsl"/>
  <xsl:variable name="ANCHOR">
    <xsl:value-of select="'true'"/>
  </xsl:variable>
  <xsl:template match="rda:Authority">
    <xsl:variable name="index">
      <xsl:call-template name="index">
        <xsl:with-param name="authority" select="."/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:element name="index">
      <xsl:for-each select="exslt:node-set($index)/links">
        <xsl:for-each select="broad_term">
          <xsl:element name="bt">
            <xsl:element name="h4">
              <xsl:element name="a">
                <xsl:variable name="clean_title">
                  <xsl:call-template name="titleise">
                    <xsl:with-param name="title" select="broad_term_title"/>
                  </xsl:call-template>
                </xsl:variable>
                <xsl:attribute name="id"><xsl:value-of select="$clean_title"/></xsl:attribute>
                <xsl:attribute name="name"><xsl:value-of select="$clean_title"/></xsl:attribute>
              </xsl:element>
              <xsl:value-of select="broad_term_title"/>
            </xsl:element>
            <xsl:for-each select="addresses">
              <xsl:for-each select="address">
                <xsl:sort select="." order="ascending"/>
                <xsl:element name="p">  
                  <xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp; </xsl:text>
                  <xsl:element name="a">
                    <xsl:attribute name="href"><xsl:value-of select="concat($prefix, @anchor)"/></xsl:attribute>
                    <xsl:value-of select="."/>
                  </xsl:element>
                </xsl:element>  
              </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="narrow_terms/narrow_term">
              <xsl:sort select="narrow_term_title"/>
              <xsl:element name="h5">  
                <xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp; </xsl:text>
                <xsl:value-of select="narrow_term_title"/>
              </xsl:element>
              <xsl:for-each select="addresses">
                <xsl:sort select="address" order="ascending"/>
                <xsl:for-each select="address[not(. = preceding-sibling::address)]">
                  <xsl:element name="p">  
                    <xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp; </xsl:text>
                    <xsl:element name="a">
                      <xsl:attribute name="href"><xsl:value-of select="concat($prefix, @anchor)"/></xsl:attribute>
                      <xsl:value-of select="."/>
                    </xsl:element>
                  </xsl:element>
                </xsl:for-each>
              </xsl:for-each>
            </xsl:for-each>
          </xsl:element>  
        </xsl:for-each>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>
