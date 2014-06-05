<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html"/>
	<xsl:param name="scid"/>
	<!-- Добавлено получение внешнего параметра. Через браузер запустить не удалось, а вот в процессорах работает -->
	<xsl:template match="/">
		<html>
			<head>
				<title>Прием платежа</title>
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
			<div>Форма</div>
			<xsl:apply-templates select="form"/>
		</form>
	</xsl:template>
	<xsl:template match="messages">
		<div>Сообщения</div>
		<xsl:apply-templates select="message"/>
	</xsl:template>
	<xsl:template match="form">
		<form class="mform" name="mform" action="/formandmessage/?scid=step_2" method="post">
			Элемент формы
			<xsl:value-of select="."/>
		</form>	
	</xsl:template>
	<xsl:template match="message">
		<div class= "">Сообщение
			<h1><xsl:value-of select="title/text()"/></h1>
			<div><xsl:value-of select="section/text()"/></div>
		</div>
	</xsl:template>
</xsl:stylesheet>
