<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:include href="utils.xsl"/>
  <xsl:template name="linking_table">
    <xsl:param name="terms"/>
    <xsl:param name="default_prefix"/>
    <xsl:for-each select="$terms">
      <xsl:variable name="term">
        <xsl:value-of select="."/>
      </xsl:variable>
      <xsl:element name="link_term">
        <xsl:choose>
          <xsl:when test="contains($term, ' - ')">
            <xsl:element name="old_ref">
              <xsl:call-template name="clean_reference">
                <xsl:with-param name="old_reference" select="substring-before($term, ' -')"/>
                <xsl:with-param name="default_prefix" select="$default_prefix"/>
              </xsl:call-template>
            </xsl:element>
            <xsl:element name="comment">
              <xsl:value-of select="substring-after($term, '- ')"/>
            </xsl:element>
          </xsl:when>
          <xsl:otherwise>
            <xsl:element name="old_ref">
              <xsl:call-template name="clean_reference">
                <xsl:with-param name="old_reference" select="$term"/>
                <xsl:with-param name="default_prefix" select="$default_prefix"/>
              </xsl:call-template>
            </xsl:element>
            <xsl:element name="comment"/>
          </xsl:otherwise>
        </xsl:choose>
        <!-- the linkedto element's parent node (a term or class) provides the item number and address-->
        <xsl:element name="new_ref">
          <xsl:value-of select="../@itemno"/>
        </xsl:element>
        <xsl:element name="func_ac">
          <xsl:call-template name="build_address">
            <xsl:with-param name="node" select="."/>
          </xsl:call-template>
        </xsl:element>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="clean_reference">
    <xsl:param name="old_reference"/>
    <xsl:param name="default_prefix"/>
    <xsl:choose>
      <xsl:when test="contains($old_reference, '.')">
        <xsl:choose>
          <xsl:when test="contains(substring-before($old_reference, '.'), ' ')">
            <xsl:variable name="prefix">
              <xsl:value-of select="substring-before(substring-before($old_reference, '.'), ' ')"/>
            </xsl:variable>
            <xsl:call-template name="split_reference">
              <xsl:with-param name="prefix" select="$prefix"/>
              <xsl:with-param name="clean_ref" select="substring-after($old_reference, concat($prefix, ' '))"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="split_reference">
              <xsl:with-param name="prefix" select="$default_prefix"/>
              <xsl:with-param name="clean_ref" select="$old_reference"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$old_reference"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="split_reference">
    <xsl:param name="prefix"/>
    <xsl:param name="clean_ref"/>
    <xsl:choose>
      <xsl:when test="contains($clean_ref, '.')">
        <xsl:variable name="after_function">
          <xsl:value-of select="substring-after($clean_ref, '.')"/>
        </xsl:variable>
        <xsl:if test="$prefix">
          <xsl:element name="prefix">
            <xsl:value-of select="$prefix"/>
          </xsl:element>
        </xsl:if>
        <xsl:element name="f">
          <xsl:value-of select="substring-before($clean_ref, '.')"/>
        </xsl:element>
        <xsl:choose>
          <xsl:when test="contains($after_function, '.')">
            <xsl:element name="a">
              <xsl:value-of select="substring-before($after_function, '.')"/>
            </xsl:element>
            <xsl:element name="c">
              <xsl:value-of select="substring-after($after_function, '.')"/>
            </xsl:element>
          </xsl:when>
          <xsl:otherwise>
            <xsl:element name="a">
              <xsl:value-of select="$after_function"/>
            </xsl:element>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$clean_ref"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
