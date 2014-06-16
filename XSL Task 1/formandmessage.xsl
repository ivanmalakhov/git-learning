<?xml version="1.0"  encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:exsl="http://exslt.org/common" extension-element-prefixes="exsl">
	<xsl:import href="message.xsl"/> <!-- Шаблоны для обработки сообщений-->
	<xsl:import href="form.xsl"/> <!--Шаблоны для обработки форм-->
	<xsl:output method="html" encoding="UTF-8"/>
	<xsl:param name="scid"/> <!-- Идентификатор формы-->
	<xsl:param name="submit-request">
		<!-- Убрать закомментированный участок кода для демонстрации работы валидации средствами xsl -->
<!--		<root>
			<item id="formComment">Коммуналька</item>
			<item id="tempAccount">2131211111</item>
			<item id="month">04</item>
			<item id="year">2004</item>
			<item id="peni">-1</item>
			<item id="sum">9999999</item>
			<item id="paymenttype">1</item>
			<item id="attrcheck"></item>
		</root>
-->	</xsl:param>
	<xsl:variable name="submit-request-set" select="exsl:node-set(submit-request)"/>
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
