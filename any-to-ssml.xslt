<xsl:stylesheet
    version="1.0"
    xmlns="https://www.w3.org/2001/10/synthesis"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

    <!-- entry point, look for <article> -->
    <xsl:template match="/">
        <speak version="1.0" xml:lang="de-DE">
            <voice name="de-DE-KatjaNeural">
                <xsl:apply-templates select="//article"/>
            </voice>
        </speak>
    </xsl:template>

    <xsl:template match="//article">
        <xsl:apply-templates select="*|text()" mode="block"/>
    </xsl:template>

    <!-- templates for block elements -->
    <xsl:template match="h1|h2|h3|h4|h5|h6" mode="block">
        <p>
            <xsl:apply-templates select="*|text()" mode="inline"/>
        </p>
    </xsl:template>

    <xsl:template match="p" mode="block">
        <p>
            <xsl:apply-templates select="*|text()" mode="inline"/>
        </p>
    </xsl:template>

    <xsl:template match="*" mode="block">
        <xsl:apply-templates select="*|text()" mode="block"/>
    </xsl:template>

    <xsl:template match="text()" mode="block">
        <xsl:apply-templates select="*|text()" mode="inline"/>
    </xsl:template>

    <!-- templates for inline elements -->
    <xsl:template match="i|em|strong|bold" mode="inline">
        <emphasis>
            <xsl:apply-templates select="*|text()" mode="inline"/>
        </emphasis>
    </xsl:template>

    <xsl:template match="a" mode="inline">
        <xsl:text>(Link Start)</xsl:text>
        <xsl:apply-templates select="*|text()" mode="inline"/>
        <xsl:text>(Link Ende)</xsl:text>
    </xsl:template>

    <xsl:template match="*" mode="inline">
        <xsl:apply-templates select="*|text()" mode="inline"/>
        <!-- additional whitespace to cover case when inline element is followed by raw text -->
        <xsl:text> </xsl:text>
    </xsl:template>

    <xsl:template match="text()" mode="inline">
        <xsl:copy-of select="."/>
    </xsl:template>

    <!-- identity template, drop the rest -->
    <xsl:template match="@*|*|processing-instruction()|comment()"/>
</xsl:stylesheet>
