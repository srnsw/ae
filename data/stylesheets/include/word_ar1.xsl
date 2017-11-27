<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" version="1.0">
  <xsl:template name="word_ar1">
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Title"/>
      </w:pPr>
      <w:r>
        <w:t>
          <xsl:text>Board of the State Archives and Records Authority of NSW</xsl:text>
        </w:t>
      </w:r>
    </w:p>
    <w:tbl>
      <w:tblPr>
        <w:tblW w:w="0" w:type="auto"/>
        <w:tblInd w:w="108" w:type="dxa"/>
        <w:tblBorders>
          <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:left w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:right w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:insideH w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:insideV w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
        </w:tblBorders>
      </w:tblPr>
      <w:tblGrid>
        <w:gridCol w:w="993"/>
        <w:gridCol w:w="1275"/>
        <w:gridCol w:w="4253"/>
        <w:gridCol w:w="1417"/>
        <w:gridCol w:w="1241"/>
      </w:tblGrid>
      <w:tr>
        <w:tblPrEx>
          <w:tblCellMar>
            <w:top w:w="0" w:type="dxa"/>
            <w:bottom w:w="0" w:type="dxa"/>
          </w:tblCellMar>
        </w:tblPrEx>
        <w:trPr>
          <w:cantSplit/>
        </w:trPr>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="993" w:type="dxa"/>
            <w:tcBorders>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:pStyle w:val="Heading3"/>
            </w:pPr>
            <w:r>
              <w:t>
                <xsl:text>AR no </xsl:text>
              </w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="1275" w:type="dxa"/>
            <w:tcBorders>
              <w:left w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:r>
              <w:t>
                <xsl:value-of select="$ARNO"/>
              </w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="4253" w:type="dxa"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:bottom w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p/>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="1417" w:type="dxa"/>
            <w:tcBorders>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:pStyle w:val="Heading3"/>
            </w:pPr>
            <w:r>
              <w:t>
                <xsl:text>SR file no</xsl:text>
              </w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="1241" w:type="dxa"/>
            <w:tcBorders>
              <w:left w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:r>
              <w:t>
                <xsl:value-of select="$SRFILENOS"/>
              </w:t>
            </w:r>
          </w:p>
        </w:tc>
      </w:tr>
    </w:tbl>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Normalsingle"/>
        <w:tabs>
          <w:tab w:val="right" w:pos="9072"/>
        </w:tabs>
        <w:spacing w:before="120" w:after="120"/>
      </w:pPr>
      <w:r>
        <w:tab wx:wTab="9075" wx:tlc="none" wx:cTlc="120"/>
      </w:r>
    </w:p>
    <w:tbl>
      <w:tblPr>
        <w:tblW w:w="0" w:type="auto"/>
        <w:tblInd w:w="108" w:type="dxa"/>
        <w:tblBorders>
          <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:left w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:right w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:insideH w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:insideV w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
        </w:tblBorders>
      </w:tblPr>
      <w:tblGrid>
        <w:gridCol w:w="2268"/>
        <w:gridCol w:w="6911"/>
      </w:tblGrid>
      <w:tr>
        <w:tblPrEx>
          <w:tblCellMar>
            <w:top w:w="0" w:type="dxa"/>
            <w:bottom w:w="0" w:type="dxa"/>
          </w:tblCellMar>
        </w:tblPrEx>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="2268" w:type="dxa"/>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:pStyle w:val="Heading3"/>
            </w:pPr>
            <w:r>
              <w:t>
                <xsl:text>Public office</xsl:text>
              </w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="6911" w:type="dxa"/>
          </w:tcPr>
          <w:p>
            <w:r>
              <w:t>
                <xsl:value-of select="$AGENCY_NAMES"/>
              </w:t>
            </w:r>
          </w:p>
          <w:p>
            <w:r>
              <w:t>
                <xsl:text>Agency no: </xsl:text>
                <xsl:value-of select="$AGENCY_NOS"/>
              </w:t>
            </w:r>
          </w:p>
        </w:tc>
      </w:tr>
    </w:tbl>
    <w:p/>
    <w:tbl>
      <w:tblPr>
        <w:tblW w:w="0" w:type="auto"/>
        <w:tblInd w:w="108" w:type="dxa"/>
        <w:tblBorders>
          <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:left w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:right w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:insideH w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:insideV w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
        </w:tblBorders>
      </w:tblPr>
      <w:tblGrid>
        <w:gridCol w:w="2268"/>
        <w:gridCol w:w="6911"/>
      </w:tblGrid>
      <w:tr>
        <w:tblPrEx>
          <w:tblCellMar>
            <w:top w:w="0" w:type="dxa"/>
            <w:bottom w:w="0" w:type="dxa"/>
          </w:tblCellMar>
        </w:tblPrEx>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="2268" w:type="dxa"/>
            <w:tcBorders>
              <w:bottom w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:pStyle w:val="Heading3"/>
            </w:pPr>
            <w:r>
              <w:t>
                <xsl:text>Type of authority</xsl:text>
              </w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="6911" w:type="dxa"/>
            <w:tcBorders>
              <w:bottom w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:r>
              <w:t>
                <xsl:value-of select="$AUTHORITY_TYPE"/>
              </w:t>
            </w:r>
          </w:p>
        </w:tc>
      </w:tr>
      <w:tr>
        <w:tblPrEx>
          <w:tblCellMar>
            <w:top w:w="0" w:type="dxa"/>
            <w:bottom w:w="0" w:type="dxa"/>
          </w:tblCellMar>
        </w:tblPrEx>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="2268" w:type="dxa"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:pStyle w:val="Heading3"/>
            </w:pPr>
            <w:r>
              <w:t>
                <xsl:text>Dates of coverage</xsl:text>
              </w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="6911" w:type="dxa"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:r>
              <w:t>
                <xsl:value-of select="$DATE_RANGE"/>
              </w:t>
            </w:r>
          </w:p>
        </w:tc>
      </w:tr>
    </w:tbl>
    <w:p>
        <w:pPr>
          <w:pStyle w:val="Heading2"/>
        </w:pPr>
        <w:r>
          <w:t>
            <xsl:text>Context</xsl:text>
          </w:t>
        </w:r>
      </w:p>
      <xsl:apply-templates select="rda:Context[@type='appraisal report']"/>
      <w:p>
        <w:pPr>
          <w:pStyle w:val="Heading2"/>
          <w:tabs>
            <w:tab w:val="left" w:pos="1985"/>
          </w:tabs>
        </w:pPr>
        <w:r>
          <w:t>
            <xsl:text>Recommendation</xsl:text>
          </w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:r>
          <w:t>
            <xsl:text>That the Board approve the records retention and disposal practices outlined in this authority.</xsl:text>
          </w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:pStyle w:val="Heading2"/>
          <w:tabs>
            <w:tab w:val="left" w:pos="1985"/>
          </w:tabs>
        </w:pPr>
        <w:r>
          <w:t>
            <xsl:text>Internal Approval</xsl:text>
          </w:t>
        </w:r>
      </w:p>
      <xsl:if test="$SUBMITTED !=''">
        <w:tbl>
          <w:tblPr>
            <w:tblStyle w:val="TableGrid"/>
            <w:tblW w:w="0" w:type="auto"/>
            <w:tblInd w:w="108" w:type="dxa"/>
            <w:tblLook w:val="01E0"/>
          </w:tblPr>
          <w:tblGrid>
            <w:gridCol w:w="2268"/>
            <w:gridCol w:w="6911"/>
          </w:tblGrid>
          <w:tr>
            <w:tc>
              <w:tcPr>
                <w:tcW w:w="2268" w:type="dxa"/>
              </w:tcPr>
              <w:p>
                <w:r>
                  <w:t>
                    <xsl:text>Public office submission</xsl:text>
                  </w:t>
                </w:r>
              </w:p>
            </w:tc>
            <w:tc>
              <w:tcPr>
                <w:tcW w:w="6911" w:type="dxa"/>
              </w:tcPr>
              <w:p>
                <w:r>
                  <w:t>
                    <xsl:text>The request for approval of this functional retention and disposal authority was submitted by </xsl:text>
                    <xsl:value-of select="$SUBMITTED"/>
                  </w:t>
                </w:r>
              </w:p>
            </w:tc>
          </w:tr>
        </w:tbl>
        <w:p/>
      </xsl:if>
      <w:tbl>
        <w:tblPr>
          <w:tblW w:w="0" w:type="auto"/>
          <w:tblInd w:w="108" w:type="dxa"/>
          <w:tblBorders>
            <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            <w:left w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            <w:right w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            <w:insideH w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            <w:insideV w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          </w:tblBorders>
        </w:tblPr>
        <w:tblGrid>
          <w:gridCol w:w="2268"/>
          <w:gridCol w:w="6911"/>
        </w:tblGrid>
        <w:tr>
          <w:tblPrEx>
            <w:tblCellMar>
              <w:top w:w="0" w:type="dxa"/>
              <w:bottom w:w="0" w:type="dxa"/>
            </w:tblCellMar>
          </w:tblPrEx>
          <w:trPr>
            <w:cantSplit/>
          </w:trPr>
          <w:tc>
            <w:tcPr>
              <w:tcW w:w="2268" w:type="dxa"/>
              <w:vmerge w:val="restart"/>
            </w:tcPr>
            <w:p>
              <w:r>
                <w:t>
                  <xsl:text>Approved for submission to Director</xsl:text>
                </w:t>
              </w:r>
            </w:p>
          </w:tc>
          <w:tc>
            <w:tcPr>
              <w:tcW w:w="6911" w:type="dxa"/>
              <w:tcBorders>
                <w:bottom w:val="nil"/>
              </w:tcBorders>
            </w:tcPr>
            <w:p/>
          </w:tc>
        </w:tr>
        <!--w:tr>
          <w:tblPrEx>
            <w:tblCellMar>
              <w:top w:w="0" w:type="dxa"/>
              <w:bottom w:w="0" w:type="dxa"/>
            </w:tblCellMar>
          </w:tblPrEx>
          <w:trPr>
            <w:cantSplit/>
          </w:trPr>
          <w:tc>
            <w:tcPr>
              <w:tcW w:w="2268" w:type="dxa"/>
              <w:vmerge/>
            </w:tcPr>
            <w:p/>
          </w:tc>
          <w:tc>
            <w:tcPr>
              <w:tcW w:w="6911" w:type="dxa"/>
              <w:tcBorders>
                <w:top w:val="nil"/>
              </w:tcBorders>
            </w:tcPr>
            <w:p>
              <w:pPr>
                <w:pStyle w:val="Normalsingle"/>
                <w:tabs>
                  <w:tab w:val="left" w:pos="5987"/>
                </w:tabs>
                <w:spacing w:before="120" w:after="120"/>
              </w:pPr>
              <w:r>
                <w:t>
                  <xsl:value-of select="$DEPUTY"/>
                </w:t>
              </w:r>
              <w:r>
                <w:br w:type="text-wrapping" w:clear="all"/>
                <w:t>
                  <xsl:text>Deputy Director</xsl:text>
                </w:t>
              </w:r>
              <w:r>
                <w:tab/>
                <w:t>
                  <xsl:text>Date</xsl:text>
                </w:t>
              </w:r>
            </w:p>
          </w:tc>
        </w:tr-->
      </w:tbl>
      <w:p/>
      <w:tbl>
        <w:tblPr>
          <w:tblW w:w="0" w:type="auto"/>
          <w:tblInd w:w="108" w:type="dxa"/>
          <w:tblBorders>
            <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            <w:left w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            <w:right w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            <w:insideH w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            <w:insideV w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          </w:tblBorders>
        </w:tblPr>
        <w:tblGrid>
          <w:gridCol w:w="2268"/>
          <w:gridCol w:w="6911"/>
        </w:tblGrid>
        <w:tr>
          <w:tblPrEx>
            <w:tblCellMar>
              <w:top w:w="0" w:type="dxa"/>
              <w:bottom w:w="0" w:type="dxa"/>
            </w:tblCellMar>
          </w:tblPrEx>
          <w:trPr>
            <w:cantSplit/>
          </w:trPr>
          <w:tc>
            <w:tcPr>
              <w:tcW w:w="2268" w:type="dxa"/>
              <w:vmerge w:val="restart"/>
            </w:tcPr>
            <w:p>
              <w:r>
                <w:t>
                  <xsl:text>Approved for submission to the Board</xsl:text>
                </w:t>
              </w:r>
            </w:p>
          </w:tc>
          <w:tc>
            <w:tcPr>
              <w:tcW w:w="6911" w:type="dxa"/>
              <w:tcBorders>
                <w:bottom w:val="nil"/>
              </w:tcBorders>
            </w:tcPr>
            <w:p/>
          </w:tc>
        </w:tr>
        <w:tr>
          <w:tblPrEx>
            <w:tblCellMar>
              <w:top w:w="0" w:type="dxa"/>
              <w:bottom w:w="0" w:type="dxa"/>
            </w:tblCellMar>
          </w:tblPrEx>
          <w:trPr>
            <w:cantSplit/>
          </w:trPr>
          <w:tc>
            <w:tcPr>
              <w:tcW w:w="2268" w:type="dxa"/>
              <w:vmerge/>
            </w:tcPr>
            <w:p/>
          </w:tc>
          <w:tc>
            <w:tcPr>
              <w:tcW w:w="6911" w:type="dxa"/>
              <w:tcBorders>
                <w:top w:val="nil"/>
              </w:tcBorders>
            </w:tcPr>
            <w:p>
              <w:pPr>
                <w:pStyle w:val="Normalsingle"/>
                <w:tabs>
                  <w:tab w:val="left" w:pos="5987"/>
                </w:tabs>
                <w:spacing w:before="120" w:after="120"/>
              </w:pPr>
              <w:r>
                <w:t>
                  <xsl:value-of select="$DIRECTOR"/>
                </w:t>
              </w:r>
              <w:r>
                <w:br w:type="text-wrapping" w:clear="all"/>
              </w:r>
              <w:r>
                <w:t>
                  <xsl:text>Director</xsl:text>
                </w:t>
              </w:r>
              <w:r>
                <w:tab/>
                <w:t>
                  <xsl:text>Date</xsl:text>
                </w:t>
              </w:r>
            </w:p>
          </w:tc>
        </w:tr>
      </w:tbl>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Heading2"/>
        <w:tabs>
          <w:tab w:val="left" w:pos="1985"/>
        </w:tabs>
        <w:ind w:left="0" w:first-line="0"/>
      </w:pPr>
      <w:r>
        <w:t>
          <xsl:text>Board approval</xsl:text>
        </w:t>
      </w:r>
    </w:p>
    <w:tbl>
      <w:tblPr>
        <w:tblW w:w="0" w:type="auto"/>
        <w:tblInd w:w="108" w:type="dxa"/>
        <w:tblBorders>
          <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:left w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:right w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:insideH w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:insideV w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
        </w:tblBorders>
      </w:tblPr>
      <w:tblGrid>
        <w:gridCol w:w="2268"/>
        <w:gridCol w:w="6911"/>
      </w:tblGrid>
      <w:tr>
        <w:tblPrEx>
          <w:tblCellMar>
            <w:top w:w="0" w:type="dxa"/>
            <w:bottom w:w="0" w:type="dxa"/>
          </w:tblCellMar>
        </w:tblPrEx>
        <w:trPr>
          <w:cantSplit/>
        </w:trPr>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="2268" w:type="dxa"/>
            <w:vmerge w:val="restart"/>
          </w:tcPr>
          <w:p>
            <w:r>
              <w:t>
                <xsl:text>Approved by Board</xsl:text>
              </w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="6911" w:type="dxa"/>
            <w:tcBorders>
              <w:bottom w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p/>
        </w:tc>
      </w:tr>
      <w:tr>
        <w:tblPrEx>
          <w:tblCellMar>
            <w:top w:w="0" w:type="dxa"/>
            <w:bottom w:w="0" w:type="dxa"/>
          </w:tblCellMar>
        </w:tblPrEx>
        <w:trPr>
          <w:cantSplit/>
        </w:trPr>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="2268" w:type="dxa"/>
            <w:vmerge/>
          </w:tcPr>
          <w:p/>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="6911" w:type="dxa"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:pStyle w:val="Normalsingle"/>
              <w:tabs>
                <w:tab w:val="left" w:pos="5987"/>
              </w:tabs>
              <w:spacing w:before="120" w:after="120"/>
            </w:pPr>
            <w:r>
              <w:t>
                <xsl:value-of select="$CHAIR"/>
              </w:t>
            </w:r>
            <w:r>
              <w:br w:type="text-wrapping" w:clear="all"/>
              <w:t>
                <xsl:text>Chairperson</xsl:text>
              </w:t>
            </w:r>
            <w:r>
              <w:tab/>
              <w:t>
                <xsl:text>Date</xsl:text>
              </w:t>
            </w:r>
          </w:p>
        </w:tc>
      </w:tr>
    </w:tbl>
  </xsl:template>
  <xsl:template match="rda:Context">
    <xsl:if test="preceding-sibling::rda:Context[@type='appraisal report']">
      <w:p/>
    </xsl:if>
    <w:tbl>
      <w:tblPr>
        <w:tblW w:w="0" w:type="auto"/>
        <w:tblInd w:w="108" w:type="dxa"/>
        <w:tblBorders>
          <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:left w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:right w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:insideH w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:insideV w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
        </w:tblBorders>
      </w:tblPr>
      <w:tblGrid>
        <w:gridCol w:w="2268"/>
        <w:gridCol w:w="6911"/>
      </w:tblGrid>
      <w:tr>
        <w:tblPrEx>
          <w:tblCellMar>
            <w:top w:w="0" w:type="dxa"/>
            <w:bottom w:w="0" w:type="dxa"/>
          </w:tblCellMar>
        </w:tblPrEx>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="2268" w:type="dxa"/>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:pStyle w:val="Heading3"/>
            </w:pPr>
            <w:r>
              <w:t>
                <xsl:value-of select="rda:ContextTitle"/>
              </w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="6911" w:type="dxa"/>
          </w:tcPr>
          <xsl:if test="not(rda:ContextContent)">
          <w:p/>
          </xsl:if>
          <xsl:for-each select="rda:ContextContent">
            <xsl:apply-templates select="rda:Paragraph"/>
            <!--xsl:if test="rda:Source">
              <w:p>
                <w:pPr>
                  <w:rPr>
                    <w:i/>
                  </w:rPr>
                </w:pPr>
                <w:r>
                  <w:rPr>
                    <w:i/>
                  </w:rPr>
                  <w:t>
                    <xsl:text>Sources used: </xsl:text>
                  </w:t>
                </w:r>
                <w:r>
                  <w:br/>
                </w:r>
                <xsl:for-each select="rda:Source">
                  <xsl:if test="position() &gt;1">
                    <xsl:choose>
                      <xsl:when test="position()=last()">
                        <w:r>
                          <w:t>
                            <xsl:text> and </xsl:text>
                          </w:t>
                        </w:r>
                      </xsl:when>
                      <xsl:otherwise>
                        <w:r>
                          <w:t>
                            <xsl:text>, </xsl:text>
                          </w:t>
                        </w:r>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:if>
                  <xsl:choose>
                    <xsl:when test="@url">
                      <xsl:choose>
                        <xsl:when test="(contains(@url,'http://'))">
                          <w:hlink w:dest="{@url}">
                            <w:r>
                              <w:rPr>
                                <w:rStyle w:val="Hyperlink"/>
                                <w:i/>
                              </w:rPr>
                              <xsl:apply-templates/>
                            </w:r>
                          </w:hlink>
                        </xsl:when>
                        <xsl:otherwise>
                          <w:hlink w:dest="http://{@url}">
                            <w:r>
                              <w:rPr>
                                <w:rStyle w:val="Hyperlink"/>
                                <w:i/>
                              </w:rPr>
                              <xsl:apply-templates/>
                            </w:r>
                          </w:hlink>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                      <w:r>
                        <w:rPr>
                          <w:i/>
                        </w:rPr>
                        <xsl:apply-templates/>
                      </w:r>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:for-each>
              </w:p>
            </xsl:if-->
          </xsl:for-each>
        </w:tc>
      </w:tr>
    </w:tbl>
  </xsl:template>
</xsl:stylesheet>
