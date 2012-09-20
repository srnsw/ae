<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:aml="http://schemas.microsoft.com/aml/2001/core" xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" xmlns:o="urn:schemas-microsoft-com:office:office" version="1.0">
  <xsl:include href="disposal_word.xsl"/>
  <xsl:include href="render_word.xsl"/>
  <xsl:template name="render_authority">
    <xsl:apply-templates select="rda:Term | rda:Class"/>
  </xsl:template>
  <xsl:template match="rda:Term">
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
          <xsl:value-of select="@itemno"/>
        </w:t>
      </w:r>
      <w:r>
        <w:t>
          <xsl:value-of select="concat(' ', rda:TermTitle)"/>
        </w:t>
      </w:r>
      <aml:annotation aml:id="{$number}" w:type="Word.Bookmark.End"/>
      <w:r>
        <w:rPr>
          <w:rStyle w:val="HiddenChar"/>
        </w:rPr>
        <w:t>
          <xsl:value-of select="$breadcrumb"/>
        </w:t>
      </w:r>
    </w:p>
    <xsl:if test="not(rda:TermDescription)">
      <w:p/>
    </xsl:if>
    <xsl:for-each select="rda:TermDescription">
      <xsl:apply-templates/>
    </xsl:for-each>
    <xsl:apply-templates select="rda:Term | rda:Class"/>
  </xsl:template>
  <xsl:template match="rda:Class">
    <xsl:variable name="breadcrumb">
      <xsl:for-each select="ancestor::rda:Term">
        <xsl:if test="parent::rda:Term">
          <xsl:text> - </xsl:text>
        </xsl:if>
        <xsl:value-of select="rda:TermTitle"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:if test="not(preceding-sibling::rda:Class)">
      <xsl:text disable-output-escaping="yes">&lt;w:tbl&gt;</xsl:text>
      <w:tblPr>
        <w:tblW w:w="9286" w:type="dxa"/>
        <w:tblBorders>
          <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
          <w:left w:val="single" w:sz="6" wx:bdrwidth="15" w:space="0" w:color="auto"/>
          <w:bottom w:val="single" w:sz="6" wx:bdrwidth="15" w:space="0" w:color="auto"/>
          <w:right w:val="single" w:sz="6" wx:bdrwidth="15" w:space="0" w:color="auto"/>
          <w:insideH w:val="single" w:sz="6" wx:bdrwidth="15" w:space="0" w:color="auto"/>
          <w:insideV w:val="single" w:sz="6" wx:bdrwidth="15" w:space="0" w:color="auto"/>
        </w:tblBorders>
        <w:tblLayout w:type="Fixed"/>
        <w:tblCellMar>
          <w:left w:w="107" w:type="dxa"/>
          <w:right w:w="107" w:type="dxa"/>
        </w:tblCellMar>
      </w:tblPr>
      <w:tblGrid>
        <w:gridCol w:w="1100" w:type="dxa"/>
        <w:gridCol w:w="5918" w:type="dxa"/>
        <w:gridCol w:w="2268" w:type="dxa"/>
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
          <w:tcW w:w="1100" w:type="dxa"/>
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
      <w:tc>
        <w:tcPr>
          <w:tcW w:w="5918" w:type="dxa"/>
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
          <w:tcW w:w="2268" w:type="dxa"/>
        </w:tcPr>
        <xsl:if test="not(rda:Disposal[not(rda:DisposalCondition='Automated')])">
          <w:p/>
        </xsl:if>
        <xsl:call-template name="disposal_action">
          <xsl:with-param name="disposals" select="rda:Disposal"/>
        </xsl:call-template>
      </w:tc>
    </w:tr>
  <xsl:if test="not(following-sibling::rda:Class)">
    <xsl:text disable-output-escaping="yes">&lt;/w:tbl&gt;</xsl:text>
  </xsl:if>  
  </xsl:template>
</xsl:stylesheet>
