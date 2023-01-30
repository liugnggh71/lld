<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:functx="http://www.functx.com"
    exclude-result-prefixes="xs" version="2.0">

    <xsl:variable name="v_newline">
        <xsl:text>&#xa;</xsl:text>
    </xsl:variable>

    <xsl:function name="functx:if-absent" as="item()*" xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="item()*"/>
        <xsl:param name="value" as="item()*"/>

        <xsl:sequence select="
                if (exists($arg))
                then
                    $arg
                else
                    $value
                "/>

    </xsl:function>

    <xsl:function name="functx:replace-multi" as="xs:string?" xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:param name="changeFrom" as="xs:string*"/>
        <xsl:param name="changeTo" as="xs:string*"/>

        <xsl:sequence select="
                if (count($changeFrom) > 0)
                then
                    functx:replace-multi(
                    replace($arg, $changeFrom[1],
                    functx:if-absent($changeTo[1], '')),
                    $changeFrom[position() > 1],
                    $changeTo[position() > 1])
                else
                    $arg
                "/>

    </xsl:function>


    <xsl:function name="functx:repeat-string" as="xs:string" xmlns:functx="http://www.functx.com">
        <xsl:param name="stringToRepeat" as="xs:string?"/>
        <xsl:param name="count" as="xs:integer"/>

        <xsl:sequence select="
                string-join((for $i in 1 to $count
                return
                    $stringToRepeat),
                '')
                "/>

    </xsl:function>

    <xsl:function name="functx:pad-string-to-length" as="xs:string"
        xmlns:functx="http://www.functx.com">
        <xsl:param name="stringToPad" as="xs:string?"/>
        <xsl:param name="padChar" as="xs:string"/>
        <xsl:param name="length" as="xs:integer"/>

        <xsl:sequence select="
                substring(
                string-join(
                ($stringToPad,
                for $i in (1 to $length)
                return
                    $padChar)
                , '')
                , 1, $length)
                "/>

    </xsl:function>
    <xsl:template name="get_indent">
        <xsl:variable name="v_indent_level">
            <xsl:value-of select="
                    sum(for $i in ancestor-or-self::*
                    return
                        $i/@indent)"/>
        </xsl:variable>
        <xsl:value-of select="functx:repeat-string('  ', $v_indent_level)"/>
    </xsl:template>

    <xsl:template match="source">
        <xsl:variable name="v_indent_string">
            <xsl:call-template name="get_indent"/>
        </xsl:variable>
        <xsl:value-of select="$v_indent_string"/>
        <xsl:text>. </xsl:text>
        <xsl:value-of select="."/>

        <xsl:if test="string-length(@log) &gt; 0">
            <xsl:choose>
                <xsl:when test="@display = 'yes'">
                    <xsl:text> | tee </xsl:text>
                    <xsl:if test="@append = 'yes'">
                        <xsl:text>-a </xsl:text>
                    </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text> &gt;</xsl:text>
                    <xsl:if test="@append = 'yes'">
                        <xsl:text>&gt;</xsl:text>
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>

            <xsl:value-of select="@log"/>
        </xsl:if>
        <xsl:value-of select="$v_newline"/>
    </xsl:template>

    <xsl:template match="header">
        <xsl:variable name="v_desc">
            <xsl:text># </xsl:text>
            <xsl:value-of select="../@name"/>
            <xsl:value-of select="$v_newline"/>
            <xsl:text><![CDATA[<<COMMENT]]></xsl:text>
            <xsl:value-of select="$v_newline"/>
            <xsl:value-of select="desc"/>
            <xsl:value-of select="$v_newline"/>
            <xsl:text>COMMENT</xsl:text>
            <xsl:value-of select="$v_newline"/>
        </xsl:variable>

        <xsl:if test="string-length(shebang) &gt; 0">
            <xsl:text>#!</xsl:text>
            <xsl:value-of select="shebang"/>
            <xsl:value-of select="$v_newline"/>
        </xsl:if>
        <xsl:value-of select="functx:repeat-string('#', 80)"/>
        <xsl:value-of select="$v_newline"/>
        <xsl:value-of select="$v_desc"/>
        <xsl:value-of select="functx:repeat-string('#', 80)"/>
        <xsl:value-of select="$v_newline"/>
    </xsl:template>


    <xsl:template name="dump_all">
        <xsl:result-document href="dump_all.xml" method="xml" indent="yes">
            <xsl:copy-of select="/"/>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="/">
        <xsl:call-template name="dump_all"/>
        <xsl:call-template name="wget"/>
        <xsl:for-each select="/bash_codes//bash_code">
            <xsl:variable name="v_stage_dir">
                <xsl:choose>
                    <xsl:when test="string-length(../@stage_dir) &gt; 0">
                        <xsl:value-of select="../@stage_dir"/>
                        <xsl:text>/</xsl:text>
                    </xsl:when>
                    <xsl:when test="string-length(../../@stage_dir) &gt; 0">
                        <xsl:value-of select="../../@stage_dir"/>
                        <xsl:text>/</xsl:text>
                    </xsl:when>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="v_code_file">
                <xsl:value-of select="$v_stage_dir"/>
                <xsl:value-of select="@subdir"/>
                <xsl:text>/</xsl:text>
                <xsl:value-of select="@name"/>
            </xsl:variable>
            <xsl:result-document href="{$v_code_file}" method="text">
                <xsl:for-each select="*">
                    <xsl:apply-templates select="."/>
                </xsl:for-each>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="run">
        <xsl:variable name="v_indent_string">
            <xsl:call-template name="get_indent"/>
        </xsl:variable>
        <xsl:value-of select="$v_indent_string"/>
        <xsl:text>#</xsl:text>
        <xsl:value-of select="@desc"/>
        <xsl:value-of select="$v_newline"/>

        <xsl:value-of select="$v_indent_string"/>
        <xsl:text>#</xsl:text>
        <xsl:for-each select="1 to string-length(@desc)">
            <xsl:text>R</xsl:text>
        </xsl:for-each>
        <xsl:value-of select="$v_newline"/>

        <xsl:value-of select="$v_indent_string"/>
        <xsl:text>echo "</xsl:text>
        <xsl:value-of select="@desc"/>
        <xsl:text>"</xsl:text>
        <xsl:value-of select="$v_newline"/>

        <xsl:value-of select="$v_newline"/>
        <xsl:value-of select="$v_indent_string"/>
        <xsl:value-of select="."/>
        <xsl:value-of select="$v_newline"/>
    </xsl:template>

    <xsl:template match="exit">
        <xsl:variable name="v_indent_string">
            <xsl:call-template name="get_indent"/>
        </xsl:variable>
        <xsl:variable name="v_exit">
            <xsl:value-of select="$v_indent_string"/>
            <xsl:text>exit </xsl:text>
            <xsl:value-of select="."/>
            <xsl:value-of select="$v_newline"/>
        </xsl:variable>

        <xsl:variable name="v_XX">
            <xsl:value-of select="$v_indent_string"/>
            <xsl:text>#</xsl:text>
            <xsl:for-each select="1 to string-length($v_exit)">
                <xsl:text>X</xsl:text>
            </xsl:for-each>
            <xsl:value-of select="$v_newline"/>
        </xsl:variable>

        <xsl:value-of select="$v_newline"/>
        <xsl:value-of select="$v_XX"/>
        <xsl:value-of select="$v_exit"/>
        <xsl:value-of select="$v_XX"/>
    </xsl:template>
    <xsl:template match="if_block">
        <xsl:variable name="v_indent_string">
            <xsl:call-template name="get_indent"/>
        </xsl:variable>
        <xsl:value-of select="$v_indent_string"/>
        <xsl:text>if </xsl:text>
        <xsl:for-each select="*">
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <xsl:value-of select="$v_newline"/>
        <xsl:value-of select="$v_indent_string"/>
        <xsl:text>fi</xsl:text>
        <xsl:value-of select="$v_newline"/>
    </xsl:template>

    <xsl:template match="test">
        <xsl:variable name="v_indent_string">
            <xsl:call-template name="get_indent"/>
        </xsl:variable>

        <!--        <xsl:if test="../name() = 'if_block' and count(preceding-sibling::test) = 0">
            <xsl:value-of select="$v_indent_string"/>
            <xsl:text>if </xsl:text>
        </xsl:if>
-->
        <xsl:if test="../name() = 'if_block' and count(preceding-sibling::test) > 0">
            <xsl:value-of select="$v_indent_string"/>
            <xsl:text>elif </xsl:text>
        </xsl:if>
        <xsl:text>[ </xsl:text>
        <xsl:apply-templates select="./*"/>
        <xsl:text> ] </xsl:text>
        <xsl:value-of select="$v_newline"/>
        <xsl:choose>
            <xsl:when test="../name() = 'if_block'">
                <xsl:value-of select="$v_indent_string"/>
                <xsl:text>then</xsl:text>
            </xsl:when>
            <xsl:when test="../name() = 'while_block'">
                <xsl:value-of select="$v_indent_string"/>
                <xsl:text> do</xsl:text>
            </xsl:when>
        </xsl:choose>

        <xsl:value-of select="$v_newline"/>
    </xsl:template>
    <xsl:template match="operand">
        <xsl:choose>
            <xsl:when test="@type = 'variable'">
                <xsl:text>${</xsl:text>
            </xsl:when>
            <xsl:when test="@type = 'constantChar'">
                <xsl:text>"</xsl:text>
            </xsl:when>
            <xsl:when test="@type = 'arithmetic'">
                <xsl:text>$((</xsl:text>
            </xsl:when>
        </xsl:choose>
        <xsl:value-of select="."/>
        <xsl:choose>
            <xsl:when test="@type = 'variable'">
                <xsl:text>}</xsl:text>
            </xsl:when>
            <xsl:when test="@type = 'constantChar'">
                <xsl:text>"</xsl:text>
            </xsl:when>
            <xsl:when test="@type = 'arithmetic'">
                <xsl:text>))</xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="operator">
        <xsl:choose>
            <xsl:when test=". = 'NumberGreater'">
                <xsl:text> -gt </xsl:text>
            </xsl:when>
            <xsl:when test=". = 'NumberGreaterEqual'">
                <xsl:text> -ge </xsl:text>
            </xsl:when>
            <xsl:when test=". = 'NumberLess'">
                <xsl:text> -lt </xsl:text>
            </xsl:when>
            <xsl:when test=". = 'NumberLessEqual'">
                <xsl:text> -le </xsl:text>
            </xsl:when>
            <xsl:when test=". = 'NumberEqual'">
                <xsl:text> -eq </xsl:text>
            </xsl:when>
            <xsl:when test=". = 'NumberNotEqual'">
                <xsl:text> -ne </xsl:text>
            </xsl:when>
            <xsl:when test=". = 'CharEqual'">
                <xsl:text> = </xsl:text>
            </xsl:when>
            <xsl:when test=". = 'CharNotEqual'">
                <xsl:text> != </xsl:text>
            </xsl:when>
            <xsl:when test=". = 'CharLess'">
                <xsl:text> \&lt; </xsl:text>
            </xsl:when>
            <xsl:when test=". = 'CharLessEqual'">
                <xsl:text> \&lt;= </xsl:text>
            </xsl:when>
            <xsl:when test=". = 'CharGreater'">
                <xsl:text> \&gt; </xsl:text>
            </xsl:when>
            <xsl:when test=". = 'CharGreaterEqual'">
                <xsl:text> \&gt;= </xsl:text>
            </xsl:when>
            <xsl:when test=". = 'CharLength'">
                <xsl:text> -n </xsl:text>
            </xsl:when>
            <xsl:when test=". = 'CharZeroLength'">
                <xsl:text> -z </xsl:text>
            </xsl:when>
            <xsl:when test=". = 'FileNotEmpty'">
                <xsl:text> -s </xsl:text>
            </xsl:when>
            <xsl:when test=". = 'FileEmpty'">
                <xsl:text> ! -s </xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="echo">
        <xsl:variable name="v_indent_string">
            <xsl:call-template name="get_indent"/>
        </xsl:variable>

        <xsl:if test="@wrapper and (@position = 'both' or @position = 'front')">
            <xsl:value-of select="$v_newline"/>
            <xsl:value-of select="$v_indent_string"/>
            <xsl:text>echo "</xsl:text>
            <xsl:value-of select="functx:pad-string-to-length('#', @wrapper, string-length(.))"/>
            <xsl:text>"</xsl:text>
            <xsl:value-of select="$v_newline"/>
        </xsl:if>
        <xsl:value-of select="$v_indent_string"/>
        <xsl:text>echo "</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>"</xsl:text>
        <xsl:value-of select="$v_newline"/>
        <xsl:if test="@wrapper and (@position = 'both' or @position = 'back')">
            <xsl:value-of select="$v_indent_string"/>
            <xsl:text>echo "</xsl:text>
            <xsl:value-of select="functx:pad-string-to-length('#', @wrapper, string-length(.))"/>
            <xsl:text>"</xsl:text>
            <xsl:value-of select="$v_newline"/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="steps">
        <xsl:for-each select="*">
            <xsl:apply-templates select="."/>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="full_code">
        <xsl:value-of select="$v_newline"/>
        <xsl:value-of select="."/>
    </xsl:template>

    <xsl:template name="wget">
        <xsl:variable name="f_wget" select="/bash_codes/stage/wget_stage_code"/>
        <xsl:variable name="v_git_url" select="/bash_codes/@git"/>
        <xsl:result-document href="{$f_wget}" method="text">
            <xsl:text># wget </xsl:text>
            <xsl:value-of select="$v_git_url"/>
            <xsl:text>/</xsl:text>
            <xsl:value-of select="$f_wget"/>
            <xsl:value-of select="$v_newline"/>
            <xsl:value-of select="$v_newline"/>
            
            <xsl:text><![CDATA[pwd=$(pwd)]]></xsl:text>
            <xsl:value-of select="$v_newline"/>
            
            <xsl:for-each-group select="//bash_code[@name]" group-by="@subdir">
                <xsl:variable name="v_subdir" select="./@subdir"> </xsl:variable>
                <xsl:text>cd ${pwd}</xsl:text>
                <xsl:value-of select="$v_newline"/>
                <xsl:text>mkdir -p </xsl:text>
                <xsl:value-of select="$v_subdir"/>
                <xsl:value-of select="$v_newline"/>
                
                <xsl:text>cat &lt;&lt; 'EOC' &gt; </xsl:text>
                <xsl:choose>
                    <xsl:when test="position() gt 1">
                        <xsl:text>&gt;</xsl:text>
                    </xsl:when>
                </xsl:choose>
                <xsl:value-of select="$v_subdir"/>
                <xsl:text>/profile.txt</xsl:text>
                <xsl:value-of select="$v_newline"/>
                <xsl:text>export PATH=${HOME}/</xsl:text>
                <xsl:value-of select="$v_subdir"/>
                <xsl:text>:$PATH</xsl:text>
                <xsl:value-of select="$v_newline"/>
                <xsl:text>EOC</xsl:text>
                <xsl:value-of select="$v_newline"/>
                
                
<!--                
                <xsl:text>echo -n export PATH=\${HOME}/</xsl:text>
                <xsl:value-of select="$v_subdir"/>
                <xsl:choose>
                    <xsl:when test="position() gt 1">
                        <xsl:text>&gt;</xsl:text>
                    </xsl:when>
                </xsl:choose>
                <xsl:text>&gt; </xsl:text>
                <xsl:value-of select="$v_subdir"/>
                <xsl:text>/</xsl:text>
                <xsl:text>profile.txt</xsl:text>
                <xsl:value-of select="$v_newline"/>
                <xsl:text>echo ':${PATH}' >> profile.txt </xsl:text>
                <xsl:value-of select="$v_newline"/>
-->                <xsl:text>echo cd </xsl:text>
                <xsl:value-of select="$v_subdir"/>
                <xsl:choose>
                    <xsl:when test="position() gt 1">
                        <xsl:text>&gt;</xsl:text>
                    </xsl:when>
                </xsl:choose>
                <xsl:text>&gt; </xsl:text>
                <xsl:value-of select="$v_subdir"/>
                <xsl:text>/cd_dba_code_bin.sh</xsl:text>
                <xsl:value-of select="$v_newline"/>
                
                <xsl:text>echo ln -s cd_dba_code_bin.sh BN</xsl:text>
                <xsl:text> &gt; </xsl:text>
                <xsl:value-of select="$v_subdir"/>
                <xsl:text>/ln_bn.sh</xsl:text>
                <xsl:value-of select="$v_newline"/>
                
                <xsl:text>cd ${pwd}/</xsl:text>
                <xsl:value-of select="$v_subdir"/>
                <xsl:value-of select="$v_newline"/>
                <xsl:for-each select="current-group()">
                    <xsl:text>wget </xsl:text>
                    <xsl:value-of select="$v_git_url"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="@subdir"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="@name"/>
                    <xsl:value-of select="$v_newline"/>

                    <xsl:text>chmod u+x </xsl:text>
                    <xsl:value-of select="@name"/>
                    <xsl:value-of select="$v_newline"/>
                </xsl:for-each>
            </xsl:for-each-group>

            <xsl:for-each-group select="//bash_code[@symbolic_link]" group-by="@subdir">
                <xsl:variable name="v_subdir" select="./@subdir"> </xsl:variable>
                <xsl:text>cd ${pwd}/</xsl:text>
                <xsl:value-of select="$v_subdir"/>
                <xsl:value-of select="$v_newline"/>
                <xsl:for-each select="current-group()">
                    <xsl:text>ln -s </xsl:text>
                    <xsl:value-of select="./@name"/>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="./@symbolic_link"/>
                    <xsl:value-of select="$v_newline"/>
                </xsl:for-each>
            </xsl:for-each-group>
            <xsl:text>cd ${pwd}</xsl:text>
            <xsl:value-of select="$v_newline"/>
        </xsl:result-document>
    </xsl:template>


</xsl:stylesheet>
