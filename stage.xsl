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
        <xsl:call-template name="master_stage"/>
        <xsl:result-document href="install_ssh.sh" method="text">
            <xsl:for-each select="//Installs/install">
                <xsl:text>ssh opc@</xsl:text>
                <xsl:value-of select="ip"/>
                <xsl:value-of select="$v_newline"/>
            </xsl:for-each>
        </xsl:result-document>
    </xsl:template>

    <xsl:template name="master_stage">
        <xsl:result-document href="master_install.sh" method="text">
            
            <xsl:text>sh &lt;&lt; 'EOF'</xsl:text>
            <xsl:value-of select="$v_newline"/>
            
            <xsl:for-each select="//install_zip">
                <xsl:variable name="v_zip_file" select="functx:substring-after-last(., '/')"></xsl:variable>
                <xsl:text>wget </xsl:text>
                <xsl:value-of select="."/>
                <xsl:value-of select="$v_newline"/>
                <xsl:for-each select="//Installs/install">
                    <xsl:text>echo ============================================================</xsl:text>
                    <xsl:value-of select="$v_newline"/>
                    <xsl:text>echo </xsl:text>
                    <xsl:value-of select="host"/>
                    <xsl:value-of select="$v_newline"/>
                    <xsl:text>echo ============================================================</xsl:text>
                    <xsl:value-of select="$v_newline"/>
                    
                    <xsl:text>scp </xsl:text>
                    <xsl:value-of select="$v_zip_file"/>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="ip"/>
                    <xsl:text>:/tmp</xsl:text>
                    <xsl:value-of select="$v_newline"/>
                    
                    <xsl:text>ssh </xsl:text>
                    <xsl:value-of select="ip"/>
                    <xsl:text> unzip -o /tmp/</xsl:text>
                    <xsl:value-of select="$v_zip_file"/>
                    <xsl:text>  &lt; /dev/null</xsl:text>
                    <xsl:value-of select="$v_newline"/>
                    
                </xsl:for-each>
                
            </xsl:for-each>
            <xsl:text>EOF</xsl:text>
            <xsl:value-of select="$v_newline"/>
            
        </xsl:result-document>
        <xsl:result-document href="master_stage.sh" method="text">
            <xsl:text>cat &lt;&lt; EOC &gt; download.sh</xsl:text>
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
            <xsl:text>chmod u+x download.sh</xsl:text>
            <xsl:value-of select="$v_newline"/>
            <xsl:text>./download.sh</xsl:text>
            <xsl:value-of select="$v_newline"/>
            <xsl:value-of select="//prepare_zip_cmd"/>
            <xsl:value-of select="$v_newline"/>
        </xsl:result-document>
    </xsl:template>

    <xsl:template name="dump_all">
        <xsl:result-document href="dump_all.xml" method="xml" indent="yes">
            <xsl:copy-of select="/"/>
        </xsl:result-document>
    </xsl:template>

</xsl:stylesheet>
