<?xml version="1.0" encoding="UTF-8"?>
<!-- Litteratur-Tafel.xml to Demo-Website -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output omit-xml-declaration="yes" method="html" indent="yes" encoding="UTF-8"/>


<xsl:template match="/">
    <!-- HTML+Bootstrap -->
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
    <html>
        <xsl:call-template name="head"/>
        <body>
            <xsl:call-template name="nav"/>
            <div class="container">
                <xsl:call-template name="container-content"/>
            </div> <!-- /container -->
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
            <script src="js/bootstrap.min.js"></script>
            <script src="js/ie10-viewport-bug-workaround.js"></script>
            <script src="js/jquery.rwdImageMaps.min.js"></script>
            <script>
                $(document).ready(function(e) {
                $('img[usemap]').rwdImageMaps();
                });
            </script>
            <script src="js/jquery.scrollto.js"></script>
            <script>
                $(document).ready(function () {
                $('a.jumplink').click(function (e) {
                e.preventDefault();
                var coor = $(this.hash).attr('coords').split(',');
                $('html,body').scrollTo(coor[0], coor[1]);
                });
                });
            </script>
        </body>
    </html>
</xsl:template>


<xsl:template match="tei:TEI"/>  


<!-- HTML head -->
<xsl:template name="head">
    <head>
        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <meta name="description" content=""/>
        <link rel="icon" href="../../favicon.ico"/>
        
        <title><xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"></xsl:value-of></title>
        
        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet"/>
        
        <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
        <link href="css/ie10-viewport-bug-workaround.css" rel="stylesheet"/>
        
        <!-- Custom styles for this template -->
        <link href="navbar-fixed-top.css" rel="stylesheet"/>
        
        <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
        <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
        <script src="js/ie-emulation-modes-warning.js"></script>
        
        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
        
        <link href="css/style.css" rel="stylesheet"/>
    </head>
</xsl:template>
    
<!-- HTML nav -->
    <xsl:template name="nav">
        <!-- Fixed navbar -->
        <nav class="navbar navbar-default navbar-fixed-top">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">Flaischlen-Demo</a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="#">Home</a></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Autor <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <!-- insert authors from particDesc -->
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Jahr <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <!-- insert years -->
                            </ul>
                        </li>
                    </ul>
                    
                </div><!--/.nav-collapse -->
            </div>
        </nav>
    </xsl:template>

<!-- HTML Bootstrap container -->
    <xsl:template name="container-content">
        <xsl:call-template name="imagemap"/>
        
    </xsl:template>

<xsl:template name="imagemap">
    <xsl:for-each select="//tei:sourceDoc//tei:surface">
        <div class="row">
            <!-- embeds the imagemap and calls the map-template for each available image=surface -->
            <xsl:element name="img">
                <xsl:attribute name="class">
                    <xsl:text>img-responsive</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="src">
                    <xsl:value-of select="concat('pics/',@facs)"></xsl:value-of>
                </xsl:attribute>
                <xsl:attribute name="usemap">
                    <xsl:value-of select="concat('#',substring-before(@facs,'.png'))"></xsl:value-of>
                </xsl:attribute>
            </xsl:element>
        </div>
                <xsl:call-template name="make_map">
                    <xsl:with-param name="surface-id">
                        <xsl:value-of select="substring-before(@facs,'.png')"/>
                    </xsl:with-param>
                </xsl:call-template>
               
    </xsl:for-each>
</xsl:template>

<xsl:template name="make_map">
    <!-- creates imagemap -->
    <xsl:param name="surface-id"/>
    <xsl:element name="map">
        <xsl:attribute name="name">
            <xsl:value-of select="$surface-id"/>
        </xsl:attribute>
        <xsl:for-each select="//tei:surface[contains(@facs,$surface-id)]/tei:zone"> 
            <xsl:element name="area">
                <xsl:attribute name="id">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
                <xsl:attribute name="shape">
                    <xsl:text>rect</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="coords">
                    <xsl:value-of select="concat(@ulx, ',' ,@uly, ',',@lrx,',',@lry)"/>
                </xsl:attribute>    
                    <xsl:attribute name="alt">
                        <xsl:value-of select="./tei:line"/>
                    </xsl:attribute>
                    <xsl:attribute name="href">
                        <!-- link to GND? -->
                        <xsl:text>#</xsl:text>
                    </xsl:attribute>
            </xsl:element>
        </xsl:for-each>
    </xsl:element>    
    
    
</xsl:template>

</xsl:stylesheet>