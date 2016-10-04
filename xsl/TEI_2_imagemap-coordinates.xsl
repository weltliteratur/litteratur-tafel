<?xml version="1.0" encoding="UTF-8"?>
<!-- Generates areas for a .map File, that can be edited in the GIMP-Imagemap-Tool -->
<!-- also works for transforming zones to html:imagemap areas 
set the params accordingly:
Reference Points for the slices see wiki: https://github.com/weltliteratur/litteratur-tafel/wiki/Coordinates-cheat-sheet
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:littafel="https://github.com/weltliteratur/litteratur-tafel/ns"
  exclude-result-prefixes="xs"
  version="2.0">
  <xsl:output encoding="UTF-8" omit-xml-declaration="yes" indent="no" method="xml"/>

  <!-- PARAMETERS -->
  
  <!-- get areas for image of edition -->
  <xsl:param name="map-ed">
    <xsl:text>map-ed2</xsl:text>
  </xsl:param>
  
  <xsl:param name="reference-pt-old-x">
    3193
  </xsl:param>
  
  <xsl:param name="reference-pt-old-y">
    874
  </xsl:param>
  
  <xsl:param name="reference-pt-new-x">
    105
  </xsl:param>
  
  <xsl:param name="reference-pt-new-y">
    227
  </xsl:param>
  
  <!-- select x-range for extracting zones; allows slicing of SUB's image -->
  <xsl:param name="from-x-coordinate">
    <!-- SUB not sliced, maximum lrx value if bigger, would be next slice -->
    3082
  </xsl:param>
  <xsl:param name="to-x-coordinate">
    <!-- SUB not sliced, maximum lrx value if bigger, would be next slice -->
    4517
  </xsl:param>
  
 

  <!-- FUNCTIONS -->

<xsl:function name="littafel:translate_coordinate">
  <!-- translates a coordinate -->
  <!-- coordinate-value to be translated passed to the function -->
  <xsl:param name="coordinate"/>
  <!-- coordinate old reference point-old -->
  <xsl:param name="ref-pt-old-coordinate"/>
  <!-- coordinate new reference point -->
  <xsl:param name="ref-pt-new-coordinate"/>
  <!-- scalefactor; read preset parameter -->
  <xsl:param name="scalefactor"/>
  
  
    
   <!-- translating  -->
      <xsl:value-of select="round(($coordinate - $ref-pt-old-coordinate)*$scalefactor)+$ref-pt-new-coordinate"/>   
</xsl:function>

  <xsl:template match="/">
    
    <!-- If transforming several Slices: change @xml:id to right surface!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <xsl:for-each select="//tei:zone[ancestor::tei:surfaceGrp[@xml:id eq $map-ed]][contains(@ana,'#author')][number(@ulx) &gt; number($from-x-coordinate)][number(@lrx) &lt; number($to-x-coordinate)]">
      <!-- <area shape="rect" coords="474,776,737,820" alt="Volkspoesie" href="#h2_Volkspoesie" /> -->
      <xsl:element name="area">
        <xsl:attribute name="id">
          <xsl:value-of select="@xml:id"/>
        </xsl:attribute>  
        <xsl:attribute name="shape">
            <xsl:text>rect</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="coords">
            <xsl:variable name="new-ulx">
              <xsl:value-of select="littafel:translate_coordinate(@ulx,$reference-pt-old-x,$reference-pt-new-x,1)"/>
            </xsl:variable>
            <xsl:variable name="new-uly">
              <xsl:value-of select="littafel:translate_coordinate(@uly,$reference-pt-old-y,$reference-pt-new-y,1)"/>
            </xsl:variable>
            <xsl:variable name="new-lrx">
              <xsl:value-of select="littafel:translate_coordinate(@lrx,$reference-pt-old-x,$reference-pt-new-x,1)"/>
            </xsl:variable>
            <xsl:variable name="new-lry">
              <xsl:value-of select="littafel:translate_coordinate(@lry,$reference-pt-old-y,$reference-pt-new-y,1)"/>
            </xsl:variable>
            <xsl:value-of select="concat($new-ulx,',',$new-uly, ',',$new-lrx,',',$new-lry)"></xsl:value-of>
          </xsl:attribute>
          <xsl:attribute name="alt">
            <xsl:value-of select="normalize-space(./tei:line/text())"/>
          </xsl:attribute>
          <xsl:attribute name="href">
            <!-- link to GND -->
            <xsl:variable name="person-id">
              <xsl:value-of select="substring-after(@corresp,'#')"/>
            </xsl:variable>
            <xsl:variable name="gnd-link">
              <xsl:value-of select="concat('http://d-nb.info/gnd/',./ancestor::tei:TEI//tei:person[@xml:id eq $person-id]/tei:idno)"/>
            </xsl:variable>
            <xsl:value-of select="$gnd-link"/>
          </xsl:attribute>        
      </xsl:element>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
    
  </xsl:template>
  
</xsl:stylesheet>