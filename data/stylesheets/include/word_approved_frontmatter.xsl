<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" version="1.0">
  <xsl:template name="frontmatter_one">
    <wx:sect>
      <w:p>
        <w:pPr>
          <w:jc w:val="center"/>
          <w:rPr>
            <w:b/>
            <w:sz w:val="32"/>
            <w:sz-cs w:val="32"/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
            <w:sz w:val="32"/>
            <w:sz-cs w:val="32"/>
          </w:rPr>
          <w:br/>
        </w:r>
        <w:r>
          <w:rPr>
            <w:b/>
            <w:sz w:val="32"/>
            <w:sz-cs w:val="32"/>
          </w:rPr>
          <w:t>
            <xsl:value-of select="$ORG_FULL"/>
          </w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:jc w:val="center"/>
          <w:rPr>
            <w:sz w:val="32"/>
            <w:sz-cs w:val="32"/>
          </w:rPr>
        </w:pPr>
      </w:p>
      <w:p>
        <w:pPr>
          <w:jc w:val="center"/>
          <w:rPr>
            <w:sz w:val="32"/>
            <w:sz-cs w:val="32"/>
          </w:rPr>
        </w:pPr>
      </w:p>
      <w:p>
        <w:pPr>
          <w:jc w:val="center"/>
          <w:rPr>
            <w:sz w:val="32"/>
            <w:sz-cs w:val="32"/>
          </w:rPr>
        </w:pPr>
      </w:p>
      <w:tbl>
        <w:tblPr>
          <w:tblW w:w="5000" w:type="pct"/>
          <w:tblBorders>
            <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            <w:left w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            <w:right w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            <w:insideH w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            <w:insideV w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          </w:tblBorders>
          <w:tblCellMar>
            <w:left w:w="56" w:type="dxa"/>
            <w:right w:w="56" w:type="dxa"/>
          </w:tblCellMar>
        </w:tblPr>
        <w:tblGrid>
          <w:gridCol w:w="48" w:type="pct"/>
          <w:gridCol w:w="4903" w:type="pct"/>
          <w:gridCol w:w="48" w:type="pct"/>
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
              <w:tcW w:w="48" w:type="pct"/>
              <w:tcBorders>
                <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
                <w:left w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
                <w:bottom w:val="nil"/>
                <w:right w:val="nil"/>
              </w:tcBorders>
            </w:tcPr>
            <w:p>
              <w:pPr>
                <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
              </w:pPr>
            </w:p>
          </w:tc>
          <w:tc>
            <w:tcPr>
              <w:tcW w:w="4903" w:type="pct"/>
              <w:tcBorders>
                <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
                <w:left w:val="nil"/>
                <w:bottom w:val="nil"/>
                <w:right w:val="nil"/>
              </w:tcBorders>
            </w:tcPr>
            <w:p>
              <w:pPr>
                <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
                <w:ind w:left="142"/>
              </w:pPr>
            </w:p>
          </w:tc>
          <w:tc>
            <w:tcPr>
              <w:tcW w:w="48" w:type="pct"/>
              <w:tcBorders>
                <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
                <w:left w:val="nil"/>
                <w:bottom w:val="nil"/>
                <w:right w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              </w:tcBorders>
            </w:tcPr>
            <w:p>
              <w:pPr>
                <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
              </w:pPr>
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
          <w:trPr>
            <w:cantSplit/>
          </w:trPr>
          <w:tc>
            <w:tcPr>
              <w:tcW w:w="48" w:type="pct"/>
              <w:tcBorders>
                <w:top w:val="nil"/>
                <w:bottom w:val="nil"/>
                <w:right w:val="nil"/>
              </w:tcBorders>
            </w:tcPr>
            <w:p>
              <w:pPr>
                <w:rPr>
                  <w:sz w:val="24"/>
                </w:rPr>
              </w:pPr>
            </w:p>
          </w:tc>
          <w:tc>
            <w:tcPr>
              <w:tcW w:w="4903" w:type="pct"/>
              <w:tcBorders>
                <w:top w:val="nil"/>
                <w:left w:val="nil"/>
                <w:bottom w:val="nil"/>
                <w:right w:val="nil"/>
              </w:tcBorders>
              <w:shd w:val="pct-5" w:color="auto" w:fill="FFFFFF" wx:bgcolor="F2F2F2"/>
            </w:tcPr>
            <w:p>
              <w:pPr>
                <w:pStyle w:val="ChapterHeading"/>
                <w:pBdr>
                  <w:bottom w:val="none" w:sz="0" wx:bdrwidth="0" w:space="0" w:color="auto"/>
                </w:pBdr>
                <w:ind w:left="0" w:first-line="0"/>
                <w:jc w:val="center"/>
                <w:rPr>
                  <w:sz w:val="20"/>
                </w:rPr>
              </w:pPr>
            </w:p>
            <w:p>
              <w:pPr>
                <w:pStyle w:val="ChapterHeading"/>
                <w:pBdr>
                  <w:bottom w:val="none" w:sz="0" wx:bdrwidth="0" w:space="0" w:color="auto"/>
                </w:pBdr>
                <w:ind w:left="0" w:first-line="0"/>
                <w:jc w:val="center"/>
              </w:pPr>
              <w:r>
                <w:t>
                  <xsl:value-of select="$AUTHORITY_TYPE"/>
                  <xsl:text>: </xsl:text>
                  <xsl:value-of select="$RDANO"/>
                </w:t>
              </w:r>
            </w:p>
            <w:p>
              <w:pPr>
                <w:ind w:left="142"/>
                <w:jc w:val="center"/>
                <w:rPr>
                  <w:b-cs/>
                  <w:sz w:val="28"/>
                  <w:sz-cs w:val="28"/>
                </w:rPr>
              </w:pPr>
              <w:r>
                <w:rPr>
                  <w:b-cs/>
                  <w:sz w:val="28"/>
                  <w:sz-cs w:val="28"/>
                </w:rPr>
                <w:t>
                  <xsl:if test="rda:Scope">
                    <xsl:text>This authority covers records documenting the function of </xsl:text>
                    <xsl:value-of select="rda:Scope"/>
                  </xsl:if>
                </w:t>
              </w:r>
            </w:p>
            <w:p>
              <w:pPr>
                <w:ind w:left="142"/>
                <w:jc w:val="center"/>
                <w:rPr>
                  <w:sz w:val="28"/>
                  <w:sz-cs w:val="28"/>
                </w:rPr>
              </w:pPr>
              <w:r>
                <w:rPr>
                  <w:sz w:val="28"/>
                  <w:sz-cs w:val="28"/>
                </w:rPr>
                <w:t>
                <xsl:if test="string($AGENCY_NAMES)">
                  <xsl:text>Issued to </xsl:text>
                  <xsl:value-of select="$AGENCY_NAMES"/>
                  </xsl:if>
                </w:t>
              </w:r>
            </w:p>
           </w:tc>
          <w:tc>
            <w:tcPr>
              <w:tcW w:w="48" w:type="pct"/>
              <w:tcBorders>
                <w:top w:val="nil"/>
                <w:left w:val="nil"/>
                <w:bottom w:val="nil"/>
              </w:tcBorders>
            </w:tcPr>
            <w:p>
              <w:pPr>
                <w:rPr>
                  <w:sz w:val="24"/>
                </w:rPr>
              </w:pPr>
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
          <w:trPr>
            <w:cantSplit/>
          </w:trPr>
          <w:tc>
            <w:tcPr>
              <w:tcW w:w="48" w:type="pct"/>
              <w:tcBorders>
                <w:top w:val="nil"/>
                <w:left w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
                <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
                <w:right w:val="nil"/>
              </w:tcBorders>
            </w:tcPr>
            <w:p>
              <w:pPr>
                <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
              </w:pPr>
            </w:p>
          </w:tc>
          <w:tc>
            <w:tcPr>
              <w:tcW w:w="4903" w:type="pct"/>
              <w:tcBorders>
                <w:top w:val="nil"/>
                <w:left w:val="nil"/>
                <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
                <w:right w:val="nil"/>
              </w:tcBorders>
            </w:tcPr>
            <w:p>
              <w:pPr>
                <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
                <w:ind w:left="142"/>
              </w:pPr>
            </w:p>
          </w:tc>
          <w:tc>
            <w:tcPr>
              <w:tcW w:w="48" w:type="pct"/>
              <w:tcBorders>
                <w:top w:val="nil"/>
                <w:left w:val="nil"/>
                <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
                <w:right w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              </w:tcBorders>
            </w:tcPr>
            <w:p>
              <w:pPr>
                <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
              </w:pPr>
            </w:p>
          </w:tc>
        </w:tr>
      </w:tbl>
      <w:p/>
      <w:p>
        <w:pPr>
          <w:pBdr>
            <w:bottom w:val="none" w:sz="0" wx:bdrwidth="0" w:space="0" w:color="auto"/>
          </w:pBdr>
          <w:ind w:left="0" w:first-line="0"/>
          <w:rPr>
            <w:b w:val="off"/>
            <w:sz w:val="28"/>
            <w:sz-cs w:val="28"/>
          </w:rPr>
        </w:pPr>
      </w:p>
      <w:p>
        <w:pPr>
          <w:pStyle w:val="ChapterHeading"/>
          <w:pBdr>
            <w:bottom w:val="none" w:sz="0" wx:bdrwidth="0" w:space="0" w:color="auto"/>
          </w:pBdr>
          <w:ind w:left="0" w:first-line="0"/>
          <w:rPr>
            <w:b w:val="off"/>
            <w:sz w:val="28"/>
            <w:sz-cs w:val="28"/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
            <w:b w:val="off"/>
            <w:sz w:val="28"/>
            <w:sz-cs w:val="28"/>
          </w:rPr>
          <w:t>
            <xsl:text>This </xsl:text>
            <xsl:value-of select="$AUTHORITY_TYPE_LC"/>
            <xsl:text> is approved under section 21(2)c of the</xsl:text>
          </w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:b w:val="off"/>
            <w:sz w:val="28"/>
            <w:sz-cs w:val="28"/>
            <w:i/>
          </w:rPr>
          <w:t>
            <xsl:text xml:space="preserve"> State Records Act 1998 </xsl:text>
          </w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:b w:val="off"/>
            <w:sz w:val="28"/>
            <w:sz-cs w:val="28"/>
          </w:rPr>
          <w:t>
            <xsl:text>following prior approval by the Board of the State Archives and Records Authority of New South Wales in accordance with section 21(3) of the Act.</xsl:text>
          </w:t>
          <w:br w:type="page" />
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:sectPr>
            <w:hdr w:type="odd">
              <w:p>
                <w:pPr>
                  <w:pStyle w:val="Header"/>
                  <w:pBdr>
                    <w:bottom w:val="none" w:sz="0" wx:bdrwidth="0" w:space="0" w:color="auto"/>
                  </w:pBdr>
                </w:pPr>
              </w:p>
            </w:hdr>
            <w:ftr w:type="odd">
              <w:p>
                <w:pPr>
                  <w:pStyle w:val="Footer"/>
                  <w:pBdr>
                    <w:top w:val="none" w:sz="0" wx:bdrwidth="0" w:space="0" w:color="auto"/>
                  </w:pBdr>
                </w:pPr>
                <w:r>
                  <w:rPr>
                    <w:sz w:val="16"/>
                    <w:sz-cs w:val="16"/>
                  </w:rPr>
                  <w:t>
                    <xsl:text>© State of New South Wales through the State Archives and Records Authority of New South Wales </xsl:text>
                    <xsl:value-of select="$ISSUE_YEAR"/>
                    <xsl:text>. This work may be freely reproduced for personal, educational or government purposes. Permission must be received from State Archives and Records Authority for all other uses.</xsl:text>
                  </w:t>
                </w:r>
              </w:p>
              <xsl:if test="$AUTHORITY_TYPE='General Retention and Disposal Authority'">
              <w:p>
                <w:pPr>
                  <w:pStyle w:val="Footer"/>
                  <w:pBdr>
                    <w:top w:val="none" w:sz="0" wx:bdrwidth="0" w:space="0" w:color="auto"/>
                  </w:pBdr>
                </w:pPr>
                <w:r>
                  <w:rPr>
                    <w:sz w:val="16"/>
                    <w:sz-cs w:val="16"/>
                  </w:rPr>
                  <w:t>
                    <xsl:text>ISBN XXXXXXXXX</xsl:text>
                  </w:t>
                </w:r>
              </w:p>
              </xsl:if>
            </w:ftr>
            <w:hdr w:type="first">
              <w:p>
                <w:pPr>
                  <w:pStyle w:val="Header"/>
                  <w:pBdr>
                    <w:bottom w:val="none" w:sz="0" wx:bdrwidth="0" w:space="0" w:color="auto"/>
                  </w:pBdr>
                </w:pPr>
              </w:p>
            </w:hdr>
            <w:ftr w:type="first">
              <w:p>
                <w:pPr>
                  <w:pStyle w:val="Footer"/>
                  <w:pBdr>
                    <w:top w:val="none" w:sz="0" wx:bdrwidth="0" w:space="0" w:color="auto"/>
                  </w:pBdr>
                </w:pPr>
              </w:p>
            </w:ftr>
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
            <w:pgNumType w:start="1"/>
            <w:cols w:space="720"/>
            <w:titlePg/>
          </w:sectPr>
        </w:pPr>
        <w:r>
          <w:t xml:space="preserve"> </w:t>
        </w:r>
      </w:p>  
    </wx:sect>
  </xsl:template>
  <xsl:template name="frontmatter_two">
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Title"/>
      </w:pPr>
      <w:r>
        <w:t>
          <xsl:text >State Archives and Records Authority of New South Wales</xsl:text>
        </w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Title"/>
      </w:pPr>
      <w:r>
        <w:t>
          <xsl:value-of select="$AUTHORITY_TYPE"/>
        </w:t>
      </w:r>
    </w:p>
    <w:p/>
    <w:tbl>
      <w:tblPr>
        <w:tblW w:w="5000" w:type="pct"/>
        <w:tblBorders>
          <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:left w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:right w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:insideH w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:insideV w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
        </w:tblBorders>
        <w:tblCellMar>
          <w:left w:w="56" w:type="dxa"/>
          <w:right w:w="56" w:type="dxa"/>
        </w:tblCellMar>
      </w:tblPr>
      <w:tblGrid>
        <w:gridCol w:w="72" w:type="pct"/>
        <w:gridCol w:w="864" w:type="pct"/>
        <w:gridCol w:w="695" w:type="pct"/>
        <w:gridCol w:w="1158" w:type="pct"/>
        <w:gridCol w:w="77" w:type="pct"/>
        <w:gridCol w:w="947" w:type="pct"/>
        <w:gridCol w:w="709" w:type="pct"/>
        <w:gridCol w:w="72" w:type="pct"/>
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
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:left w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="864" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="695" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="1158" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="77" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:left w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="947" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="709" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
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
        <w:trPr>
          <w:cantSplit/>
        </w:trPr>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:rPr>
                <w:b/>
                <w:b-cs/>
                <w:sz w:val="28"/>
              </w:rPr>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="864" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
            <w:shd w:val="pct-5" w:color="auto" w:fill="FFFFFF" wx:bgcolor="F2F2F2"/>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:ind w:left="142"/>
              <w:rPr>
                <w:b/>
                <w:b-cs/>
                <w:sz w:val="24"/>
              </w:rPr>
            </w:pPr>
            <w:r>
              <w:rPr>
                <w:b/>
                <w:b-cs/>
                <w:sz w:val="24"/>
              </w:rPr>
              <w:t>
                <xsl:text>Authority no</xsl:text>
              </w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="695" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:rPr>
                <w:b/>
                <w:b-cs/>
                <w:sz w:val="24"/>
              </w:rPr>
            </w:pPr>
            <w:r>
              <w:rPr>
                <w:b/>
                <w:b-cs/>
                <w:sz w:val="24"/>
              </w:rPr>
              <w:t>
                <xsl:value-of select="$RDANO"/>
              </w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="1158" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:rPr>
                <w:b/>
                <w:b-cs/>
                <w:sz w:val="28"/>
              </w:rPr>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="77" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:rPr>
                <w:b/>
                <w:b-cs/>
                <w:sz w:val="28"/>
              </w:rPr>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="947" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
            <w:shd w:val="pct-5" w:color="auto" w:fill="FFFFFF" wx:bgcolor="F2F2F2"/>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:ind w:left="142"/>
              <w:rPr>
                <w:b/>
                <w:b-cs/>
                <w:sz w:val="24"/>
              </w:rPr>
            </w:pPr>
            <w:r>
              <w:rPr>
                <w:b/>
                <w:b-cs/>
                <w:sz w:val="24"/>
              </w:rPr>
              <w:t>
                <xsl:text>SR file no</xsl:text>
              </w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="709" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:rPr>
                <w:b/>
                <w:b-cs/>
                <w:sz w:val="24"/>
              </w:rPr>
            </w:pPr>
            <w:r>
              <w:rPr>
                <w:b/>
                <w:b-cs/>
                <w:sz w:val="24"/>
              </w:rPr>
              <w:t>
                <xsl:value-of select="$SRFILENOS"/>
              </w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:rPr>
                <w:b/>
                <w:b-cs/>
                <w:sz w:val="28"/>
              </w:rPr>
            </w:pPr>
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
        <w:trPr>
          <w:cantSplit/>
        </w:trPr>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="864" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="695" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:right w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="1158" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="77" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="947" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="709" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:right w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
      </w:tr>
    </w:tbl>
    <w:p>
      <w:pPr>
        <w:tabs>
          <w:tab w:val="right" w:pos="9071"/>
        </w:tabs>
      </w:pPr>
    </w:p>
    <w:tbl>
      <w:tblPr>
        <w:tblW w:w="5000" w:type="pct"/>
        <w:tblBorders>
          <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:left w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:right w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:insideH w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:insideV w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
        </w:tblBorders>
        <w:tblLayout w:type="Fixed"/>
        <w:tblCellMar>
          <w:left w:w="56" w:type="dxa"/>
          <w:right w:w="56" w:type="dxa"/>
        </w:tblCellMar>
      </w:tblPr>
      <w:tblGrid>
        <w:gridCol w:w="72" w:type="pct"/>
        <w:gridCol w:w="864" w:type="pct"/>
        <w:gridCol w:w="3585" w:type="pct"/>
        <w:gridCol w:w="72" w:type="pct"/>
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
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:left w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="864" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="3585" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
              <w:ind w:left="142"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
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
        <w:trPr>
          <w:cantSplit/>
        </w:trPr>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:rPr>
                <w:sz w:val="24"/>
              </w:rPr>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="864" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
            <w:shd w:val="pct-5" w:color="auto" w:fill="FFFFFF" wx:bgcolor="F2F2F2"/>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:ind w:left="142"/>
              <w:rPr>
                <w:b/>
                <w:b-cs/>
                <w:sz w:val="24"/>
              </w:rPr>
            </w:pPr>
            <w:r>
              <w:rPr>
                <w:b/>
                <w:b-cs/>
                <w:sz w:val="24"/>
              </w:rPr>
              <w:t>
                <xsl:text>Scope</xsl:text>
              </w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="3585" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:ind w:left="142"/>
              <w:rPr>
                <w:sz w:val="24"/>
              </w:rPr>
            </w:pPr>
            <w:r>
              <w:rPr>
                <w:sz w:val="24"/>
              </w:rPr>
              <w:t><xsl:text>This </xsl:text><xsl:value-of select="$AUTHORITY_TYPE_LC"/><xsl:text> covers records documenting the function of </xsl:text><xsl:value-of select="rda:Scope"/><xsl:value-of select="$DATETEXT"/>.</w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:rPr>
                <w:sz w:val="24"/>
              </w:rPr>
            </w:pPr>
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
        <w:trPr>
          <w:cantSplit/>
        </w:trPr>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="864" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="3585" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
              <w:ind w:left="142"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
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
        <w:trPr>
          <w:cantSplit/>
        </w:trPr>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="60" w:after="60"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="864" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="60" w:after="60"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="3585" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="60" w:after="60"/>
              <w:ind w:left="142"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="60" w:after="60"/>
            </w:pPr>
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
        <w:trPr>
          <w:cantSplit/>
        </w:trPr>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="864" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="3585" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
              <w:ind w:left="142"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
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
        <w:trPr>
          <w:cantSplit/>
        </w:trPr>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:rPr>
                <w:b/>
                <w:b-cs/>
                <w:sz w:val="24"/>
              </w:rPr>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="864" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
            <w:shd w:val="pct-5" w:color="auto" w:fill="FFFFFF" wx:bgcolor="F2F2F2"/>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:ind w:left="142"/>
              <w:rPr>
                <w:b/>
                <w:b-cs/>
                <w:sz w:val="24"/>
              </w:rPr>
            </w:pPr>
            <w:r>
              <w:rPr>
                <w:b/>
                <w:b-cs/>
                <w:sz w:val="24"/>
              </w:rPr>
              <w:t>
                <xsl:text>Public office</xsl:text>
              </w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="3585" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <xsl:choose>
            <xsl:when test="string($AGENCY_NAMES)">
            <w:p>
              <w:pPr>
                <w:ind w:left="142"/>
                <w:rPr>
                  <w:sz w:val="24"/>
                </w:rPr>
              </w:pPr>
              <w:r>
                <w:rPr>
                  <w:sz w:val="24"/>
                </w:rPr>
                <w:t>
                  <xsl:value-of select="$AGENCY_NAMES"/>
                </w:t>
              </w:r>
            </w:p>
            </xsl:when>
            <xsl:when test="rda:Context[@type='appraisal report' and rda:ContextTitle='Public office']">
              <xsl:for-each select="rda:Context[@type='appraisal report' and rda:ContextTitle='Public office']">
                <xsl:if test="not(rda:ContextContent)">
                  <w:p/>
                </xsl:if>
                <xsl:for-each select="rda:ContextContent">
                  <xsl:apply-templates select="rda:Paragraph"/>
                </xsl:for-each>
              </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
              <w:p/>
            </xsl:otherwise>
          </xsl:choose>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:rPr>
                <w:b/>
                <w:b-cs/>
                <w:sz w:val="24"/>
              </w:rPr>
            </w:pPr>
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
        <w:trPr>
          <w:cantSplit/>
        </w:trPr>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="864" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="3585" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
              <w:ind w:left="142"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:right w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
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
        <w:trPr>
          <w:cantSplit/>
        </w:trPr>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="60" w:after="60"/>
              <w:rPr>
                <w:rFonts w:ascii="Times New Roman" w:h-ansi="Times New Roman"/>
                <wx:font wx:val="Times New Roman"/>
                <w:sz w:val="24"/>
              </w:rPr>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="864" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="60" w:after="60"/>
              <w:rPr>
                <w:rFonts w:ascii="Times New Roman" w:h-ansi="Times New Roman"/>
                <wx:font wx:val="Times New Roman"/>
                <w:sz w:val="24"/>
              </w:rPr>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="3585" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="60" w:after="60"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="60" w:after="60"/>
            </w:pPr>
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
        <w:trPr>
          <w:cantSplit/>
        </w:trPr>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="864" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="3585" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
              <w:ind w:left="142"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
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
        <w:trPr>
          <w:cantSplit/>
        </w:trPr>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:after="0"/>
              <w:rPr>
                <w:sz w:val="24"/>
              </w:rPr>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="864" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
            <w:shd w:val="pct-5" w:color="auto" w:fill="FFFFFF" wx:bgcolor="F2F2F2"/>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:ind w:left="142"/>
              <w:rPr>
                <w:b/>
                <w:b-cs/>
                <w:sz w:val="24"/>
              </w:rPr>
            </w:pPr>
            <w:r>
              <w:rPr>
                <w:b/>
                <w:b-cs/>
                <w:sz w:val="24"/>
              </w:rPr>
              <w:t>
                <xsl:text>Approval date</xsl:text>
              </w:t>
            </w:r>
            <w:r>
              <w:rPr>
                <w:b/>
                <w:b-cs/>
                <w:sz w:val="24"/>
              </w:rPr>
              <w:br/>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="3585" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:tabs>
                <w:tab w:val="center" w:pos="5244"/>
              </w:tabs>
              <w:spacing w:after="0"/>
              <w:ind w:left="142"/>
              <w:rPr>
                <w:sz w:val="24"/>
              </w:rPr>
            </w:pPr>
          </w:p>
          <w:p>
            <w:pPr>
              <w:tabs>
                <w:tab w:val="center" w:pos="5244"/>
              </w:tabs>
              <w:spacing w:before="240" w:after="0"/>
              <w:ind w:left="142"/>
              <w:rPr>
                <w:sz w:val="24"/>
              </w:rPr>
            </w:pPr>
            <w:r>
              <w:rPr>
                <w:sz w:val="24"/>
              </w:rPr>
              <w:tab wx:wTab="3960" wx:tlc="none" wx:cTlc="43"/>
              <w:t><xsl:value-of select="$ISSUE_DAY"/>/<xsl:value-of select="$ISSUE_MONTH"/>/<xsl:value-of select="$ISSUE_YEAR"/></w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:after="0"/>
              <w:rPr>
                <w:sz w:val="24"/>
              </w:rPr>
            </w:pPr>
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
        <w:trPr>
          <w:cantSplit/>
        </w:trPr>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0"/>
              <w:rPr>
                <w:sz w:val="24"/>
              </w:rPr>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="864" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
            <w:shd w:val="pct-5" w:color="auto" w:fill="FFFFFF" wx:bgcolor="F2F2F2"/>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0"/>
              <w:rPr>
                <w:sz w:val="24"/>
              </w:rPr>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="3585" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:tabs>
                <w:tab w:val="center" w:pos="5244"/>
              </w:tabs>
              <w:spacing w:before="0"/>
              <w:ind w:left="142"/>
              <w:rPr>
                <w:sz w:val="24"/>
              </w:rPr>
            </w:pPr>
            <w:r>
              <w:rPr>
                <w:sz w:val="24"/>
              </w:rPr>
              <w:t>
                <xsl:value-of select="$DIRECTOR"/>
              </w:t>
            </w:r>
            <w:r>
              <w:rPr>
                <w:sz w:val="24"/>
              </w:rPr>
              <w:tab wx:wTab="3120" wx:tlc="none" wx:cTlc="34"/>
              <w:t>
                <xsl:text>Date</xsl:text>
              </w:t>
            </w:r>
            <w:r>
              <w:rPr>
                <w:sz w:val="24"/>
              </w:rPr>
              <w:br/>
              <w:t>
                <xsl:value-of select="$DIRECTOR_ROLE"/>
              </w:t>
            </w:r>
            <w:r>
              <w:rPr>
                <w:sz w:val="24"/>
              </w:rPr>
              <w:br/>
              <w:t>
                <xsl:value-of select="$ORG_FULL"/>
              </w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0"/>
              <w:rPr>
                <w:sz w:val="24"/>
              </w:rPr>
            </w:pPr>
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
        <w:trPr>
          <w:cantSplit/>
        </w:trPr>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="864" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="3585" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:right w:val="nil"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
              <w:ind w:left="142"/>
            </w:pPr>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="72" w:type="pct"/>
            <w:tcBorders>
              <w:top w:val="nil"/>
              <w:left w:val="nil"/>
              <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
              <w:right w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
            </w:tcBorders>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:before="0" w:after="0" w:line="140" w:line-rule="exact"/>
            </w:pPr>
          </w:p>
        </w:tc>
      </w:tr>
    </w:tbl>
    <w:p/>
  </xsl:template>
</xsl:stylesheet>
