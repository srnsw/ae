<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template name="portrait_header_footer">
    <xsl:param name="header_first" select="''"/>
    <xsl:param name="header_text" select="$header_first"/>
    <xsl:param name="footer_text" select="''"/>
    <xsl:param name="tab" select="''"/>
    <xsl:param name="gaadmin" select="'false'"/>
    <w:hdr w:type="odd">
      <w:p>
        <w:pPr>
          <w:pStyle w:val="Header"/>
        </w:pPr>
        <w:r>
          <w:t>
            <xsl:value-of select="$header_text"/>
          </w:t>
        </w:r>
      </w:p>
    </w:hdr>
    <w:ftr w:type="even">
      <w:p>
        <w:pPr>
          <w:framePr w:hanchor="margin" w:vanchor="text" w:wrap="around" w:x-align="right" w:y="1"/>
        </w:pPr>
        <w:r>
          <w:fldChar w:fldCharType="begin"/>
        </w:r>
        <w:r>
          <w:instrText>PAGE </w:instrText>
        </w:r>
        <w:r>
          <w:fldChar w:fldCharType="end"/>
        </w:r>
      </w:p>
    </w:ftr>
    <w:ftr w:type="odd">
      <xsl:if test="$footer_text != ''">
        <w:p>
          <w:pPr>
            <w:pStyle w:val="Footer"/>
            <w:jc w:val="center"/>
          </w:pPr>
          <w:r>
            <w:t>
              <xsl:value-of select="$footer_text"/>
            </w:t>
          </w:r>
        </w:p>
      </xsl:if>
      <w:p>
        <w:pPr>
          <w:pStyle w:val="Footer"/>
          <xsl:if test="$tab != ''">
            <w:tabs>
              <w:tab w:pos="9072" w:val="clear"/>
              <w:tab w:pos="{$tab}" w:val="right"/>
            </w:tabs>
          </xsl:if>
        </w:pPr>
        <w:r>
          <w:t>State Archives and Records Authority of New South Wales</w:t>
        </w:r>
        <w:r>
          <w:tab wx:cTlc="78" wx:tlc="none" wx:wTab="4740"/>
        </w:r>
        <w:r>
          <w:rPr>
            <w:rStyle w:val="PageNumber"/>
          </w:rPr>
          <w:fldChar w:fldCharType="begin"/>
        </w:r>
        <w:r>
          <w:rPr>
            <w:rStyle w:val="PageNumber"/>
          </w:rPr>
          <w:instrText>PAGE </w:instrText>
        </w:r>
        <w:r>
          <w:rPr>
            <w:rStyle w:val="PageNumber"/>
          </w:rPr>
          <w:fldChar w:fldCharType="separate"/>
        </w:r>
        <w:r>
          <w:rPr>
            <w:rStyle w:val="PageNumber"/>
            <w:noProof/>
          </w:rPr>
          <w:t>2</w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:rStyle w:val="PageNumber"/>
          </w:rPr>
          <w:fldChar w:fldCharType="end"/>
        </w:r>
      </w:p>
    </w:ftr>
    <w:hdr w:type="first">
      <w:p>
        <w:pPr>
          <w:pStyle w:val="InternalHeader"/>
        </w:pPr>
        <w:r>
          <w:t>
            <xsl:value-of select="$header_first"/>
          </w:t>
        </w:r>
      </w:p>
    </w:hdr>
    <w:ftr w:type="first">
      <w:p>
        <w:pPr>
          <w:pStyle w:val="Footer"/>
          <w:jc w:val="center"/>
        </w:pPr>
        <w:r>
          <w:t>
            <xsl:value-of select="$footer_text"/>
          </w:t>
        </w:r>
      </w:p>
    </w:ftr>
  </xsl:template>
  <xsl:template name="headers_footers">
    <xsl:param name="BIC"/>
    <xsl:param name="gaadmin" select="'false'"/>
    <w:hdr w:type="odd">
      <xsl:call-template name="standard_header"/>
      <xsl:choose>
        <xsl:when test="$gaadmin = 'true'">
          <xsl:call-template name="ga28_header_table"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="header_table"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:call-template name="breadcrumb"/>
    </w:hdr>
    <w:ftr w:type="odd">
      <xsl:call-template name="main_footer">
        <xsl:with-param name="BIC" select="$BIC"/>
      </xsl:call-template>
    </w:ftr>
    <w:hdr w:type="first">
      <xsl:call-template name="standard_header_first"/>
      <xsl:choose>
        <xsl:when test="$gaadmin = 'true'">
          <xsl:call-template name="ga28_header_table"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="header_table"/>
        </xsl:otherwise>
      </xsl:choose>
      <w:p>
        <w:pPr>
          <w:spacing w:after="0" w:before="0"/>
        </w:pPr>
      </w:p>
    </w:hdr>
    <w:ftr w:type="first">
      <xsl:call-template name="main_footer">
        <xsl:with-param name="BIC" select="$BIC"/>
      </xsl:call-template>
    </w:ftr>
  </xsl:template>
  <xsl:template name="standard_header">
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Subtitle"/>
      </w:pPr>
      <w:r>
        <w:t>
          <xsl:value-of select="$SHORT_TITLE"/>
        </w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Heading4"/>
        <w:tabs>
          <xsl:choose>
            <xsl:when test="$ORIENTATION='portrait'">
              <w:tab w:pos="9072" w:val="right"/>
            </xsl:when>
            <xsl:otherwise>
              <w:tab w:pos="14742" w:val="right"/>
            </xsl:otherwise>
          </xsl:choose>
        </w:tabs>
        <w:rPr>
          <w:b-cs/>
        </w:rPr>
      </w:pPr>
      <w:r>
        <w:rPr>
          <w:b-cs/>
        </w:rPr>
        <w:t>
          <xsl:value-of select="$ID"/>
        </w:t>
      </w:r>
      <w:r>
        <w:rPr>
          <w:b-cs/>
        </w:rPr>
        <w:tab wx:cTlc="98" wx:tlc="none" wx:wTab="5910"/>
        <w:t>
          <xsl:text>Dates of coverage: </xsl:text>
          <xsl:value-of select="$DATE_RANGE"/>
        </w:t>
      </w:r>
    </w:p>
  </xsl:template>
  <xsl:template name="standard_header_first">
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Subtitle"/>
      </w:pPr>
      <w:r>
        <w:t>
          <xsl:value-of select="$AUTHORITY_HEAD"/>
        </w:t>
      </w:r>
      <w:r>
        <w:br/>
        <w:t>
          <xsl:value-of select="$AUTHORITY_TITLE"/>
        </w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Heading4"/>
        <w:tabs>
          <xsl:choose>
            <xsl:when test="$ORIENTATION='portrait'">
              <w:tab w:pos="9072" w:val="right"/>
            </xsl:when>
            <xsl:otherwise>
              <w:tab w:pos="14742" w:val="right"/>
            </xsl:otherwise>
          </xsl:choose>
        </w:tabs>
        <w:rPr>
          <w:b-cs/>
        </w:rPr>
      </w:pPr>
      <w:r>
        <w:rPr>
          <w:b-cs/>
        </w:rPr>
        <w:t>
          <xsl:value-of select="$ID"/>
        </w:t>
      </w:r>
      <w:r>
        <w:rPr>
          <w:b-cs/>
        </w:rPr>
        <w:tab wx:cTlc="98" wx:tlc="none" wx:wTab="5910"/>
        <w:t>
          <xsl:text>Dates of coverage: </xsl:text>
          <xsl:value-of select="$DATE_RANGE"/>
        </w:t>
      </w:r>
    </w:p>
  </xsl:template>
  <!-- GA 28 Style header -->
  <xsl:template name="ga28_header_table">
    <!-- class number -->
    <xsl:variable name="size_1">
      <xsl:choose>
        <xsl:when test="$ORIENTATION='landscape'">
          <xsl:text>1100</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>992</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!-- disposal action | custody -->
    <xsl:variable name="size_2">
      <xsl:choose>
        <xsl:when test="$ORIENTATION='landscape'">
          <xsl:text>2870</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>2268</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!-- description wo/ custody-->
    <xsl:variable name="size_3">
      <xsl:choose>
        <xsl:when test="$ORIENTATION='landscape'">
          <xsl:text>10915</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>5812</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!-- description w/ custody-->
    <xsl:variable name="size_4">
      <xsl:choose>
        <xsl:when test="$ORIENTATION='landscape'">
          <xsl:text>8045</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>3544</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!-- width -->
    <xsl:variable name="width">
      <xsl:choose>
        <xsl:when test="$ORIENTATION='landscape'">
          <xsl:text>14885</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>9072</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <w:tbl>
      <w:tblPr>
        <w:tblW w:type="dxa" w:w="{$width}"/>
        <w:jc w:val="center"/>
        <w:tblBorders>
          <w:top w:color="auto" w:space="0" w:sz="6" w:val="single" wx:bdrwidth="10"/>
          <w:left w:color="auto" w:space="0" w:sz="6" w:val="single" wx:bdrwidth="10"/>
          <w:bottom w:color="auto" w:space="0" w:sz="6" w:val="single" wx:bdrwidth="10"/>
          <w:right w:color="auto" w:space="0" w:sz="6" w:val="single" wx:bdrwidth="10"/>
          <w:insideH w:color="auto" w:space="0" w:sz="6" w:val="single" wx:bdrwidth="10"/>
          <w:insideV w:color="auto" w:space="0" w:sz="6" w:val="single" wx:bdrwidth="10"/>
        </w:tblBorders>
      </w:tblPr>
      <w:tblGrid>
        <w:gridCol w:type="dxa" w:w="{$size_1}"/>
        <xsl:choose>
          <xsl:when test="$COLS='c'">
            <w:gridCol w:type="dxa" w:w="{$size_4}"/>
          </xsl:when>
          <xsl:otherwise>
            <w:gridCol w:type="dxa" w:w="{$size_3}"/>
          </xsl:otherwise>
        </xsl:choose>
        <w:gridCol w:type="dxa" w:w="{$size_2}"/>
        <xsl:if test="$COLS='c'">
          <w:gridCol w:type="dxa" w:w="{$size_2}"/>
        </xsl:if>
      </w:tblGrid>
      <w:tr>
        <w:trPr>
          <w:jc w:val="center"/>
        </w:trPr>
        <w:tc>
          <w:tcPr>
            <w:tcW w:type="dxa" w:w="{$size_1}"/>
            <w:shd w:color="auto" w:fill="auto" w:val="clear"/>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:after="100" w:after-autospacing="on" w:before="100" w:before-autospacing="on"/>
              <w:rPr>
                <w:b/>
                <w:sz-cs w:val="24"/>
              </w:rPr>
            </w:pPr>
            <w:r>
              <w:rPr>
                <w:b/>
                <w:sz-cs w:val="24"/>
              </w:rPr>
              <w:t>No.</w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <xsl:choose>
              <xsl:when test="$COLS='c'">
                <w:tcW w:type="dxa" w:w="{$size_4}"/>
              </xsl:when>
              <xsl:otherwise>
                <w:tcW w:type="dxa" w:w="{$size_3}"/>
              </xsl:otherwise>
            </xsl:choose>
            <w:shd w:color="auto" w:fill="auto" w:val="clear"/>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:after="100" w:after-autospacing="on" w:before="100" w:before-autospacing="on"/>
              <w:rPr>
                <w:b/>
                <w:sz-cs w:val="24"/>
              </w:rPr>
            </w:pPr>
            <w:r>
              <w:rPr>
                <w:b/>
                <w:sz-cs w:val="24"/>
              </w:rPr>
              <w:t>Description of records</w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:type="dxa" w:w="{$size_2}"/>
            <w:shd w:color="auto" w:fill="auto" w:val="clear"/>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:after="100" w:after-autospacing="on" w:before="100" w:before-autospacing="on"/>
              <w:rPr>
                <w:b/>
                <w:sz-cs w:val="24"/>
              </w:rPr>
            </w:pPr>
            <w:r>
              <w:rPr>
                <w:b/>
                <w:sz-cs w:val="24"/>
              </w:rPr>
              <w:t>Disposal action</w:t>
            </w:r>
          </w:p>
        </w:tc>
        <xsl:if test="$COLS='c'">
          <w:tc>
            <w:tcPr>
              <w:tcW w:type="dxa" w:w="{$size_2}"/>
              <w:shd w:color="auto" w:fill="auto" w:val="clear"/>
            </w:tcPr>
            <w:p>
              <w:pPr>
                <w:spacing w:after="100" w:after-autospacing="on" w:before="100" w:before-autospacing="on"/>
                <w:rPr>
                  <w:b/>
                  <w:sz-cs w:val="24"/>
                </w:rPr>
              </w:pPr>
              <w:r>
                <w:rPr>
                  <w:b/>
                  <w:sz-cs w:val="24"/>
                </w:rPr>
                <w:t>Custody</w:t>
              </w:r>
            </w:p>
          </w:tc>
        </xsl:if>
      </w:tr>
    </w:tbl>
  </xsl:template>
  <xsl:template name="header_table">
    <xsl:variable name="size_1">
      <xsl:text>1100</xsl:text>
    </xsl:variable>
    <xsl:variable name="size_2">
      <xsl:choose>
        <xsl:when test="$ORIENTATION='portrait'">
          <xsl:text>1440</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>2268</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="size_3">
      <xsl:choose>
        <xsl:when test="$ORIENTATION='portrait'">
          <xsl:text>1967</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>2870</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="size_4">
      <xsl:choose>
        <xsl:when test="$ORIENTATION='portrait'">
          <xsl:text>2426</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>4813</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="size_5">
      <xsl:choose>
        <xsl:when test="$ORIENTATION='portrait'">
          <xsl:text>4779</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>8647</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="size_6">
      <xsl:choose>
        <xsl:when test="$ORIENTATION='portrait'">
          <xsl:text>3339</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>6379</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <w:tbl>
      <w:tblPr>
        <xsl:choose>
          <xsl:when test="$ORIENTATION='portrait'">
            <w:tblW w:type="dxa" w:w="9286"/>
          </xsl:when>
          <xsl:otherwise>
            <w:tblW w:type="dxa" w:w="14885"/>
          </xsl:otherwise>
        </xsl:choose>
        <w:tblBorders>
          <w:top w:color="auto" w:space="0" w:sz="4" w:val="single" wx:bdrwidth="10"/>
          <w:left w:color="auto" w:space="0" w:sz="4" w:val="single" wx:bdrwidth="10"/>
          <w:bottom w:color="auto" w:space="0" w:sz="4" w:val="single" wx:bdrwidth="10"/>
          <w:right w:color="auto" w:space="0" w:sz="4" w:val="single" wx:bdrwidth="10"/>
          <w:insideH w:color="auto" w:space="0" w:sz="6" w:val="single" wx:bdrwidth="15"/>
          <w:insideV w:color="auto" w:space="0" w:sz="6" w:val="single" wx:bdrwidth="15"/>
        </w:tblBorders>
        <w:tblLayout w:type="Fixed"/>
        <w:tblCellMar>
          <w:left w:type="dxa" w:w="107"/>
          <w:right w:type="dxa" w:w="107"/>
        </w:tblCellMar>
      </w:tblPr>
      <w:tblGrid>
        <w:gridCol w:type="dxa" w:w="{$size_1}"/>
        <xsl:choose>
          <xsl:when test="$COLS='j_c'">
            <w:gridCol w:type="dxa" w:w="{$size_2}"/>
          </xsl:when>
          <xsl:otherwise>
            <w:gridCol w:type="dxa" w:w="{$size_3}"/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
          <xsl:when test="$COLS='j_c'">
            <w:gridCol w:type="dxa" w:w="{$size_4}"/>
          </xsl:when>
          <xsl:when test="$COLS='no_j_c'">
            <w:gridCol w:type="dxa" w:w="{$size_5}"/>
          </xsl:when>
          <xsl:otherwise>
            <w:gridCol w:type="dxa" w:w="{$size_6}"/>
          </xsl:otherwise>
        </xsl:choose>
        <w:gridCol w:type="dxa" w:w="{$size_2}"/>
        <xsl:if test="$COLS!='no_j_c'">
          <w:gridCol w:type="dxa" w:w="{$size_2}"/>
        </xsl:if>
        <xsl:if test="$COLS='j_c'">
          <w:gridCol w:type="dxa" w:w="{$size_2}"/>
        </xsl:if>
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
            <w:tcW w:type="dxa" w:w="{$size_1}"/>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:tabs>
                <w:tab w:pos="1170" w:val="left"/>
              </w:tabs>
              <w:spacing w:after="60" w:before="60"/>
              <w:jc w:val="center"/>
              <w:rPr>
                <w:b/>
                <w:sz w:val="16"/>
              </w:rPr>
            </w:pPr>
            <w:r>
              <w:rPr>
                <w:b/>
                <w:sz w:val="16"/>
              </w:rPr>
              <w:t>
                <xsl:text>No</xsl:text>
              </w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <xsl:choose>
              <xsl:when test="$COLS='j_c'">
                <w:tcW w:type="dxa" w:w="{$size_2}"/>
              </xsl:when>
              <xsl:otherwise>
                <w:tcW w:type="dxa" w:w="{$size_3}"/>
              </xsl:otherwise>
            </xsl:choose>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:after="60" w:before="60"/>
              <w:jc w:val="center"/>
              <w:rPr>
                <w:b/>
                <w:sz w:val="16"/>
              </w:rPr>
            </w:pPr>
            <w:r>
              <w:rPr>
                <w:b/>
                <w:sz w:val="16"/>
              </w:rPr>
              <w:t>
                <xsl:text>Function/Activity</xsl:text>
              </w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <xsl:choose>
              <xsl:when test="$COLS='j_c'">
                <w:tcW w:type="dxa" w:w="{$size_4}"/>
              </xsl:when>
              <xsl:when test="$COLS='no_j_c'">
                <w:tcW w:type="dxa" w:w="{$size_5}"/>
              </xsl:when>
              <xsl:otherwise>
                <w:tcW w:type="dxa" w:w="{$size_6}"/>
              </xsl:otherwise>
            </xsl:choose>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:after="60" w:before="60"/>
              <w:jc w:val="center"/>
              <w:rPr>
                <w:b/>
                <w:sz w:val="16"/>
              </w:rPr>
            </w:pPr>
            <w:r>
              <w:rPr>
                <w:b/>
                <w:sz w:val="16"/>
              </w:rPr>
              <w:t>
                <xsl:text>Description</xsl:text>
              </w:t>
            </w:r>
          </w:p>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:type="dxa" w:w="{$size_2}"/>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:after="60" w:before="60"/>
              <w:jc w:val="center"/>
              <w:rPr>
                <w:b/>
                <w:sz w:val="16"/>
              </w:rPr>
            </w:pPr>
            <w:r>
              <w:rPr>
                <w:b/>
                <w:sz w:val="16"/>
              </w:rPr>
              <w:t>
                <xsl:text>Disposal Action</xsl:text>
              </w:t>
            </w:r>
          </w:p>
        </w:tc>
        <xsl:choose>
          <xsl:when test="$COLS='j_c' or $COLS='j'">
            <w:tc>
              <w:tcPr>
                <w:tcW w:type="dxa" w:w="{$size_2}"/>
              </w:tcPr>
              <w:p>
                <w:pPr>
                  <w:spacing w:after="60" w:before="60"/>
                  <w:jc w:val="center"/>
                  <w:rPr>
                    <w:b/>
                    <w:sz w:val="16"/>
                  </w:rPr>
                </w:pPr>
                <w:r>
                  <w:rPr>
                    <w:b/>
                    <w:sz w:val="16"/>
                  </w:rPr>
                  <w:t>
                    <xsl:text>Justification</xsl:text>
                  </w:t>
                </w:r>
              </w:p>
            </w:tc>
          </xsl:when>
          <xsl:when test="$COLS='c'">
            <w:tc>
              <w:tcPr>
                <w:tcW w:type="dxa" w:w="{$size_2}"/>
              </w:tcPr>
              <w:p>
                <w:pPr>
                  <w:spacing w:after="60" w:before="60"/>
                  <w:jc w:val="center"/>
                  <w:rPr>
                    <w:b/>
                    <w:sz w:val="16"/>
                  </w:rPr>
                </w:pPr>
                <w:r>
                  <w:rPr>
                    <w:b/>
                    <w:sz w:val="16"/>
                  </w:rPr>
                  <w:t>
                    <xsl:text>Custody*</xsl:text>
                  </w:t>
                </w:r>
              </w:p>
            </w:tc>
          </xsl:when>
        </xsl:choose>
        <xsl:if test="$COLS='j_c'">
          <w:tc>
            <w:tcPr>
              <w:tcW w:type="dxa" w:w="{$size_2}"/>
            </w:tcPr>
            <w:p>
              <w:pPr>
                <w:spacing w:after="60" w:before="60"/>
                <w:jc w:val="center"/>
                <w:rPr>
                  <w:b/>
                  <w:sz w:val="16"/>
                </w:rPr>
              </w:pPr>
              <w:r>
                <w:rPr>
                  <w:b/>
                  <w:sz w:val="16"/>
                </w:rPr>
                <w:t>
                  <xsl:text>Custody</xsl:text>
                </w:t>
              </w:r>
            </w:p>
          </w:tc>
        </xsl:if>
      </w:tr>
    </w:tbl>
  </xsl:template>
  <xsl:template name="breadcrumb">
    <w:p>
      <w:pPr>
        <w:rPr>
          <w:i/>
        </w:rPr>
      </w:pPr>
      <w:r>
        <w:fldChar w:fldCharType="begin"/>
      </w:r>
      <w:r>
        <w:rPr>
          <w:i/>
        </w:rPr>
        <w:instrText>STYLEREF  &quot;HIDDEN CHAR&quot; \* MERGEFORMAT</w:instrText>
      </w:r>
      <w:r>
        <w:fldChar w:fldCharType="separate"/>
      </w:r>
      <w:r>
        <w:rPr>
          <w:i/>
        </w:rPr>
        <w:t/>
      </w:r>
      <w:r>
        <w:fldChar w:fldCharType="end"/>
      </w:r>
    </w:p>
  </xsl:template>
  <xsl:template name="main_footer">
    <xsl:param name="BIC"/>
    <xsl:if test="$COLS='c'">
      <w:p>
        <w:pPr>
          <w:tabs>
            <xsl:choose>
              <xsl:when test="$ORIENTATION='portrait'">
                <w:tab w:pos="9072" w:val="right"/>
              </xsl:when>
              <xsl:otherwise>
                <w:tab w:pos="14742" w:val="right"/>
              </xsl:otherwise>
            </xsl:choose>
          </w:tabs>
          <w:rPr>
            <w:sz w:val="18"/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
            <w:sz w:val="18"/>
          </w:rPr>
          <w:t>
            <xsl:text>* see </xsl:text>
          </w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:i/>
            <w:sz w:val="18"/>
          </w:rPr>
          <w:t>
            <xsl:text>About the functional retention and disposal authority</xsl:text>
          </w:t>
        </w:r>
      </w:p>
    </xsl:if>
    <xsl:if test="$BIC='true'">
      <w:p>
        <w:pPr>
          <w:tabs>
            <w:tab w:pos="14742" w:val="right"/>
          </w:tabs>
          <w:jc w:val="center"/>
          <w:rPr>
            <w:sz w:val="18"/>
          </w:rPr>
        </w:pPr>
        <w:r>
          <w:rPr>
            <w:sz w:val="18"/>
          </w:rPr>
          <w:t>BOARD-IN-CONFIDENCE</w:t>
        </w:r>
      </w:p>
    </xsl:if>
    <xsl:call-template name="footer"/>
  </xsl:template>
  <xsl:template name="footer">
    <w:p>
      <w:pPr>
        <w:tabs>
          <xsl:choose>
            <xsl:when test="$ORIENTATION='portrait'">
              <w:tab w:pos="9072" w:val="right"/>
            </xsl:when>
            <xsl:otherwise>
              <w:tab w:pos="14742" w:val="right"/>
            </xsl:otherwise>
          </xsl:choose>
        </w:tabs>
        <w:rPr>
          <w:smallCaps/>
          <w:sz w:val="18"/>
        </w:rPr>
      </w:pPr>
      <w:r>
        <w:rPr>
          <w:sz w:val="18"/>
        </w:rPr>
        <w:t>
          <xsl:text>State Archives and Records Authority of New South Wales</xsl:text>
        </w:t>
      </w:r>
      <w:r>
        <w:rPr>
          <w:sz w:val="18"/>
        </w:rPr>
        <w:tab wx:cTlc="105" wx:tlc="none" wx:wTab="6360"/>
      </w:r>
      <w:r>
        <w:rPr>
          <w:sz w:val="18"/>
        </w:rPr>
        <w:fldChar w:fldCharType="begin"/>
      </w:r>
      <w:r>
        <w:rPr>
          <w:sz w:val="18"/>
        </w:rPr>
        <w:instrText>PAGE </w:instrText>
      </w:r>
      <w:r>
        <w:rPr>
          <w:sz w:val="18"/>
        </w:rPr>
        <w:fldChar w:fldCharType="separate"/>
      </w:r>
      <w:r>
        <w:rPr>
          <w:sz w:val="18"/>
        </w:rPr>
        <w:fldChar w:fldCharType="end"/>
      </w:r>
      <w:r>
        <w:rPr>
          <w:sz w:val="18"/>
        </w:rPr>
        <w:t>
          <xsl:text> of </xsl:text>
        </w:t>
      </w:r>
      <w:r>
        <w:rPr>
          <w:sz w:val="18"/>
        </w:rPr>
        <w:fldChar w:fldCharType="begin"/>
      </w:r>
      <w:r>
        <w:rPr>
          <w:sz w:val="18"/>
        </w:rPr>
        <w:instrText>=</w:instrText>
      </w:r>
      <w:r>
        <w:rPr>
          <w:sz w:val="18"/>
        </w:rPr>
        <w:fldChar w:fldCharType="begin"/>
      </w:r>
      <w:r>
        <w:rPr>
          <w:sz w:val="18"/>
        </w:rPr>
        <w:instrText>NUMPAGES </w:instrText>
      </w:r>
      <w:r>
        <w:rPr>
          <w:sz w:val="18"/>
        </w:rPr>
        <w:fldChar w:fldCharType="separate"/>
      </w:r>
      <w:r>
        <w:rPr>
          <w:sz w:val="18"/>
        </w:rPr>
        <w:fldChar w:fldCharType="end"/>
      </w:r>
      <w:r>
        <w:rPr>
          <w:sz w:val="18"/>
        </w:rPr>
        <w:instrText>
          <xsl:text>-</xsl:text>
          <xsl:value-of select="$ADJUST_PGNO"/>
        </w:instrText>
      </w:r>
      <w:r>
        <w:rPr>
          <w:sz w:val="18"/>
        </w:rPr>
        <w:fldChar w:fldCharType="separate"/>
      </w:r>
      <w:r>
        <w:rPr>
          <w:sz w:val="18"/>
        </w:rPr>
        <w:fldChar w:fldCharType="end"/>
      </w:r>
    </w:p>
  </xsl:template>
  <xsl:template name="contents_headers_footers">
    <w:hdr w:type="odd">
      <xsl:call-template name="standard_header"/>
      <xsl:call-template name="contents_header_table"/>
    </w:hdr>
    <w:ftr w:type="odd">
      <xsl:call-template name="footer"/>
    </w:ftr>
    <w:hdr w:type="first">
      <xsl:call-template name="standard_header_first"/>
      <xsl:call-template name="contents_header_table"/>
    </w:hdr>
    <w:ftr w:type="first">
      <xsl:call-template name="footer"/>
    </w:ftr>
  </xsl:template>
  <xsl:template name="contents_header_table">
    <w:tbl>
      <w:tblPr>
        <w:tblW w:type="pct" w:w="5000"/>
        <w:tblBorders>
          <w:top w:color="auto" w:space="0" w:sz="4" w:val="single" wx:bdrwidth="10"/>
          <w:left w:color="auto" w:space="0" w:sz="4" w:val="single" wx:bdrwidth="10"/>
          <w:bottom w:color="auto" w:space="0" w:sz="4" w:val="single" wx:bdrwidth="10"/>
          <w:right w:color="auto" w:space="0" w:sz="4" w:val="single" wx:bdrwidth="10"/>
          <w:insideH w:color="auto" w:space="0" w:sz="6" w:val="single" wx:bdrwidth="15"/>
          <w:insideV w:color="auto" w:space="0" w:sz="6" w:val="single" wx:bdrwidth="15"/>
        </w:tblBorders>
        <w:tblLayout w:type="Fixed"/>
        <w:tblCellMar>
          <w:left w:type="dxa" w:w="107"/>
          <w:right w:type="dxa" w:w="107"/>
        </w:tblCellMar>
      </w:tblPr>
      <w:tblGrid>
        <w:gridCol w:type="pct" w:w="5000"/>
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
            <w:tcW w:type="pct" w:w="5000"/>
          </w:tcPr>
          <w:p>
            <w:pPr>
              <w:spacing w:after="60" w:before="60"/>
              <w:rPr>
                <w:b/>
                <w:sz w:val="16"/>
              </w:rPr>
            </w:pPr>
            <w:r>
              <w:rPr>
                <w:b/>
                <w:sz w:val="16"/>
              </w:rPr>
              <w:t>
                <xsl:text>List of Functions and Activities covered</xsl:text>
              </w:t>
            </w:r>
          </w:p>
        </w:tc>
      </w:tr>
    </w:tbl>
    <w:p>
      <w:pPr>
        <w:spacing w:after="0" w:before="0"/>
      </w:pPr>
    </w:p>
  </xsl:template>
</xsl:stylesheet>