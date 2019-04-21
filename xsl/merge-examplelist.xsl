<?xml version="1.0"?>
<!-- Create the ot-placeholder:examplelist element along the lines of current
     figure and table list support.
     
     Add a generated ID to every example that has a title, so that we don't
     have to worry about creating IDs in the PDF override. -->
<xsl:stylesheet version="2.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
                xmlns:ditamsg="http://dita-ot.sourceforge.net/ns/200704/ditamsg"
                xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
                exclude-result-prefixes="dita-ot ditamsg">

  <xsl:template match="*[contains(@class,' topic/example ')][not(@id)][*[contains(@class,' topic/title ')]]">
    <xsl:param name="newid"/>
    <xsl:copy>
      <xsl:attribute name="id" select="concat('example_genid_',generate-id(.))"/>
      <xsl:apply-templates select="@*|*|comment()|processing-instruction()|text()">
        <xsl:with-param name="newid"/>
      </xsl:apply-templates>
    </xsl:copy>    
  </xsl:template>
  
  <xsl:template match="*[contains(@class,' bookmap/booklist ')][not(@href)][@outputclass='examplelist']" priority="2" mode="build-tree">
    <!--<ot-placeholder:examplelist id="{generate-id()}">
      <xsl:apply-templates mode="build-tree"/>
    </ot-placeholder:examplelist>-->
    <topic id="{generate-id()}" class="+ topic/topic pdf2placeholder/examplelist ">
      <title class="- topic/title ">
        <xsl:call-template name="getVariable">
          <xsl:with-param name="id" select="'List of Examples'"/>
        </xsl:call-template>
      </title>
      <!--body class=" topic/body "/-->
      <xsl:apply-templates mode="build-tree"/>
    </topic>
  </xsl:template>

</xsl:stylesheet>
