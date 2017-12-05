<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:variable name="upperCaseChars" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
  <xsl:variable name="lowerCaseChars" select="'abcdefghijklmnopqrstuvwxyz'"/>
  <xsl:template name="camel_case">
    <xsl:param name="string"/>
    <xsl:param name="strict" select="'false'"/>
    <xsl:variable name="first_letter" select="substring($string, 1, 1)"/>
    <xsl:variable name="remainder" select="substring($string, 2)"/>
    <xsl:variable name="rest">
      <xsl:choose>
        <xsl:when test="$strict='true'">
          <xsl:value-of select="translate($remainder, $upperCaseChars, $lowerCaseChars)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$remainder"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="first_up" select="translate($first_letter, $lowerCaseChars, $upperCaseChars)"/>
    <xsl:value-of select="concat($first_up, $rest)"/>
  </xsl:template>
  <xsl:template name="lower_case">
    <xsl:param name="string"/>
    <xsl:value-of select="translate($string, $upperCaseChars, $lowerCaseChars)"/>
  </xsl:template>
  <!-- turn a month number into a month name -->
  <xsl:template name="monthname">
    <xsl:param name="month"/>
    <xsl:choose>
      <xsl:when test="$month = '01'">
        <xsl:text>January</xsl:text>
      </xsl:when>
      <xsl:when test="$month = '02'">
        <xsl:text>February</xsl:text>
      </xsl:when>
      <xsl:when test="$month = '03'">
        <xsl:text>March</xsl:text>
      </xsl:when>
      <xsl:when test="$month = '04'">
        <xsl:text>April</xsl:text>
      </xsl:when>
      <xsl:when test="$month = '05'">
        <xsl:text>May</xsl:text>
      </xsl:when>
      <xsl:when test="$month = '06'">
        <xsl:text>June</xsl:text>
      </xsl:when>
      <xsl:when test="$month = '07'">
        <xsl:text>July</xsl:text>
      </xsl:when>
      <xsl:when test="$month = '08'">
        <xsl:text>August</xsl:text>
      </xsl:when>
      <xsl:when test="$month = '09'">
        <xsl:text>September</xsl:text>
      </xsl:when>
      <xsl:when test="$month = '10'">
        <xsl:text>October</xsl:text>
      </xsl:when>
      <xsl:when test="$month = '11'">
        <xsl:text>November</xsl:text>
      </xsl:when>
      <xsl:when test="$month = '12'">
        <xsl:text>December</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$month"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--Build an address with an item number e.g. "Function - Activity - Item number"-->
  <xsl:template name="build_address_with_itemno">
    <xsl:param name="node"/>
    <xsl:call-template name="build_address">
      <xsl:with-param name="node" select="$node"/>
    </xsl:call-template>
    <xsl:if test="$node/@itemno">
      <xsl:text>- </xsl:text>
      <xsl:value-of select="$node/@itemno"/>
    </xsl:if>
  </xsl:template>
  <!--Build an address e.g. "Function - Activity"-->
  <xsl:template name="build_address">
    <xsl:param name="node"/>
    <xsl:param name="parents" select="''"/>
    <xsl:param name="sep" select="' - '"/>
    <xsl:choose>
      <xsl:when test="$node[self::rda:Authority]">
        <xsl:value-of select="$parents"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="$node">
          <xsl:variable name="title">
            <xsl:if test="self::rda:Term">
              <xsl:if test="parent::rda:Term">
                <xsl:value-of select="$sep"/>
              </xsl:if>
              <xsl:value-of select="rda:TermTitle"/>
            </xsl:if>
          </xsl:variable>
          <xsl:call-template name="build_address">
            <xsl:with-param name="node" select=".."/>
            <xsl:with-param name="parents" select="concat($title, $parents)"/>
          </xsl:call-template>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--test if a custody column is necessary-->
  <xsl:template name="hascustody">
    <xsl:param name="classes"/>
    <xsl:choose>
      <xsl:when test="not($classes)">
        <xsl:text>false</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$classes[1]/rda:Disposal/rda:DisposalCondition='Authorised'">
            <xsl:call-template name="testcustody">
              <xsl:with-param name="disposals" select="$classes[1]/rda:Disposal[rda:DisposalCondition='Authorised']"/>
              <xsl:with-param name="classes" select="$classes[position() &gt; 1]"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="testcustody">
              <xsl:with-param name="disposals" select="$classes[1]/rda:Disposal[not(rda:DisposalCondition='Automated')]"/>
              <xsl:with-param name="classes" select="$classes[position() &gt; 1]"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="testcustody">
    <xsl:param name="disposals"/>
    <xsl:param name="classes"/>
    <xsl:choose>
      <xsl:when test="not($disposals)">
        <xsl:call-template name="hascustody">
          <xsl:with-param name="classes" select="$classes"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$disposals[1]/rda:CustomCustody">
            <xsl:text>true</xsl:text>
          </xsl:when>
          <xsl:when test="$disposals[1]/rda:DisposalAction='Required as State archives'">
            <xsl:choose>
              <xsl:when test="$disposals[1]/rda:RetentionPeriod or $disposals[1]/rda:DisposalTrigger">
                <xsl:text>true</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="testcustody">
                  <xsl:with-param name="disposals" select="$disposals[position() &gt; 1]"/>
                  <xsl:with-param name="classes" select="$classes"/>
                </xsl:call-template>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="testcustody">
              <xsl:with-param name="disposals" select="$disposals[position() &gt; 1]"/>
              <xsl:with-param name="classes" select="$classes"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- this traverses up the node tree and returns the first RDANO found -useful for authorities with multiple RDANOs-->
  <xsl:template name="local_id">
    <xsl:param name="node"/>
    <xsl:for-each select="$node">
      <xsl:variable name="id">
        <xsl:call-template name="get_id">
          <xsl:with-param name="node" select="."/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="$id != 'false'">
          <xsl:value-of select="$id"/>
        </xsl:when>
        <xsl:when test="parent::*">
          <xsl:call-template name="local_id">
            <xsl:with-param name="node" select="parent::*"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'DRAFT'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="get_id">
    <xsl:param name="node"/>
    <xsl:choose>
      <xsl:when test="$node/rda:ID[@control='FA' or @control='GA' or @control='DA' or @control='GDA' or @control='DR']">
        <xsl:for-each select="$node/rda:ID[@control='FA' or @control='GA' or @control='DA' or @control='GDA' or @control='DR']">
          <xsl:if test="position() &gt;1">
            <xsl:text>, </xsl:text>
          </xsl:if>
          <xsl:value-of select="concat(@control, .)"/>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>false</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="pad_itemno">
    <xsl:param name="prefix" select="''"/>
    <xsl:param name="suffix"/>
    <xsl:choose>
      <xsl:when test="contains($suffix, '.')">
        <xsl:variable name="padded">
          <xsl:call-template name="pad_no">
            <xsl:with-param name="no" select="substring-before($suffix, '.')"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:call-template name="pad_itemno">
          <xsl:with-param name="prefix" select="concat($prefix, $padded, '.')"/>
          <xsl:with-param name="suffix" select="substring-after($suffix, '.')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="padded">
          <xsl:call-template name="pad_no">
            <xsl:with-param name="no" select="$suffix"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="concat($prefix, $padded)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="pad_no">
    <xsl:param name="no"/>
    <xsl:choose>
      <xsl:when test="string-length($no) &lt; 2">
        <xsl:value-of select="concat('0', $no)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$no"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="titleise">
    <xsl:param name="title"/>
    <xsl:variable name="illegal" select="' ,()'"/>
    <xsl:variable name="clean" select="'-'"/>
    <xsl:choose>
      <xsl:when test="contains($title, '&amp;')">
        <xsl:value-of select="translate(concat(substring-before($title, '&amp;'), 'and', substring-after($title, '&amp;')), $illegal, $clean)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="translate($title, $illegal, $clean)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="make_date_text">
    <xsl:param name="date_range"/>
    <xsl:for-each select="$date_range">
      <xsl:choose>
        <xsl:when test="not(rda:End)">
          <xsl:if test="rda:Start/@circa='true'">
            <xsl:text>c.</xsl:text>
          </xsl:if>
          <xsl:value-of select="rda:Start"/>
          <xsl:text>+</xsl:text>
        </xsl:when>
        <xsl:when test="not(rda:Start)">
          <xsl:text>pre-</xsl:text>
          <xsl:if test="rda:End/@circa='true'">
            <xsl:text>c.</xsl:text>
          </xsl:if>
          <xsl:value-of select="rda:End"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:if test="rda:Start/@circa='true'">
            <xsl:text>c.</xsl:text>
          </xsl:if>
          <xsl:value-of select="rda:Start"/>
          <xsl:text>-</xsl:text>
          <xsl:if test="rda:End/@circa='true'">
            <xsl:text>c.</xsl:text>
          </xsl:if>
          <xsl:value-of select="rda:End"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>