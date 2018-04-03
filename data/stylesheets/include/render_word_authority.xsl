<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:aml="http://schemas.microsoft.com/aml/2001/core" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="disposal_word.xsl"/>
  <xsl:include href="render_word.xsl"/>
  <xsl:template name="render_authority">
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
    <xsl:apply-templates select="rda:Term | rda:Class">
      <xsl:with-param name="size_1" select="$size_1"/>
      <xsl:with-param name="size_2" select="$size_2"/>
      <xsl:with-param name="size_3" select="$size_3"/>
      <xsl:with-param name="size_4" select="$size_4"/>
      <xsl:with-param name="width" select="$width"/>
    </xsl:apply-templates>
  </xsl:template>
  <!-- TERM -->
  <xsl:template match="rda:Term">
    <xsl:param name="size_1"/>
    <xsl:param name="size_2"/>
    <xsl:param name="size_3"/>
    <xsl:param name="size_4"/>
    <xsl:param name="width"/>
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
    <w:p>
      <w:pPr>
        <xsl:choose>
          <xsl:when test="parent::rda:Authority">
            <w:pStyle w:val="Heading1"/>
            <w:pageBreakBefore/>
          </xsl:when>
          <xsl:otherwise>
            <w:pStyle w:val="Heading2"/>
          </xsl:otherwise>
        </xsl:choose>
      </w:pPr>
      <aml:annotation aml:id="{$number}" w:name="{generate-id(.)}" w:type="Word.Bookmark.Start"/>
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
          <xsl:if test="@itemno">
            <xsl:value-of select="concat(@itemno, ' ')"/>
          </xsl:if>
        </w:t>
      </w:r>
      <w:r>
        <w:t>
          <xsl:value-of select="rda:TermTitle"/>
        </w:t>
      </w:r>
      <aml:annotation aml:id="{$number}" w:type="Word.Bookmark.End"/>
    </w:p>
    <xsl:for-each select="rda:TermDescription">
      <xsl:apply-templates/>
    </xsl:for-each>
    <xsl:apply-templates select="rda:Term | rda:Class">
      <xsl:with-param name="size_1" select="$size_1"/>
      <xsl:with-param name="size_2" select="$size_2"/>
      <xsl:with-param name="size_3" select="$size_3"/>
      <xsl:with-param name="size_4" select="$size_4"/>
      <xsl:with-param name="width" select="$width"/>
    </xsl:apply-templates>
  </xsl:template>
  <!-- CLASS -->
  <xsl:template match="rda:Class">
    <xsl:param name="size_1"/>
    <xsl:param name="size_2"/>
    <xsl:param name="size_3"/>
    <xsl:param name="size_4"/>
    <xsl:param name="width"/>
    <xsl:variable name="breadcrumb">
      <xsl:for-each select="ancestor::rda:Term">
        <xsl:if test="parent::rda:Term">
          <xsl:text> - </xsl:text>
        </xsl:if>
        <xsl:value-of select="rda:TermTitle"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:if test="not(preceding-sibling::rda:Class)">
      <w:p>
        <w:pPr>
          <w:spacing w:after="60" w:before="0"/>
        </w:pPr>
        <w:r/>
      </w:p>
      <xsl:text disable-output-escaping="yes">&lt;w:tbl&gt;</xsl:text>
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
    </xsl:if>
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
        </w:p>
        <w:p>
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
        </w:tcPr>
        <xsl:if test="rda:ClassTitle">
          <w:p>
            <w:r>
              <w:rPr>
                <w:b/>
              </w:rPr>
              <w:t>
                <xsl:value-of select="rda:ClassTitle"/>
              </w:t>
            </w:r>
          </w:p>
        </xsl:if>
        <xsl:if test="not(rda:ClassDescription)">
          <w:p/>
        </xsl:if>
        <xsl:for-each select="rda:ClassDescription">
          <xsl:apply-templates/>
        </xsl:for-each>
      </w:tc>
      <w:tc>
        <w:tcPr>
          <w:tcW w:type="dxa" w:w="{$size_2}"/>
        </w:tcPr>
        <xsl:if test="not(rda:Disposal[not(rda:DisposalCondition='Automated')])">
          <w:p/>
        </xsl:if>
        <xsl:call-template name="disposal_action">
          <xsl:with-param name="disposals" select="rda:Disposal"/>
        </xsl:call-template>
      </w:tc>
      <xsl:if test="$COLS='c'">
        <w:tc>
          <w:tcPr>
            <w:tcW w:type="dxa" w:w="{$size_2}"/>
          </w:tcPr>
          <xsl:if test="not(rda:Disposal[not(rda:DisposalCondition='Automated')])">
            <w:p/>
          </xsl:if>
          <xsl:call-template name="custody">
            <xsl:with-param name="disposals" select="rda:Disposal"/>
          </xsl:call-template>
        </w:tc>
      </xsl:if>
    </w:tr>
    <xsl:if test="$JUSTIFICATION='row' and rda:Justification">
      <xsl:choose>
        <xsl:when test="$SHOWARCHIVESJUST='false'"/>
        <xsl:otherwise>
          <w:tr>
            <w:tc>
              <w:tcPr>
                <w:tcW w:type="dxa" w:w="{$width}"/>
                <xsl:variable name="span">
                  <xsl:choose>
                    <xsl:when test="$COLS='c'">
                      <xsl:value-of select="'4'"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="'3'"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:variable>
                <w:gridSpan w:val="{$span}"/>
              </w:tcPr>
              <xsl:for-each select="rda:Justification">
                <xsl:for-each select="rda:Paragraph">
                  <w:p>
                    <xsl:if test="position() = 1">
                      <w:r>
                        <w:rPr>
                          <w:b/>
                        </w:rPr>
                        <w:t>
                          <xsl:text>Justification/Remarks: </xsl:text>
                        </w:t>
                      </w:r>
                    </xsl:if>
                    <xsl:apply-templates/>
                  </w:p>
                </xsl:for-each>
              </xsl:for-each>
            </w:tc>
          </w:tr>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:if test="not(following-sibling::rda:Class)">
      <xsl:text disable-output-escaping="yes">&lt;/w:tbl&gt;</xsl:text>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>