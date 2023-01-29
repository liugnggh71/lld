<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:functx="http://www.functx.com"
    exclude-result-prefixes="xs" version="2.0">

    <xsl:variable name="v_newline">
        <xsl:text>&#xa;</xsl:text>
    </xsl:variable>
    
    <xsl:variable name="v_git_source" select="/stage/@git"/>

    <xsl:function name="functx:substring-after-last" as="xs:string"
        xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:param name="delim" as="xs:string"/>

        <xsl:sequence select="
                replace($arg, concat('^.*', functx:escape-for-regex($delim)), '')
                "/>

    </xsl:function>

    <xsl:function name="functx:escape-for-regex" as="xs:string" xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="xs:string?"/>

        <xsl:sequence select="
                replace($arg,
                '(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))', '\\$1')
                "/>

    </xsl:function>

    <xsl:template match="/">
        <xsl:call-template name="dump_all"/>
        <xsl:result-document href="master_stage.sh" method="text">
            <xsl:text>cat &lt;&lt; EOC</xsl:text>
            <xsl:value-of select="$v_newline"/>
            <xsl:text>sh &lt;&lt; EOS</xsl:text>
            <xsl:value-of select="$v_newline"/>
            <xsl:text>wget </xsl:text>
            <xsl:value-of select="$v_git_source"/>
            <xsl:text>/</xsl:text>
            <xsl:text>master_stage.sh</xsl:text>
            <xsl:value-of select="$v_newline"/>
            <xsl:for-each select="//stage/wget_stage_code">
                <xsl:text>wget </xsl:text>
                <xsl:value-of select="$v_git_source"/>
                <xsl:text>/</xsl:text>
                <xsl:value-of select="."/>
                <xsl:value-of select="$v_newline"/>
            </xsl:for-each>
            <xsl:text>chmod u+x master_stage.sh</xsl:text>
            <xsl:value-of select="$v_newline"/>
            <xsl:for-each select="//stage/wget_stage_code">
                <xsl:text>chmod u+x </xsl:text>
                <xsl:value-of select="."/>
                <xsl:value-of select="$v_newline"/>
            </xsl:for-each>
            <xsl:for-each select="//stage/wget_stage_code">
                <xsl:text>./</xsl:text>
                <xsl:value-of select="."/>
                <xsl:value-of select="$v_newline"/>
            </xsl:for-each>
            <xsl:text>EOS</xsl:text>
            <xsl:value-of select="$v_newline"/>
            <xsl:text>EOC</xsl:text>
            <xsl:value-of select="$v_newline"/>
            <xsl:for-each select="//stage/wget_stage_code">
                <xsl:text>./</xsl:text>
                <xsl:value-of select="."/>
                <xsl:value-of select="$v_newline"/>
            </xsl:for-each>
        </xsl:result-document>
    </xsl:template>

    <xsl:template name="dump_all">
        <xsl:result-document href="dump_all.xml" method="xml" indent="yes">
            <xsl:copy-of select="/"/>
        </xsl:result-document>
    </xsl:template>

</xsl:stylesheet>
