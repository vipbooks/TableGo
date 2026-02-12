<#-- 自定义模板生成数据库设计文档Excel -->
<?xml version="1.0" encoding="UTF-8"?>
<?mso-application progid="Excel.Sheet"?>

<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:html="http://www.w3.org/TR/REC-html40" xmlns:dt="uuid:C2F41010-65B3-11d1-A29F-00AA00C14882">
    <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
        <Author>${paramConfig.author}</Author>
        <LastAuthor>${paramConfig.author}</LastAuthor>
        <Created>${today} ${currentTime}</Created>
        <LastSaved>${today} ${currentTime}</LastSaved>
    </DocumentProperties>
    <CustomDocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
        <KSOProductBuildVer dt:dt="string">2052-11.1.0.9145</KSOProductBuildVer>
    </CustomDocumentProperties>
    <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">
        <WindowWidth>20445</WindowWidth>
        <WindowHeight>11670</WindowHeight>
        <ProtectStructure>False</ProtectStructure>
        <ProtectWindows>False</ProtectWindows>
    </ExcelWorkbook>
    <Styles>
        <Style ss:ID="s44" ss:Name="40% - 强调文字颜色 5">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#000000"/>
            <Interior ss:Color="#B4C6E7" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s28" ss:Name="强调文字颜色 2">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#FFFFFF"/>
            <Interior ss:Color="#ED7D31" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s25" ss:Name="计算">
            <Borders>
                <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#7F7F7F"/>
                <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#7F7F7F"/>
                <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#7F7F7F"/>
                <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#7F7F7F"/>
            </Borders>
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#FA7D00" ss:Bold="1"/>
            <Interior ss:Color="#F2F2F2" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s21" ss:Name="60% - 强调文字颜色 1">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#FFFFFF"/>
            <Interior ss:Color="#9BC2E6" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s8" ss:Name="千位分隔">
            <NumberFormat ss:Format="_ * #,##0.00_ ;_ * \-#,##0.00_ ;_ * &quot;-&quot;??_ ;_ @_ "/>
        </Style>
        <Style ss:ID="s37" ss:Name="20% - 强调文字颜色 2">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#000000"/>
            <Interior ss:Color="#FCE4D6" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s20" ss:Name="标题 2">
            <Borders>
                <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="2" ss:Color="#5B9BD5"/>
            </Borders>
            <Font ss:FontName="宋体" x:CharSet="134" ss:Size="13" ss:Color="#44546A" ss:Bold="1"/>
        </Style>
        <Style ss:ID="s16" ss:Name="警告文本">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#FF0000"/>
        </Style>
        <Style ss:ID="s9" ss:Name="60% - 强调文字颜色 3">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#FFFFFF"/>
            <Interior ss:Color="#C9C9C9" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s1" ss:Name="货币[0]">
            <NumberFormat ss:Format="_ &quot;￥&quot;* #,##0_ ;_ &quot;￥&quot;* \-#,##0_ ;_ &quot;￥&quot;* &quot;-&quot;_ ;_ @_ "/>
        </Style>
        <Style ss:ID="s2" ss:Name="20% - 强调文字颜色 3">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#000000"/>
            <Interior ss:Color="#EDEDED" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s3" ss:Name="输入">
            <Borders>
                <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#7F7F7F"/>
                <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#7F7F7F"/>
                <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#7F7F7F"/>
                <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#7F7F7F"/>
            </Borders>
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#3F3F76"/>
            <Interior ss:Color="#FFCC99" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s7" ss:Name="差">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#9C0006"/>
            <Interior ss:Color="#FFC7CE" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s41" ss:Name="20% - 强调文字颜色 4">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#000000"/>
            <Interior ss:Color="#FFF2CC" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s36" ss:Name="40% - 强调文字颜色 1">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#000000"/>
            <Interior ss:Color="#BDD7EE" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s19" ss:Name="标题 1">
            <Borders>
                <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="2" ss:Color="#5B9BD5"/>
            </Borders>
            <Font ss:FontName="宋体" x:CharSet="134" ss:Size="15" ss:Color="#44546A" ss:Bold="1"/>
        </Style>
        <Style ss:ID="s13" ss:Name="注释">
            <Borders>
                <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#B2B2B2"/>
                <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#B2B2B2"/>
                <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#B2B2B2"/>
                <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#B2B2B2"/>
            </Borders>
            <Interior ss:Color="#FFFFCC" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s5" ss:Name="千位分隔[0]">
            <NumberFormat ss:Format="_ * #,##0_ ;_ * \-#,##0_ ;_ * &quot;-&quot;_ ;_ @_ "/>
        </Style>
        <Style ss:ID="s6" ss:Name="40% - 强调文字颜色 3">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#000000"/>
            <Interior ss:Color="#DBDBDB" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s46" ss:Name="强调文字颜色 6">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#FFFFFF"/>
            <Interior ss:Color="#70AD47" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s38" ss:Name="40% - 强调文字颜色 2">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#000000"/>
            <Interior ss:Color="#F8CBAD" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s33" ss:Name="20% - 强调文字颜色 5">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#000000"/>
            <Interior ss:Color="#D9E1F2" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s31" ss:Name="好">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#006100"/>
            <Interior ss:Color="#C6EFCE" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s29" ss:Name="链接单元格">
            <Borders>
                <Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3" ss:Color="#FF8001"/>
            </Borders>
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#FA7D00"/>
        </Style>
        <Style ss:ID="s22" ss:Name="标题 3">
            <Borders>
                <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="2" ss:Color="#ACCCEA"/>
            </Borders>
            <Font ss:FontName="宋体" x:CharSet="134" ss:Size="11" ss:Color="#44546A" ss:Bold="1"/>
        </Style>
        <Style ss:ID="s17" ss:Name="标题">
            <Font ss:FontName="宋体" x:CharSet="134" ss:Size="18" ss:Color="#44546A" ss:Bold="1"/>
        </Style>
        <Style ss:ID="s10" ss:Name="超链接">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#0000FF" ss:Underline="Single"/>
        </Style>
        <Style ss:ID="s4" ss:Name="货币">
            <NumberFormat ss:Format="_ &quot;￥&quot;* #,##0.00_ ;_ &quot;￥&quot;* \-#,##0.00_ ;_ &quot;￥&quot;* &quot;-&quot;??_ ;_ @_ "/>
        </Style>
        <Style ss:ID="s47" ss:Name="40% - 强调文字颜色 6">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#000000"/>
            <Interior ss:Color="#C6E0B4" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s39" ss:Name="强调文字颜色 3">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#FFFFFF"/>
            <Interior ss:Color="#A5A5A5" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s35" ss:Name="20% - 强调文字颜色 1">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#000000"/>
            <Interior ss:Color="#DDEBF7" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s27" ss:Name="20% - 强调文字颜色 6">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#000000"/>
            <Interior ss:Color="#E2EFDA" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s18" ss:Name="解释性文本">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#7F7F7F" ss:Italic="1"/>
        </Style>
        <Style ss:ID="s15" ss:Name="标题 4">
            <Font ss:FontName="宋体" x:CharSet="134" ss:Size="11" ss:Color="#44546A" ss:Bold="1"/>
        </Style>
        <Style ss:ID="s12" ss:Name="已访问的超链接">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#800080" ss:Underline="Single"/>
        </Style>
        <Style ss:ID="s11" ss:Name="百分比">
            <NumberFormat ss:Format="0%"/>
        </Style>
        <Style ss:ID="Default" ss:Name="Normal">
            <Alignment ss:Vertical="Center"/>
            <Borders/>
            <Font ss:FontName="宋体" x:CharSet="134" ss:Size="11" ss:Color="#000000"/>
            <Interior/>
            <NumberFormat/>
            <Protection/>
        </Style>
        <Style ss:ID="s45" ss:Name="60% - 强调文字颜色 5">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#FFFFFF"/>
            <Interior ss:Color="#8EA9DB" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s43" ss:Name="强调文字颜色 5">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#FFFFFF"/>
            <Interior ss:Color="#4472C4" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s26" ss:Name="检查单元格">
            <Borders>
                <Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3" ss:Color="#3F3F3F"/>
                <Border ss:Position="Left" ss:LineStyle="Double" ss:Weight="3" ss:Color="#3F3F3F"/>
                <Border ss:Position="Right" ss:LineStyle="Double" ss:Weight="3" ss:Color="#3F3F3F"/>
                <Border ss:Position="Top" ss:LineStyle="Double" ss:Weight="3" ss:Color="#3F3F3F"/>
            </Borders>
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#FFFFFF" ss:Bold="1"/>
            <Interior ss:Color="#A5A5A5" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s24" ss:Name="输出">
            <Borders>
                <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#3F3F3F"/>
                <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#3F3F3F"/>
                <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#3F3F3F"/>
                <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#3F3F3F"/>
            </Borders>
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#3F3F3F" ss:Bold="1"/>
            <Interior ss:Color="#F2F2F2" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s14" ss:Name="60% - 强调文字颜色 2">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#FFFFFF"/>
            <Interior ss:Color="#F4B084" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s42" ss:Name="40% - 强调文字颜色 4">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#000000"/>
            <Interior ss:Color="#FFE699" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s32" ss:Name="适中">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#9C6500"/>
            <Interior ss:Color="#FFEB9C" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s30" ss:Name="汇总">
            <Borders>
                <Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3" ss:Color="#5B9BD5"/>
                <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#5B9BD5"/>
            </Borders>
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#000000" ss:Bold="1"/>
        </Style>
        <Style ss:ID="s23" ss:Name="60% - 强调文字颜色 4">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#FFFFFF"/>
            <Interior ss:Color="#FFD966" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s48" ss:Name="60% - 强调文字颜色 6">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#FFFFFF"/>
            <Interior ss:Color="#A9D08E" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s40" ss:Name="强调文字颜色 4">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#FFFFFF"/>
            <Interior ss:Color="#FFC000" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s34" ss:Name="强调文字颜色 1">
            <Font ss:FontName="宋体" x:CharSet="0" ss:Size="11" ss:Color="#FFFFFF"/>
            <Interior ss:Color="#5B9BD5" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s49"/>
        <Style ss:ID="s50">
            <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
        </Style>
        <Style ss:ID="s51">
            <Alignment ss:Vertical="Center" ss:WrapText="1"/>
        </Style>
        <Style ss:ID="s52">
            <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
            <Borders>
                <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
                <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
                <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
                <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
            </Borders>
            <Font ss:FontName="微软雅黑" x:CharSet="134" ss:Size="16" ss:Color="#000000" ss:Bold="1"/>
            <Interior ss:Color="#C9C9C9" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s53">
            <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
            <Borders>
                <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
                <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
                <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
                <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
            </Borders>
            <Font ss:FontName="微软雅黑" x:CharSet="134" ss:Size="14" ss:Color="#000000" ss:Bold="1"/>
            <Interior ss:Color="#C9C9C9" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s54">
            <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
            <Borders>
                <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
                <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
                <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
                <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
            </Borders>
            <Font ss:FontName="微软雅黑" x:CharSet="134" ss:Size="14" ss:Color="#000000" ss:Bold="1"/>
            <Interior ss:Color="#C9C9C9" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s55">
            <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
            <Borders>
                <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
                <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
                <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
                <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
            </Borders>
            <Font ss:FontName="微软雅黑" x:CharSet="134" ss:Size="12" ss:Color="#000000"/>
        </Style>
        <Style ss:ID="s56">
            <Borders>
                <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
                <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
                <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
                <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
            </Borders>
            <Font ss:FontName="微软雅黑" x:CharSet="134" ss:Size="12" ss:Color="#000000"/>
        </Style>
        <Style ss:ID="s57">
            <Alignment ss:Vertical="Center" ss:WrapText="1"/>
            <Borders>
                <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
                <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
                <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
                <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
            </Borders>
            <Font ss:FontName="微软雅黑" x:CharSet="134" ss:Size="12" ss:Color="#000000"/>
        </Style>
        <Style ss:ID="s58">
            <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
            <Borders>
                <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
                <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
                <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
                <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
            </Borders>
            <Font ss:FontName="微软雅黑" x:CharSet="134" ss:Size="16" ss:Color="#000000" ss:Bold="1"/>
            <Interior ss:Color="#C9C9C9" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s59">
            <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
            <Borders>
                <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
                <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
                <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
                <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
            </Borders>
            <Font ss:FontName="微软雅黑" x:CharSet="134" ss:Size="16" ss:Color="#000000" ss:Bold="1"/>
            <Interior ss:Color="#C9C9C9" ss:Pattern="Solid"/>
        </Style>
        <Style ss:ID="s60">
            <Borders/>
            <Font ss:FontName="微软雅黑" x:CharSet="134" ss:Size="12" ss:Color="#000000"/>
        </Style>
    </Styles>
    <!-- 初始化数据库表信息 -->
    <Worksheet ss:Name="${docTitle}">
        <Table ss:ExpandedColumnCount="7" ss:ExpandedRowCount="4" x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="13.5">
            <Column ss:Index="1" ss:StyleID="s50" ss:AutoFitWidth="0" ss:Width="51.75"/>
            <Column ss:Index="2" ss:StyleID="Default" ss:AutoFitWidth="0" ss:Width="135.75" ss:Span="1"/>
            <Column ss:Index="4" ss:StyleID="s50" ss:AutoFitWidth="0" ss:Width="39.75" ss:Span="1"/>
            <Column ss:Index="6" ss:StyleID="s50" ss:AutoFitWidth="0" ss:Width="135.75"/>
            <Column ss:StyleID="s51" ss:AutoFitWidth="0" ss:Width="363.75"/>
        <#list tableInfoList as tableInfo>
            <Row ss:Height="22.5">
                <Cell ss:StyleID="s58" ss:MergeAcross="6">
                    <Data ss:Type="String">${FtlUtils.emptyToDefault(tableInfo.remark, "${tableInfo.simpleRemark}（${tableInfo.tableName}）", tableInfo.tableName)}</Data>
                </Cell>
            </Row>
            <Row ss:Height="21">
                <Cell ss:StyleID="s53">
                    <Data ss:Type="String">序号</Data>
                </Cell>
                <Cell ss:StyleID="s53">
                    <Data ss:Type="String">字段名</Data>
                </Cell>
                <Cell ss:StyleID="s53">
                    <Data ss:Type="String">数据类型</Data>
                </Cell>
                <Cell ss:StyleID="s53">
                    <Data ss:Type="String">主键</Data>
                </Cell>
                <Cell ss:StyleID="s53">
                    <Data ss:Type="String">非空</Data>
                </Cell>
                <Cell ss:StyleID="s53">
                    <Data ss:Type="String">默认值</Data>
                </Cell>
                <Cell ss:StyleID="s54">
                    <Data ss:Type="String">注释</Data>
                </Cell>
            </Row>
            <!-- 初始化表结构字段信息 -->
            <#list tableInfo.fieldInfos as fieldInfo>
            <Row ss:Height="17.25">
                <Cell ss:StyleID="s55">
                    <Data ss:Type="Number">${fieldInfo_index + 1}</Data>
                </Cell>
                <Cell ss:StyleID="s56">
                    <Data ss:Type="String">${fieldInfo.colName}</Data>
                </Cell>
                <Cell ss:StyleID="s56">
                    <Data ss:Type="String">${fieldInfo.dataTypeStr}</Data>
                </Cell>
                <Cell ss:StyleID="s55">
                    <Data ss:Type="String"><#if fieldInfo.primaryKey>是<#else>否</#if></Data>
                </Cell>
                <Cell ss:StyleID="s55">
                    <Data ss:Type="String"><#if fieldInfo.primaryKey>是<#elseif fieldInfo.nullable == "false">是<#else>否</#if></Data>
                </Cell>
                <Cell ss:StyleID="s55">
                    <Data ss:Type="String">${fieldInfo.defaultValue}</Data>
                </Cell>
                <Cell ss:StyleID="s57">
                    <Data ss:Type="String">${fieldInfo.remark}</Data>
                </Cell>
            </Row>
            </#list>
            <Row>
                <Cell ss:StyleID="s60"/>
                <Cell ss:StyleID="s60"/>
                <Cell ss:StyleID="s60"/>
                <Cell ss:StyleID="s60"/>
                <Cell ss:StyleID="s60"/>
                <Cell ss:StyleID="s60"/>
                <Cell ss:StyleID="s60"/>
            </Row>
            <Row>
                <Cell ss:StyleID="s60"/>
                <Cell ss:StyleID="s60"/>
                <Cell ss:StyleID="s60"/>
                <Cell ss:StyleID="s60"/>
                <Cell ss:StyleID="s60"/>
                <Cell ss:StyleID="s60"/>
                <Cell ss:StyleID="s60"/>
            </Row>
         </#list>
       </Table>
    </Worksheet>
</Workbook>