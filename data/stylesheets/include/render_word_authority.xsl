<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:aml="http://schemas.microsoft.com/aml/2001/core" xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" xmlns:o="urn:schemas-microsoft-com:office:office" version="1.0">
  <xsl:include href="disposal_word.xsl"/>
  <xsl:include href="render_word.xsl"/>
  <xsl:template name="render_authority">
      <!-- class number -->
  <xsl:variable name="size_1">
    <xsl:text>992</xsl:text>
  </xsl:variable>
  <!-- disposal action | custody -->
  <xsl:variable name="size_2">
    <xsl:text>2268</xsl:text>  
  </xsl:variable>
  <!-- description wo/ custody-->
  <xsl:variable name="size_3">
    <xsl:text>5812</xsl:text>  
  </xsl:variable>
  <!-- description w/ custody-->
  <xsl:variable name="size_4">
    <xsl:text>3544</xsl:text>  
  </xsl:variable>
          </w:tblGrid>
      <xsl:apply-templates select="rda:Term | rda:Class">
        <xsl:with-param name="size_1" select="$size_1"/>
        <xsl:with-param name="size_2" select="$size_2"/>
        <xsl:with-param name="size_3" select="$size_3"/>
        <xsl:with-param name="size_4" select="$size_4"/>
      </xsl:apply-templates>
  </xsl:template>
    <!-- TERM -->
  <xsl:template match="rda:Term">
    <xsl:param name="size_1" />
    <xsl:param name="size_2" />
    <xsl:param name="size_3" />
    <xsl:param name="size_4" />
    <xsl:variable name="breadcrumb">
      <xsl:for-each select="ancestor-or-self::rda:Term">
        <xsl:if test="parent::rda:Term">
          <xsl:text> - </xsl:text>
        </xsl:if>
        <xsl:value-of select="rda:TermTitle"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="number">
      <xsl:number value="position()" format="1"/>
    </xsl:variable>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Heading1"/>
        <xsl:if test="parent::rda:Authority">
          <w:pageBreakBefore/>
        </xsl:if>
      </w:pPr>
      <aml:annotation aml:id="{$number}" w:type="Word.Bookmark.Start" w:name="{generate-id(.)}"/>
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
    <xsl:if test="not(rda:TermDescription)">
      <w:p/>
    </xsl:if>
    <xsl:for-each select="rda:TermDescription">
      <xsl:apply-templates/>
    </xsl:for-each>
    <xsl:apply-templates select="rda:Term | rda:Class"/>
  </xsl:template>
  <!-- CLASS -->
  <xsl:template match="rda:Class">
    <xsl:param name="size_1" />
    <xsl:param name="size_2" />
    <xsl:param name="size_3" />
    <xsl:param name="size_4" />
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
          <w:spacing w:before="0" w:after="60"/>
        </w:pPr>  
        <w:r/>
      </w:p>  
      <xsl:text disable-output-escaping="yes">&lt;w:tbl&gt;</xsl:text>
      <w:tblPr>
        <w:tblW w:w="9072" w:type="dxa"/>
        <w:jc w:val="center"/>
        <w:tblBorders>
          <w:top w:val="single" w:sz="6" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:left w:val="single" w:sz="6" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:bottom w:val="single" w:sz="6" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:right w:val="single" w:sz="6" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:insideH w:val="single" w:sz="6" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:insideV w:val="single" w:sz="6" wx:bdrwidth="10" w:space="0" w:color="auto"/>
        </w:tblBorders>
      </w:tblPr>
      <w:tblGrid>
        <w:gridCol w:w="{$size_1}" w:type="dxa"/>
        <xsl:choose>
          <xsl:when test="$COLS='c'">
            <w:gridCol w:w="{$size_4}" w:type="dxa"/>
          </xsl:when>
          <xsl:otherwise>
            <w:gridCol w:w="{$size_3}" w:type="dxa"/>
          </xsl:otherwise>
        </xsl:choose>
        <w:gridCol w:w="{$size_2}" w:type="dxa"/>
        <xsl:if test="$COLS='c'">
          <w:gridCol w:w="{$size_2}" w:type="dxa"/>
        </xsl:if>
      </w:tblGrid>
    </xsl:if>
    <w:tr>
      <w:tblPrEx>
        <w:tblCellMar>
          <w:top w:w="0" w:type="dxa"/>
          <w:bottom w:w="0" w:type="dxa"/>
        </w:tblCellMar>
      </w:tblPrEx>
      <w:tc>
        <w:tcPr>
          <w:tcW w:w="{$size_1}" w:type="dxa"/>
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
            <w:tcW w:w="{$size_4}" w:type="dxa"/>
          </xsl:when>
          <xsl:otherwise>
            <w:tcW w:w="{$size_3}" w:type="dxa"/>
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
          <w:tcW w:w="{$size_2}" w:type="dxa"/>
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
          <w:tcW w:w="{$size_2}" w:type="dxa"/>
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
            <w:tcW w:w="9072" w:type="dxa"/>
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
                      <w:t><xsl:text>Justification/Remarks: </xsl:text></w:t>
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
