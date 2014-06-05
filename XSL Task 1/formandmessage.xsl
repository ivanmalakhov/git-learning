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
				 <div class="main">
					<div class="forms">
						<xsl:value-of select="$scid"/>
						<xsl:apply-templates select="/payment/forms/form[@id=$scid]"/><!-- Адресное обращение. обращаемся к конкретной форме-->
					</div>
					<div class="messages">
						<xsl:apply-templates select="/payment/messages/message[form_id=$scid]"/>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="forms">
		<form>
			<div>Form</div>
			<xsl:apply-templates select="form"/>
		</form>
	</xsl:template>
	<xsl:template match="messages">
		<div>Messages</div>
		<xsl:apply-templates select="message"/>
	</xsl:template>
	<xsl:template match="form">
		<form class="mform" name="mform" action="/formandmessage/?scid=step_2" method="post">
			Form Element
			<xsl:value-of select="."/>
		</form>	
	</xsl:template>
	<xsl:template match="message">
		<div class= "info">
			<xsl:attribute name="class" >
				<xsl:value-of select="@messagetype"/>
			</xsl:attribute>
			<xsl:apply-templates select="title"/>
			<xsl:apply-templates select="section"/>
		</div>
	</xsl:template>
	<xsl:template match="title">
		<div class="ttl">
			<xsl:value-of select="text()"/>
		</div>
	</xsl:template>
	<xsl:template match="section">
		<div class="section">
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	<xsl:template match="simpletext">
		<div class="simpletext">
				<xsl:value-of select="text()"/>
		</div>
	</xsl:template>
	<xsl:template match="listtext">
		<li class="li">
				<xsl:value-of select="text()"/>
		</li>
	</xsl:template>	
</xsl:stylesheet>
