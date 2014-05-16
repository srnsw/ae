<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" version="1.0">
  <xsl:template match="rda:Paragraph">
    <w:p>
      <xsl:apply-templates/>
    </w:p>
  </xsl:template>
  <xsl:template match="rda:Emphasis">
    <w:r>
      <w:rPr>
        <w:b/>
      </w:rPr>
      <xsl:apply-templates/>
    </w:r>
  </xsl:template>
  <xsl:template match="rda:Source">
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
  </xsl:template>
  <xsl:template match="rda:List">
    <xsl:if test="preceding-sibling::text() or preceding-sibling::*">
      <xsl:text disable-output-escaping="yes">&lt;/w:p&gt;&lt;w:p&gt;</xsl:text>
    </xsl:if>
    <xsl:for-each select="rda:Item">
      <xsl:if test="preceding-sibling::rda:Item">
        <xsl:text disable-output-escaping="yes">&lt;w:p&gt;</xsl:text>
      </xsl:if>
      <w:pPr>
        <w:listPr>
          <w:ilvl w:val="0"/>
          <w:ilfo w:val="1"/>
          <wx:t wx:val="·" wx:wTabBefore="360" wx:wTabAfter="270"/>
          <wx:font wx:val="Symbol"/>
        </w:listPr>
      </w:pPr>
      <xsl:apply-templates/>
      <xsl:if test="following-sibling::rda:Item">
        <xsl:text disable-output-escaping="yes">&lt;/w:p&gt;</xsl:text>
      </xsl:if>
    </xsl:for-each>
    <xsl:if test="following-sibling::text() or following-sibling::*">
      <xsl:text disable-output-escaping="yes">&lt;/w:p&gt;&lt;w:p&gt;</xsl:text>
    </xsl:if>
  </xsl:template>
  <xsl:template match="text()">
    <w:r>
      <w:t>
        <xsl:value-of select="."/>
      </w:t>
    </w:r>
  </xsl:template>
  <xsl:template match="rda:SeeReference">
	  <xsl:if test="$SHOWSEEREF='true' or not(rda:IDRef)">
    <w:p>
      <w:r>
          <w:t><xsl:text>See </xsl:text></w:t>
      </w:r>
      <xsl:if test="rda:IDRef">
        <xsl:choose>
          <xsl:when test="rda:IDRef/@control = 'GA' or rda:IDRef/@control = 'GDA'">
            <w:r>
              <w:t><xsl:text>General Retention and Disposal Authority </xsl:text></w:t>
            </w:r>
          </xsl:when>
          <xsl:otherwise>
            <w:r>
              <w:t><xsl:text>Functional Retention and Disposal Authority </xsl:text></w:t>
            </w:r>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>  
      <xsl:if test="rda:AuthorityTitleRef">
        <w:r>
          <w:rPr>
            <w:i/>
          </w:rPr>
          <w:t><xsl:value-of select="rda:AuthorityTitleRef"/><xsl:text> </xsl:text></w:t>
        </w:r>
      </xsl:if>
      <xsl:for-each select="rda:TermTitleRef">
        <w:r>
          <w:rPr>
            <w:b/>
          </w:rPr>
          <w:t>
            <xsl:if test="position() &gt;1">
              <xsl:text>- </xsl:text>
            </xsl:if>
            <xsl:value-of select="."/>
            <xsl:text> </xsl:text>
          </w:t>
        </w:r>
      </xsl:for-each>
      <xsl:if test="rda:ItemNoRef">  
        <w:r>
          <w:t>      
            <xsl:value-of select="concat(rda:ItemNoRef, ' ')"/>
          </w:t>
        </w:r>
      </xsl:if>
      <xsl:if test="rda:SeeText">  
        <w:r>
          <w:t>      
            <xsl:value-of select="rda:SeeText"/>
          </w:t>
        </w:r>
      </xsl:if>
    </w:p>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
