<?xml version="1.0" encoding="UTF-8"?>
<!-- Litteratur-Tafel.xml to Demo-Website -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output omit-xml-declaration="yes" method="html" indent="yes" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>
  <xsl:preserve-space elements="tei:p"/>
  
<xsl:template match="tei:teiHeader"/>
<xsl:template match="tei:sourceDoc"/>
<xsl:template match="tei:text">
  <xsl:element name="div">
  <xsl:apply-templates/>
  </xsl:element>
</xsl:template>

<xsl:template match="tei:head">
  <xsl:element name="h2">
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>


<xsl:template match="tei:p">
  <xsl:element name="p">
   <xsl:apply-templates/>
  </xsl:element>
</xsl:template>
  
<xsl:template match="tei:fw"/>
<xsl:template match="tei:cb"/>
  <xsl:template match="tei:pb"/>

<xsl:template match="tei:emph">
  <xsl:element name="em">
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>
  
</xsl:stylesheet>