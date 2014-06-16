<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:exsl="http://exslt.org/common" extension-element-prefixes="exsl">
<!--Шаблон для построения валидации формы -->
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
				<xsl:with-param name="for"><xsl:value-of select="@id"/></xsl:with-param>
			</xsl:apply-templates>
			<xsl:element name="div">
				<xsl:attribute name="class"><xsl:text>xf-elementhint</xsl:text></xsl:attribute>
				<xsl:element name="input">
					<xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
					<xsl:attribute name="name"><xsl:value-of select="@id"/></xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="value/text()"/></xsl:attribute>
					<xsl:attribute name="type"><xsl:text>text</xsl:text></xsl:attribute>
					<xsl:attribute name="class"><xsl:text>xf_input</xsl:text></xsl:attribute>
					<xsl:if test="@max"><xsl:attribute name="data-max"><xsl:value-of select="@max"/></xsl:attribute></xsl:if>
					<xsl:if test="@min"><xsl:attribute name="data-min"><xsl:value-of select="@min"/></xsl:attribute></xsl:if>
					<xsl:if test="@length"><xsl:attribute name="data-length"><xsl:value-of select="@length"/></xsl:attribute></xsl:if>
					<xsl:if test="@regexp"><xsl:attribute name="data-regexp"><xsl:value-of select="@regexp"/></xsl:attribute></xsl:if>
					<xsl:if test="@required"><xsl:attribute name="data-required"><xsl:value-of select="@required"/></xsl:attribute></xsl:if>
					<xsl:if test="@error"><xsl:attribute name="data-error"><xsl:value-of select="@error"/></xsl:attribute></xsl:if>
					<xsl:call-template name="checkvalue">
						<xsl:with-param name="context" select="."/>
					</xsl:call-template>
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
						<xsl:with-param name="id" select="@id"/>
						<xsl:with-param name="label" select="label"/>
						<xsl:with-param name="value" select="value"/>
						<xsl:with-param name="hint" select="hint"/>				
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="label">
						<xsl:with-param name="for"><xsl:value-of select="@id"/></xsl:with-param>
					</xsl:apply-templates>
						<xsl:element name="div">
							<xsl:attribute name="class"><xsl:text>xf-elementhint</xsl:text></xsl:attribute>
							<xsl:element name="select">
								<xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
								<xsl:attribute name="name"><xsl:value-of select="@id"/></xsl:attribute>
								<xsl:attribute name="value"><xsl:value-of select="value/text()"/></xsl:attribute>
								<xsl:attribute name="class"><xsl:text>xf-select</xsl:text></xsl:attribute>
								<xsl:if test="@appearance='compact'">
									<xsl:attribute name="size"><xsl:value-of select="count(item)"/></xsl:attribute>
								</xsl:if>
								<xsl:if test="@required"><xsl:attribute name="data-required"><xsl:value-of select="@required"/></xsl:attribute></xsl:if>	
								<xsl:if test="@error"><xsl:attribute name="data-error"><xsl:value-of select="@error"/></xsl:attribute></xsl:if>
								<xsl:apply-templates select="item" mode="simpleselect"/>
							</xsl:element>
							<xsl:apply-templates select="hint"/>
						</xsl:element>
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
					<xsl:if test="@required"><xsl:attribute name="data-required"><xsl:value-of select="@required"/></xsl:attribute></xsl:if>	
					<xsl:if test="@error"><xsl:attribute name="data-error"><xsl:value-of select="@error"/></xsl:attribute></xsl:if>
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
				<xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
				<xsl:attribute name="name"><xsl:value-of select="@id"/></xsl:attribute>
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
	
	<!-- Шаблон для проверка значения формы-->
	<xsl:template name="checkvalue">
		<xsl:param name="context"/>
		<xsl:variable name="submit-value" select="exsl:node-set($submit-request)/root/item[@id=$context/@id]/text()"/>
		<xsl:if test="string-length($submit-value)&gt;0">
			<xsl:if test="$context/@required = 'true'">
				<xsl:if test="not($submit-value)">
					<xsl:attribute name="class">validation-wrong</xsl:attribute>
				</xsl:if>
			</xsl:if>
			<xsl:if test="string-length($context/@length)&gt;0">
				<xsl:if test="not ( string-length($submit-value)=$context/@length)">
					<xsl:attribute name="class">validation-wrong</xsl:attribute>
				</xsl:if>				
			</xsl:if>
			<xsl:if test="string-length($context/@max)&gt;0">
				<xsl:if test="number($submit-value) &gt; $context/@max">
					<xsl:attribute name="class">validation-wrong</xsl:attribute>
				</xsl:if>								
			</xsl:if>
			<xsl:if test="string-length($context/@min)&gt;0">
				<xsl:if test="number($submit-value) &lt; $context/@min">
					<xsl:attribute name="class">validation-wrong</xsl:attribute>
				</xsl:if>												
			</xsl:if>
			<xsl:attribute name="value"><xsl:value-of select="$submit-value"/></xsl:attribute>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
