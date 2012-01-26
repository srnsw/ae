<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" version="1.0">
  <xsl:include href="render_html.xsl"/>
  <xsl:include href="stocks.xsl"/>
  <xsl:include href="disposal_html.xsl"/>
  <xsl:include href="disposal_common.xsl"/>
  <xsl:template name="preview_contents">
       <tr valign="top">
            <td>
              <b>No.</b>
            </td>
            <td>
              <b>Function</b>
            </td>
            <td>
              <b>Description</b>
            </td>
            <td>
              <b>Disposal action</b>
            </td>
            <td>
              <b>Justfication</b>
            </td>
            <td>
              <b>Custody</b>
            </td>
            <xsl:if test="$SHOW_UPDATES='true'">
        <td>
        <b>Update</b>
      </td>
      </xsl:if>
          </tr>
    </xsl:template>
  <xsl:template match="rda:Term">
    <xsl:variable name="bgcolor">
      <xsl:choose>
        <xsl:when test="parent::rda:Authority">
          <xsl:text>#9FBFDF</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>#E3F8FF</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <tr valign="top" bgcolor="{$bgcolor}">
      <td>
        <p>
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
        </p>
      </td>
      <td>
        <p>
          <a name="{generate-id(.)}">
            <b>
            <xsl:choose>
              <xsl:when test="$SHOW_UPDATES='true'">
                <xsl:call-template name="build_address">
                  <xsl:with-param name="node" select="."/>
                </xsl:call-template>
              </xsl:when>
              <xsl:when test="rda:TermTitle">
                <xsl:value-of select="rda:TermTitle"/>
              </xsl:when>
              <xsl:when test="rda:DateRange">
				<xsl:text>Date range: </xsl:text>	   
				<xsl:call-template name="make_date_text">
				  <xsl:with-param name="date_range" select="rda:DateRange"/>
				</xsl:call-template>	 
			  </xsl:when>	  
            </xsl:choose>  
          </b>
          </a>
        </p>
        <xsl:if test="rda:DateRange and ($SHOW_UPDATES='true' or rda:TermTitle)">
		  <p>
			<b>
			  <xsl:text>Date range: </xsl:text>	 
			  <xsl:call-template name="make_date_text">
			   <xsl:with-param name="date_range" select="rda:DateRange"/>
			  </xsl:call-template>
          </b>
        </p>
        </xsl:if>
      </td>
      <td>
        <xsl:for-each select="rda:TermDescription">
          <xsl:apply-templates/>
        </xsl:for-each>
      </td>
      <td/>
      <td/>
      <td/>
       <xsl:if test="$SHOW_UPDATES='true'">
        <td>
        <xsl:value-of select="@update"/>
      </td>
      </xsl:if>
    </tr>
    <xsl:if test="$SHOW_COMMENTS='true'">
      <xsl:for-each select="rda:Comment">
        <tr class="{@author}" valign="top">
          <td>
            <p>
              <i>
                <xsl:value-of select="@author"/>
              </i>
            </p>
          </td>
          <td colspan="5">
            <xsl:apply-templates/>
          </td>
        </tr>
      </xsl:for-each>
    </xsl:if>
    <xsl:if test="$SHOW_UPDATES='false'">
    <xsl:apply-templates select="rda:Term | rda:Class"/>
    </xsl:if>
  </xsl:template>
  <xsl:template match="rda:Class">
    <tr valign="top" bgcolor="#F3F3F3">
      <td>
        <p>
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
        </p>
      </td>
      <td>
        <p>
          <a name="{generate-id(.)}">
          <b>
            <xsl:choose>
              <xsl:when test="$SHOW_UPDATES='true'">
                <xsl:call-template name="build_address">
                  <xsl:with-param name="node" select="."/>
                </xsl:call-template>
              </xsl:when>
              <xsl:when test="rda:ClassTitle">
                <xsl:value-of select="rda:ClassTitle"/>
              </xsl:when>
              <xsl:when test="rda:DateRange">
				<xsl:text>Date range: </xsl:text>	   
				<xsl:call-template name="make_date_text">
				  <xsl:with-param name="date_range" select="rda:DateRange"/>
				</xsl:call-template>	 
			  </xsl:when>	  
            </xsl:choose>  
          </b>
          </a>
        </p>
        <xsl:if test="rda:DateRange and ($SHOW_UPDATES='true' or rda:ClassTitle)">
		  <p>
			<b>
			  <xsl:text>Date range: </xsl:text>	 
			  <xsl:call-template name="make_date_text">
			   <xsl:with-param name="date_range" select="rda:DateRange"/>
			  </xsl:call-template>
			</b>
		  </p>  
		</xsl:if>
      </td>
      <td>
        <xsl:for-each select="rda:ClassDescription">
          <xsl:apply-templates/>
        </xsl:for-each>
      </td>
      <td>
        <xsl:call-template name="disposal_action">
          <xsl:with-param name="disposals" select="rda:Disposal"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:for-each select="rda:Justification">
          <xsl:apply-templates/>
        </xsl:for-each>
      </td>
      <td>
        <xsl:call-template name="custody">
          <xsl:with-param name="disposals" select="rda:Disposal"/>
        </xsl:call-template>
      </td>
      <xsl:if test="$SHOW_UPDATES='true'">
        <td>
        <xsl:value-of select="@update"/>
      </td>
      </xsl:if>
    </tr>
    <xsl:if test="$SHOW_COMMENTS='true'">
      <xsl:for-each select="rda:Comment">
        <tr class="{@author}" valign="top">
          <td>
            <p>
              <i>
                <xsl:value-of select="@author"/>
              </i>
            </p>
          </td>
          <td colspan="5">
            <xsl:apply-templates/>
          </td>
        </tr>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
