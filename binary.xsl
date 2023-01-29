<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:functx="http://www.functx.com"
    exclude-result-prefixes="xs" version="2.0">

    <xsl:variable name="v_newline">
        <xsl:text>&#xa;</xsl:text>
    </xsl:variable>

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
        <xsl:result-document href="install_binary_lld.sh" method="text">
            <xsl:for-each select="//binary/commands">
                <xsl:apply-templates select="."/>
            </xsl:for-each>
        </xsl:result-document>
    </xsl:template>

    <xsl:template name="dump_all">
        <xsl:result-document href="dump_all.xml" method="xml" indent="yes">
            <xsl:copy-of select="/"/>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="mkdir_stage">
        <xsl:variable name="v_stage_dir" select="../../../stage_dir"/>
        <xsl:text>mkdir -p </xsl:text>
        <xsl:value-of select="$v_stage_dir"/>
        <xsl:value-of select="$v_newline"/>
    </xsl:template>

    <xsl:template match="cd_stage">
        <xsl:variable name="v_stage_dir" select="../../../stage_dir"/>
        <xsl:text>cd </xsl:text>
        <xsl:value-of select="$v_stage_dir"/>
        <xsl:value-of select="$v_newline"/>
    </xsl:template>
    <xsl:template match="wget_zip">
        <xsl:variable name="v_stage_dir" select="../../../wget_zip"/>
        <xsl:text>wget </xsl:text>
        <xsl:value-of select="$v_stage_dir"/>
        <xsl:value-of select="$v_newline"/>
    </xsl:template>
    <xsl:template match="unzip_wget_zip">
        <xsl:variable name="v_stage_dir"
            select="functx:substring-after-last(../../../wget_zip, '/')"/>
        <xsl:text>unzip </xsl:text>
        <xsl:value-of select="$v_stage_dir"/>
        <xsl:value-of select="$v_newline"/>
    </xsl:template>
    <xsl:template match="cp_single_pick">
        <xsl:variable name="v_stage_dir" select="../../../wget_zip"/>
        <xsl:variable name="v_install_file_name" select="../../../@name"/>
        <xsl:text>cp -p </xsl:text>
        <xsl:value-of select="@copy_from"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="$v_install_file_name"/>
        <xsl:value-of select="$v_newline"/>
    </xsl:template>
    <xsl:template match="commands">
        <xsl:for-each select="*">
            <xsl:apply-templates select="."/>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="command">
        <xsl:for-each select="*">
            <xsl:apply-templates select="."/>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
