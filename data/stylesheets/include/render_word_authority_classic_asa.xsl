<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:aml="http://schemas.microsoft.com/aml/2001/core" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="disposal_word_asa.xsl"/>
  <xsl:include href="render_word_asa.xsl"/>
  <xsl:template name="render_authority">
    <xsl:variable name="size_1">
      <xsl:choose>
        <xsl:when test="$CUSTOWN='true'">
          <xsl:text>994</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>1100</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="size_2">
      <xsl:choose>
        <xsl:when test="$CUSTOWN='true'">
          <xsl:text>2126</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>2551</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="size_3">
      <xsl:choose>
        <xsl:when test="$CUSTOWN='true'">
          <xsl:text>4252</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>5020</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="size_4">
      <xsl:choose>
        <xsl:when test="$CUSTOWN='true'">
          <xsl:text>2551</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>2551</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="size_5">
      <xsl:choose>
        <xsl:when test="$CUSTOWN='true'">
          <xsl:text>2551</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>3804</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <w:tbl>
      <w:tblPr>
        <w:tblW w:type="dxa" w:w="14885"/>
        <w:tblBorders>
          <w:top w:color="auto" w:space="0" w:sz="4" w:val="single" wx:bdrwidth="10"/>
          <w:left w:color="auto" w:space="0" w:sz="6" w:val="single" wx:bdrwidth="15"/>
          <w:bottom w:color="auto" w:space="0" w:sz="6" w:val="single" wx:bdrwidth="15"/>
          <w:right w:color="auto" w:space="0" w:sz="6" w:val="single" wx:bdrwidth="15"/>
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
        <w:gridCol w:w="{$size_1}"/>
        <w:gridCol w:w="{$size_2}"/>
        <w:gridCol w:w="{$size_3}"/>
        <w:gridCol w:w="{$size_4}"/>
        <w:gridCol w:w="{$size_5}"/>
        <xsl:if test="$CUSTOWN='true'">
          <w:gridCol w:w="1276"/>
          <w:gridCol w:w="1276"/>
        </xsl:if>
      </w:tblGrid>
      <xsl:apply-templates select="rda:Term | rda:Class">
        <xsl:with-param name="size_1" select="$size_1"/>
        <xsl:with-param name="size_2" select="$size_2"/>
        <xsl:with-param name="size_3" select="$size_3"/>
        <xsl:with-param name="size_4" select="$size_4"/>
        <xsl:with-param name="size_5" select="$size_5"/>
      </xsl:apply-templates>
    </w:tbl>
  </xsl:template>
  <xsl:template match="rda:Term">
    <xsl:param name="size_1"/>
    <xsl:param name="size_2"/>
    <xsl:param name="size_3"/>
    <xsl:param name="size_4"/>
    <xsl:param name="size_5"/>
    <xsl:variable name="breadcrumb">
      <xsl:for-each select="ancestor-or-self::rda:Term">
        <xsl:if test="parent::rda:Term">
          <xsl:text> - </xsl:text>
        </xsl:if>
        <xsl:value-of select="rda:TermTitle"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="number">
      <xsl:number format="1" value="position()"/>
    </xsl:variable>
    <w:tr>
      <w:tblPrEx>
        <w:tblCellMar>
          <w:top w:type="dxa" w:w="0"/>
          <w:bottom w:type="dxa" w:w="0"/>
        </w:tblCellMar>
      </w:tblPrEx>
      <w:tc>
        <w:tcPr>
          <w:tcW w:type="dxa" w:w="{$size_1}"/>
        </w:tcPr>
        <w:p>
          <xsl:if test="parent::rda:Authority">
            <w:pPr>
              <w:pStyle w:val="TOC2"/>
            </w:pPr>
          </xsl:if>
          <w:r>
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
          <w:r>
            <w:rPr>
              <w:rStyle w:val="HiddenChar"/>
            </w:rPr>
            <w:t>
              <xsl:value-of select="$breadcrumb"/>
            </w:t>
          </w:r>
        </w:p>
      </w:tc>
      <aml:annotation aml:id="{$number}" w:name="{generate-id(.)}" w:type="Word.Bookmark.Start"/>
      <aml:annotation aml:id="{$number}" w:type="Word.Bookmark.End"/>
      <w:tc>
        <w:tcPr>
          <w:tcW w:type="dxa" w:w="{$size_2}"/>
        </w:tcPr>
        <w:p>
          <w:pPr>
            <xsl:choose>
              <xsl:when test="parent::rda:Authority">
                <w:pStyle w:val="TOC1"/>
              </xsl:when>
              <xsl:otherwise>
                <w:pStyle w:val="TOC2"/>
              </xsl:otherwise>
            </xsl:choose>
            <w:tabs>
              <w:tab w:pos="9072" w:val="clear"/>
            </w:tabs>
            <w:spacing w:after="120" w:before="120"/>
            <w:rPr>
              <w:b-cs/>
              <w:b/>
            </w:rPr>
          </w:pPr>
          <w:r>
            <w:rPr>
              <w:b-cs/>
              <w:b/>
            </w:rPr>
            <w:t>
              <xsl:choose>
                <xsl:when test="rda:TermTitle">
                  <xsl:value-of select="rda:TermTitle"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:if test="rda:DateRange">
                    <xsl:text>Date range: </xsl:text>
                    <xsl:call-template name="make_date_text">
                      <xsl:with-param name="date_range" select="rda:DateRange"/>
                    </xsl:call-template>
                  </xsl:if>
                </xsl:otherwise>
              </xsl:choose>
            </w:t>
          </w:r>
        </w:p>
        <xsl:if test="rda:TermTitle and rda:DateRange">
          <w:p>
            <w:pPr>
              <w:pStyle w:val="Normalsingle"/>
              <w:spacing w:after="120" w:before="120"/>
            </w:pPr>
            <w:r>
              <w:rPr>
                <w:b-cs/>
                <w:b/>
              </w:rPr>
              <w:t>
                <xsl:text>Date range: </xsl:text>
                <xsl:call-template name="make_date_text">
                  <xsl:with-param name="date_range" select="rda:DateRange"/>
                </xsl:call-template>
              </w:t>
            </w:r>
          </w:p>
        </xsl:if>
      </w:tc>
      <w:tc>
        <w:tcPr>
          <w:tcW w:type="dxa" w:w="{$size_3}"/>
        </w:tcPr>
        <xsl:if test="not(rda:TermDescription)">
          <w:p/>
        </xsl:if>
        <xsl:for-each select="rda:TermDescription">
          <xsl:apply-templates/>
        </xsl:for-each>
      </w:tc>
      <w:tc>
        <!--Blank Disposal action cell-->
        <w:tcPr>
          <w:tcW w:type="dxa" w:w="{$size_4}"/>
        </w:tcPr>
        <w:p/>
      </w:tc>
      <w:tc>
        <!--Blank examples cell-->
        <w:tcPr>
          <w:tcW w:type="dxa" w:w="{$size_5}"/>
        </w:tcPr>
        <w:p/>
      </w:tc>
      <xsl:if test="$CUSTOWN='true'">
        <!--Blank custody cell-->
        <w:tc>
          <w:tcPr>
            <w:tcW w:type="dxa" w:w="1276"/>
          </w:tcPr>
          <w:p/>
        </w:tc>
        <!--Blank owner cell-->
        <w:tc>
          <w:tcPr>
            <w:tcW w:type="dxa" w:w="1276"/>
          </w:tcPr>
          <w:p/>
        </w:tc>
      </xsl:if>
    </w:tr>
    <xsl:apply-templates select="rda:Term | rda:Class">
      <xsl:with-param name="size_1" select="$size_1"/>
      <xsl:with-param name="size_2" select="$size_2"/>
      <xsl:with-param name="size_3" select="$size_3"/>
      <xsl:with-param name="size_4" select="$size_4"/>
      <xsl:with-param name="size_5" select="$size_5"/>
    </xsl:apply-templates>
  </xsl:template>
  <xsl:template match="rda:Class">
    <xsl:param name="size_1"/>
    <xsl:param name="size_2"/>
    <xsl:param name="size_3"/>
    <xsl:param name="size_4"/>
    <xsl:param name="size_5"/>
    <xsl:variable name="breadcrumb">
      <xsl:for-each select="ancestor::rda:Term">
        <xsl:if test="parent::rda:Term">
          <xsl:text> - </xsl:text>
        </xsl:if>
        <xsl:value-of select="rda:TermTitle"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="number">
      <xsl:number format="1" value="position()"/>
    </xsl:variable>
    <w:tr>
      <w:tblPrEx>
        <w:tblCellMar>
          <w:top w:type="dxa" w:w="0"/>
          <w:bottom w:type="dxa" w:w="0"/>
        </w:tblCellMar>
      </w:tblPrEx>
      <w:tc>
        <w:tcPr>
          <w:tcW w:type="dxa" w:w="{$size_1}"/>
        </w:tcPr>
        <w:p>
          <w:r>
            <w:t>
              <xsl:if test="ancestor::rda:Term[rda:ID] | rda:ID">
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
          <w:r>
            <w:rPr>
              <w:rStyle w:val="HiddenChar"/>
            </w:rPr>
            <w:t>
              <xsl:value-of select="$breadcrumb"/>
            </w:t>
          </w:r>
        </w:p>
      </w:tc>
      <aml:annotation aml:id="{$number}" w:name="{generate-id(.)}" w:type="Word.Bookmark.Start"/>
      <aml:annotation aml:id="{$number}" w:type="Word.Bookmark.End"/>
      <w:tc>
        <!--Class Title cell-->
        <w:tcPr>
          <w:tcW w:type="dxa" w:w="{$size_2}"/>
        </w:tcPr>
        <w:p>
          <w:pPr>
            <w:pStyle w:val="Normalsingle"/>
            <w:spacing w:after="120" w:before="120"/>
          </w:pPr>
          <w:r>
            <xsl:if test="parent::rda:Authority">
              <w:rPr>
                <w:b-cs/>
                <w:b/>
              </w:rPr>
            </xsl:if>
            <w:t>
              <xsl:if test="rda:ClassTitle">
                <xsl:value-of select="rda:ClassTitle"/>
              </xsl:if>
            </w:t>
          </w:r>
        </w:p>
      </w:tc>
      <w:tc>
        <w:tcPr>
          <w:tcW w:type="dxa" w:w="{$size_3}"/>
        </w:tcPr>
        <xsl:if test="not(rda:ClassDescription)">
          <w:p/>
        </xsl:if>
        <xsl:for-each select="rda:ClassDescription">
          <xsl:apply-templates/>
        </xsl:for-each>
      </w:tc>
      <w:tc>
        <w:tcPr>
          <w:tcW w:type="dxa" w:w="{$size_4}"/>
        </w:tcPr>
        <xsl:if test="not(rda:Disposal[not(rda:DisposalCondition='Automated')])">
          <w:p/>
        </xsl:if>
        <xsl:call-template name="disposal_action">
          <xsl:with-param name="disposals" select="rda:Disposal"/>
        </xsl:call-template>
      </w:tc>
      <w:tc>
        <w:tcPr>
          <w:tcW w:type="dxa" w:w="{$size_5}"/>
        </w:tcPr>
        <xsl:if test="not(rda:Justification)">
          <w:p/>
        </xsl:if>
        <xsl:for-each select="rda:Justification">
          <xsl:apply-templates/>
        </xsl:for-each>
      </w:tc>
      <xsl:if test="$CUSTOWN='true'">
        <w:tc>
          <w:tcPr>
            <w:tcW w:type="dxa" w:w="1276"/>
          </w:tcPr>
          <w:p/>
        </w:tc>
        <w:tc>
          <w:tcPr>
            <w:tcW w:type="dxa" w:w="1276"/>
          </w:tcPr>
          <w:p/>
        </w:tc>
      </xsl:if>
    </w:tr>
  </xsl:template>
</xsl:stylesheet>