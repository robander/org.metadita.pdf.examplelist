<?xml version="1.0"?>
<!-- Add the example list to the TOC + bookmarks, and
     create the generated topic. -->
<xsl:stylesheet version="2.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
                xmlns:ditamsg="http://dita-ot.sourceforge.net/ns/200704/ditamsg"
                xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="dita-ot ditamsg">
  
  <xsl:variable name="id.loe" select="'generated-list-of-examples'"/>
  
  <!-- Reuse LOT indentation and attribute styles -->
  <xsl:template match="ot-placeholder:examplelist | *[contains(@class, ' pdf2placeholder/examplelist ')]" mode="toc">
    <xsl:if test="//*[contains(@class, ' topic/example ')]/*[contains(@class, ' topic/title ' )]">
      <fo:block xsl:use-attribute-sets="__toc__indent__lot">
        <fo:block xsl:use-attribute-sets="__toc__topic__content__lot">
          <fo:basic-link internal-destination="{$id.loe}" xsl:use-attribute-sets="__toc__link">
            <fo:inline xsl:use-attribute-sets="__toc__title">
              <xsl:call-template name="getVariable">
                <xsl:with-param name="id" select="'List of Examples'"/>
              </xsl:call-template>
            </fo:inline>
            <fo:inline xsl:use-attribute-sets="__toc__page-number">
              <fo:leader xsl:use-attribute-sets="__toc__leader"/>
              <fo:page-number-citation ref-id="{$id.loe}"/>
            </fo:inline>
          </fo:basic-link>
        </fo:block>
      </fo:block>
    </xsl:if>
  </xsl:template>
  <xsl:template match="ot-placeholder:examplelist | *[contains(@class, ' pdf2placeholder/examplelist ')]" mode="bookmark">
    <xsl:if test="//*[contains(@class, ' topic/example ')]/*[contains(@class, ' topic/title ' )]">
      <fo:bookmark internal-destination="{$id.loe}">
        <xsl:if test="$bookmarkStyle!='EXPANDED'">
          <xsl:attribute name="starting-state">hide</xsl:attribute>
        </xsl:if>
        <fo:bookmark-title>
          <xsl:call-template name="getVariable">
            <xsl:with-param name="id" select="'List of Examples'"/>
          </xsl:call-template>
        </fo:bookmark-title>
        <xsl:apply-templates mode="bookmark"/>
      </fo:bookmark>
    </xsl:if>
  </xsl:template>
  
  <xsl:variable name="exampleset">
    <xsl:for-each select="//*[contains (@class, ' topic/example ')][*[contains(@class, ' topic/title ' )]]">
      <xsl:if test="dita-ot:notExcludedByDraftElement(.)">
        <xsl:copy>
          <xsl:copy-of select="@*"/>
          <xsl:if test="not(@id)">
            <xsl:attribute name="id">
              <xsl:call-template name="get-id"/>
            </xsl:attribute>
          </xsl:if>
        </xsl:copy>
      </xsl:if>
    </xsl:for-each>
  </xsl:variable>  
  
  <xsl:template match="*[contains(@class, ' bookmap/booklist ')][@outputclass='examplelist']" mode="generatePageSequences">
    <xsl:for-each select="key('topic-id', @id)">
      <xsl:choose>
        <xsl:when test="self::ot-placeholder:examplelist or contains(@class, ' pdf2placeholder/examplelist ')">
          <xsl:call-template name="createExampleList"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="processTopicSimple"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
  <xsl:template match="ot-placeholder:examplelist | *[contains(@class, ' pdf2placeholder/examplelist ')]" name="createExampleList">
    <xsl:if test="//*[contains(@class, ' topic/example ')]/*[contains(@class, ' topic/title ' )]">
      <!--exists tables with titles-->
      <fo:page-sequence master-reference="toc-sequence" xsl:use-attribute-sets="page-sequence.lot">
        <xsl:call-template name="insertTocStaticContents"/>
        <fo:flow flow-name="xsl-region-body">
          <fo:block start-indent="0in">
            <xsl:call-template name="createLOEHeader"/>
            
            <xsl:apply-templates select="//*[contains (@class, ' topic/example ')]
              [child::*[contains(@class, ' topic/title ' )]]
              [dita-ot:notExcludedByDraftElement(.)]"
              mode="list.of.examples"/>
          </fo:block>
        </fo:flow>
        
      </fo:page-sequence>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="createLOEHeader">
    <fo:block xsl:use-attribute-sets="__lotf__heading" id="{$id.loe}">
      <fo:marker marker-class-name="current-header">
        <xsl:call-template name="getVariable">
          <xsl:with-param name="id" select="'List of Examples'"/>
        </xsl:call-template>
      </fo:marker>
      <xsl:apply-templates select="." mode="customTopicMarker"/>
      <xsl:apply-templates select="." mode="customTopicAnchor"/>
      <xsl:call-template name="getVariable">
        <xsl:with-param name="id" select="'List of Examples'"/>
      </xsl:call-template>
    </fo:block>
  </xsl:template>
  
  <xsl:template match="*[contains (@class, ' topic/example ')][child::*[contains(@class, ' topic/title ' )]]" mode="list.of.examples">
    <fo:block xsl:use-attribute-sets="__lotf__indent">
      <fo:block xsl:use-attribute-sets="__lotf__content">
        <fo:basic-link xsl:use-attribute-sets="__toc__link">
          <xsl:attribute name="internal-destination">
            <xsl:call-template name="get-id"/>
          </xsl:attribute>
          
          <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-startprop ')]/revprop[@changebar]" mode="changebar">
            <xsl:with-param name="changebar-id" select="concat(dita-ot:generate-changebar-id(.),'-toc')"/>
          </xsl:apply-templates>
          
          <fo:inline xsl:use-attribute-sets="__lotf__title">
            <xsl:apply-templates select="./*[contains(@class, ' topic/title ')]" mode="insert-text"/>
          </fo:inline>
          
          <fo:inline xsl:use-attribute-sets="__lotf__page-number">
            <fo:leader xsl:use-attribute-sets="__lotf__leader"/>
            <fo:page-number-citation>
              <xsl:attribute name="ref-id">
                <xsl:call-template name="get-id"/>
              </xsl:attribute>
            </fo:page-number-citation>
          </fo:inline>
          
          <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-endprop ')]/revprop[@changebar]" mode="changebar">
            <xsl:with-param name="changebar-id" select="concat(dita-ot:generate-changebar-id(.),'-toc')"/>
          </xsl:apply-templates>
          
        </fo:basic-link>
      </fo:block>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>
