<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="utils.xsl"/>
    <xsl:variable name="AUTHORITY_HEAD">
    <xsl:text>Australian Society of Archivists</xsl:text>
  </xsl:variable>
  <xsl:variable name="AUTHORITY_TITLE">
    <xsl:text>Records Retention &amp; Disposal Schedule for Non-Government Schools</xsl:text>
  </xsl:variable>
  <xsl:variable name="SHORT_TITLE">
    <xsl:text>ASA RRDS for Non-Government Schools</xsl:text>
  </xsl:variable>
  <xsl:variable name="LEFT_SUB">
    <xsl:text>Version 2</xsl:text>
  </xsl:variable>
  <xsl:variable name="RIGHT_SUB">
    <xsl:text>April 2018</xsl:text>
  </xsl:variable>
  <xsl:variable name="DIRECTOR">
    <xsl:value-of select="'Geoff Hinchcliffe'"/>
  </xsl:variable>
  <xsl:variable name="MANAGER_ROLE">
    <xsl:value-of select="'Acting Manager'"/>
  </xsl:variable>
  <xsl:variable name="MANAGER">
    <xsl:value-of select="'Sally Irvine-Smith'"/>
  </xsl:variable>
  <xsl:variable name="CHAIR">
    <xsl:value-of select="'Anne Henderson AM'"/>
  </xsl:variable>
  <xsl:variable name="ARNO">
    <xsl:text>AR</xsl:text>
    <xsl:value-of select="rda:Authority/rda:ID[@control='AR']"/>
  </xsl:variable>
  <xsl:variable name="RDANO">
    <xsl:choose>
      <xsl:when test="rda:Authority/rda:ID[@control='FA' or @control='GA' or @control='DA' or @control='GDA' or @control='DR']">
        <xsl:for-each select="rda:Authority/rda:ID[@control='FA' or @control='GA' or @control='DA' or @control='GDA' or @control='DR']">
          <xsl:if test="position() &gt;1">
            <xsl:text>, </xsl:text>
          </xsl:if>
          <xsl:value-of select="concat(@control, .)"/>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>DRAFT</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="SRFILENOS">
    <xsl:for-each select="rda:Authority/rda:ID[@control='SRFileNo']">
      <xsl:if test="position() &gt;1">
        <xsl:text>, </xsl:text>
      </xsl:if>
      <xsl:value-of select="."/>
    </xsl:for-each>
  </xsl:variable>
  <!-- list of agencies: either to whom the authority was issued or who were involved in drafting it-->
  <xsl:variable name="AGENCY_NAMES">
    <xsl:choose>
      <xsl:when test="rda:Authority/rda:Status/rda:Issued">
        <xsl:for-each select="rda:Authority/rda:Status/rda:Issued">
          <xsl:if test="position() &gt;1">
            <xsl:choose>
              <xsl:when test="position()=last()">
                <xsl:text>and </xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>, </xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
          <xsl:value-of select="rda:Agency"/>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="rda:Authority/rda:Status/rda:Draft[not(rda:Agency = preceding-sibling::rda:Draft/rda:Agency)]">
          <xsl:if test="position() &gt;1">
            <xsl:choose>
              <xsl:when test="position()=last()">
                <xsl:text>and </xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>, </xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
          <xsl:value-of select="rda:Agency"/>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="AGENCY_NOS">
    <xsl:choose>
      <xsl:when test="rda:Authority/rda:Status/rda:Issued">
        <xsl:for-each select="rda:Authority/rda:Status/rda:Issued">
          <xsl:if test="position() &gt;1">
            <xsl:choose>
              <xsl:when test="position()=last()">
                <xsl:text>and </xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>, </xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
          <xsl:value-of select="rda:Agency/@agencyno"/>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="rda:Authority/rda:Status/rda:Draft[not(rda:Agency = preceding-sibling::rda:Draft/rda:Agency)]">
          <xsl:if test="position() &gt;1">
            <xsl:choose>
              <xsl:when test="position()=last()">
                <xsl:text>and </xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>, </xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
          <xsl:value-of select="rda:Agency/@agencyno"/>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="AUTHORITY_TYPE">
    <xsl:choose>
      <xsl:when test="rda:Authority/rda:ID[@control='GA' or @control='GDA']">
        <xsl:text>General Retention and Disposal Authority</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>Functional Retention and Disposal Authority</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="AUTHORITY_TYPE_LC">
    <xsl:choose>
      <xsl:when test="rda:Authority/rda:ID[@control='GA' or @control='GDA']">
        <xsl:text>general retention and disposal authority</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>retention and disposal authority</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="SCOPE" select="rda:Authority/rda:Scope"/>
  <xsl:variable name="DATE_RANGE">
    <xsl:choose>
      <xsl:when test="rda:Authority/rda:DateRange">
        <xsl:call-template name="make_date_text">
          <xsl:with-param name="date_range" select="rda:Authority/rda:DateRange"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="//rda:DateRange">
            <xsl:text>Various</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>Open</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="DATETEXT">
    <xsl:choose>
      <xsl:when test="rda:Authority/rda:DateRange">
        <xsl:for-each select="rda:Authority/rda:DateRange">
          <xsl:choose>
            <xsl:when test="not(rda:End)">
              <xsl:text>from </xsl:text>
              <xsl:if test="rda:Start/@circa='true'">
                <xsl:text>c.</xsl:text>
              </xsl:if>
              <xsl:value-of select="rda:Start"/>
              <xsl:text>onwards</xsl:text>
            </xsl:when>
            <xsl:when test="not(rda:Start)">
              <xsl:text>before </xsl:text>
              <xsl:if test="rda:End/@circa='true'">
                <xsl:text>c.</xsl:text>
              </xsl:if>
              <xsl:value-of select="rda:End"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>from </xsl:text>
              <xsl:if test="rda:Start/@circa='true'">
                <xsl:text>c.</xsl:text>
              </xsl:if>
              <xsl:value-of select="rda:Start"/>
              <xsl:text>to </xsl:text>
              <xsl:if test="rda:End/@circa='true'">
                <xsl:text>c.</xsl:text>
              </xsl:if>
              <xsl:value-of select="rda:End"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="ISSUE_DATE">
    <xsl:choose>
      <xsl:when test="rda:Authority/rda:Status/rda:Issued/rda:Date">
        <xsl:value-of select="rda:Authority/rda:Status/rda:Issued/rda:Date"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>XXXX-XX-XX</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="ISSUE_YEAR">
    <xsl:value-of select="substring($ISSUE_DATE, 1, 4)"/>
  </xsl:variable>
  <xsl:variable name="ISSUE_MONTH">
    <xsl:value-of select="substring($ISSUE_DATE, 6, 2)"/>
  </xsl:variable>
  <xsl:variable name="ISSUE_DAY">
    <xsl:value-of select="substring($ISSUE_DATE, 9, 2)"/>
  </xsl:variable>
  <xsl:variable name="DRAFT_VERSION">
    <xsl:for-each select="rda:Authority/rda:Status/rda:Draft[@version]">
      <xsl:sort order="descending" select="@version"/>
      <xsl:if test="position() = 1">
        <xsl:value-of select="@version"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:variable>
  <xsl:variable name="DRAFT_AGENCIES">
    <xsl:for-each select="rda:Authority/rda:Status/rda:Draft[@version=$DRAFT_VERSION]">
      <xsl:if test="position() &gt;1">
        <xsl:choose>
          <xsl:when test="position()=last()">
            <xsl:text>and </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>, </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      <xsl:value-of select="rda:Agency"/>
    </xsl:for-each>
  </xsl:variable>
  <xsl:variable name="draft_y_m_d">
    <xsl:value-of select="rda:Authority/rda:Status/rda:Draft[@version=$DRAFT_VERSION]/rda:Date"/>
  </xsl:variable>
  <xsl:variable name="draft_month">
    <xsl:call-template name="monthname">
      <xsl:with-param name="month" select="substring($draft_y_m_d, 6, 2)"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="DRAFT_DATE">
    <xsl:value-of select="concat($draft_month, ' ', substring($draft_y_m_d, 1, 2))"/>
  </xsl:variable>
</xsl:stylesheet>