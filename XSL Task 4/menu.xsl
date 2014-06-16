<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:exsl="http://exslt.org/common" extension-element-prefixes="exsl">
	<xsl:output method="html" encoding="UTF-8"/>
	<xsl:param name="menu">
<!--		<item is-current="true">
			<title>yandex.ru</title>
			<url>http://yandex.ru</url>
		</item>
		<item is-current="false">
			<title>mail.ru</title>
			<url>http://mail.ru</url>
		</item>
		<item is-current="false">
			<title>google.com</title>
			<url>http://google.com</url>
		</item>
-->	</xsl:param>
<!-- 
Закомментирована часть которая имитирует передачу nodeset в качестве параметра.
Передать такой параметр через xsltproc не получилось.		
-->
	<xsl:template match="/">
		<html>
			<head>
				<title>Menu</title>
				<link rel="stylesheet" type="text/css" href="menu.css" />
			</head>
			<body>
				<div class="menu">
					<ul>
						<!--Если есть внешний парамер со структурой меню обрабатываем его
							Если параметра нет, обрабатываем xml -->
						<xsl:choose>
							<xsl:when test="$menu">
								<xsl:apply-templates select="exsl:node-set($menu)" mode="param"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="root"/>
							</xsl:otherwise>
						</xsl:choose>
					</ul>
				</div>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="root">
		<!--
			Получение временного дерева. Приводим воходящий XML к структуре, аналогичной структуре входного параметра.
		-->
		<xsl:variable name="menutemp">
			<xsl:call-template name="project">
				<xsl:with-param name="page" select="project/page"/>
				<xsl:with-param name="host" select="request/host"/>
				<xsl:with-param name="url" select="request/url"/>
			</xsl:call-template>
		</xsl:variable>
		<!--Обработка  временного дерева по уже известной схеме-->
		<xsl:apply-templates select="exsl:node-set($menutemp)" mode="param"/>
	</xsl:template>

	<!--Шаблон для преобразования XML во временной дерево-->	
	<xsl:template name="project">
		<xsl:param name="page"/>
		<xsl:param name="host"/>
		<xsl:param name="url"/>		
		<xsl:for-each select="$page"> 
			<xsl:element name="item">
				<xsl:attribute name="is-current"><xsl:text>false</xsl:text></xsl:attribute>
				<xsl:if test="$url=text()">
					<xsl:attribute name="is-current"><xsl:text>true</xsl:text></xsl:attribute>
				</xsl:if> 
				<xsl:element name="title">
					<xsl:value-of select="@name"/>
				</xsl:element>
				<xsl:element name="url">
					<xsl:value-of select="concat('http://',concat($host,text()))"/>
				</xsl:element>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
	
	<!-- Шаблон формирующий меню-->
	<xsl:template match="item" mode="param">
		<li>
			<xsl:element name="a">
				<xsl:if test="@is-current = 'true'">
					<xsl:attribute name="class"><xsl:text>active</xsl:text></xsl:attribute>
				</xsl:if>
				<xsl:attribute name="title"><xsl:value-of select="title/text()"/></xsl:attribute>
				<xsl:attribute name="href"><xsl:value-of select="url/text()"/></xsl:attribute>
				<xsl:value-of select="title/text()"/>
			</xsl:element>
		</li>
	</xsl:template>
</xsl:stylesheet>
