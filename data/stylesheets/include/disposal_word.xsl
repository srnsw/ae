<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:sl="http://schemas.microsoft.com/schemaLibrary/2003/core" xmlns:aml="http://schemas.microsoft.com/aml/2001/core" xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:dt="uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:wsp="http://schemas.microsoft.com/office/word/2003/wordml/sp2" xmlns:st1="urn:schemas-microsoft-com:office:smarttags" version="1.0">
  <xsl:include href="disposal_common.xsl"/>
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
            <xsl:when test="rda:DisposalAction='Transfer'">
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
