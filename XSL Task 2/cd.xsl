<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:exsl="http://exslt.org/common" extension-element-prefixes="exsl">
	<xsl:output method="html" encoding="UTF-8"/>
	<xsl:param name="year" />
	<xsl:param name="sort">artist</xsl:param>
	<xsl:param name="order"><xsl:text>ascending</xsl:text></xsl:param>
	<xsl:param name="artist" />
	<xsl:variable name="order-dict">
			<order>
				<item id = "year" data-type="number"/>
				<item id = "artist" data-type="text"/>
				<item id = "title" data-type="text"/>
				<item id = "company" data-type="text"/>
			</order>
	</xsl:variable>
	<xsl:variable name="order-dict-set" select="exsl:node-set($order-dict)"/>
	
	<xsl:key use="year" match="catalog/cd" name="cd-by-year"/> <!--попытка использовать ключи--> 
	<xsl:template match="/">
		<html>
			<head>
				<title>cd</title>
				<link rel="stylesheet" type="text/css" href="cd.css" />
			</head>
			<body>
				<xsl:variable select="$order-dict-set/order/item[@id=$sort]/@data-type" name="datatype"/>
				<xsl:value-of select="$datatype"/>
				<xsl:apply-templates select="catalog/cd[contains(year,$year)][contains(artist,$artist)]">
					<xsl:sort select="*[name()=$sort]"  order="{$order}" data-type="{$datatype}"/>
				</xsl:apply-templates>			
			</body>  
		</html>
	</xsl:template>
	<xsl:template match="cd">
		<xsl:apply-templates select="cover"/>
		<xsl:element name="div">
			<xsl:attribute name="class"><xsl:text>cd</xsl:text></xsl:attribute>
			<xsl:element name="div">
				<xsl:attribute name="class"><xsl:text>title</xsl:text></xsl:attribute>
				<xsl:apply-templates select="title"/>
				<xsl:apply-templates select="year"/>	
			</xsl:element>
			<xsl:apply-templates select="artist"/>
			<xsl:element name="div">
				<xsl:attribute name="class"><xsl:text>company</xsl:text></xsl:attribute>
				<xsl:apply-templates select="company"/>
				<xsl:apply-templates select="country"/>	
			</xsl:element>
			<xsl:apply-templates select="price"/>
			<xsl:apply-templates select="tracks"/>			
		</xsl:element>
	</xsl:template>
	<xsl:template match="title">
		<xsl:element name="span">
			<xsl:value-of select="name()"/><xsl:text>: </xsl:text>
		</xsl:element>
		<xsl:element name="span">
			<xsl:attribute name="class"><xsl:text>title</xsl:text></xsl:attribute>
			<xsl:value-of select="text()"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="artist">
		<xsl:element name="div">
			<xsl:attribute name="class"><xsl:text>artist</xsl:text></xsl:attribute>
			<xsl:element name="span">
				<xsl:value-of select="name()"/><xsl:text>: </xsl:text>
			</xsl:element>
			<xsl:value-of select="text()"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="country">
		<xsl:element name="span">
			<xsl:attribute name="class"><xsl:text>country</xsl:text></xsl:attribute>
			<xsl:text>(</xsl:text><xsl:value-of select="text()"/><xsl:text>)</xsl:text>
		</xsl:element>
	</xsl:template>
	<xsl:template match="company">
		<xsl:element name="span">
			<xsl:value-of select="name()"/><xsl:text>: </xsl:text>
		</xsl:element>
		<xsl:element name="span">
			<xsl:attribute name="class"><xsl:text>company</xsl:text></xsl:attribute>
			<xsl:value-of select="text()"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="price">
		<xsl:element name="div">
			<xsl:attribute name="class"><xsl:text>price</xsl:text></xsl:attribute>
			<xsl:element name="span">
				<xsl:value-of select="name()"/><xsl:text>: </xsl:text>
			</xsl:element>
			<xsl:value-of select="text()"/><xsl:text>$</xsl:text>
		</xsl:element>
	</xsl:template>
	<xsl:template match="year">
		<xsl:element name="span">
			<xsl:attribute name="class"><xsl:text>year</xsl:text></xsl:attribute>
			<xsl:text>(</xsl:text><xsl:value-of select="text()"/><xsl:text>)</xsl:text>
		</xsl:element>
	</xsl:template>
	<xsl:template match="cover">
		<xsl:element name="div">
			<xsl:attribute name="class"><xsl:text>cover</xsl:text></xsl:attribute>
			<xsl:element name="img">
				<xsl:attribute name="class"><xsl:text>coverimage</xsl:text></xsl:attribute>
				<xsl:attribute name="src"><xsl:value-of select="text()"/></xsl:attribute>
			</xsl:element>
		</xsl:element>
	</xsl:template>	
	<xsl:template match="tracks">
		<xsl:element name="span">
			<xsl:attribute name="class"><xsl:text>tracks</xsl:text></xsl:attribute>
			<xsl:text>Track list:</xsl:text>
		</xsl:element>
		<xsl:element name="ul">
			<xsl:apply-templates select="track"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="track">
		<xsl:element name="li">
			<xsl:value-of select="text()"/>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
