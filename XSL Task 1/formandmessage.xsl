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
				<script type="text/javascript" src="formandmessage.js"/>	
			</head>
			<body>
				<xsl:element name="div">				
					<xsl:attribute name="class">main</xsl:attribute>
						<xsl:apply-templates select="/payment/forms/form[@id=$scid]"/><!-- Адресное обращение. обращаемся к конкретной форме-->
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
		<xsl:element name="form">
			<xsl:attribute name="name">frmPayment</xsl:attribute>
			<xsl:attribute name="id">frmPayment</xsl:attribute>
			<xsl:attribute name="method">post</xsl:attribute>
			<xsl:element name="div">				
				<xsl:attribute name="class">xf-form</xsl:attribute>
				<xsl:apply-templates/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="group">
	<xsl:element name="div">
		<xsl:attribute name="class"><xsl:text>xf-group</xsl:text></xsl:attribute>
		<xsl:apply-templates/>		
	</xsl:element>
	</xsl:template>
	<xsl:template match="input">
		<xsl:element name="div">
			<xsl:attribute name="class"><xsl:text>xf-field</xsl:text></xsl:attribute>
			<xsl:apply-templates select="label">
				<xsl:with-param name="for"><xsl:value-of select="@ref"/></xsl:with-param>
			</xsl:apply-templates>
			<xsl:element name="div">
				<xsl:attribute name="class"><xsl:text>xf-elementhint</xsl:text></xsl:attribute>
				<xsl:element name="input">
					<xsl:attribute name="id"><xsl:value-of select="@ref"/></xsl:attribute>
					<xsl:attribute name="name"><xsl:value-of select="@ref"/></xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="value/text()"/></xsl:attribute>
					<xsl:attribute name="type"><xsl:text>text</xsl:text></xsl:attribute>
					<xsl:attribute name="class"><xsl:text>xf_input xf_input_text</xsl:text></xsl:attribute>
					<xsl:attribute name="pattern"><xsl:value-of select="pattern"/></xsl:attribute>
				</xsl:element>
				<xsl:apply-templates select="hint"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="select">
		<xsl:element name="div">
			<xsl:attribute name="class"><xsl:text>xf-field</xsl:text></xsl:attribute>
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
		<xsl:param name="typeelement"/>		
		<xsl:apply-templates select="$label">
			<xsl:with-param name="for"><xsl:value-of select="$id"/></xsl:with-param>
		</xsl:apply-templates>
			<xsl:element name="div">
				<xsl:attribute name="class"><xsl:text>xf-elementhint</xsl:text></xsl:attribute>
				<xsl:element name="select">
					<xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
					<xsl:attribute name="name"><xsl:value-of select="$id"/></xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="$value/text()"/></xsl:attribute>
					<xsl:attribute name="class"><xsl:text>xf-select</xsl:text></xsl:attribute>
					<xsl:if test="@appearance='compact'">
						<xsl:attribute name="size"><xsl:value-of select="count(item)"/></xsl:attribute>
					</xsl:if>
					<xsl:apply-templates select="$item" mode="simpleselect"/>
				</xsl:element>
				<xsl:apply-templates select="$hint"/>
			</xsl:element>
	</xsl:template>
	<xsl:template name="simplecheckbox">
		<xsl:param name="id"/>
		<xsl:param name="label"/>
		<xsl:param name="value"/>
		<xsl:param name="hint"/>
			<xsl:element name="label">
				<xsl:attribute name="class"><xsl:text>xf-label</xsl:text></xsl:attribute>
				<xsl:element name="input">
					<xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
					<xsl:attribute name="name"><xsl:value-of select="$id"/></xsl:attribute>
					<xsl:attribute name="type"><xsl:text>checkbox</xsl:text></xsl:attribute>
					<xsl:attribute name="class"><xsl:text>xf-input checkbox</xsl:text></xsl:attribute>
					<xsl:if test="$value/text()= 'true'">
						<xsl:attribute name="checked"><xsl:text>checked</xsl:text></xsl:attribute>
					</xsl:if>
				</xsl:element>
				<xsl:value-of select="$label"/>
			</xsl:element>
	</xsl:template>
	<xsl:template match="item" mode="simpleselect">
		<xsl:element name="option">
			<xsl:attribute name="value"><xsl:value-of select="value/text()"/></xsl:attribute>
			<xsl:value-of select="label/text()"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="submit">
		<xsl:element name="div">
			<xsl:attribute name="class"><xsl:text>xf-field</xsl:text></xsl:attribute>	
			<xsl:element name="input">
				<xsl:attribute name="type"><xsl:value-of select="@submission"/></xsl:attribute>
				<xsl:attribute name="class"><xsl:text>xf-submit</xsl:text></xsl:attribute>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="hint">
		<xsl:element name="br"/>
		<xsl:element name="span">
			<xsl:attribute name="class"><xsl:text>xf-hint</xsl:text></xsl:attribute>
			<xsl:value-of select="text()"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="label">
		<xsl:param name="for"/>
		<xsl:element name="label">
			<xsl:attribute name="for" ><xsl:value-of select="$for"/></xsl:attribute>
			<xsl:attribute name="class"><xsl:text>xf-label</xsl:text></xsl:attribute>
			<xsl:value-of select="text()"/>
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
