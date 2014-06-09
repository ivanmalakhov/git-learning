<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html"/>
	<xsl:param name="scid"/>
	<!-- Добавлено получение внешнего параметра. Через браузер запустить не удалось, а вот в процессорах работает -->
	<xsl:template match="/">
		<html>
			<head>
				<title>Payment</title>
				<link rel="stylesheet" type="text/css" href="formandmessage.css" />
			</head>
			<body>
				<xsl:element name="div">				
					<xsl:attribute name="class">main</xsl:attribute>
					<xsl:element name="div">				
						<xsl:attribute name="class">form</xsl:attribute>
						<xsl:apply-templates select="/payment/forms/form[@id=$scid]"/><!-- Адресное обращение. обращаемся к конкретной форме-->
					</xsl:element>
					<xsl:element name="div">				
						<xsl:attribute name="class">messages</xsl:attribute>
						<xsl:apply-templates select="/payment/messages/message[form_id=$scid]"> <!--  Адресное образщение к сообщения к сообщениям для конкретной формы-->
							<xsl:sort  data-type="number" order="descending" select="@messagetype"/>
						</xsl:apply-templates>
					</xsl:element>
				</xsl:element> <!-- Div Class main -->
			</body>
		</html>
	</xsl:template>
	<xsl:template match="form">
		<xsl:element name="div">
			<xsl:attribute name="class">formhead</xsl:attribute>
			<xsl:text>Form</xsl:text>
		</xsl:element>
		<xsl:element name="form">
			<xsl:attribute name="class">mform</xsl:attribute>
			<xsl:attribute name="name">mform</xsl:attribute>
			<xsl:attribute name="action"><xsl:text disable-output-escaping="yes">/formandmessage/?scid=step_2</xsl:text></xsl:attribute>
			<xsl:attribute name="method">post</xsl:attribute>
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>
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
