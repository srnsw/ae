<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:aml="http://schemas.microsoft.com/aml/2001/core" xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" xmlns:o="urn:schemas-microsoft-com:office:office" version="1.0">
  <xsl:output method="xml" indent="yes"/>
  <xsl:include href="include/stocks.xsl"/>
  <xsl:include href="include/word_header.xsl"/>
  <xsl:include href="include/word_headers_footers.xsl"/>
  <xsl:include href="include/render_word.xsl"/>
  <xsl:template match="rda:Authority">
    <xsl:processing-instruction name="mso-application">
      <xsl:text>progid="Word.Document"</xsl:text>
    </xsl:processing-instruction>
    <w:wordDocument w:macrosPresent="no" w:embeddedObjPresent="no" w:ocxPresent="no" xml:space="preserve">
			<xsl:call-template name="word_header"/>
			<w:body>
			 <w:p>
              <w:pPr>
                <w:pStyle w:val="Heading2"/>
              </w:pPr>
              <w:r>
                <w:t><xsl:text>Comments on </xsl:text><xsl:value-of select="$DRAFT_AGENCIES"/><xsl:text> draft </xsl:text><xsl:value-of select="AUTHORITY_TYPE_LC"/><xsl:text> (version </xsl:text><xsl:value-of select="$DRAFT_VERSION"/><xsl:text>, submitted </xsl:text><xsl:value-of select="$DRAFT_DATE"/><xsl:text>)</xsl:text></w:t>
              </w:r>
            </w:p>
            <w:p>
              <w:r>
                <w:t><xsl:text>This document outlines State Archives and Records NSW’s feedback on the draft functional retention and disposal authority developed by </xsl:text><xsl:value-of select="$DRAFT_AGENCIES"/><xsl:text>. Please also see the suggested changes in the amended authority.</xsl:text></w:t>
              </w:r>
            </w:p>
            <xsl:if test="rda:Comment[@author='SRNSW']">
              <w:p>
                <w:pPr>
                  <w:rPr>
                    <w:b/>
                    <w:u w:val="single"/>
                  </w:rPr>
                </w:pPr>
                <w:r>
                  <w:rPr>
                    <w:b/>
                    <w:u w:val="single"/>
                  </w:rPr>
                  <w:t><xsl:text>GENERAL COMMENTS</xsl:text></w:t>
                </w:r>
              </w:p>
            </xsl:if>
            <xsl:apply-templates select="rda:Comment[@author='SRNSW']"/>
            <xsl:if test="rda:Context/rda:Comment[@author='SRNSW']">
              <w:p>
                <w:pPr>
                  <w:rPr>
                    <w:b/>
                    <w:u w:val="single"/>
                  </w:rPr>
                </w:pPr>
                <w:r>
                  <w:rPr>
                    <w:b/>
                    <w:u w:val="single"/>
                  </w:rPr>
                  <w:t><xsl:text>SPECIFIC COMMENTS – SUPPORTING DOCUMENTATION</xsl:text></w:t>
                </w:r>
              </w:p>
            </xsl:if>
            <xsl:for-each select="rda:Context[rda:Comment/@author='SRNSW']">
              <w:p>
                <w:pPr>
                  <w:pStyle w:val="B1"/>
                  <w:tabs>
                    <w:tab w:val="clear" w:pos="584"/>
                  </w:tabs>
                  <w:ind w:left="0" w:first-line="0"/>
                  <w:rPr>
                    <w:b/>
                  </w:rPr>
                </w:pPr>
                <w:r>
                  <w:rPr>
                    <w:b/>
                  </w:rPr>
                  <w:t><xsl:value-of select="rda:ContextTitle"/></w:t>
                </w:r>
              </w:p>
              <xsl:for-each select="rda:Comment[@author='SRNSW']">
              <xsl:apply-templates select="rda:Paragraph"/>
              </xsl:for-each>
            </xsl:for-each>
            <xsl:if test="//rda:Term/rda:Comment[@author='SRNSW'] or //rda:Class/rda:Comment[@author='SRNSW']">
              <w:p>
                <w:pPr>
                  <w:rPr>
                    <w:b/>
                    <w:u w:val="single"/>
                  </w:rPr>
                </w:pPr>
                <w:r>
                  <w:rPr>
                    <w:b/>
                    <w:u w:val="single"/>
                  </w:rPr>
                  <w:t>SPECIFIC COMMENTS – FUNCTIONS AND ACTIVITIES</w:t>
                </w:r>
              </w:p>
            </xsl:if>
            <xsl:apply-templates select="//rda:Term[rda:Comment/@author='SRNSW'] | //rda:Class[rda:Comment/@author='SRNSW']"/>
			<wx:sect>
			<w:sectPr>
            <xsl:call-template name="portrait_header_footer"/>
            <w:pgSz w:w="11906" w:h="16838"/>
            <w:pgMar w:top="1440" w:right="941" w:bottom="1440" w:left="941" w:header="708" w:footer="708" w:gutter="0"/>
            <w:cols w:space="708"/>
            <w:docGrid w:line-pitch="360"/>
          </w:sectPr>
      </wx:sect>
    </w:body>
		</w:wordDocument>
  </xsl:template>
  <xsl:template match="rda:Term | rda:Class">
    <w:p>
      <w:pPr>
        <w:pStyle w:val="B1"/>
        <w:tabs>
          <w:tab w:val="clear" w:pos="584"/>
        </w:tabs>
        <w:ind w:left="0" w:first-line="0"/>
        <w:rPr>
          <w:b/>
        </w:rPr>
      </w:pPr>
      <w:r>
        <w:rPr>
          <w:b/>
        </w:rPr>
        <w:t><xsl:call-template name="build_address_with_itemno"><xsl:with-param name="node" select="."/></xsl:call-template></w:t>
      </w:r>
    </w:p>
    <xsl:for-each select="rda:Comment[@author='SRNSW']">
    <xsl:apply-templates select="rda:Paragraph"/>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
