<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="word_approval_table.xsl"/>
  <xsl:template name="word_ar1">
    <w:p>
      <w:pPr>
        <w:pStyle w:val="ARTitle"/>
      </w:pPr>
      <w:r>
        <w:t>
          <xsl:text>Board of the </xsl:text>
          <xsl:value-of select="$ORG_LONG"/>
        </w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="ARH1"/>
      </w:pPr>
      <w:r>
        <w:t>
          <xsl:text>Submission</xsl:text>
        </w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:r>
        <w:t>
          <xsl:text>Request for approval of retention and disposal authorisation – </xsl:text>
          <xsl:value-of select="$SCOPE_TITLE" />
        </w:t>
      </w:r>
    </w:p>
    <!--xsl:if test="$SUBMITTED !=''">
      <w:p>
      <w:pPr>
        <w:pStyle w:val="ARH1"/>
      </w:pPr>
      <w:r>
        <w:t>
          <xsl:text>Public office submission</xsl:text>
        </w:t>
      </w:r>
    </w:p>
     <w:p>
      <w:r>
        <w:t>
           <xsl:text>The request for approval of this functional retention and disposal authority was submitted by </xsl:text>
           <xsl:value-of select="$SUBMITTED"/>
        </w:t>
      </w:r>
    </w:p>
    </xsl:if-->
    <xsl:apply-templates select="rda:Context[@type='appraisal report']"/>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="ARH1"/>
      </w:pPr>
      <w:r>
        <w:t>
          <xsl:text>Recommendation</xsl:text>
        </w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:r>
        <w:t>
          <xsl:text>It is recommended that the Board approve the retention and disposal practices outlined in the attached authority.</xsl:text>
        </w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="ARH1"/>
      </w:pPr>
      <w:r>
        <w:t>
          <xsl:text>Approve</xsl:text>
        </w:t>
      </w:r>
    </w:p>
    <xsl:call-template name="approval_table" />
  </xsl:template>
  <xsl:template match="rda:Context">
    <w:p>
      <w:pPr>
        <w:pStyle w:val="ARH1"/>
      </w:pPr>
      <w:r>
        <w:t>
          <xsl:value-of select="rda:ContextTitle"/>
        </w:t>
      </w:r>
    </w:p>
    <xsl:if test="not(rda:ContextContent)">
      <w:p/>
    </xsl:if>
    <xsl:for-each select="rda:ContextContent">
      <xsl:apply-templates select="rda:Paragraph"/>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>