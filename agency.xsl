<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="2.0">

<xsl:template match="/">
  <html>
		<head>
			<title> Туристическа Агенция</title>
			<link rel="stylesheet" href="agency.css" type="text/css" />

		</head>
		<body>
      <div class="header-title">
			  <h1> Каталог на туристическа агенция</h1>
		  </div>
      <div class="container">
        <section class="row">
          <div class="container-fluid">

            <xsl:for-each select="Agency/Groups">
              <xsl:for-each select="./Group">
                <div class="contry">
                  <h2 style="text-align: center;"><xsl:value-of select="@Country"/></h2>
                </div>
                  <xsl:variable name="IDgroup" select="@ID"></xsl:variable>
                  <xsl:for-each select="../../Subgroups">
                      <xsl:variable name="subgroup_ID" select="@group"></xsl:variable>
                      <xsl:call-template name="table-body">
                        <xsl:with-param name="Subgroup" select="./Subgroup" />
                        <xsl:with-param name="IDgroup" select="$IDgroup" />
                        <xsl:with-param name="sortBy" select="'./City/text()'" />
                      </xsl:call-template>
                </xsl:for-each>
              </xsl:for-each>
            </xsl:for-each>
          </div>
        </section>
     </div>
		</body>
	</html>
</xsl:template>

<xsl:template name="table-body">
  <xsl:param name="IDgroup" />
  <xsl:param name="sortBy" />
  
  <xsl:for-each select="./Subgroup[@group=$IDgroup]">
  <xsl:sort select="[local-name()=$sortBy]"/>

  <div class="city-box row">
    <div class="city"><h2><xsl:value-of select="./City/text()"/></h2></div>
    <div class="col-2 image">
      <img>
        <xsl:attribute name="src"> <xsl:value-of select="no//@src"/> </xsl:attribute>
        <xsl:attribute name="width"><xsl:value-of select="no//@width"/></xsl:attribute>
        <xsl:attribute name="height"><xsl:value-of select="no//@height"/></xsl:attribute>
      </img>
    </div>
    <div class="col-10 trips_information">
      <ul>
        <xsl:for-each select="./Trips">
          <xsl:for-each select="./Trip">
            <li class="trip">
                <b><xsl:value-of select="./Type/text()"/> - <xsl:value-of select="./Price/text()"/></b>
                <span>От <xsl:value-of select="./DateTo/text()"/></span>
                <span>До <xsl:value-of select="./DateFrom/text()"/></span>
              <ul>
                <p style="margin-bottom: 0px;"><b>Пътници: </b><xsl:for-each select="./Passengers/Passenger">
                    <xsl:value-of select="./Name/text()"/>,
                </xsl:for-each> </p>
                <p style="margin-top: 0px;"><b>Допълнителна информация: </b><xsl:value-of select="./Description/text()"/></p>
              </ul>
            </li>
          </xsl:for-each>
        </xsl:for-each>
      </ul>
    </div>
  </div>
</xsl:for-each>
</xsl:template>
</xsl:stylesheet>
