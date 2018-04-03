<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" version="1.0">
  <xsl:include href="disposal_common_asa.xsl"/>
  <xsl:template name="standard_action">
    <xsl:param name="disposal"/>
    <xsl:param name="condition"/>
    <xsl:for-each select="$disposal">
      <xsl:choose>
        <xsl:when test="rda:CustomAction">
          <xsl:if test="$condition">
            <w:p>
              <w:r>
                <w:rPr>
                  <w:b/>
                </w:rPr>
                <w:t>
                  <xsl:value-of select="$condition"/>
                  <xsl:text>:</xsl:text>
                </w:t>
              </w:r>
            </w:p>
          </xsl:if>
          <xsl:for-each select="rda:CustomAction">
            <xsl:apply-templates/>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="rda:DisposalAction='Destroy'">
             <w:p>
                 <xsl:if test="$condition">
                  <w:r>
                    <w:rPr>
                      <w:b/>
                    </w:rPr>
                    <w:t>
                      <xsl:value-of select="$condition"/>
                      <xsl:text>:</xsl:text>
                    </w:t>
                    <w:br/>
                  </w:r>
              </xsl:if>
                <w:r>
                  <w:t>
                    <xsl:call-template name="standard_string">
                      <xsl:with-param name="disposal" select="."/>
                    </xsl:call-template>
                  </w:t>
                </w:r>
              </w:p>
            </xsl:when>
            <xsl:when test="rda:DisposalAction='Transfer'">
              <w:p>
                 <xsl:if test="$condition">
                  <w:r>
                    <w:rPr>
                      <w:b/>
                    </w:rPr>
                    <w:t>
                      <xsl:value-of select="$condition"/>
                      <xsl:text>:</xsl:text>
                    </w:t>
                    <w:br/>
                  </w:r>
              </xsl:if>
                <w:r>
                  <w:t>
                    <xsl:call-template name="standard_string">
                      <xsl:with-param name="disposal" select="."/>
                    </xsl:call-template>
                  </w:t>
                </w:r>
              </w:p>
            </xsl:when>
            <!-- ASA custom -->
            <xsl:when test="rda:DisposalAction='Retain in agency'">
             <w:p>
                <xsl:if test="$condition">
                  <w:r>
                    <w:rPr>
                      <w:b/>
                    </w:rPr>
                    <w:t>
                      <xsl:value-of select="$condition"/>
                      <xsl:text>:</xsl:text>
                    </w:t>
                    <w:br/>
                  </w:r>
                </xsl:if>
                <w:r>
                  <w:t>
                   <xsl:text>Retain permanently</xsl:text>
                  </w:t>
                </w:r>
              </w:p>
            </xsl:when>
            <xsl:otherwise>
              <xsl:if test="$condition">
               <w:p>
                  <w:r>
                    <w:rPr>
                      <w:b/>
                    </w:rPr>
                    <w:t>
                      <xsl:value-of select="$condition"/>
                      <xsl:text>:</xsl:text>
                    </w:t>
                  </w:r>
                </w:p>
              </xsl:if>
              <w:p>
                <w:r>
                  <w:t>
                    <xsl:value-of select="rda:DisposalAction"/>
                  </w:t>
                </w:r>
              </w:p>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="multiple_action">
    <xsl:param name="disposals"/>
    <xsl:choose>
      <xsl:when test="$disposals[1]/rda:DisposalAction='Destroy'">
        <w:p>
          <w:r>
            <w:t>
              <xsl:call-template name="multiple_string">
                <xsl:with-param name="disposals" select="$disposals"/>
              </xsl:call-template>
            </w:t>
          </w:r>
        </w:p>
      </xsl:when>
      <xsl:when test="$disposals[1]/rda:DisposalAction='Transfer'">
        <w:p>
          <w:r>
            <w:t>
              <xsl:call-template name="multiple_string">
                <xsl:with-param name="disposals" select="$disposals"/>
              </xsl:call-template>
            </w:t>
          </w:r>
        </w:p>
      </xsl:when>
      <xsl:otherwise>
        <w:p>
          <w:r>
            <w:t>
              <xsl:value-of select="$disposals[1]/rda:DisposalAction"/>
            </w:t>
          </w:r>
        </w:p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="standard_custody">
    <xsl:param name="disposal"/>
    <xsl:param name="condition"/>
    <xsl:for-each select="$disposal">
      <xsl:choose>
        <xsl:when test="rda:CustomCustody">
          <xsl:if test="$condition">
            <w:p>
              <w:r>
                <w:rPr>
                  <w:b/>
                </w:rPr>
                <w:t>
                  <xsl:value-of select="$condition"/>
                  <xsl:text>:</xsl:text>
                </w:t>
              </w:r>
            </w:p>
          </xsl:if>
          <xsl:for-each select="rda:CustomCustody">
            <xsl:apply-templates/>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="rda:DisposalAction='Required as State archives'">
              <xsl:if test="$condition">
                <w:p>
                  <w:r>
                    <w:rPr>
                      <w:b/>
                    </w:rPr>
                    <w:t>
                      <xsl:value-of select="$condition"/>
                      <xsl:text>:</xsl:text>
                    </w:t>
                  </w:r>
                </w:p>
              </xsl:if>
              <w:p>
                <w:r>
                  <w:t>
                    <xsl:call-template name="standard_string">
                      <xsl:with-param name="disposal" select="."/>
                    </xsl:call-template>
                  </w:t>
                </w:r>
              </w:p>
            </xsl:when>
            <xsl:otherwise>
              <w:p/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="multiple_custody">
    <xsl:param name="disposals"/>
    <xsl:choose>
      <xsl:when test="$disposals[1]/rda:DisposalAction='Required as State archives'">
        <w:p>
          <w:r>
            <w:t>
              <xsl:call-template name="multiple_string">
                <xsl:with-param name="disposals" select="$disposals"/>
              </xsl:call-template>
            </w:t>
          </w:r>
        </w:p>
      </xsl:when>
      <xsl:otherwise>
        <w:p/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
