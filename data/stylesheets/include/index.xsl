<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" xmlns:exslt="http://exslt.org/common" version="1.0">
   <xsl:template name="index">
    <xsl:param name="authority"/>
    <xsl:for-each select="$authority">
      <!--create a list of link terms for all linked to elements with index type and all functions and activities-->
      <xsl:variable name="first_run">
        <xsl:element name="links">
          <xsl:apply-templates select="//rda:LinkedTo[@type='index']"/>
          <xsl:call-template name="index_terms"> 
            <xsl:with-param name="terms" select="//rda:Term[@itemno]"/>
          </xsl:call-template>
        </xsl:element>
      </xsl:variable>
      <!-- recreate the list of link terms created in the first run and this time add to it, in reverse, all link terms with a narrow term (so the narrow term becomes the broad term and the broad the narrow)-->
      <xsl:variable name="raw_terms">
        <xsl:element name="links">
          <xsl:apply-templates select="//rda:LinkedTo[@type='index']"/>
          <xsl:call-template name="index_terms"> 
            <xsl:with-param name="terms" select="//rda:Term[@itemno]"/>
          </xsl:call-template>
          <xsl:call-template name="reverse">
            <xsl:with-param name="reverse_term" select="exslt:node-set($first_run)/links/link_term[nt]"/>
          </xsl:call-template>
        </xsl:element>
      </xsl:variable>
      <!-- now cluster together all links with the same broad terms--> 
      <xsl:variable name="clustered_list">
        <xsl:element name="links">
          <xsl:call-template name="unique_terms">
            <xsl:with-param name="unique_term" select="exslt:node-set($raw_terms)/links/link_term[not(bt = preceding-sibling::link_term/bt)]"/>
            <xsl:with-param name="raw_terms" select="exslt:node-set($raw_terms)/links"/>
          </xsl:call-template>
        </xsl:element>
      </xsl:variable>
      <xsl:element name="links">
        <xsl:for-each select="exslt:node-set($clustered_list)/links">
          <xsl:for-each select="link">
            <xsl:sort select="term" order="ascending"/>
            <xsl:element name="broad_term">
              <xsl:choose>
              <xsl:when test="addresses/address/qualifier and not(addresses/address[2])">
                <xsl:element name="broad_term_title">
                  <xsl:value-of select="concat(term, ' (', addresses/address/qualifier, ')')"/>
                </xsl:element>
                <xsl:element name="addresses">
                  <xsl:element name="address">
                   <xsl:if test="$ANCHOR='true'">
                     <xsl:attribute name="anchor">
                       <xsl:value-of select="addresses/address/@anchor"/>
                     </xsl:attribute>
                   </xsl:if> 
                   <xsl:value-of select="addresses/address/address_text"/>
                  </xsl:element>
                </xsl:element>
              </xsl:when>
              <xsl:otherwise>
                <xsl:element name="broad_term_title">
                  <xsl:value-of select="term"/>
                </xsl:element>
                <xsl:for-each select="addresses[address[not(qualifier)]]">
                  <xsl:element name="addresses">
                    <xsl:for-each select="address[not(qualifier) and not(./address_text = preceding-sibling::address/address_text)]">
                      <xsl:element name="address">
                        <xsl:if test="$ANCHOR='true'">
                          <xsl:attribute name="anchor">
                            <xsl:value-of select="@anchor"/>
                          </xsl:attribute>
                        </xsl:if>
                        <xsl:value-of select="address_text"/>
                      </xsl:element>
                    </xsl:for-each>
                  </xsl:element>
                </xsl:for-each>
                <xsl:for-each select="addresses[address/qualifier]">
                  <xsl:element name="narrow_terms">
                    <xsl:call-template name="unique_narrow_terms">
                      <xsl:with-param name="unique_narrow_term" select="address[qualifier[not(. = ../preceding-sibling::address/qualifier)]]"/>
                      <xsl:with-param name="addresses" select="address"/>
                    </xsl:call-template>
                  </xsl:element>
                </xsl:for-each>
              </xsl:otherwise>
              </xsl:choose>
            </xsl:element>
          </xsl:for-each>
        </xsl:for-each>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>
  <!-- create indexing terms for each linked to element with an index type-->
  <xsl:template match="rda:LinkedTo[@type='index']">
    <xsl:element name="link_term">
      <xsl:variable name="term">
        <xsl:value-of select="translate(., $upperCaseChars, $lowerCaseChars)"/>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="contains($term, ' - ')">
          <xsl:element name="bt">
            <xsl:value-of select="normalize-space(substring-before($term, ' -'))"/>
          </xsl:element>
          <xsl:element name="nt">
            <xsl:value-of select="normalize-space(substring-after($term, '- '))"/>
          </xsl:element>
        </xsl:when>
        <xsl:otherwise>
          <xsl:element name="bt">
            <xsl:value-of select="$term"/>
          </xsl:element>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:element name="address">
        <xsl:if test="$ANCHOR='true'">
          <xsl:attribute name="anchor">
            <xsl:for-each select="ancestor::rda:Term">
              <xsl:if test="position() &gt; 1"><xsl:text>#</xsl:text></xsl:if>
              <xsl:value-of select="rda:anchor"/>
            </xsl:for-each>
          </xsl:attribute>
        </xsl:if>
        <xsl:call-template name="build_address_with_itemno">
          <xsl:with-param name="node" select=".."/>
        </xsl:call-template>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <!-- create indexing terms for each function and activity in the authority-->
  <xsl:template name="index_terms">
    <xsl:param name="terms"/>
    <xsl:for-each select="$terms">
    <xsl:element name="link_term">
      <xsl:element name="bt">
        <xsl:value-of select="translate(normalize-space(rda:TermTitle), $upperCaseChars, $lowerCaseChars)"/>
      </xsl:element>
      <xsl:if test="parent::rda:Term">
        <xsl:element name="nt">
          <xsl:value-of select="translate(normalize-space(../rda:TermTitle), $upperCaseChars, $lowerCaseChars)"/>
        </xsl:element>
      </xsl:if>
      <xsl:element name="address">
        <xsl:if test="$ANCHOR='true'">
          <xsl:attribute name="anchor">
            <xsl:for-each select="ancestor-or-self::rda:Term">
              <xsl:if test="position() &gt; 1"><xsl:text>#</xsl:text></xsl:if>
              <xsl:value-of select="rda:anchor"/>
            </xsl:for-each>
          </xsl:attribute>
        </xsl:if>
        <xsl:call-template name="build_address_with_itemno">
          <xsl:with-param name="node" select="."/>
        </xsl:call-template>
      </xsl:element>
    </xsl:element>
    </xsl:for-each>
  </xsl:template>
  <!-- reverses the broad and narrow terms in a link-->
  <xsl:template name="reverse">
    <xsl:param name="reverse_term"/>
    <xsl:for-each select="$reverse_term">
      <xsl:element name="link_term">
        <xsl:element name="bt">
          <xsl:value-of select="nt"/>
        </xsl:element>
        <xsl:element name="nt">
          <xsl:value-of select="bt"/>
        </xsl:element>
        <xsl:element name="address">
          <xsl:if test="$ANCHOR='true'">
            <xsl:attribute name="anchor">
              <xsl:value-of select="address/@anchor"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:value-of select="address"/>
        </xsl:element>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>
  <!-- cluster together identical broad terms-->
  <xsl:template name="unique_terms">
    <xsl:param name="unique_term"/>
    <xsl:param name="raw_terms"/>
    <xsl:for-each select="$unique_term">
      <xsl:element name="link">
        <xsl:variable name="term">
          <xsl:value-of select="bt"/>
        </xsl:variable>
        <xsl:element name="term">
          <xsl:value-of select="$term"/>
        </xsl:element>
        <xsl:element name="addresses">
          <xsl:for-each select="$raw_terms/link_term[bt=$term]">
            <xsl:element name="address">
              <xsl:if test="$ANCHOR='true'">
                <xsl:attribute name="anchor">
                  <xsl:value-of select="address/@anchor"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:if test="nt">
                <xsl:element name="qualifier">
                  <xsl:value-of select="nt"/>
                </xsl:element>
              </xsl:if>
              <xsl:element name="address_text">
                <xsl:value-of select="address"/>
              </xsl:element>
            </xsl:element>
          </xsl:for-each>
        </xsl:element>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>
  <!-- cluster together identical narrow terms within a broad term-->
  <xsl:template name="unique_narrow_terms">
    <xsl:param name="unique_narrow_term"/>
    <xsl:param name="addresses"/>
    <xsl:for-each select="$unique_narrow_term">
      <xsl:element name="narrow_term">
        <xsl:variable name="term">
          <xsl:value-of select="qualifier"/>
        </xsl:variable>
        <xsl:element name="narrow_term_title">
          <xsl:value-of select="$term"/>
        </xsl:element>
        <xsl:element name="addresses">
          <xsl:for-each select="$addresses[qualifier=$term]">
            <xsl:element name="address">
              <xsl:if test="$ANCHOR='true'">
                <xsl:attribute name="anchor">
                  <xsl:value-of select="@anchor"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="address_text"/>
            </xsl:element>
          </xsl:for-each>
        </xsl:element>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
