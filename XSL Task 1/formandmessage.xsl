<?xml version="1.0"  encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="form.xsl"/>
	<xsl:import href="message.xsl"/>
	<xsl:output method="html" encoding="UTF-8"/>
	<xsl:param name="scid"/>
	<!-- Добавлено получение внешнего параметра. Через браузер запустить не удалось, а вот в процессорах работает -->
	<xsl:template match="/">
		<html>
			<head>
				<title>Payment</title>
				<link rel="stylesheet" type="text/css" href="formandmessage.css" />
				<script type="text/javascript" src="jquery-1.11.1.min.js"/>
				<script type="text/javascript" src="lodash.compat.min.js"/>
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
</xsl:stylesheet>
