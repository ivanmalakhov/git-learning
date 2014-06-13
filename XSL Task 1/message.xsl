<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:template match="message">
		<xsl:element name="div">
			<xsl:attribute name="class" >
				<xsl:variable name="messagetype" select="@messagetype"/>
				<xsl:choose >
					<xsl:when test="$messagetype=1">
						<xsl:text>info</xsl:text>
					</xsl:when>
					<xsl:when test="$messagetype=2">
						<xsl:text>warning</xsl:text>
					</xsl:when>
					<xsl:when test="$messagetype=3">
						<xsl:text>critical</xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:attribute>
			<xsl:apply-templates select="title"/>
			<xsl:apply-templates select="section"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="title">
		<xsl:element name="div">
			<xsl:attribute name="class">ttl</xsl:attribute>
			<xsl:value-of select="text()"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="section">
		<xsl:element name="div">
			<xsl:attribute name="class">section</xsl:attribute>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="simpletext">
		<xsl:element name="div">
			<xsl:attribute name="class">simpletext</xsl:attribute>
			<xsl:value-of select="text()"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="listtext">
		<xsl:element name="li">
				<xsl:value-of select="text()"/>
		</xsl:element>
	</xsl:template>	
</xsl:stylesheet>
