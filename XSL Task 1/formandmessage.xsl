<?xml version="1.0"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
 	<xsl:output method="html"/>
 	<xsl:param name="scid"/> <!-- Добавлено получение внешнего параметра. Через браузер запустить не удалось, а вот в процессорах работает -->
	<xsl:template match="/">
		<html>
			<head>
				<title>Прием платежа</title>
			</head>
			<body>
				<div>
					<xsl:value-of select="$scid"/>
					<xsl:copy-of select="$scid"/>
					<xsl:apply-templates select="payment/forms" />
				</div>
				<div>
					<xsl:apply-templates select="payment/messages" />
				</div>
			</body>
		</html>						
	</xsl:template>
		
	<xsl:template match="forms">
		<form>
			<div>Форма</div>
			<xsl:apply-templates select="form" />
		</form>
	</xsl:template>
	
	<xsl:template match="messages">
		<div>Сообщения</div>
		<xsl:apply-templates select="message" />
	</xsl:template>

	<xsl:template match="form">
			<div>Элемент формы</div>
	</xsl:template>

	<xsl:template match="message">
			<div>Сообщение</div>
	</xsl:template>		
</xsl:stylesheet>