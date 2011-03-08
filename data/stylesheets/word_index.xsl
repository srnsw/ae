<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:aml="http://schemas.microsoft.com/aml/2001/core" xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" xmlns:o="urn:schemas-microsoft-com:office:office" version="1.0">
  <xsl:output method="xml" indent="yes"/>
  <xsl:include href="include/stocks.xsl"/>
  <xsl:include href="include/word_header.xsl"/>
  <xsl:include href="include/word_headers_footers.xsl"/>
  <xsl:include href="include/index.xsl"/>
  <xsl:variable name="ANCHOR">
    <xsl:value-of select="'false'"/>
  </xsl:variable>
  <xsl:variable name="AUTHORITY_TITLE">
    <xsl:choose>
      <xsl:when test="rda:Authority/rda:AuthorityTitle">
        <xsl:value-of select="rda:Authority/rda:AuthorityTitle"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="camel_case">
          <xsl:with-param name="string" select="$SCOPE"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="//rda:Agency">
      <xsl:value-of select="concat(' (', $AGENCY_NAMES, ')')"/>
    </xsl:if>
  </xsl:variable>
  <xsl:template match="/">
    <xsl:processing-instruction name="mso-application">
      <xsl:text>progid="Word.Document"</xsl:text>
    </xsl:processing-instruction>
    <w:wordDocument w:macrosPresent="no" w:embeddedObjPresent="no" w:ocxPresent="no" xml:space="preserve">
<xsl:call-template name="word_header">
	<xsl:with-param name="tab" select="'720'"/>
	<xsl:with-param name="spacing" select="'0'"/>
</xsl:call-template>
<xsl:apply-templates select="rda:Authority"/>
</w:wordDocument>
  </xsl:template>
  <xsl:template match="rda:Authority">
    <!--acquire an index from index.xsl-->
    <xsl:variable name="index">
      <xsl:call-template name="index">
        <xsl:with-param name="authority" select="."/>
      </xsl:call-template>
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
              <w:gridCol w:w="2319"/>
              <w:gridCol w:w="3048"/>
              <w:gridCol w:w="4723"/>
            </w:tblGrid>
            <!--index goes here-->
            <xsl:for-each select="exslt:node-set($index)/links">
              <xsl:for-each select="broad_term">
                <w:tr>
                  <w:tc>
                    <w:tcPr>
                      <w:tcW w:w="2319" w:type="dxa"/>
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
                          <xsl:value-of select="broad_term_title"/>
                        </w:t>
                      </w:r>
                    </w:p>
                  </w:tc>
                  <w:tc>
                    <w:tcPr>
                      <w:tcW w:w="3048" w:type="dxa"/>
                      <w:shd w:val="clear" w:color="auto" w:fill="auto"/>
                    </w:tcPr>
                    <w:p>
                      <w:pPr>
                        <w:rPr>
                          <w:sz-cs w:val="20"/>
                        </w:rPr>
                      </w:pPr>
                    </w:p>
                  </w:tc>
                  <w:tc>
                    <w:tcPr>
                      <w:tcW w:w="4723" w:type="dxa"/>
                      <w:shd w:val="clear" w:color="auto" w:fill="auto"/>
                    </w:tcPr>
                    <w:p>
                      <w:pPr>
                        <w:rPr>
                          <w:sz-cs w:val="20"/>
                        </w:rPr>
                      </w:pPr>
                      <w:r>
                        <w:rPr/>
                        <w:t>
                          <xsl:for-each select="addresses">
                            <xsl:for-each select="address">
                              <xsl:sort select="." order="ascending"/>
                              <xsl:if test="position() &gt; 1">
                                <xsl:text>, </xsl:text>
                              </xsl:if>
                              <xsl:value-of select="."/>
                            </xsl:for-each>
                          </xsl:for-each>
                        </w:t>
                      </w:r>
                    </w:p>
                  </w:tc>
                </w:tr>
                <xsl:for-each select="narrow_terms/narrow_term">
                  <xsl:sort select="narrow_term_title"/>
                  <w:tr>
                    <w:tc>
                      <w:tcPr>
                        <w:tcW w:w="2319" w:type="dxa"/>
                        <w:shd w:val="clear" w:color="auto" w:fill="auto"/>
                      </w:tcPr>
                      <w:p>
                        <w:pPr>
                          <w:rPr>
                            <w:sz-cs w:val="20"/>
                          </w:rPr>
                        </w:pPr>
                      </w:p>
                    </w:tc>
                    <w:tc>
                      <w:tcPr>
                        <w:tcW w:w="3048" w:type="dxa"/>
                        <w:shd w:val="clear" w:color="auto" w:fill="auto"/>
                      </w:tcPr>
                      <w:p>
                        <w:pPr>
                          <w:rPr>
                            <w:sz-cs w:val="20"/>
                          </w:rPr>
                        </w:pPr>
                        <w:r>
                          <w:rPr/>
                          <w:t>
                            <xsl:value-of select="narrow_term_title"/>
                          </w:t>
                        </w:r>
                      </w:p>
                    </w:tc>
                    <w:tc>
                      <w:tcPr>
                        <w:tcW w:w="4723" w:type="dxa"/>
                        <w:shd w:val="clear" w:color="auto" w:fill="auto"/>
                      </w:tcPr>
                      <w:p>
                        <w:pPr>
                          <w:rPr>
                            <w:sz-cs w:val="20"/>
                          </w:rPr>
                        </w:pPr>
                        <w:r>
                          <w:rPr/>
                          <w:t>
                            <xsl:for-each select="addresses">
                              <xsl:sort select="address" order="ascending"/>
                              <xsl:for-each select="address[not(. = preceding-sibling::address)]">
                                <xsl:if test="position() &gt; 1">
                                  <xsl:text>, </xsl:text>
                                </xsl:if>
                                <xsl:value-of select="."/>
                              </xsl:for-each>
                            </xsl:for-each>
                          </w:t>
                        </w:r>
                      </w:p>
                    </w:tc>
                  </w:tr>
                </xsl:for-each>
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
              <xsl:with-param name="header_first" select="concat($AUTHORITY_TYPE, ' - ', $AUTHORITY_TITLE)"/>
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
