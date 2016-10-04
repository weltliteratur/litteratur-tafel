<?xml version="1.0" encoding="UTF-8"?>
<!-- XSLT for parsing the person-records in Litteratur-Tafel.xml tei:person
produces the Person-Index as unorderd lists and links to the designated fields of the html imagemap
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:tei="http://www.tei-c.org/ns/1.0"
xmlns:littafel="https://github.com/weltliteratur/litteratur-tafel/ns"
exclude-result-prefixes="xs"
version="2.0">
<xsl:output omit-xml-declaration="yes" method="html" indent="yes" encoding="UTF-8"/>
  
  <!-- Functions -->
  <xsl:function name="littafel:parse_persName">
    <xsl:param name="persName"/>
    <xsl:choose>
      <xsl:when test="not($persName/element())">
        <!-- persName is not structured -->
        <xsl:value-of select="$persName"/>
      </xsl:when>
      <xsl:when test="(count($persName/element())) eq 1 and $persName/tei:forename">
        <!-- only forename -->
        <xsl:value-of select="$persName/tei:forename"></xsl:value-of>
      </xsl:when>
      <xsl:when test="(count($persName/element())) eq 2 and $persName/tei:forename and $persName/tei:surname">
        <!-- only elements are forename and surname
          persName should be parsed as surname, forename -->
        <xsl:value-of select="concat($persName/tei:surname,', ',$persName/tei:forename)"/>
      </xsl:when>
      <xsl:when test="(count($persName/element()) eq 3) and $persName/tei:surname and $persName/tei:forename and $persName/tei:nameLink">
        <!-- Name ist structured: surname, forename nameLink (von,...) -->
        <xsl:value-of select="concat($persName/tei:surname,', ',$persName/tei:forename, ' ', $persName/tei:nameLink)"/>
      </xsl:when>
      <xsl:when test="(count($persName/element()) eq 4) and $persName/tei:surname and $persName/tei:forename and $persName/tei:nameLink and $persName/tei:addName">
        <!-- Name ist structured: surname, forename namelink addName -->
        <xsl:value-of select="concat($persName/tei:surname,', ',$persName/tei:forename, ' ', $persName/tei:nameLink, ' ', $persName/tei:addName)"/>
      </xsl:when>
      <xsl:when test="(count($persName/element()) eq 2 and $persName/tei:forename and $persName/tei:addName)">
        <!-- Name ist structured: forename, addName 
        parse: forname addName
        -->
        <xsl:value-of select="concat($persName/tei:forename, ' ', $persName/tei:addName)"/>
      </xsl:when>
      <xsl:when test="(count($persName/element()) eq 3 and $persName/tei:forename and $persName/tei:addName and $persName/tei:nameLink)">
        <!-- Name ist structured: forename, nameLink, addName 
        parse: forname nameLink addName
        -->
        <xsl:value-of select="concat($persName/tei:forename, ' ', $persName/tei:nameLink, ' ', $persName/tei:addName)"/>
      </xsl:when>
      <xsl:when test="(count($persName/element()) eq 3 and $persName/tei:roleName and $persName/tei:nameLink and $persName/tei:surname)">
        <!-- Name ist structured: roleName, nameLink, surname 
        parse: roleName nameLink surname (Burggraf von ...)
        -->
        <xsl:value-of select="concat($persName/tei:roleName, ' ', $persName/tei:nameLink, ' ', $persName/tei:surname)"/>
      </xsl:when>
      <xsl:when test="(count($persName/element()) eq 3 and $persName/tei:roleName and $persName/tei:forename and $persName/tei:surname)">
        <!-- Name ist structured: roleName, surname, forename 
        parse: surname, roleName forname (Byron, Lord George Gordon ...)
        -->
        <xsl:value-of select="concat($persName/tei:surname, ', ', $persName/tei:roleName, ' ', $persName/tei:forename)"/>
      </xsl:when>
      <xsl:when test="(count($persName/element()) eq 3 and $persName/tei:forename and $persName/tei:surname and $persName/tei:addName)">
        <!-- Name ist structured: forename, surname, addName 
        parse: forename surname addName (Latin Poets)
        -->
        <xsl:value-of select="concat($persName/tei:forename, ' ', $persName/tei:surname, ' ', $persName/tei:addName)"/>
      </xsl:when>
      <xsl:when test="(count($persName/element()) eq 2 and $persName/tei:roleName and $persName/tei:forename)">
        <!-- Name ist structured: roleName, forename 
        parse: rolename forename (Meister Eckhart)
        -->
        <xsl:value-of select="concat($persName/tei:roleName, ' ', $persName/tei:forename)"/>
      </xsl:when>
      <xsl:when test="(count($persName/element()) eq 3 and $persName/tei:roleName and $persName/tei:forename and $persName/tei:genName)">
        <!-- Name ist structured: roleName, forename, genName 
        parse: forename genName (roleName) (Papst Gregor I)
        -->
        <xsl:value-of select="concat($persName/tei:forename, ' ', $persName/tei:genName, ' (', $persName/tei:roleName ,')')"/>
      </xsl:when>
      <xsl:when test="(count($persName/element()) eq 2 and $persName/tei:nameLink and $persName/tei:addName)">
        <!-- Name ist structured: nameLink addName 
        parse: nameLink addName (Der Kührenberger)
        -->
        <xsl:value-of select="concat($persName/tei:nameLink, ' ', $persName/tei:addName)"/>
      </xsl:when>
      <xsl:when test="(count($persName/element())) eq 1 and $persName/tei:addName">
        <!-- only addName (Muskatblüt) -->
        <xsl:value-of select="$persName/tei:addName"></xsl:value-of>
      </xsl:when>
      <xsl:when test="(count($persName/element()) eq 3 and $persName/tei:forename and $persName/tei:genName and $persName/tei:addName)">
        <!-- Name ist structured: forename genName addName 
        parse: forename genName addName (Notker I Babulus)
        -->
        <xsl:value-of select="concat($persName/tei:forename, ' ', $persName/tei:genName, ' ', $persName/tei:addName)"/>
      </xsl:when>
      
      <xsl:when test="(count($persName/element()) eq 5 and $persName/tei:forename and $persName/tei:genName and $persName/tei:surname and $persName/tei:nameLink and $persName/tei:roleName)">
        <!-- Name ist structured: roleName forename genName nameLink surname 
        parse: surname,  roleName forename genName nameLink (Markgraf Berthold IV. von Vohburg-Hohenburg)
        -->
        <xsl:value-of select="concat($persName/tei:surname, ', ', $persName/tei:roleName, ' ',$persName/tei:forename, ' ' , $persName/tei:genName, ' ', $persName/tei:nameLink)"/>
      </xsl:when>
      
      
      <xsl:when test="(count($persName/element()) eq 4 and $persName/tei:forename and $persName/tei:addName and $persName/tei:nameLink and $persName/tei:roleName)">
        <!-- Name ist structured: roleName forename genName nameLink surname 
        parse: forename nameLink addName (roleName) (Archipresbyter Leo von Neapel)
        -->
        <xsl:value-of select="concat($persName/tei:forename, ' ', $persName/tei:nameLink, ' ',$persName/tei:addName, ' (' , $persName/tei:roleName, ')')"/>
      </xsl:when>
      
      
    </xsl:choose>
    
  </xsl:function>
  
 <xsl:template match="/">
   <xsl:element name="h3">
     <xsl:text>Authors</xsl:text>
   </xsl:element>
   <xsl:element name="ul">
   <xsl:for-each-group select="//tei:person[tei:idno != 'none'][not(tei:occupation)]" group-by="upper-case(substring(.//*[@sort='1'],1,1))">
     <xsl:sort order="ascending" select="current-grouping-key()"/>
     <xsl:element name="li">
     <xsl:element name="h4">
      <xsl:value-of select="current-grouping-key()"/>
     </xsl:element>
        <xsl:element name="ul">
          <xsl:for-each select="current-group()">
            <xsl:sort select="littafel:parse_persName(tei:persName)[1]"/>
            <xsl:element name="li">
              <xsl:element name="a">
                <xsl:attribute name="class">
                  <xsl:text>jumplink</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="href">
                  <xsl:variable name="corresp-val">
                    <xsl:value-of select="concat('#',@xml:id)"/>
                  </xsl:variable>
                  <!-- Wenn auf mehrere gelinkt werden muss, ist das noch extra zu behandeln 
                   momentan link [@corresp eq $corresp-val][1] nur auf's erste Vorkommen
                  -->
                     
                    <xsl:value-of select="concat('#',ancestor::tei:TEI//tei:zone[ancestor::tei:surfaceGrp[@xml:id eq 'map-ed2']][@corresp eq $corresp-val][1]/@xml:id)"/>
                  
                </xsl:attribute>
                
                <xsl:value-of select="littafel:parse_persName(tei:persName)"/>
                
              </xsl:element>
              </xsl:element>
          </xsl:for-each>
        </xsl:element>   
     </xsl:element>
   </xsl:for-each-group>
   
   </xsl:element>
 </xsl:template> 
  
  <xsl:template match="tei:TEI"/>
  
 
</xsl:stylesheet>