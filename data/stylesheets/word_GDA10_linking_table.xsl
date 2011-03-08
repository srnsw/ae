<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:aml="http://schemas.microsoft.com/aml/2001/core" xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" xmlns:o="urn:schemas-microsoft-com:office:office" version="1.0">
  <xsl:output method="xml" indent="yes"/>
  <xsl:include href="include/word_header.xsl"/>
  <xsl:include href="include/word_headers_footers.xsl"/>
  <xsl:include href="include/linking_table.xsl"/>
  <!-- if you want to always link to the same previous authority set a default prefix (e.g. GDA10) on the variable below-->
  <!-- e.g. <xsl:variable name="DEFAULT_PREFIX" select="'GDA10'"/>-->
  <xsl:variable name="DEFAULT_PREFIX" select="'GDA10'"/>
  <!-- change the Linking Table Header name to specify your own header -->
  <xsl:variable name="LINKING_TABLE_HEADER" select="'DRAFT - General Retention and Disposal Authority: Local Government records (Linking Table)'"/>
  <xsl:template match="/">
    <xsl:processing-instruction name="mso-application">
      <xsl:text>progid="Word.Document"</xsl:text>
    </xsl:processing-instruction>
    <w:wordDocument w:macrosPresent="no" w:embeddedObjPresent="no" w:ocxPresent="no">
      <xsl:call-template name="word_header">
        <xsl:with-param name="tab" select="'720'"/>
        <xsl:with-param name="spacing" select="'0'"/>
      </xsl:call-template>
      <xsl:apply-templates select="rda:Authority"/>
    </w:wordDocument>
  </xsl:template>
  <xsl:template match="rda:Authority">
    <!--acquire a linking table from linking_table.xsl-->
    <xsl:variable name="linked_terms">
      <xsl:element name="links">
        <xsl:call-template name="linking_table">
          <xsl:with-param name="terms" select="//rda:LinkedTo[@type='linking table']"/>
          <xsl:with-param name="default_prefix" select="$DEFAULT_PREFIX"/>
        </xsl:call-template>
      </xsl:element>
    </xsl:variable>
    <!--word document-->
    <w:body>
      <wx:sect>
          <w:tbl>
            <w:tblPr>
              <w:tblW w:w="10090" w:type="dxa"/>
              <w:tblBorders>
                <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
                <w:left w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
                <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
                <w:right w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
                <w:insideH w:val="single" w:sz="6" wx:bdrwidth="15" w:space="0" w:color="auto"/>
                <w:insideV w:val="single" w:sz="6" wx:bdrwidth="15" w:space="0" w:color="auto"/>
              </w:tblBorders>
              <w:tblCellMar>
                <w:top w:w="15" w:type="dxa"/>
                <w:left w:w="15" w:type="dxa"/>
                <w:bottom w:w="15" w:type="dxa"/>
                <w:right w:w="15" w:type="dxa"/>
              </w:tblCellMar>
            </w:tblPr>
            <w:tblGrid>
              <w:gridCol w:w="1609"/>
              <w:gridCol w:w="1249"/>
              <w:gridCol w:w="4172"/>
              <w:gridCol w:w="3060"/>
            </w:tblGrid>
            <!--linking table goes here-->
            <!--table headers-->
            <w:tr>
              <w:trPr>
                <w:tblHeader/>
              </w:trPr>
              <w:tc>
                <w:tcPr>
                  <w:tcW w:w="1609" w:type="dxa"/>
                  <w:shd w:val="clear" w:color="auto" w:fill="auto"/>
                </w:tcPr>
                <w:p>
                  <w:pPr>
                    <w:rPr>
                      <w:b/>
                      <w:sz-cs w:val="20"/>
                    </w:rPr>
                  </w:pPr>
                  <w:r>
                    <w:rPr>
                      <w:b/>
                      <w:sz-cs w:val="20"/>
                    </w:rPr>
                    <w:t><xsl:value-of select="$DEFAULT_PREFIX"/><xsl:text> reference</xsl:text></w:t>
                  </w:r>
                </w:p>
              </w:tc>
              <w:tc>
                <w:tcPr>
                  <w:tcW w:w="1249" w:type="dxa"/>
                  <w:shd w:val="clear" w:color="auto" w:fill="auto"/>
                </w:tcPr>
                <w:p>
                  <w:pPr>
                    <w:rPr>
                      <w:b/>
                      <w:i-cs/>
                      <w:sz-cs w:val="20"/>
                    </w:rPr>
                  </w:pPr>
                  <w:r>
                    <w:rPr>
                      <w:b/>
                      <w:i-cs/>
                      <w:sz-cs w:val="20"/>
                    </w:rPr>
                    <w:t>GAXX reference</w:t>
                  </w:r>
                </w:p>
              </w:tc>
              <w:tc>
                <w:tcPr>
                  <w:tcW w:w="4172" w:type="dxa"/>
                  <w:shd w:val="clear" w:color="auto" w:fill="auto"/>
                </w:tcPr>
                <w:p>
                  <w:pPr>
                    <w:rPr>
                      <w:b/>
                      <w:sz-cs w:val="20"/>
                    </w:rPr>
                  </w:pPr>
                  <w:r>
                    <w:rPr>
                      <w:b/>
                      <w:sz-cs w:val="20"/>
                    </w:rPr>
                    <w:t>Function/Activity</w:t>
                  </w:r>
                </w:p>
              </w:tc>
              <w:tc>
                <w:tcPr>
                  <w:tcW w:w="3060" w:type="dxa"/>
                  <w:shd w:val="clear" w:color="auto" w:fill="auto"/>
                </w:tcPr>
                <w:p>
                  <w:pPr>
                    <w:rPr>
                      <w:b/>
                      <w:sz-cs w:val="20"/>
                    </w:rPr>
                  </w:pPr>
                  <w:r>
                    <w:rPr>
                      <w:b/>
                      <w:sz-cs w:val="20"/>
                    </w:rPr>
                    <w:t>Comments</w:t>
                  </w:r>
                </w:p>
              </w:tc>
            </w:tr>
            <!--table rows-->
            <xsl:for-each select="exslt:node-set($linked_terms)/links">
              <xsl:for-each select="link_term">
                <xsl:sort select="old_ref/prefix" order="ascending"/>
                <xsl:sort select="old_ref/f" data-type="number" order="ascending"/>
                <xsl:sort select="old_ref/a" data-type="number" order="ascending"/>
                <xsl:sort select="old_ref/c" data-type="number" order="ascending"/>
                <w:tr>
                  <w:tc>
                    <w:tcPr>
                      <w:tcW w:w="1609" w:type="dxa"/>
                      <w:shd w:val="clear" w:color="auto" w:fill="auto"/>
                    </w:tcPr>
                    <w:p>
                      <w:pPr>
                        <w:rPr>
                          <w:b/>
                          <w:sz-cs w:val="20"/>
                        </w:rPr>
                      </w:pPr>
                      <w:r>
                        <w:rPr>
                          <w:b/>
                          <w:sz-cs w:val="20"/>
                        </w:rPr>
                        <w:t>
                          <xsl:choose>
                            <xsl:when test="old_ref/f"><xsl:if test="old_ref/prefix"><xsl:value-of select="concat(old_ref/prefix, ' ')"/></xsl:if><xsl:value-of select="old_ref/f"/>.<xsl:value-of select="old_ref/a"/>.<xsl:value-of select="old_ref/c"/></xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="old_ref"/>
                            </xsl:otherwise>
                          </xsl:choose>
                        </w:t>
                      </w:r>
                    </w:p>
                  </w:tc>
                  <w:tc>
                    <w:tcPr>
                      <w:tcW w:w="1249" w:type="dxa"/>
                      <w:shd w:val="clear" w:color="auto" w:fill="auto"/>
                    </w:tcPr>
                    <w:p>
                      <w:pPr>
                        <w:rPr>
                          <w:b/>
                          <w:sz-cs w:val="20"/>
                        </w:rPr>
                      </w:pPr>
                      <w:r>
                        <w:rPr>
                          <w:b/>
                          <w:sz-cs w:val="20"/>
                        </w:rPr>
                        <w:t>
                          <xsl:value-of select="new_ref"/>
                        </w:t>
                      </w:r>
                    </w:p>
                  </w:tc>
                  <w:tc>
                    <w:tcPr>
                      <w:tcW w:w="4172" w:type="dxa"/>
                      <w:shd w:val="clear" w:color="auto" w:fill="auto"/>
                    </w:tcPr>
                    <w:p>
                      <w:pPr>
                        <w:rPr>
                          <w:sz-cs w:val="20"/>
                        </w:rPr>
                      </w:pPr>
                      <w:r>
                        <w:rPr>
                          <w:sz-cs w:val="20"/>
                        </w:rPr>
                        <w:t>
                          <xsl:value-of select="func_ac"/>
                        </w:t>
                      </w:r>
                    </w:p>
                  </w:tc>
                  <w:tc>
                    <w:tcPr>
                      <w:tcW w:w="3060" w:type="dxa"/>
                      <w:shd w:val="clear" w:color="auto" w:fill="auto"/>
                    </w:tcPr>
                    <w:p>
                      <w:pPr>
                        <w:rPr>
                          <w:sz-cs w:val="20"/>
                        </w:rPr>
                      </w:pPr>
                      <w:r>
                        <w:rPr>
                          <w:sz-cs w:val="20"/>
                        </w:rPr>
                        <w:t>
                          <xsl:value-of select="comment"/>
                        </w:t>
                      </w:r>
                    </w:p>
                  </w:tc>
                </w:tr>
              </xsl:for-each>
            </xsl:for-each>
          </w:tbl>
          <w:p>
            <w:pPr>
              <w:spacing w:line="360" w:line-rule="auto"/>
              <w:rPr>
                <w:sz-cs w:val="20"/>
              </w:rPr>
            </w:pPr>
          </w:p>
          <w:sectPr>
            <xsl:call-template name="portrait_header_footer">
              <xsl:with-param name="header_first" select="$LINKING_TABLE_HEADER"/>
              <xsl:with-param name="tab" select="'9923'"/>
            </xsl:call-template>
            <w:pgSz w:w="11906" w:h="16838"/>
            <w:pgMar w:top="1440" w:right="941" w:bottom="1440" w:left="941" w:header="708" w:footer="708" w:gutter="0"/>
            <w:cols w:space="708"/>
            <w:docGrid w:line-pitch="360"/>
          </w:sectPr>
      </wx:sect>
    </w:body>
  </xsl:template>
</xsl:stylesheet>
