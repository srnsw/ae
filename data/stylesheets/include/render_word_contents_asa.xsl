<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" version="1.0"> 
  <xsl:template name="TOC">
    <w:tbl>
      <w:tblPr>
        <w:tblStyle w:val="TableGrid"/>
        <w:tblW w:w="5000" w:type="pct"/>
        <w:tblLook w:val="01E0"/>
      </w:tblPr>
      <w:tblGrid>
        <w:gridCol w:w="2000" w:type="pct"/>
        <w:gridCol w:w="1900" w:type="pct"/>
        <w:gridCol w:w="600" w:type="pct"/>
        <w:gridCol w:w="500" w:type="pct"/>
      </w:tblGrid>
      <w:tr>
        <w:trPr>
          <w:tblHeader/>
        </w:trPr>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="2000" w:type="pct"/>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:rPr>
                <w:b/>
              </w:rPr>
            </w:pPr>
            <w:r>
              <w:rPr>
                <w:b/>
              </w:rPr>
              <w:t>Function</w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="1900" w:type="pct"/>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:rPr>
                <w:b/>
              </w:rPr>
            </w:pPr>
            <w:r>
              <w:rPr>
                <w:b/>
              </w:rPr>
              <w:t>Class</w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="600" w:type="pct"/>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:rPr>
                <w:b/>
              </w:rPr>
            </w:pPr>
            <w:r>
              <w:rPr>
                <w:b/>
              </w:rPr>
              <w:t>Reference</w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="500" w:type="pct"/>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:rPr>
                <w:b/>
              </w:rPr>
            </w:pPr>
            <w:r>
              <w:rPr>
                <w:b/>
              </w:rPr>
              <w:t>Page</w:t>
            </w:r>
          </w:p>
        </w:tc>
      </w:tr>
      <xsl:for-each select="rda:Term | rda:Class">
        <w:tr>
          <w:tc>
            <w:tcPr>
              <w:tcW w:w="2000" w:type="pct"/>
            </w:tcPr>
            <w:p>
              <w:hlink w:bookmark="{generate-id(.)}" w:screenTip="{rda:TermTitle | rda:ClassTitle}">
                <w:r>
                  <w:rPr/>
                  <w:t>
                    <xsl:value-of select="rda:TermTitle | rda:ClassTitle"/>
                  </w:t>
                </w:r>
              </w:hlink>
            </w:p>
          </w:tc>
          <w:tc>
            <w:tcPr>
              <w:tcW w:w="1900" w:type="pct"/>
            </w:tcPr>
            <w:p/>
          </w:tc>
          <w:tc>
            <w:tcPr>
              <w:tcW w:w="600" w:type="pct"/>
            </w:tcPr>
            <w:p>
              <w:r>
                <w:rPr/>
                <w:t>
                    <xsl:if test="rda:ID">
                      <xsl:variable name="id">
                        <xsl:call-template name="local_id">
                          <xsl:with-param name="node" select="."/>
                        </xsl:call-template>
                      </xsl:variable>
                      <xsl:if test="$id != $RDANO">
                        <xsl:value-of select="concat($id, ' ')"/>
                      </xsl:if>
                    </xsl:if>
                    <xsl:value-of select="@itemno"/>
                  </w:t>
              </w:r>
            </w:p>
          </w:tc>
          <w:tc>
            <w:tcPr>
              <w:tcW w:w="500" w:type="pct"/>
            </w:tcPr>
            <w:p>
              <w:fldSimple w:instr=" PAGEREF  {generate-id(.)}  \* MERGEFORMAT ">
                <w:r>
                  <w:rPr/>
                  <w:t>ctr-a, F9</w:t>
                </w:r>
              </w:fldSimple>
            </w:p>
          </w:tc>
        </w:tr>
        <xsl:for-each select="rda:Term | rda:Class">
          <w:tr>
            <w:tc>
              <w:tcPr>
                <w:tcW w:w="2000" w:type="pct"/>
              </w:tcPr>
              <w:p/>
            </w:tc>
            <w:tc>
              <w:tcPr>
                <w:tcW w:w="1900" w:type="pct"/>
              </w:tcPr>
              <w:p>
                <w:hlink w:bookmark="{generate-id(.)}" w:screenTip="{rda:TermTitle | rda:ClassTitle}">
                  <w:r>
                    <w:rPr/>
                    <w:t><xsl:value-of select="rda:TermTitle | rda:ClassTitle"/></w:t>
                  </w:r>
                </w:hlink>
              </w:p>
            </w:tc>
             <w:tc>
              <w:tcPr>
                <w:tcW w:w="600" w:type="pct"/>
              </w:tcPr>
              <w:p>
                <w:r>
                  <w:rPr/>
                  <w:t>
                    <xsl:if test="ancestor-or-self::rda:Term[rda:ID]">
                      <xsl:variable name="id">
                        <xsl:call-template name="local_id">
                          <xsl:with-param name="node" select="."/>
                        </xsl:call-template>
                      </xsl:variable>
                      <xsl:if test="$id != $RDANO">
                        <xsl:value-of select="concat($id, ' ')"/>
                      </xsl:if>
                    </xsl:if>
                    <xsl:value-of select="@itemno"/>
                  </w:t>
                </w:r>
              </w:p>
            </w:tc>
            <w:tc>
              <w:tcPr>
                <w:tcW w:w="500" w:type="pct"/>
              </w:tcPr>
              <w:p>
                <w:fldSimple w:instr=" PAGEREF  {generate-id(.)}  \* MERGEFORMAT ">
                  <w:r>
                    <w:rPr/>
                    <w:t>ctr-a, F9</w:t>
                  </w:r>
                </w:fldSimple>
              </w:p>
            </w:tc>
          </w:tr>
        </xsl:for-each>
      </xsl:for-each>
    </w:tbl>
    <w:p>
      <w:pPr>
        <w:rPr>
          <w:b/>
        </w:rPr>
        <w:sectPr>
          <xsl:call-template name="contents_headers_footers"/>
          <xsl:choose>
              <xsl:when test="$ORIENTATION='portrait'">
                <w:pgSz w:w="11907" w:h="16840" w:code="9"/>
                <w:pgMar w:top="1418" w:right="1418" w:bottom="1418" w:left="1418" w:header="567" w:footer="567" w:gutter="0"/>
              </xsl:when>
              <xsl:otherwise>
                <w:pgSz w:w="16840" w:h="11907" w:orient="landscape" w:code="9"/>
                <w:pgMar w:top="1418" w:right="1134" w:bottom="1418" w:left="1134" w:header="567" w:footer="567" w:gutter="0"/>
              </xsl:otherwise>
          </xsl:choose>
          <w:paperSrc w:first="7" w:other="7"/>
          <w:cols w:space="720"/>
          <w:titlePg/>
        </w:sectPr>
      </w:pPr>
    </w:p>
  </xsl:template>
</xsl:stylesheet>
