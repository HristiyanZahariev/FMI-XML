<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet	version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:x="http://www.w3schools.com"
				exclude-result-prefixes="x">
	
	<xsl:param name="id">h1</xsl:param>
	
	<xsl:template match="x:hotels">
		<xsl:for-each select="x:hotel">
			<xsl:if test="@id=$id">
				
				<div id="name"><xsl:value-of select="x:name" /></div>
    			<img src="images/{$id}.jpg"/>
				<div id="description">Description: <xsl:value-of select="x:description"/></div>
				
			</xsl:if>
		</xsl:for-each>
	</xsl:template>	
	
</xsl:stylesheet>
