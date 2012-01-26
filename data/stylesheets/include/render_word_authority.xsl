<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:aml="http://schemas.microsoft.com/aml/2001/core" xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" xmlns:o="urn:schemas-microsoft-com:office:office" version="1.0">
  <xsl:include href="disposal_word.xsl"/>
  <xsl:include href="render_word.xsl"/>
  <xsl:template name="render_authority">
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
            <w:tblW w:w="9286" w:type="dxa"/>
          </xsl:when>
          <xsl:otherwise>
            <w:tblW w:w="14885" w:type="dxa"/>
          </xsl:otherwise>
        </xsl:choose>
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
         <w:gridCol w:w="{$size_1}" w:type="dxa"/>
         <xsl:choose>
          <xsl:when test="$COLS='j_c'">
            <w:gridCol w:w="{$size_2}" w:type="dxa"/>
          </xsl:when>
          <xsl:otherwise>
            <w:gridCol w:w="{$size_3}" w:type="dxa"/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
          <xsl:when test="$COLS='j_c'">
            <w:gridCol w:w="{$size_4}" w:type="dxa"/>
          </xsl:when>
          <xsl:when test="$COLS='no_j_c'">
            <w:gridCol w:w="{$size_5}" w:type="dxa"/>
          </xsl:when>
          <xsl:otherwise>
            <w:gridCol w:w="{$size_6}" w:type="dxa"/>
          </xsl:otherwise>
        </xsl:choose>
        <w:gridCol w:w="{$size_2}" w:type="dxa"/>
        <xsl:if test="$COLS!='no_j_c'">
          <w:gridCol w:w="{$size_2}" w:type="dxa"/>
        </xsl:if>
        <xsl:if test="$COLS='j_c'">
          <w:gridCol w:w="{$size_2}" w:type="dxa"/>
        </xsl:if>
      </w:tblGrid>
      <xsl:apply-templates select="rda:Term | rda:Class">
        <xsl:with-param name="size_1" select="$size_1"/>
        <xsl:with-param name="size_2" select="$size_2"/>
        <xsl:with-param name="size_3" select="$size_3"/>
        <xsl:with-param name="size_4" select="$size_4"/>
        <xsl:with-param name="size_5" select="$size_5"/>
        <xsl:with-param name="size_6" select="$size_6"/>
      </xsl:apply-templates>
    </w:tbl>
  </xsl:template>
  <xsl:template match="rda:Term">
    <xsl:param name="size_1" />
    <xsl:param name="size_2" />
    <xsl:param name="size_3" />
    <xsl:param name="size_4" />
    <xsl:param name="size_5" />
    <xsl:param name="size_6" />
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
            <w:t><xsl:value-of select="$breadcrumb"/></w:t>
          </w:r>
        </w:p>
      </w:tc>
      <aml:annotation aml:id="{$number}" w:type="Word.Bookmark.Start" w:name="{generate-id(.)}"/>
      <aml:annotation aml:id="{$number}" w:type="Word.Bookmark.End"/>
      <w:tc>
        <w:tcPr>
          <xsl:choose>
            <xsl:when test="$COLS='j_c'">
              <w:tcW w:w="{$size_2}" w:type="dxa"/>
            </xsl:when>
            <xsl:otherwise>
              <w:tcW w:w="{$size_3}" w:type="dxa"/>
            </xsl:otherwise>
          </xsl:choose>
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
              <w:tab w:val="clear" w:pos="9072"/>
            </w:tabs>
            <w:spacing w:before="120" w:after="120"/>
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
            <w:t><xsl:choose>
				<xsl:when test="rda:TermTitle"><xsl:value-of select="rda:TermTitle"/></xsl:when>
				<xsl:otherwise>
				  <xsl:if test="rda:DateRange">
					<xsl:text>Date range: </xsl:text>  
					<xsl:call-template name="make_date_text">
		              <xsl:with-param name="date_range" select="rda:DateRange"/>
		            </xsl:call-template>
		          </xsl:if>
		        </xsl:otherwise>
			 </xsl:choose></w:t>
          </w:r>
        </w:p>
        <xsl:if test="rda:TermTitle and rda:DateRange">
			<w:p>
          <w:pPr>
            <w:pStyle w:val="Normalsingle"/>
            <w:spacing w:before="120" w:after="120"/>
          </w:pPr>
          <w:r>
            <w:rPr>
              <w:b-cs/>
              <w:b/>
            </w:rPr>
            <w:t>Date range: <xsl:call-template name="make_date_text">
		   <xsl:with-param name="date_range" select="rda:DateRange"/>
		 </xsl:call-template></w:t>
          </w:r>
        </w:p>
		</xsl:if>
      </w:tc>
      <w:tc>
        <w:tcPr>
          <xsl:choose>
            <xsl:when test="$COLS='j_c'">
              <w:tcW w:w="{$size_4}" w:type="dxa"/>
            </xsl:when>
            <xsl:when test="$COLS='no_j_c'">
              <w:tcW w:w="{$size_5}" w:type="dxa"/>
            </xsl:when>
            <xsl:otherwise>
              <w:tcW w:w="{$size_6}" w:type="dxa"/>
            </xsl:otherwise>
          </xsl:choose>
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
          <w:tcW w:w="{$size_2}" w:type="dxa"/>
        </w:tcPr>
        <w:p/>
      </w:tc>
      <xsl:if test="$COLS!='no_j_c'">
        <w:tc>
          <!--Blank cell-->
          <w:tcPr>
            <w:tcW w:w="{$size_2}" w:type="dxa"/>
          </w:tcPr>
          <w:p/>
        </w:tc>
      </xsl:if>
      <xsl:if test="$COLS='j_c'">
        <w:tc>
          <!--Blank cell-->
          <w:tcPr>
            <w:tcW w:w="{$size_2}" w:type="dxa"/>
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
        <xsl:with-param name="size_6" select="$size_6"/>
      </xsl:apply-templates>
  </xsl:template>
  <xsl:template match="rda:Class">
    <xsl:param name="size_1" />
    <xsl:param name="size_2" />
    <xsl:param name="size_3" />
    <xsl:param name="size_4" />
    <xsl:param name="size_5" />
    <xsl:param name="size_6" />
      <xsl:variable name="breadcrumb">
      <xsl:for-each select="ancestor::rda:Term">
        <xsl:if test="parent::rda:Term">
          <xsl:text> - </xsl:text>
        </xsl:if>
        <xsl:value-of select="rda:TermTitle"/>
      </xsl:for-each>
    </xsl:variable>
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
        <!--Blank Class Title cell-->
        <w:tcPr>
          <xsl:choose>
            <xsl:when test="$COLS='j_c'">
              <w:tcW w:w="{$size_2}" w:type="dxa"/>
            </xsl:when>
            <xsl:otherwise>
              <w:tcW w:w="{$size_3}" w:type="dxa"/>
            </xsl:otherwise>
          </xsl:choose>
        </w:tcPr>
        <w:p>
          <w:pPr>
            <w:pStyle w:val="Normalsingle"/>
            <w:spacing w:before="120" w:after="120"/>
          </w:pPr>
          <w:r>
            <w:rPr>
              <w:b-cs/>
              <w:b/>
            </w:rPr>
            <w:t><xsl:choose>
				<xsl:when test="rda:ClassTitle"><xsl:value-of select="rda:ClassTitle"/></xsl:when>
				<xsl:otherwise>
				  <xsl:if test="rda:DateRange">
					<xsl:text>Date range: </xsl:text>  
					<xsl:call-template name="make_date_text">
		              <xsl:with-param name="date_range" select="rda:DateRange"/>
		            </xsl:call-template>
		          </xsl:if>
		        </xsl:otherwise>
			 </xsl:choose></w:t>
          </w:r>
        </w:p>
        <xsl:if test="rda:ClassTitle and rda:DateRange">
			<w:p>
          <w:pPr>
            <w:pStyle w:val="Normalsingle"/>
            <w:spacing w:before="120" w:after="120"/>
          </w:pPr>
          <w:r>
            <w:rPr>
              <w:b-cs/>
              <w:b/>
            </w:rPr>
            <w:t>Date range: <xsl:call-template name="make_date_text">
		   <xsl:with-param name="date_range" select="rda:DateRange"/>
		 </xsl:call-template></w:t>
          </w:r>
        </w:p>
		</xsl:if>
      </w:tc>
      <w:tc>
        <w:tcPr>
          <xsl:choose>
            <xsl:when test="$COLS='j_c'">
              <w:tcW w:w="{$size_4}" w:type="dxa"/>
            </xsl:when>
            <xsl:when test="$COLS='no_j_c'">
              <w:tcW w:w="{$size_5}" w:type="dxa"/>
            </xsl:when>
            <xsl:otherwise>
              <w:tcW w:w="{$size_6}" w:type="dxa"/>
            </xsl:otherwise>
          </xsl:choose>
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
          <w:tcW w:w="{$size_2}" w:type="dxa"/>
        </w:tcPr>
         <xsl:if test="not(rda:Disposal[not(rda:DisposalCondition='Automated')])">
              <w:p/>
            </xsl:if>
        <xsl:call-template name="disposal_action">
          <xsl:with-param name="disposals" select="rda:Disposal"/>
        </xsl:call-template>
      </w:tc>
      <xsl:choose>
        <xsl:when test="$COLS='j_c' or $COLS='j'">
          <w:tc>
            <w:tcPr>
              <w:tcW w:w="{$size_2}" w:type="dxa"/>
            </w:tcPr>
            <xsl:if test="not(rda:Justification)">
              <w:p/>
            </xsl:if>
            <xsl:for-each select="rda:Justification">
				<xsl:choose>
				<xsl:when test="$SHOWSEEREF='false'">
				<xsl:choose>
				<xsl:when test="../rda:Disposal/rda:DisposalAction='Required as State archives'">
				<w:p/>
				</xsl:when> 
				<xsl:otherwise>
				<xsl:apply-templates/>
				</xsl:otherwise>
				</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
				<xsl:apply-templates/>
				</xsl:otherwise>
				</xsl:choose>
            </xsl:for-each>
          </w:tc>
        </xsl:when>
        <xsl:when test="$COLS='c'">
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
        </xsl:when>
      </xsl:choose>
      <xsl:if test="$COLS='j_c'">
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
		<xsl:when test="$SHOWSEEREF='false' and rda:Disposal/rda:DisposalAction='Required as State archives'"/>
        <xsl:otherwise>
      <w:tr>
        <w:tc>
          <w:tcPr>
            <xsl:choose>
              <xsl:when test="$ORIENTATION='portrait'">
                <w:tcW w:w="9286" w:type="dxa"/>
              </xsl:when>
              <xsl:otherwise>
                <w:tcW w:w="14885" w:type="dxa"/>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:variable name="span">
              <xsl:choose>
                <xsl:when test="$COLS='no_j_c'">
                  <xsl:value-of select="'4'"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="'5'"/>
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
  </xsl:template>
</xsl:stylesheet>
