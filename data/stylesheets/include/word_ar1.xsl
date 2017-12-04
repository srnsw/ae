<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template name="word_ar1">
    <w:p>
      <w:pPr>
        <w:pStyle w:val="ARTitle"/>
      </w:pPr>
      <w:r>
        <w:t>
          <xsl:text>Board of the State Archives and Records Authority of NSW</xsl:text>
        </w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="ARH1"/>
      </w:pPr>
      <w:r>
        <w:t>
          <xsl:text>Submission</xsl:text>
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
    <xsl:apply-templates select="rda:Context[@type='appraisal report']"/>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="ARH1"/>
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
          <xsl:text>It is recommended that the Board approve the retention and disposal practices outlined in the attached authority.</xsl:text>
        </w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Heading2"/>
        <w:tabs>
          <w:tab w:pos="1985" w:val="left"/>
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
          <w:tblW w:type="auto" w:w="0"/>
          <w:tblInd w:type="dxa" w:w="108"/>
          <w:tblLook w:val="01E0"/>
        </w:tblPr>
        <w:tblGrid>
          <w:gridCol w:w="2268"/>
          <w:gridCol w:w="6911"/>
        </w:tblGrid>
        <w:tr>
          <w:tc>
            <w:tcPr>
              <w:tcW w:type="dxa" w:w="2268"/>
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
              <w:tcW w:type="dxa" w:w="6911"/>
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
        <w:tblW w:type="auto" w:w="0"/>
        <w:tblInd w:type="dxa" w:w="108"/>
        <w:tblBorders>
          <w:top w:color="auto" w:space="0" w:sz="4" w:val="single" wx:bdrwidth="10"/>
          <w:left w:color="auto" w:space="0" w:sz="4" w:val="single" wx:bdrwidth="10"/>
          <w:bottom w:color="auto" w:space="0" w:sz="4" w:val="single" wx:bdrwidth="10"/>
          <w:right w:color="auto" w:space="0" w:sz="4" w:val="single" wx:bdrwidth="10"/>
          <w:insideH w:color="auto" w:space="0" w:sz="4" w:val="single" wx:bdrwidth="10"/>
          <w:insideV w:color="auto" w:space="0" w:sz="4" w:val="single" wx:bdrwidth="10"/>
        </w:tblBorders>
      </w:tblPr>
      <w:tblGrid>
        <w:gridCol w:w="2268"/>
        <w:gridCol w:w="6911"/>
      </w:tblGrid>
      <w:tr>
        <w:tblPrEx>
          <w:tblCellMar>
            <w:top w:type="dxa" w:w="0"/>
            <w:bottom w:type="dxa" w:w="0"/>
          </w:tblCellMar>
        </w:tblPrEx>
        <w:trPr>
          <w:cantSplit/>
        </w:trPr>
        <w:tc>
          <w:tcPr>
            <w:tcW w:type="dxa" w:w="2268"/>
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
            <w:tcW w:type="dxa" w:w="6911"/>
            <w:tcBorders>
              <w:bottom w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p/>
        </w:tc>
      </w:tr>
      <!--w:tr><w:tblPrEx><w:tblCellMar><w:top w:w="0" w:type="dxa"/><w:bottom w:w="0" w:type="dxa"/></w:tblCellMar></w:tblPrEx><w:trPr><w:cantSplit/></w:trPr><w:tc><w:tcPr><w:tcW w:w="2268" w:type="dxa"/><w:vmerge/></w:tcPr><w:p/></w:tc><w:tc><w:tcPr><w:tcW w:w="6911" w:type="dxa"/><w:tcBorders><w:top w:val="nil"/></w:tcBorders></w:tcPr><w:p><w:pPr><w:pStyle w:val="Normalsingle"/><w:tabs><w:tab w:val="left" w:pos="5987"/></w:tabs><w:spacing w:before="120" w:after="120"/></w:pPr><w:r><w:t><xsl:value-of select="$DEPUTY"/></w:t></w:r><w:r><w:br w:type="text-wrapping" w:clear="all"/><w:t><xsl:text>Deputy Director</xsl:text></w:t></w:r><w:r><w:tab/><w:t><xsl:text>Date</xsl:text></w:t></w:r></w:p></w:tc></w:tr-->
    </w:tbl>
    <w:p/>
    <w:tbl>
      <w:tblPr>
        <w:tblW w:type="auto" w:w="0"/>
        <w:tblInd w:type="dxa" w:w="108"/>
        <w:tblBorders>
          <w:top w:color="auto" w:space="0" w:sz="4" w:val="single" wx:bdrwidth="10"/>
          <w:left w:color="auto" w:space="0" w:sz="4" w:val="single" wx:bdrwidth="10"/>
          <w:bottom w:color="auto" w:space="0" w:sz="4" w:val="single" wx:bdrwidth="10"/>
          <w:right w:color="auto" w:space="0" w:sz="4" w:val="single" wx:bdrwidth="10"/>
          <w:insideH w:color="auto" w:space="0" w:sz="4" w:val="single" wx:bdrwidth="10"/>
          <w:insideV w:color="auto" w:space="0" w:sz="4" w:val="single" wx:bdrwidth="10"/>
        </w:tblBorders>
      </w:tblPr>
      <w:tblGrid>
        <w:gridCol w:w="2268"/>
        <w:gridCol w:w="6911"/>
      </w:tblGrid>
      <w:tr>
        <w:tblPrEx>
          <w:tblCellMar>
            <w:top w:type="dxa" w:w="0"/>
            <w:bottom w:type="dxa" w:w="0"/>
          </w:tblCellMar>
        </w:tblPrEx>
        <w:trPr>
          <w:cantSplit/>
        </w:trPr>
        <w:tc>
          <w:tcPr>
            <w:tcW w:type="dxa" w:w="2268"/>
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
            <w:tcW w:type="dxa" w:w="6911"/>
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
            <w:top w:type="dxa" w:w="0"/>
            <w:bottom w:type="dxa" w:w="0"/>
          </w:tblCellMar>
        </w:tblPrEx>
        <w:trPr>
          <w:cantSplit/>
        </w:trPr>
        <w:tc>
          <w:tcPr>
            <w:tcW w:type="dxa" w:w="2268"/>
            <w:vmerge/>
          </w:tcPr>
          <w:p/>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:type="dxa" w:w="6911"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:pStyle w:val="Normalsingle"/>
              <w:tabs>
                <w:tab w:pos="5987" w:val="left"/>
              </w:tabs>
              <w:spacing w:after="120" w:before="120"/>
            </w:pPr>
            <w:r>
              <w:t>
                <xsl:value-of select="$DIRECTOR"/>
              </w:t>
            </w:r>
            <w:r>
              <w:br w:clear="all" w:type="text-wrapping"/>
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
          <w:tab w:pos="1985" w:val="left"/>
        </w:tabs>
        <w:ind w:first-line="0" w:left="0"/>
      </w:pPr>
      <w:r>
        <w:t>
          <xsl:text>Board approval</xsl:text>
        </w:t>
      </w:r>
    </w:p>
    <w:tbl>
      <w:tblPr>
        <w:tblW w:type="auto" w:w="0"/>
        <w:tblInd w:type="dxa" w:w="108"/>
        <w:tblBorders>
          <w:top w:color="auto" w:space="0" w:sz="4" w:val="single" wx:bdrwidth="10"/>
          <w:left w:color="auto" w:space="0" w:sz="4" w:val="single" wx:bdrwidth="10"/>
          <w:bottom w:color="auto" w:space="0" w:sz="4" w:val="single" wx:bdrwidth="10"/>
          <w:right w:color="auto" w:space="0" w:sz="4" w:val="single" wx:bdrwidth="10"/>
          <w:insideH w:color="auto" w:space="0" w:sz="4" w:val="single" wx:bdrwidth="10"/>
          <w:insideV w:color="auto" w:space="0" w:sz="4" w:val="single" wx:bdrwidth="10"/>
        </w:tblBorders>
      </w:tblPr>
      <w:tblGrid>
        <w:gridCol w:w="2268"/>
        <w:gridCol w:w="6911"/>
      </w:tblGrid>
      <w:tr>
        <w:tblPrEx>
          <w:tblCellMar>
            <w:top w:type="dxa" w:w="0"/>
            <w:bottom w:type="dxa" w:w="0"/>
          </w:tblCellMar>
        </w:tblPrEx>
        <w:trPr>
          <w:cantSplit/>
        </w:trPr>
        <w:tc>
          <w:tcPr>
            <w:tcW w:type="dxa" w:w="2268"/>
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
            <w:tcW w:type="dxa" w:w="6911"/>
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
            <w:top w:type="dxa" w:w="0"/>
            <w:bottom w:type="dxa" w:w="0"/>
          </w:tblCellMar>
        </w:tblPrEx>
        <w:trPr>
          <w:cantSplit/>
        </w:trPr>
        <w:tc>
          <w:tcPr>
            <w:tcW w:type="dxa" w:w="2268"/>
            <w:vmerge/>
          </w:tcPr>
          <w:p/>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:type="dxa" w:w="6911"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:pStyle w:val="Normalsingle"/>
              <w:tabs>
                <w:tab w:pos="5987" w:val="left"/>
              </w:tabs>
              <w:spacing w:after="120" w:before="120"/>
            </w:pPr>
            <w:r>
              <w:t>
                <xsl:value-of select="$CHAIR"/>
              </w:t>
            </w:r>
            <w:r>
              <w:br w:clear="all" w:type="text-wrapping"/>
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
    <w:p>
      <w:pPr>
        <w:pStyle w:val="ARH1"/>
      </w:pPr>
      <w:r>
        <w:t>
          <xsl:value-of select="rda:ContextTitle"/>
        </w:t>
      </w:r>
    </w:p>
    <xsl:if test="not(rda:ContextContent)">
      <w:p/>
    </xsl:if>
    <xsl:for-each select="rda:ContextContent">
      <xsl:apply-templates select="rda:Paragraph"/>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>