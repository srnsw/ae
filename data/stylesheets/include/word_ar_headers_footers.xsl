<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="word_logo.xsl"/>
  <xsl:template name="ar_header_footer">
    <xsl:param name="header_first" select="''"/>
    <xsl:param name="header_first_x" select="''"/>
    <xsl:param name="footer_text" select="''"/>
    <xsl:param name="footer_first_a" select="''"/>
    <xsl:param name="footer_first_a_x" select="''"/>
    <xsl:param name="footer_first_b" select="''"/>
    <xsl:param name="footer_first_c" select="''"/>
    <xsl:param name="tab" select="''"/>
    <xsl:param name="gaadmin" select="'false'"/>
    <xsl:call-template name="hdr_odd" />
    <xsl:call-template name="ftr">
      <xsl:with-param name="type" select="'odd'"/>
      <xsl:with-param name="text" select="$footer_text"/>
      <xsl:with-param name="sub_a" select="$footer_first_a"/>
      <xsl:with-param name="sub_a_x" select="$footer_first_a_x"/>
      <xsl:with-param name="sub_b" select="$footer_first_b"/>
      <xsl:with-param name="sub_c" select="$footer_first_c"/>
    </xsl:call-template>
    <xsl:call-template name="hdr_first">
      <xsl:with-param name="text" select="$header_first"/>
      <xsl:with-param name="text_x" select="$header_first_x"/>
    </xsl:call-template>
    <xsl:call-template name="ftr">
      <xsl:with-param name="type" select="'first'"/>
      <xsl:with-param name="text" select="$footer_text"/>
      <xsl:with-param name="sub_a" select="$footer_first_a"/>
      <xsl:with-param name="sub_a_x" select="$footer_first_a_x"/>
      <xsl:with-param name="sub_b" select="$footer_first_b"/>
      <xsl:with-param name="sub_c" select="$footer_first_c"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="hdr_odd">
    <w:hdr w:type="odd">
      <w:p>
        <w:pPr>
          <w:pStyle w:val="Header"/>
        </w:pPr>
        <w:r>
          <w:t/>
        </w:r>
      </w:p>
    </w:hdr>
  </xsl:template>
  <xsl:template name="hdr_first">
    <xsl:param name="text"/>
    <xsl:param name="text_x"/>
    <w:hdr w:type="first">
      <w:p>
        <w:pPr>
          <w:pStyle w:val="Header"/>
          <w:ind w:left="-709"/>
          <w:jc w:val="left"/>
        </w:pPr>
        <w:r>
          <xsl:call-template name="word_logo"/>
        </w:r>
        <w:r>
          <w:tab/>
        </w:r>
        <w:r>
          <w:rPr>
            <wx:font wx:val="Verdana"/>
            <w:b/>
            <w:color w:val="0070C0"/>
            <w:sz w:val="28"/>
          </w:rPr>
          <w:t>
            <xsl:value-of select="$text"/>
          </w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <wx:font wx:val="Verdana"/>
            <w:b/>
            <w:color w:val="0070C0"/>
            <w:sz w:val="28"/>
            <w:highlight w:val="yellow"/>
          </w:rPr>
          <w:t>
            <xsl:value-of select="$text_x"/>
          </w:t>
        </w:r>
      </w:p>
    </w:hdr>
  </xsl:template>
  <xsl:template name="ftr">
    <xsl:param name="type"/>
    <xsl:param name="text"/>
    <xsl:param name="sub_a"/>
    <xsl:param name="sub_a_x"/>
    <xsl:param name="sub_b"/>
    <xsl:param name="sub_c"/>
    <w:ftr w:type="{$type}">
      <w:p>
        <w:pPr>
          <w:pStyle w:val="Footer"/>
          <w:jc w:val="center"/>
        </w:pPr>
        <w:r>
          <w:t>
            <xsl:value-of select="$text"/>
          </w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:pPr>
          <w:pStyle w:val="Footer"/>
          <w:tabs>
            <w:tab w:pos="4500" w:val="center"/>
          </w:tabs>
        </w:pPr>
        <w:r>
          <w:t>
            <xsl:value-of select="$sub_a"/>
          </w:t>
        </w:r>
         <w:r>
           <w:rPr>
            <w:highlight w:val="yellow"/>
          </w:rPr>
          <w:t>
            <xsl:value-of select="$sub_a_x"/>
          </w:t>
        </w:r>
        <w:r>
          <w:tab/>
        </w:r>
        <w:r>
          <w:t>
            <xsl:value-of select="$sub_b"/>
          </w:t>
        </w:r>
        <w:r>
          <w:tab/>
        </w:r>
        <w:r>
          <w:t>
            <xsl:value-of select="$sub_c"/>
          </w:t>
        </w:r>
      </w:p>
    </w:ftr>
  </xsl:template>
</xsl:stylesheet>