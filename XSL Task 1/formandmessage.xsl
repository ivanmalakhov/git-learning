<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" encoding="UTF-8"/>
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
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="input">
		<xsl:element name="div">
			<xsl:call-template name="simpleinput">
				<xsl:with-param name="id" select="@ref"/>
				<xsl:with-param name="label" select="label"/>
				<xsl:with-param name="value" select="value"/>
				<xsl:with-param name="hint" select="hint"/>				
			</xsl:call-template>
		</xsl:element>
	</xsl:template>
	<xsl:template match="select">
		<xsl:element name="div">
			<xsl:choose>
				<xsl:when test="@typeelement='boolean'">
					<xsl:call-template name="simplecheckbox">
						<xsl:with-param name="id" select="@ref"/>
						<xsl:with-param name="label" select="label"/>
						<xsl:with-param name="value" select="value"/>
						<xsl:with-param name="hint" select="hint"/>				
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="simpleselect">
						<xsl:with-param name="id" select="@ref"/>
						<xsl:with-param name="label" select="label"/>
						<xsl:with-param name="value" select="value"/>
						<xsl:with-param name="hint" select="hint"/>				
						<xsl:with-param name="item" select="item"/>				
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="simpleselect">
		<xsl:param name="id"/>
		<xsl:param name="label"/>
		<xsl:param name="value"/>
		<xsl:param name="hint"/>
		<xsl:param name="item"/>		
		<xsl:element name="label">
			<xsl:attribute name="for" ><xsl:value-of select="$id"/></xsl:attribute>
			<xsl:value-of select="$label/text()"/>
		</xsl:element>
			<xsl:element name="select">
				<xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
				<xsl:attribute name="name"><xsl:value-of select="$id"/></xsl:attribute>
				<xsl:attribute name="value"><xsl:value-of select="$value/text()"/></xsl:attribute>
				<xsl:apply-templates select="$item" mode="simpleselect"/>
			</xsl:element>
			<xsl:element name="span"><xsl:value-of select="$hint/text()"/></xsl:element>
	</xsl:template>
	<xsl:template name="simplecheckbox">
		<xsl:param name="id"/>
		<xsl:param name="label"/>
		<xsl:param name="value"/>
		<xsl:param name="hint"/>		
			<xsl:element name="input">
				<xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
				<xsl:attribute name="name"><xsl:value-of select="$id"/></xsl:attribute>
				<xsl:attribute name="type"><xsl:text>checkbox</xsl:text></xsl:attribute>
				<xsl:if test="$value/text()= 'true'">
					<xsl:attribute name="checked"><xsl:text>checked</xsl:text></xsl:attribute>
				</xsl:if>
			</xsl:element>
			<xsl:element name="span"><xsl:value-of select="$label"/></xsl:element>
	</xsl:template>
	<xsl:template match="item" mode="simpleselect">
		<xsl:element name="option">
			<xsl:attribute name="value"><xsl:value-of select="value/text()"/></xsl:attribute>
			<xsl:value-of select="label/text()"/>
		</xsl:element>
	</xsl:template>
	<xsl:template name="simpleinput">
		<xsl:param name="id"/>
		<xsl:param name="label"/>
		<xsl:param name="value"/>
		<xsl:param name="hint"/>
		<xsl:element name="label">
			<xsl:attribute name="for" ><xsl:value-of select="$id"/></xsl:attribute>
			<xsl:value-of select="$label/text()"/>
		</xsl:element>
			<xsl:element name="input">
				<xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
				<xsl:attribute name="name"><xsl:value-of select="$id"/></xsl:attribute>
				<xsl:attribute name="value"><xsl:value-of select="$value/text()"/></xsl:attribute>
			</xsl:element>
			<xsl:element name="span"><xsl:value-of select="$hint/text()"/></xsl:element>
	</xsl:template>
<!--	<xsl:template match="label" mode="input">
		<xsl:param name="for"/>
		<xsl:element name="label">
			<xsl:attribute name="for" ><xsl:text><xsl:value-of select="$for"/></xsl:text></xsl:attribute>
			<xsl:value-of select="text()"/>
		</xsl:element>
	</xsl:template>-->
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
