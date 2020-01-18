<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet	version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:x="http://www.w3schools.com"
				exclude-result-prefixes="x">
	
	<xsl:param name="sortKey">name</xsl:param>
	<xsl:param name="sortOrder">ascending</xsl:param>
	<xsl:param name="sortType">text</xsl:param>
	
	<xsl:template match="/">
		<table border="0" class="sortable">
			<xsl:call-template name="create_header" />
			<xsl:choose>
				<xsl:when test="$sortKey = 'name'">
					<xsl:apply-templates select="//x:hotels" />
				</xsl:when>
				<xsl:when test="$sortKey = 'city'">
					<xsl:apply-templates select="//x:hotels" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="//x:hotels" />
				</xsl:otherwise>
			</xsl:choose>
		</table>
	</xsl:template>
	
	<xsl:template name="create_header">
	<tr>
		<th>
			<a href="javascript:sort('name')">Hotel</a>
			<xsl:call-template name="show_sorting">
				<xsl:with-param name="header" select="'name'" />
			</xsl:call-template>
		</th>
		<th>
			<a href="javascript:sort('city')">City</a>
			<xsl:call-template name="show_sorting">
				<xsl:with-param name="header" select="'city'" />
			</xsl:call-template>
		</th>
		<th>Description</th>
		<th>Services &amp; Facilities:</th>
		<th>
			<a href="javascript:sort('stars')">Stars</a>
			<xsl:call-template name="show_sorting">
				<xsl:with-param name="header" select="'stars'" />
			</xsl:call-template>
		</th>
		<th>
			<a href="javascript:sort('price')">Price</a>
			<xsl:call-template name="show_sorting">
				<xsl:with-param name="header" select="'price'" />
			</xsl:call-template>
		</th>
	</tr>
	</xsl:template>
	
	<xsl:template name="show_sorting">
		<xsl:param name="header" />
		<xsl:if test="$sortKey = $header">
			<xsl:if test="$sortOrder = 'ascending'">&#x25B4;</xsl:if>
			<xsl:if test="$sortOrder = 'descending'">&#x25BE;</xsl:if>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="x:hotels">
		<xsl:for-each select="x:hotel">
		<xsl:sort select="*[name(.)=$sortKey]|@*[name(.)=$sortKey]|x:price/*[name(.)=$sortKey]" order="{$sortOrder}" data-type="{$sortType}" />
		<tr>
			<xsl:apply-templates select="." />
		</tr>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="x:hotel">
		<td>
			<xsl:variable name="URL">
  				<xsl:value-of select="@url"/> 
			</xsl:variable>
			<xsl:variable name="request_id">
  				<xsl:value-of select="@id"/> 
			</xsl:variable>
			<a href="{$URL}?id={$request_id}">
        		<xsl:value-of select="x:name" />
   			</a>
    		<br />
    	</td>
		<td><xsl:value-of select="@city" /></td>
		<td><xsl:value-of select="substring(x:description,0,50)" />...</td>
		<td>
			
			Services &amp; Facilities: <xsl:value-of select="x:about/x:services" />
		</td>

		<!-- Stars and Price -->

		<xsl:if test="x:stars">
			<td>
				<xsl:value-of select="format-number(x:stars, '# stars')" />
			</td>
		</xsl:if>		
		<td><xsl:value-of select="format-number(x:price, '#,###eur')" /></td>
		
	</xsl:template>
	
</xsl:stylesheet>
