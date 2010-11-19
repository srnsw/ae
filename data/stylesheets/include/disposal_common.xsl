<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rda="http://www.records.nsw.gov.au/schemas/RDA" version="1.0">
  <xsl:template name="disposal_action">
    <xsl:param name="disposals"/>
    <xsl:param name="is_text" select="'false'"/>
    <xsl:choose>
      <xsl:when test="$disposals/rda:DisposalCondition">
        <xsl:choose>
        <!-- if there is a disposal element with an authorised condition, just choose it-->
          <xsl:when test="$disposals/rda:DisposalCondition='Authorised'">
            <xsl:call-template name="standard_action">
              <xsl:with-param name="disposal" select="$disposals[rda:DisposalCondition='Authorised']"/>
            </xsl:call-template>
          </xsl:when>
          <!-- send if longer/shorter conditions to multiple action template for processing-->
          <xsl:when test="$disposals/rda:DisposalCondition='If longer'">
            <xsl:call-template name="multiple_action">
              <xsl:with-param name="disposals" select="$disposals[rda:DisposalCondition='If longer']"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="$disposals/rda:DisposalCondition='If shorter'">
            <xsl:call-template name="multiple_action">
              <xsl:with-param name="disposals" select="$disposals[rda:DisposalCondition='If shorter']"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
          <!-- ignore any automated conditions, process the rest-->
            <xsl:for-each select="$disposals[not(rda:DisposalCondition='Automated')]">
            <xsl:if test="(position() &gt; 1) and (not($is_text='false'))">
              <xsl:choose>
                <xsl:when test="$is_text='plone'">
                  <br/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>\n</xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
              <xsl:call-template name="standard_action">
                <xsl:with-param name="disposal" select="."/>
                <xsl:with-param name="condition" select="rda:DisposalCondition"/>
              </xsl:call-template>
            </xsl:for-each>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <!-- if there are multiple disposal elements but no conditions (naughty!) and you want text output-->
      <xsl:when test="$disposals[2] and (not($is_text='false'))">
        <xsl:for-each select="$disposals">
            <xsl:if test="(position() &gt; 1)">
              <xsl:choose>
                <xsl:when test="$is_text='plone'">
                  <br/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>\n</xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
              <xsl:call-template name="standard_action">
                <xsl:with-param name="disposal" select="."/>
              </xsl:call-template>
            </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="standard_action">
          <xsl:with-param name="disposal" select="$disposals"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="custody">
    <xsl:param name="disposals"/>
    <xsl:param name="is_text" select="'false'"/>
    <xsl:choose>
      <xsl:when test="$disposals/rda:DisposalCondition">
        <xsl:choose>
          <xsl:when test="$disposals/rda:DisposalCondition='Authorised'">
            <xsl:call-template name="standard_custody">
              <xsl:with-param name="disposal" select="$disposals[rda:DisposalCondition='Authorised']"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="$disposals/rda:DisposalCondition='If longer'">
            <xsl:call-template name="multiple_custody">
              <xsl:with-param name="disposals" select="$disposals[rda:DisposalCondition='If longer']"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="$disposals/rda:DisposalCondition='If shorter'">
            <xsl:call-template name="multiple_custody">
              <xsl:with-param name="disposals" select="$disposals[rda:DisposalCondition='If shorter']"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:for-each select="$disposals[not(rda:DisposalCondition='Automated')]">
            <xsl:if test="(position() &gt; 1) and (not($is_text='false'))">
              <xsl:choose>
                <xsl:when test="$is_text='plone'">
                  <br/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>\n</xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
              <xsl:call-template name="standard_custody">
                <xsl:with-param name="disposal" select="."/>
                <xsl:with-param name="condition" select="rda:DisposalCondition"/>
              </xsl:call-template>
            </xsl:for-each>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <!-- if there are multiple disposal elements but no conditions (naughty!) and you want text output-->
      <xsl:when test="$disposals[2] and (not($is_text='false'))">
        <xsl:for-each select="$disposals">
            <xsl:if test="(position() &gt; 1)">
              <xsl:choose>
                <xsl:when test="$is_text='plone'">
                  <br/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>\n</xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
              <xsl:call-template name="standard_custody">
                <xsl:with-param name="disposal" select="."/>
              </xsl:call-template>
            </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="standard_custody">
          <xsl:with-param name="disposal" select="$disposals"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="retention_string">
    <xsl:param name="disposal"/>
    <xsl:choose>
      <xsl:when test="$disposal/rda:RetentionPeriod">
        <xsl:variable name="initialunit" select="$disposal/rda:RetentionPeriod/@unit"/>
        <xsl:choose>
          <xsl:when test="$disposal/rda:RetentionPeriod='1'">
            <xsl:value-of select="concat('minimum of 1 ', substring-before($initialunit,'s'))"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="concat('minimum of ', $disposal/rda:RetentionPeriod, ' ', $initialunit)"/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="$disposal/rda:DisposalTrigger">
          <xsl:value-of select="concat(' after ', $disposal/rda:DisposalTrigger)"/>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$disposal/rda:DisposalTrigger">
          <xsl:value-of select="concat('until ', $disposal/rda:DisposalTrigger)"/>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="standard_string">
    <xsl:param name="disposal"/>
    <xsl:for-each select="$disposal">
      <xsl:choose>
        <xsl:when test="rda:RetentionPeriod | rda:DisposalTrigger">
          <xsl:variable name="suffix">
            <xsl:choose>
              <xsl:when test="rda:DisposalAction='Required as State archives'">
                <xsl:text>, then transfer</xsl:text>
              </xsl:when>
              <xsl:when test="rda:DisposalAction='Transfer'">
                <xsl:text>, then transfer</xsl:text>
                <xsl:if test="rda:TransferTo">
                  <xsl:text> to </xsl:text>
                  <xsl:value-of select="rda:TransferTo"/>
                </xsl:if>
              </xsl:when>
              <xsl:when test="rda:DisposalAction='Destroy'">
                <xsl:text>, then destroy</xsl:text>
              </xsl:when>
            </xsl:choose>
          </xsl:variable>
          <xsl:text>Retain </xsl:text>
          <xsl:call-template name="retention_string">
            <xsl:with-param name="disposal" select="."/>
          </xsl:call-template>
          <xsl:value-of select="$suffix"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="rda:DisposalAction='Transfer'">
              <xsl:text>Transfer</xsl:text>
              <xsl:if test="rda:TransferTo">
                <xsl:text> to </xsl:text>
                <xsl:value-of select="rda:TransferTo"/>
              </xsl:if>
            </xsl:when>
            <xsl:when test="rda:DisposalAction='Destroy'">
              <xsl:text>Destroy</xsl:text>
            </xsl:when>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="multiple_string">
    <xsl:param name="disposals"/>
    <xsl:variable name="longer_shorter">
      <xsl:choose>
        <xsl:when test="$disposals[1]/rda:DisposalCondition='If longer'">
          <xsl:text>longer</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>shorter</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="suffix">
      <xsl:choose>
        <xsl:when test="$disposals[1]/rda:DisposalAction='Required as State archives'">
          <xsl:text>, then transfer</xsl:text>
        </xsl:when>
        <xsl:when test="$disposals[1]/rda:DisposalAction='Transfer'">
          <xsl:text>, then transfer</xsl:text>
          <xsl:if test="$disposals[1]/rda:TransferTo">
            <xsl:value-of select="concat(' to ', $disposals[1]/rda:TransferTo)"/>
          </xsl:if>
        </xsl:when>
        <xsl:when test="$disposals[1]/rda:DisposalAction='Destroy'">
          <xsl:text>, then destroy</xsl:text>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:text>Retain </xsl:text>
    <xsl:for-each select="$disposals">
      <xsl:choose>
        <xsl:when test="position()=last()">
          <xsl:text> or </xsl:text>
        </xsl:when>
        <xsl:when test="position() &gt; 1">
          <xsl:text>, </xsl:text>
        </xsl:when>
      </xsl:choose>
      <xsl:call-template name="retention_string">
        <xsl:with-param name="disposal" select="."/>
      </xsl:call-template>
    </xsl:for-each>
    <xsl:value-of select="concat(', whichever is ', $longer_shorter, $suffix)"/>
  </xsl:template>
  <!--used for tsv stylesheet-->
  <xsl:template name="simple">
    <xsl:param name="disposals"/>
    <xsl:param name="action"/>
    <xsl:variable name="trigger_list" select="'//action completed/superseded/reference use ceases/administrative or reference use ceases/'"/>
    <xsl:choose>
      <xsl:when test="$disposals/rda:DisposalCondition='Automated'">
          <xsl:call-template name="router">
              <xsl:with-param name="disposal" select="$disposals[rda:DisposalCondition='Automated']"/>
              <xsl:with-param name="action" select="$action"/>
          </xsl:call-template>
      </xsl:when>
      <!-- if there are no disposal elements with a simple action, go no further-->
      <xsl:when test="not($disposals/rda:DisposalAction)">
          <xsl:if test="$action = 'simple_action' or $action = 'simple_trigger'">
              <xsl:value-of select= "'See authorised action'"/>
          </xsl:if>
      </xsl:when>
      <!-- if you have multiple elements (leaving out 'Authorised' ones), test if all elements have the same action -->
      <xsl:when test="$disposals[not(rda:DisposalCondition='Authorised')][2]">
        <xsl:choose>
          <xsl:when test="$action = 'simple_action'">
            <xsl:variable name="single_action">
              <xsl:call-template name="single_action">
                <xsl:with-param name="disposals" select="$disposals"/>
              </xsl:call-template>
            </xsl:variable>
            <xsl:choose>
              <xsl:when test="$single_action = 'true'">
                <!-- if simple actions all the same, just give the first action (don't call the router template because if transfer the action, don't want multiple transferees!-->
                <xsl:value-of select="$disposals/rda:DisposalAction"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select= "'See authorised action'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:when test="$action = 'simple_trigger'">
            <xsl:value-of select= "'See authorised action'"/>
          </xsl:when>           
          <xsl:otherwise/>
        </xsl:choose>  
      </xsl:when>
      <xsl:when test="$disposals[not(rda:DisposalCondition='Authorised')]">
        <xsl:choose>
          <xsl:when test="$action='simple_trigger' and not(contains($trigger_list, concat('/', $disposals[not(rda:DisposalCondition='Authorised')]/rda:DisposalTrigger, '/')))">
            <xsl:value-of select= "'See authorised action'"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="router">
              <xsl:with-param name="disposal" select="$disposals[not(rda:DisposalCondition='Authorised')]"/>
              <xsl:with-param name="action" select="$action"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <!-- in case there is only one element and it has an authorised condition-->
      <xsl:otherwise>
          <xsl:if test="$action = 'simple_action' or $action = 'simple_trigger'">
              <xsl:value-of select= "'See authorised action'"/>
          </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="router">
    <xsl:param name="disposal"/>
    <xsl:param name="action"/>
    <xsl:choose>
      <xsl:when test="$action = 'simple_action'">
        <xsl:call-template name="simple_action">
          <xsl:with-param name="disposal" select="$disposal"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$action = 'simple_years'">
        <xsl:call-template name="simple_years">
          <xsl:with-param name="disposal" select="$disposal"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$action = 'simple_months'">
        <xsl:call-template name="simple_months">
          <xsl:with-param name="disposal" select="$disposal"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$action = 'simple_trigger'">
        <xsl:call-template name="simple_trigger">
          <xsl:with-param name="disposal" select="$disposal"/>
        </xsl:call-template>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="simple_action">
    <xsl:param name="disposal"/>
    <xsl:for-each select="$disposal">
    <xsl:choose>
      <xsl:when test="rda:DisposalAction='Transfer'">
        <xsl:text>Transfer</xsl:text>
        <xsl:if test="rda:TransferTo">
          <xsl:text> to </xsl:text>
          <xsl:value-of select="rda:TransferTo"/>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="rda:DisposalAction"/>
      </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="simple_years">
    <xsl:param name="disposal"/>
    <xsl:for-each select="$disposal">
      <xsl:choose>
        <xsl:when test="rda:RetentionPeriod[@unit='years']">
          <xsl:value-of select="rda:RetentionPeriod[@unit='years']"/>
        </xsl:when>
        <xsl:when test="rda:RetentionPeriod[@unit='months']">0</xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="simple_months">
    <xsl:param name="disposal"/>
        <xsl:for-each select="$disposal">
      <xsl:choose>
        <xsl:when test="rda:RetentionPeriod[@unit='months']">
          <xsl:value-of select="rda:RetentionPeriod[@unit='months']"/>
        </xsl:when>
        <xsl:when test="rda:RetentionPeriod[@unit='years']">0</xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="simple_trigger">
    <xsl:param name="disposal"/>
        <xsl:value-of select="$disposal/rda:DisposalTrigger"/>
  </xsl:template>
  <!-- if multiple disposal elements test to see if all disposal actions are the same -->
  <xsl:template name="single_action">
    <xsl:param name="disposals"/>
    <xsl:call-template name="check_action">
      <xsl:with-param name="subsequent" select="$disposals[rda:DisposalAction][position() &gt; 1]"/>
      <xsl:with-param name="first" select="$disposals[rda:DisposalAction][1]"/>
    </xsl:call-template>
   </xsl:template>
  <xsl:template name="check_action">
    <xsl:param name="subsequent"/>
    <xsl:param name="first"/>
    <xsl:choose>
      <xsl:when test="not($subsequent)">
        <xsl:value-of select="'true'"/>
      </xsl:when>
      <xsl:when test="$first/rda:DisposalAction = $subsequent[1]/rda:DisposalAction">
        <xsl:call-template name="check_action">
          <xsl:with-param name="subsequent" select="$subsequent[position() &gt; 1]"/>
          <xsl:with-param name="first" select="$first"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'false'"/>
      </xsl:otherwise>
    </xsl:choose>  
  </xsl:template>
</xsl:stylesheet>
