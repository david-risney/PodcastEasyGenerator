<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" 
	xmlns:atom="http://www.w3.org/2005/Atom">
	<xsl:template match="podcast">
		<rss version="2.0">
			<channel>
				<title><xsl:value-of select="@name"/></title>
				<link><xsl:value-of select="@descriptionUri"/></link>
				<description><xsl:value-of select="@description"/></description>
				<language>en-us</language>
				<copyright><xsl:value-of select="@descriptionUri"/></copyright>
				<lastBuildDate><xsl:value-of select="@lastUpdated"/></lastBuildDate>
				<itunes:image href="{@imageUri}" />
				<itunes:explicit>yes</itunes:explicit>
				<xsl:apply-templates select="entry"/>
			</channel>
		</rss>
	</xsl:template>
	<xsl:template match="entry">
		<item>
			<title><xsl:value-of select="@name"/></title>
			<link><xsl:value-of select="@uri"/></link>
			<enclosure url="{@uri}" length="{@length}" type="audio/mpeg" />
			<description></description>
			<pubDate><xsl:value-of select="@date"/></pubDate>
			<guid isPermaLink="false"><xsl:value-of select="@uri"/></guid>
		</item>
	</xsl:template>
</xsl:stylesheet>
