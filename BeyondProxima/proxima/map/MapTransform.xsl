<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns:vml="urn:schemas-microsoft-com:vml">

<xsl:template match="/">
    <html>
      <head>
        <title>Map</title>
        <style>
          vml:line { behavior: url(#default#VML); }
          .ship { position: absolute; z-index: 2 }
          .star { position: absolute; z-index: 1 }
        </style>
        <script type="text/javascript" src="interface.js" />
      </head>
      <body bgcolor="black" onmousemove="moveline(event)" style="overflow: hidden">
        <img src="blank.gif"><xsl:attribute name="onload">init()</xsl:attribute></img>
        <div>
          <xsl:for-each select="map/S">
            <input type="hidden">
              <xsl:attribute name="id">S:<xsl:value-of select="@ID" />:X</xsl:attribute>
              <xsl:attribute name="value"><xsl:value-of select="@X" /></xsl:attribute>
            </input>
            <input type="hidden">
              <xsl:attribute name="id">S:<xsl:value-of select="@ID" />:Y</xsl:attribute>
              <xsl:attribute name="value"><xsl:value-of select="@Y" /></xsl:attribute>
            </input>
            <input type="hidden">
              <xsl:attribute name="id">S:<xsl:value-of select="@ID" />:N</xsl:attribute>
              <xsl:attribute name="value"><xsl:value-of select="@N" /></xsl:attribute>
            </input>
            <input type="hidden">
              <xsl:attribute name="id">S:<xsl:value-of select="@ID" />:C</xsl:attribute>
              <xsl:attribute name="value"><xsl:value-of select="@C" /></xsl:attribute>
            </input>
            <img src="star.png" alt="star" class="star">
              <xsl:attribute name="id">S:<xsl:value-of select="@ID" /></xsl:attribute>
              <xsl:attribute name="style">left: <xsl:value-of select="@X*32" />px; top: <xsl:value-of select="@Y*32" />px</xsl:attribute>
              <xsl:attribute name="alt">S:<xsl:value-of select="@ID" /> (<xsl:value-of select="@X" />, <xsl:value-of select="@Y" />)</xsl:attribute>
            </img>
          </xsl:for-each>
          <xsl:for-each select="map/F">
            <input type="hidden">
              <xsl:attribute name="id">F:<xsl:value-of select="@ID" />:S1</xsl:attribute>
              <xsl:attribute name="value"><xsl:value-of select="@S1" /></xsl:attribute>
            </input>
            <xsl:choose>
              <xsl:when test="@S2">
                <input type="hidden">
                  <xsl:attribute name="id">F:<xsl:value-of select="@ID" />:S2</xsl:attribute>
                  <xsl:attribute name="value"><xsl:value-of select="@S2" /></xsl:attribute>
                </input>
                <input type="hidden">
                  <xsl:attribute name="id">F:<xsl:value-of select="@ID" />:P</xsl:attribute>
                  <xsl:attribute name="value"><xsl:value-of select="@P" /></xsl:attribute>
                </input>
                <img src="ship.png" class="ship">
                  <xsl:attribute name="id">F:<xsl:value-of select="@ID" /></xsl:attribute>
                  <xsl:attribute name="alt">F:<xsl:value-of select="@ID" /></xsl:attribute>
                  <xsl:attribute name="onload">position_moving_fleet('<xsl:value-of select="@ID" />')</xsl:attribute>
                  <xsl:attribute name="onclick">change_course('<xsl:value-of select="@ID" />')</xsl:attribute>
                </img>
              </xsl:when>
              <xsl:otherwise>
                <img src="ship.png" class="ship">
                  <xsl:attribute name="id">F:<xsl:value-of select="@ID" /></xsl:attribute>
                  <xsl:attribute name="alt">F:<xsl:value-of select="@ID" /></xsl:attribute>
                  <xsl:attribute name="onload">position_orbiting_fleet('<xsl:value-of select="@ID" />')</xsl:attribute>
                  <xsl:attribute name="onclick">new_course('<xsl:value-of select="@ID" />')</xsl:attribute>
                </img>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </div>
      </body>
    </html>
</xsl:template>

</xsl:stylesheet>