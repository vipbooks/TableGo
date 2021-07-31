<#-- 自定义模板生成数据库设计文档Word -->
<?xml version="1.0" encoding="UTF-8"?>
<?mso-application progid="Word.Document"?>

<pkg:package xmlns:pkg="http://schemas.microsoft.com/office/2006/xmlPackage">
    <pkg:part pkg:name="/_rels/.rels" pkg:contentType="application/vnd.openxmlformats-package.relationships+xml">
        <pkg:xmlData>
            <Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
                <Relationship Id="rId4" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/>
                <Relationship Id="rId2" Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties" Target="docProps/core.xml"/>
                <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties" Target="docProps/app.xml"/>
                <Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/custom-properties" Target="docProps/custom.xml"/>
            </Relationships>
        </pkg:xmlData>
    </pkg:part>
    <pkg:part pkg:name="/word/_rels/document.xml.rels" pkg:contentType="application/vnd.openxmlformats-package.relationships+xml">
        <pkg:xmlData>
            <Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
                <Relationship Id="rId9" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/fontTable" Target="fontTable.xml"/>
                <Relationship Id="rId8" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/numbering" Target="numbering.xml"/>
                <Relationship Id="rId7" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/customXml" Target="../customXml/item1.xml"/>
                <Relationship Id="rId5" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme" Target="theme/theme1.xml"/>
                <Relationship Id="rId4" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/footer" Target="footer1.xml"/>
                <Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/header" Target="header1.xml"/>
                <Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/settings" Target="settings.xml"/>
                <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>

                <!-- 初始化所有数据库表ER图 -->
                <#list tableInfoList as tableInfo>
                <Relationship Id="rId_${tableInfo.tableName}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="media/${tableInfo.tableName}.png"/>
                </#list>
            </Relationships>
        </pkg:xmlData>
    </pkg:part>
    <pkg:part pkg:name="/word/document.xml" pkg:contentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml">
        <pkg:xmlData>
            <w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:wpc="http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:wp14="http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:w15="http://schemas.microsoft.com/office/word/2012/wordml" xmlns:wpg="http://schemas.microsoft.com/office/word/2010/wordprocessingGroup" xmlns:wpi="http://schemas.microsoft.com/office/word/2010/wordprocessingInk" xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml" xmlns:wps="http://schemas.microsoft.com/office/word/2010/wordprocessingShape" xmlns:wpsCustomData="http://www.wps.cn/officeDocument/2013/wpsCustomData" mc:Ignorable="w14 w15 wp14">
                <w:body>
                    <w:p>
                        <w:pPr>
                            <w:jc w:val="center"/>
                            <w:rPr>
                                <w:rFonts w:hint="eastAsia" w:ascii="微软雅黑" w:hAnsi="微软雅黑" w:eastAsia="微软雅黑" w:cs="微软雅黑"/>
                                <w:b/>
                                <w:sz w:val="44"/>
                                <w:szCs w:val="44"/>
                            </w:rPr>
                        </w:pPr>
                        <w:bookmarkStart w:id="0" w:name="_GoBack"/>
                        <w:bookmarkEnd w:id="0"/>
                        <w:r>
                            <w:rPr>
                                <w:rFonts w:hint="eastAsia" w:ascii="微软雅黑" w:hAnsi="微软雅黑" w:eastAsia="微软雅黑" w:cs="微软雅黑"/>
                                <w:b/>
                                <w:sz w:val="44"/>
                                <w:szCs w:val="44"/>
                            </w:rPr>
                            <w:t>${docTitle}</w:t>
                        </w:r>
                    </w:p>
                    <w:p/>
                    <!-- 初始化数据库表信息 -->
                    <#list tableInfoList as tableInfo>
                    <w:p>
                        <w:pPr>
                            <w:pStyle w:val="2"/>
                            <w:bidi w:val="0"/>
                        </w:pPr>
                        <w:r>
                            <w:rPr>
                                <w:rFonts w:hint="eastAsia"/>
                            </w:rPr>
                            <#if tableInfo.remark?? && tableInfo.remark?trim != "">
                            <w:t>${tableInfo.simpleRemark}（${tableInfo.tableName}）</w:t>
                            <#else>
                            <w:t>${tableInfo.tableName}</w:t>
                            </#if>
                        </w:r>
                    </w:p>
                    <w:p>
                        <w:r>
                            <w:pict>
                                <v:shape id="_x0000_i1025" o:spt="75" type="#_x0000_t75" style="height:${tableInfo.height}px;width:${tableInfo.width}px;" filled="f" o:preferrelative="t" stroked="f" coordsize="21600,21600">
                                    <v:path/>
                                    <v:fill on="f" focussize="0,0"/>
                                    <v:stroke on="f" joinstyle="miter"/>
                                    <v:imagedata r:id="rId_${tableInfo.tableName}" o:title=""/>
                                    <o:lock v:ext="edit" aspectratio="t"/>
                                    <w10:wrap type="none"/>
                                    <w10:anchorlock/>
                                </v:shape>
                            </w:pict>
                        </w:r>
                    </w:p>
                    <w:p>
                        <w:pPr>
                            <w:ind w:firstLine="210" w:firstLineChars="100"/>
                        </w:pPr>
                        <w:r>
                            <w:rPr>
                                <w:rFonts w:hint="eastAsia" w:ascii="微软雅黑" w:hAnsi="微软雅黑" w:eastAsia="微软雅黑" w:cs="微软雅黑"/>
                                <w:b/>
                            </w:rPr>
                            <w:t>描述：</w:t>
                        </w:r>
                        <w:r>
                            <w:rPr>
                                <w:rFonts w:hint="eastAsia" w:ascii="微软雅黑" w:hAnsi="微软雅黑" w:eastAsia="微软雅黑" w:cs="微软雅黑"/>
                            </w:rPr>
                            <w:t>${tableInfo.remark}</w:t>
                        </w:r>
                    </w:p>
                    <w:p>
                        <w:pPr>
                            <w:ind w:firstLine="210" w:firstLineChars="100"/>
                            <w:rPr>
                                <w:rFonts w:hint="eastAsia" w:ascii="微软雅黑" w:hAnsi="微软雅黑" w:eastAsia="微软雅黑" w:cs="微软雅黑"/>
                                <w:b/>
                            </w:rPr>
                        </w:pPr>
                        <w:r>
                            <w:rPr>
                                <w:rFonts w:hint="eastAsia" w:ascii="微软雅黑" w:hAnsi="微软雅黑" w:eastAsia="微软雅黑" w:cs="微软雅黑"/>
                                <w:b/>
                            </w:rPr>
                            <w:t>表结构：</w:t>
                        </w:r>
                    </w:p>
                    <!-- 初始化表结构表格信息 -->
                    <#include "dbTable.ftl">
                    <w:p/>
                    </#list>
                    <w:sectPr>
                        <w:headerReference r:id="rId3" w:type="default"/>
                        <w:footerReference r:id="rId4" w:type="default"/>
                        <w:pgSz w:w="11906" w:h="16838"/>
                        <w:pgMar w:top="1440" w:right="1440" w:bottom="1440" w:left="1440" w:header="851" w:footer="992" w:gutter="0"/>
                        <w:cols w:space="720" w:num="1"/>
                        <w:docGrid w:type="lines" w:linePitch="312" w:charSpace="0"/>
                    </w:sectPr>
                </w:body>
            </w:document>
        </pkg:xmlData>
    </pkg:part>
    <!-- 初始化所有数据库表ER图数据 -->
    <#list tableInfoList as tableInfo>
    <pkg:part pkg:name="/word/media/${tableInfo.tableName}.png" pkg:contentType="image/png" pkg:compression="store">
        <pkg:binaryData>${tableInfo.imageBase64}</pkg:binaryData>
    </pkg:part>
    </#list>
    <pkg:part pkg:name="/customXml/_rels/item1.xml.rels" pkg:contentType="application/vnd.openxmlformats-package.relationships+xml">
        <pkg:xmlData>
            <Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
                <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/customXmlProps" Target="itemProps1.xml"/>
            </Relationships>
        </pkg:xmlData>
    </pkg:part>
    <pkg:part pkg:name="/customXml/item1.xml" pkg:contentType="application/xml">
        <pkg:xmlData>
            <s:customData xmlns:s="http://www.wps.cn/officeDocument/2013/wpsCustomData" xmlns="http://www.wps.cn/officeDocument/2013/wpsCustomData">
                <customSectProps>
                    <customSectPr/>
                </customSectProps>
            </s:customData>
        </pkg:xmlData>
    </pkg:part>
    <pkg:part pkg:name="/customXml/itemProps1.xml" pkg:contentType="application/vnd.openxmlformats-officedocument.customXmlProperties+xml">
        <pkg:xmlData>
            <ds:datastoreItem xmlns:ds="http://schemas.openxmlformats.org/officeDocument/2006/customXml" ds:itemID="{B1977F7D-205B-4081-913C-38D41E755F92}">
                <ds:schemaRefs>
                    <ds:schemaRef ds:uri="http://www.wps.cn/officeDocument/2013/wpsCustomData"/>
                </ds:schemaRefs>
            </ds:datastoreItem>
        </pkg:xmlData>
    </pkg:part>
    <pkg:part pkg:name="/docProps/app.xml" pkg:contentType="application/vnd.openxmlformats-officedocument.extended-properties+xml">
        <pkg:xmlData>
            <Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties" xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes">
                <Template>Normal.dotm</Template>
                <Company>edinsker@163.com</Company>
                <Pages>1</Pages>
                <Words>12</Words>
                <Characters>70</Characters>
                <Lines>1</Lines>
                <Paragraphs>1</Paragraphs>
                <TotalTime>1</TotalTime>
                <ScaleCrop>false</ScaleCrop>
                <LinksUpToDate>false</LinksUpToDate>
                <CharactersWithSpaces>81</CharactersWithSpaces>
                <Application>WPS Office_11.1.0.9145_F1E327BC-269C-435d-A152-05C5408002CA</Application>
                <DocSecurity>0</DocSecurity>
            </Properties>
        </pkg:xmlData>
    </pkg:part>
    <pkg:part pkg:name="/docProps/core.xml" pkg:contentType="application/vnd.openxmlformats-package.core-properties+xml">
        <pkg:xmlData>
            <cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dcmitype="http://purl.org/dc/dcmitype/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
                <dcterms:created xsi:type="dcterms:W3CDTF">2016-11-30T03:05:00Z</dcterms:created>
                <dc:creator>bianj</dc:creator>
                <dc:description>http://vipbooks.iteye.com_x000d_ http://blog.csdn.net/vipbooks_x000d_ http://www.cnblogs.com/vipbooks</dc:description>
                <cp:lastModifiedBy>vipbooks</cp:lastModifiedBy>
                <dcterms:modified xsi:type="dcterms:W3CDTF">2019-10-19T03:12:45Z</dcterms:modified>
                <dc:subject>自动生成数据库设计文档</dc:subject>
                <dc:title>数据库设计文档</dc:title>
                <cp:revision>4</cp:revision>
            </cp:coreProperties>
        </pkg:xmlData>
    </pkg:part>
    <pkg:part pkg:name="/docProps/custom.xml" pkg:contentType="application/vnd.openxmlformats-officedocument.custom-properties+xml">
        <pkg:xmlData>
            <Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/custom-properties" xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes">
                <property fmtid="{D5CDD505-2E9C-101B-9397-08002B2CF9AE}" pid="2" name="KSOProductBuildVer">
                    <vt:lpwstr>2052-11.1.0.9145</vt:lpwstr>
                </property>
            </Properties>
        </pkg:xmlData>
    </pkg:part>
    <pkg:part pkg:name="/word/fontTable.xml" pkg:contentType="application/vnd.openxmlformats-officedocument.wordprocessingml.fontTable+xml">
        <pkg:xmlData>
            <w:fonts xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml" mc:Ignorable="w14">
                <w:font w:name="Times New Roman">
                    <w:panose1 w:val="02020603050405020304"/>
                    <w:charset w:val="86"/>
                    <w:family w:val="auto"/>
                    <w:pitch w:val="default"/>
                    <w:sig w:usb0="E0002EFF" w:usb1="C000785B" w:usb2="00000009" w:usb3="00000000" w:csb0="400001FF" w:csb1="FFFF0000"/>
                </w:font>
                <w:font w:name="宋体">
                    <w:panose1 w:val="02010600030101010101"/>
                    <w:charset w:val="86"/>
                    <w:family w:val="auto"/>
                    <w:pitch w:val="default"/>
                    <w:sig w:usb0="00000003" w:usb1="288F0000" w:usb2="00000006" w:usb3="00000000" w:csb0="00040001" w:csb1="00000000"/>
                </w:font>
                <w:font w:name="Wingdings">
                    <w:panose1 w:val="05000000000000000000"/>
                    <w:charset w:val="02"/>
                    <w:family w:val="auto"/>
                    <w:pitch w:val="default"/>
                    <w:sig w:usb0="00000000" w:usb1="00000000" w:usb2="00000000" w:usb3="00000000" w:csb0="80000000" w:csb1="00000000"/>
                </w:font>
                <w:font w:name="Arial">
                    <w:panose1 w:val="020B0604020202020204"/>
                    <w:charset w:val="01"/>
                    <w:family w:val="swiss"/>
                    <w:pitch w:val="default"/>
                    <w:sig w:usb0="E0002EFF" w:usb1="C000785B" w:usb2="00000009" w:usb3="00000000" w:csb0="400001FF" w:csb1="FFFF0000"/>
                </w:font>
                <w:font w:name="黑体">
                    <w:panose1 w:val="02010609060101010101"/>
                    <w:charset w:val="86"/>
                    <w:family w:val="auto"/>
                    <w:pitch w:val="default"/>
                    <w:sig w:usb0="800002BF" w:usb1="38CF7CFA" w:usb2="00000016" w:usb3="00000000" w:csb0="00040001" w:csb1="00000000"/>
                </w:font>
                <w:font w:name="Courier New">
                    <w:panose1 w:val="02070309020205020404"/>
                    <w:charset w:val="01"/>
                    <w:family w:val="modern"/>
                    <w:pitch w:val="default"/>
                    <w:sig w:usb0="E0002EFF" w:usb1="C0007843" w:usb2="00000009" w:usb3="00000000" w:csb0="400001FF" w:csb1="FFFF0000"/>
                </w:font>
                <w:font w:name="Symbol">
                    <w:panose1 w:val="05050102010706020507"/>
                    <w:charset w:val="02"/>
                    <w:family w:val="roman"/>
                    <w:pitch w:val="default"/>
                    <w:sig w:usb0="00000000" w:usb1="00000000" w:usb2="00000000" w:usb3="00000000" w:csb0="80000000" w:csb1="00000000"/>
                </w:font>
                <w:font w:name="Calibri">
                    <w:panose1 w:val="020F0502020204030204"/>
                    <w:charset w:val="00"/>
                    <w:family w:val="swiss"/>
                    <w:pitch w:val="default"/>
                    <w:sig w:usb0="E4002EFF" w:usb1="C000247B" w:usb2="00000009" w:usb3="00000000" w:csb0="200001FF" w:csb1="00000000"/>
                </w:font>
                <w:font w:name="Arial">
                    <w:panose1 w:val="020B0604020202020204"/>
                    <w:charset w:val="00"/>
                    <w:family w:val="auto"/>
                    <w:pitch w:val="default"/>
                    <w:sig w:usb0="E0002EFF" w:usb1="C000785B" w:usb2="00000009" w:usb3="00000000" w:csb0="400001FF" w:csb1="FFFF0000"/>
                </w:font>
                <w:font w:name="微软雅黑">
                    <w:panose1 w:val="020B0503020204020204"/>
                    <w:charset w:val="86"/>
                    <w:family w:val="auto"/>
                    <w:pitch w:val="default"/>
                    <w:sig w:usb0="80000287" w:usb1="2ACF3C50" w:usb2="00000016" w:usb3="00000000" w:csb0="0004001F" w:csb1="00000000"/>
                </w:font>
                <w:font w:name="Tahoma">
                    <w:panose1 w:val="020B0604030504040204"/>
                    <w:charset w:val="00"/>
                    <w:family w:val="auto"/>
                    <w:pitch w:val="default"/>
                    <w:sig w:usb0="E1002EFF" w:usb1="C000605B" w:usb2="00000029" w:usb3="00000000" w:csb0="200101FF" w:csb1="20280000"/>
                </w:font>
            </w:fonts>
        </pkg:xmlData>
    </pkg:part>
    <pkg:part pkg:name="/word/footer1.xml" pkg:contentType="application/vnd.openxmlformats-officedocument.wordprocessingml.footer+xml">
        <pkg:xmlData>
            <w:ftr xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:wpc="http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:wp14="http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml" xmlns:w15="http://schemas.microsoft.com/office/word/2012/wordml" xmlns:wpg="http://schemas.microsoft.com/office/word/2010/wordprocessingGroup" xmlns:wpi="http://schemas.microsoft.com/office/word/2010/wordprocessingInk" xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml" xmlns:wps="http://schemas.microsoft.com/office/word/2010/wordprocessingShape" xmlns:wpsCustomData="http://www.wps.cn/officeDocument/2013/wpsCustomData" mc:Ignorable="w14 w15 wp14">
                <w:p>
                    <w:pPr>
                        <w:pStyle w:val="4"/>
                        <w:jc w:val="center"/>
                    </w:pPr>
                    <w:r>
                        <w:rPr>
                            <w:lang w:val="zh-CN"/>
                        </w:rPr>
                        <w:t xml:space="preserve"> </w:t>
                    </w:r>
                    <w:r>
                        <w:rPr>
                            <w:sz w:val="24"/>
                            <w:szCs w:val="24"/>
                        </w:rPr>
                        <w:fldChar w:fldCharType="begin"/>
                    </w:r>
                    <w:r>
                        <w:instrText xml:space="preserve">PAGE</w:instrText>
                    </w:r>
                    <w:r>
                        <w:rPr>
                            <w:sz w:val="24"/>
                            <w:szCs w:val="24"/>
                        </w:rPr>
                        <w:fldChar w:fldCharType="separate"/>
                    </w:r>
                    <w:r>
                        <w:t>1</w:t>
                    </w:r>
                    <w:r>
                        <w:rPr>
                            <w:sz w:val="24"/>
                            <w:szCs w:val="24"/>
                        </w:rPr>
                        <w:fldChar w:fldCharType="end"/>
                    </w:r>
                    <w:r>
                        <w:rPr>
                            <w:lang w:val="zh-CN"/>
                        </w:rPr>
                        <w:t xml:space="preserve"> / </w:t>
                    </w:r>
                    <w:r>
                        <w:rPr>
                            <w:sz w:val="24"/>
                            <w:szCs w:val="24"/>
                        </w:rPr>
                        <w:fldChar w:fldCharType="begin"/>
                    </w:r>
                    <w:r>
                        <w:instrText xml:space="preserve">NUMPAGES</w:instrText>
                    </w:r>
                    <w:r>
                        <w:rPr>
                            <w:sz w:val="24"/>
                            <w:szCs w:val="24"/>
                        </w:rPr>
                        <w:fldChar w:fldCharType="separate"/>
                    </w:r>
                    <w:r>
                        <w:t>1</w:t>
                    </w:r>
                    <w:r>
                        <w:rPr>
                            <w:sz w:val="24"/>
                            <w:szCs w:val="24"/>
                        </w:rPr>
                        <w:fldChar w:fldCharType="end"/>
                    </w:r>
                </w:p>
                <w:p>
                    <w:pPr>
                        <w:pStyle w:val="4"/>
                    </w:pPr>
                </w:p>
            </w:ftr>
        </pkg:xmlData>
    </pkg:part>
    <pkg:part pkg:name="/word/header1.xml" pkg:contentType="application/vnd.openxmlformats-officedocument.wordprocessingml.header+xml">
        <pkg:xmlData>
            <w:hdr xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:wpc="http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:wp14="http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml" xmlns:w15="http://schemas.microsoft.com/office/word/2012/wordml" xmlns:wpg="http://schemas.microsoft.com/office/word/2010/wordprocessingGroup" xmlns:wpi="http://schemas.microsoft.com/office/word/2010/wordprocessingInk" xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml" xmlns:wps="http://schemas.microsoft.com/office/word/2010/wordprocessingShape" xmlns:wpsCustomData="http://www.wps.cn/officeDocument/2013/wpsCustomData" mc:Ignorable="w14 w15 wp14">
                <w:p>
                    <w:pPr>
                        <w:pStyle w:val="5"/>
                        <w:rPr>
                            <w:rFonts w:hint="default" w:eastAsia="宋体"/>
                            <w:lang w:val="en-US" w:eastAsia="zh-CN"/>
                        </w:rPr>
                    </w:pPr>
                    <w:r>
                        <w:t>Author:</w:t>
                    </w:r>
                    <w:r>
                        <w:rPr>
                            <w:rFonts w:hint="eastAsia"/>
                            <w:lang w:val="en-US" w:eastAsia="zh-CN"/>
                        </w:rPr>
                        <w:t xml:space="preserve"> </w:t>
                    </w:r>
                    <w:r>
                        <w:t>bianj</w:t>
                    </w:r>
                    <w:r>
                        <w:rPr>
                            <w:rFonts w:hint="eastAsia"/>
                        </w:rPr>
                        <w:t xml:space="preserve">  </w:t>
                    </w:r>
                    <w:r>
                        <w:t>Email:</w:t>
                    </w:r>
                    <w:r>
                        <w:rPr>
                            <w:rFonts w:hint="eastAsia"/>
                            <w:lang w:val="en-US" w:eastAsia="zh-CN"/>
                        </w:rPr>
                        <w:t xml:space="preserve"> tablego</w:t>
                    </w:r>
                    <w:r>
                        <w:t>@</w:t>
                    </w:r>
                    <w:r>
                        <w:rPr>
                            <w:rFonts w:hint="eastAsia"/>
                            <w:lang w:val="en-US" w:eastAsia="zh-CN"/>
                        </w:rPr>
                        <w:t>qq</w:t>
                    </w:r>
                    <w:r>
                        <w:t>.com</w:t>
                    </w:r>
                    <w:r>
                        <w:rPr>
                            <w:rFonts w:hint="eastAsia"/>
                            <w:lang w:val="en-US" w:eastAsia="zh-CN"/>
                        </w:rPr>
                        <w:t xml:space="preserve">  http://www.tablego.cn</w:t>
                    </w:r>
                </w:p>
                <w:p>
                    <w:pPr>
                        <w:pStyle w:val="5"/>
                    </w:pPr>
                    <w:r>
                        <w:t>http://vipbooks.iteye.com</w:t>
                    </w:r>
                    <w:r>
                        <w:rPr>
                            <w:rFonts w:hint="eastAsia"/>
                        </w:rPr>
                        <w:t xml:space="preserve">  </w:t>
                    </w:r>
                    <w:r>
                        <w:t>http://blog.csdn.net/vipbooks</w:t>
                    </w:r>
                    <w:r>
                        <w:rPr>
                            <w:rFonts w:hint="eastAsia"/>
                        </w:rPr>
                        <w:t xml:space="preserve">  </w:t>
                    </w:r>
                    <w:r>
                        <w:t>http://www.cnblogs.com/vipbooks</w:t>
                    </w:r>
                </w:p>
            </w:hdr>
        </pkg:xmlData>
    </pkg:part>
    <pkg:part pkg:name="/word/numbering.xml" pkg:contentType="application/vnd.openxmlformats-officedocument.wordprocessingml.numbering+xml">
        <pkg:xmlData>
            <w:numbering xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:wpc="http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:wp14="http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml" xmlns:wpg="http://schemas.microsoft.com/office/word/2010/wordprocessingGroup" xmlns:wpi="http://schemas.microsoft.com/office/word/2010/wordprocessingInk" xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml" xmlns:wps="http://schemas.microsoft.com/office/word/2010/wordprocessingShape" mc:Ignorable="w14 wp14">
                <w:abstractNum w:abstractNumId="0">
                    <w:nsid w:val="F96AC0A8"/>
                    <w:multiLevelType w:val="singleLevel"/>
                    <w:tmpl w:val="F96AC0A8"/>
                    <w:lvl w:ilvl="0" w:tentative="0">
                        <w:start w:val="1"/>
                        <w:numFmt w:val="decimal"/>
                        <w:pStyle w:val="2"/>
                        <w:suff w:val="nothing"/>
                        <w:lvlText w:val="%1、"/>
                        <w:lvlJc w:val="left"/>
                    </w:lvl>
                </w:abstractNum>
                <w:num w:numId="1">
                    <w:abstractNumId w:val="0"/>
                </w:num>
            </w:numbering>
        </pkg:xmlData>
    </pkg:part>
    <pkg:part pkg:name="/word/settings.xml" pkg:contentType="application/vnd.openxmlformats-officedocument.wordprocessingml.settings+xml">
        <pkg:xmlData>
            <w:settings xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml" xmlns:sl="http://schemas.openxmlformats.org/schemaLibrary/2006/main" mc:Ignorable="w14">
                <w:zoom w:percent="130"/>
                <w:bordersDoNotSurroundHeader w:val="1"/>
                <w:bordersDoNotSurroundFooter w:val="1"/>
                <w:documentProtection w:enforcement="0"/>
                <w:defaultTabStop w:val="420"/>
                <w:hyphenationZone w:val="360"/>
                <w:drawingGridVerticalSpacing w:val="156"/>
                <w:displayHorizontalDrawingGridEvery w:val="0"/>
                <w:displayVerticalDrawingGridEvery w:val="2"/>
                <w:characterSpacingControl w:val="compressPunctuation"/>
                <w:compat>
                    <w:spaceForUL/>
                    <w:balanceSingleByteDoubleByteWidth/>
                    <w:doNotLeaveBackslashAlone/>
                    <w:ulTrailSpace/>
                    <w:doNotExpandShiftReturn/>
                    <w:adjustLineHeightInTable/>
                    <w:useFELayout/>
                    <w:useNormalStyleForList/>
                    <w:doNotUseIndentAsNumberingTabStop/>
                    <w:useAltKinsokuLineBreakRules/>
                    <w:allowSpaceOfSameStyleInTable/>
                    <w:doNotSuppressIndentation/>
                    <w:doNotAutofitConstrainedTables/>
                    <w:autofitToFirstFixedWidthCell/>
                    <w:displayHangulFixedWidth/>
                    <w:splitPgBreakAndParaMark/>
                    <w:doNotVertAlignCellWithSp/>
                    <w:doNotBreakConstrainedForcedTable/>
                    <w:doNotVertAlignInTxbx/>
                    <w:useAnsiKerningPairs/>
                    <w:cachedColBalance/>
                    <w:compatSetting w:name="compatibilityMode" w:uri="http://schemas.microsoft.com/office/word" w:val="11"/>
                </w:compat>
                <w:rsids>
                    <w:rsidRoot w:val="00E21E23"/>
                    <w:rsid w:val="00067493"/>
                    <w:rsid w:val="000A5ABE"/>
                    <w:rsid w:val="001040F1"/>
                    <w:rsid w:val="001602F2"/>
                    <w:rsid w:val="001A66E1"/>
                    <w:rsid w:val="001D4BBA"/>
                    <w:rsid w:val="0021015D"/>
                    <w:rsid w:val="0023598E"/>
                    <w:rsid w:val="002D24DA"/>
                    <w:rsid w:val="003069E0"/>
                    <w:rsid w:val="003E3E93"/>
                    <w:rsid w:val="003F4825"/>
                    <w:rsid w:val="004C1B61"/>
                    <w:rsid w:val="004D4289"/>
                    <w:rsid w:val="00517F7F"/>
                    <w:rsid w:val="005A16F2"/>
                    <w:rsid w:val="005C38E8"/>
                    <w:rsid w:val="00623FFC"/>
                    <w:rsid w:val="00652901"/>
                    <w:rsid w:val="006D4910"/>
                    <w:rsid w:val="007558F9"/>
                    <w:rsid w:val="00765B87"/>
                    <w:rsid w:val="007B67C7"/>
                    <w:rsid w:val="009173E3"/>
                    <w:rsid w:val="00937548"/>
                    <w:rsid w:val="009D48F1"/>
                    <w:rsid w:val="00A422E1"/>
                    <w:rsid w:val="00AA1F92"/>
                    <w:rsid w:val="00AF509B"/>
                    <w:rsid w:val="00B12748"/>
                    <w:rsid w:val="00B26845"/>
                    <w:rsid w:val="00B62786"/>
                    <w:rsid w:val="00CA4F39"/>
                    <w:rsid w:val="00D33B98"/>
                    <w:rsid w:val="00D37582"/>
                    <w:rsid w:val="00D62416"/>
                    <w:rsid w:val="00D646C3"/>
                    <w:rsid w:val="00E11540"/>
                    <w:rsid w:val="00E21E23"/>
                    <w:rsid w:val="00E669E2"/>
                    <w:rsid w:val="00EC76D2"/>
                    <w:rsid w:val="00EF1044"/>
                    <w:rsid w:val="00F3377F"/>
                    <w:rsid w:val="00F8410E"/>
                    <w:rsid w:val="00F960E4"/>
                    <w:rsid w:val="02326E79"/>
                    <w:rsid w:val="032E2500"/>
                    <w:rsid w:val="049474C0"/>
                    <w:rsid w:val="0539089F"/>
                    <w:rsid w:val="10CA6C02"/>
                    <w:rsid w:val="116916C1"/>
                    <w:rsid w:val="120A0416"/>
                    <w:rsid w:val="13942E42"/>
                    <w:rsid w:val="16CB4455"/>
                    <w:rsid w:val="16CB7740"/>
                    <w:rsid w:val="17A75365"/>
                    <w:rsid w:val="1C2E3B3B"/>
                    <w:rsid w:val="1E022D1C"/>
                    <w:rsid w:val="20ED51DA"/>
                    <w:rsid w:val="230D40D8"/>
                    <w:rsid w:val="307E6168"/>
                    <w:rsid w:val="31481EA9"/>
                    <w:rsid w:val="33B95C46"/>
                    <w:rsid w:val="368D32B3"/>
                    <w:rsid w:val="37272813"/>
                    <w:rsid w:val="37F97828"/>
                    <w:rsid w:val="3B864A9F"/>
                    <w:rsid w:val="3EE059CE"/>
                    <w:rsid w:val="402D64F6"/>
                    <w:rsid w:val="436F1A53"/>
                    <w:rsid w:val="47321570"/>
                    <w:rsid w:val="48C36F7D"/>
                    <w:rsid w:val="49330EEB"/>
                    <w:rsid w:val="4C0E0DD0"/>
                    <w:rsid w:val="4ECC7550"/>
                    <w:rsid w:val="4EEA6241"/>
                    <w:rsid w:val="4F1D0D23"/>
                    <w:rsid w:val="4FA62AB2"/>
                    <w:rsid w:val="50C115E4"/>
                    <w:rsid w:val="5A594EA9"/>
                    <w:rsid w:val="5B1F5939"/>
                    <w:rsid w:val="5C127626"/>
                    <w:rsid w:val="5D084568"/>
                    <w:rsid w:val="5E882615"/>
                    <w:rsid w:val="617E6A22"/>
                    <w:rsid w:val="63C815E4"/>
                    <w:rsid w:val="65583A36"/>
                    <w:rsid w:val="65890EF3"/>
                    <w:rsid w:val="6618525D"/>
                    <w:rsid w:val="66DF52F8"/>
                    <w:rsid w:val="67AF1633"/>
                    <w:rsid w:val="6A321F33"/>
                    <w:rsid w:val="6E7814F3"/>
                    <w:rsid w:val="6FD72A79"/>
                    <w:rsid w:val="7023213C"/>
                    <w:rsid w:val="70434D57"/>
                    <w:rsid w:val="714D2F65"/>
                    <w:rsid w:val="71CE6F4E"/>
                </w:rsids>
                <m:mathPr>
                    <m:brkBin m:val="before"/>
                    <m:brkBinSub m:val="--"/>
                    <m:smallFrac m:val="0"/>
                    <m:dispDef/>
                    <m:lMargin m:val="0"/>
                    <m:rMargin m:val="0"/>
                    <m:defJc m:val="centerGroup"/>
                    <m:wrapIndent m:val="1440"/>
                    <m:intLim m:val="subSup"/>
                    <m:naryLim m:val="undOvr"/>
                </m:mathPr>
                <w:themeFontLang w:val="en-US" w:eastAsia="zh-CN"/>
                <w:clrSchemeMapping w:bg1="light1" w:t1="dark1" w:bg2="light2" w:t2="dark2" w:accent1="accent1" w:accent2="accent2" w:accent3="accent3" w:accent4="accent4" w:accent5="accent5" w:accent6="accent6" w:hyperlink="hyperlink" w:followedHyperlink="followedHyperlink"/>
            </w:settings>
        </pkg:xmlData>
    </pkg:part>
    <pkg:part pkg:name="/word/styles.xml" pkg:contentType="application/vnd.openxmlformats-officedocument.wordprocessingml.styles+xml">
        <pkg:xmlData>
            <w:styles xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:sl="http://schemas.openxmlformats.org/schemaLibrary/2006/main" mc:Ignorable="w14">
                <w:docDefaults>
                    <w:rPrDefault>
                        <w:rPr>
                            <w:rFonts w:ascii="Calibri" w:hAnsi="Calibri" w:eastAsia="宋体" w:cs="Times New Roman"/>
                        </w:rPr>
                    </w:rPrDefault>
                </w:docDefaults>
                <w:latentStyles w:count="260" w:defQFormat="0" w:defUnhideWhenUsed="1" w:defSemiHidden="1" w:defUIPriority="99" w:defLockedState="0">
                    <w:lsdException w:qFormat="1" w:unhideWhenUsed="0" w:uiPriority="0" w:semiHidden="0" w:name="Normal"/>
                    <w:lsdException w:qFormat="1" w:unhideWhenUsed="0" w:uiPriority="9" w:semiHidden="0" w:name="heading 1"/>
                    <w:lsdException w:qFormat="1" w:uiPriority="9" w:semiHidden="0" w:name="heading 2"/>
                    <w:lsdException w:qFormat="1" w:uiPriority="9" w:name="heading 3"/>
                    <w:lsdException w:qFormat="1" w:uiPriority="9" w:name="heading 4"/>
                    <w:lsdException w:qFormat="1" w:uiPriority="9" w:name="heading 5"/>
                    <w:lsdException w:qFormat="1" w:uiPriority="9" w:name="heading 6"/>
                    <w:lsdException w:qFormat="1" w:uiPriority="9" w:name="heading 7"/>
                    <w:lsdException w:qFormat="1" w:uiPriority="9" w:name="heading 8"/>
                    <w:lsdException w:qFormat="1" w:uiPriority="9" w:name="heading 9"/>
                    <w:lsdException w:uiPriority="99" w:name="index 1"/>
                    <w:lsdException w:uiPriority="99" w:name="index 2"/>
                    <w:lsdException w:uiPriority="99" w:name="index 3"/>
                    <w:lsdException w:uiPriority="99" w:name="index 4"/>
                    <w:lsdException w:uiPriority="99" w:name="index 5"/>
                    <w:lsdException w:uiPriority="99" w:name="index 6"/>
                    <w:lsdException w:uiPriority="99" w:name="index 7"/>
                    <w:lsdException w:uiPriority="99" w:name="index 8"/>
                    <w:lsdException w:uiPriority="99" w:name="index 9"/>
                    <w:lsdException w:uiPriority="39" w:name="toc 1"/>
                    <w:lsdException w:uiPriority="39" w:name="toc 2"/>
                    <w:lsdException w:uiPriority="39" w:name="toc 3"/>
                    <w:lsdException w:uiPriority="39" w:name="toc 4"/>
                    <w:lsdException w:uiPriority="39" w:name="toc 5"/>
                    <w:lsdException w:uiPriority="39" w:name="toc 6"/>
                    <w:lsdException w:uiPriority="39" w:name="toc 7"/>
                    <w:lsdException w:uiPriority="39" w:name="toc 8"/>
                    <w:lsdException w:uiPriority="39" w:name="toc 9"/>
                    <w:lsdException w:uiPriority="99" w:name="Normal Indent"/>
                    <w:lsdException w:uiPriority="99" w:name="footnote text"/>
                    <w:lsdException w:uiPriority="99" w:name="annotation text"/>
                    <w:lsdException w:qFormat="1" w:uiPriority="99" w:semiHidden="0" w:name="header"/>
                    <w:lsdException w:qFormat="1" w:uiPriority="99" w:semiHidden="0" w:name="footer"/>
                    <w:lsdException w:uiPriority="99" w:name="index heading"/>
                    <w:lsdException w:qFormat="1" w:uiPriority="35" w:name="caption"/>
                    <w:lsdException w:uiPriority="99" w:name="table of figures"/>
                    <w:lsdException w:uiPriority="99" w:name="envelope address"/>
                    <w:lsdException w:uiPriority="99" w:name="envelope return"/>
                    <w:lsdException w:uiPriority="99" w:name="footnote reference"/>
                    <w:lsdException w:uiPriority="99" w:name="annotation reference"/>
                    <w:lsdException w:uiPriority="99" w:name="line number"/>
                    <w:lsdException w:uiPriority="99" w:name="page number"/>
                    <w:lsdException w:uiPriority="99" w:name="endnote reference"/>
                    <w:lsdException w:uiPriority="99" w:name="endnote text"/>
                    <w:lsdException w:uiPriority="99" w:name="table of authorities"/>
                    <w:lsdException w:uiPriority="99" w:name="macro"/>
                    <w:lsdException w:uiPriority="99" w:name="toa heading"/>
                    <w:lsdException w:uiPriority="99" w:name="List"/>
                    <w:lsdException w:uiPriority="99" w:name="List Bullet"/>
                    <w:lsdException w:uiPriority="99" w:name="List Number"/>
                    <w:lsdException w:uiPriority="99" w:name="List 2"/>
                    <w:lsdException w:uiPriority="99" w:name="List 3"/>
                    <w:lsdException w:uiPriority="99" w:name="List 4"/>
                    <w:lsdException w:uiPriority="99" w:name="List 5"/>
                    <w:lsdException w:uiPriority="99" w:name="List Bullet 2"/>
                    <w:lsdException w:uiPriority="99" w:name="List Bullet 3"/>
                    <w:lsdException w:uiPriority="99" w:name="List Bullet 4"/>
                    <w:lsdException w:uiPriority="99" w:name="List Bullet 5"/>
                    <w:lsdException w:uiPriority="99" w:name="List Number 2"/>
                    <w:lsdException w:uiPriority="99" w:name="List Number 3"/>
                    <w:lsdException w:uiPriority="99" w:name="List Number 4"/>
                    <w:lsdException w:uiPriority="99" w:name="List Number 5"/>
                    <w:lsdException w:qFormat="1" w:unhideWhenUsed="0" w:uiPriority="10" w:semiHidden="0" w:name="Title"/>
                    <w:lsdException w:uiPriority="99" w:name="Closing"/>
                    <w:lsdException w:uiPriority="99" w:name="Signature"/>
                    <w:lsdException w:uiPriority="1" w:semiHidden="0" w:name="Default Paragraph Font"/>
                    <w:lsdException w:uiPriority="99" w:name="Body Text"/>
                    <w:lsdException w:uiPriority="99" w:name="Body Text Indent"/>
                    <w:lsdException w:uiPriority="99" w:name="List Continue"/>
                    <w:lsdException w:uiPriority="99" w:name="List Continue 2"/>
                    <w:lsdException w:uiPriority="99" w:name="List Continue 3"/>
                    <w:lsdException w:uiPriority="99" w:name="List Continue 4"/>
                    <w:lsdException w:uiPriority="99" w:name="List Continue 5"/>
                    <w:lsdException w:uiPriority="99" w:name="Message Header"/>
                    <w:lsdException w:qFormat="1" w:unhideWhenUsed="0" w:uiPriority="11" w:semiHidden="0" w:name="Subtitle"/>
                    <w:lsdException w:uiPriority="99" w:name="Salutation"/>
                    <w:lsdException w:uiPriority="99" w:name="Date"/>
                    <w:lsdException w:uiPriority="99" w:name="Body Text First Indent"/>
                    <w:lsdException w:uiPriority="99" w:name="Body Text First Indent 2"/>
                    <w:lsdException w:uiPriority="99" w:name="Note Heading"/>
                    <w:lsdException w:uiPriority="99" w:name="Body Text 2"/>
                    <w:lsdException w:uiPriority="99" w:name="Body Text 3"/>
                    <w:lsdException w:uiPriority="99" w:name="Body Text Indent 2"/>
                    <w:lsdException w:uiPriority="99" w:name="Body Text Indent 3"/>
                    <w:lsdException w:uiPriority="99" w:name="Block Text"/>
                    <w:lsdException w:uiPriority="99" w:name="Hyperlink"/>
                    <w:lsdException w:uiPriority="99" w:name="FollowedHyperlink"/>
                    <w:lsdException w:qFormat="1" w:unhideWhenUsed="0" w:uiPriority="22" w:semiHidden="0" w:name="Strong"/>
                    <w:lsdException w:qFormat="1" w:unhideWhenUsed="0" w:uiPriority="20" w:semiHidden="0" w:name="Emphasis"/>
                    <w:lsdException w:uiPriority="99" w:name="Document Map"/>
                    <w:lsdException w:uiPriority="99" w:name="Plain Text"/>
                    <w:lsdException w:uiPriority="99" w:name="E-mail Signature"/>
                    <w:lsdException w:uiPriority="99" w:name="Normal (Web)"/>
                    <w:lsdException w:uiPriority="99" w:name="HTML Acronym"/>
                    <w:lsdException w:uiPriority="99" w:name="HTML Address"/>
                    <w:lsdException w:uiPriority="99" w:name="HTML Cite"/>
                    <w:lsdException w:uiPriority="99" w:name="HTML Code"/>
                    <w:lsdException w:uiPriority="99" w:name="HTML Definition"/>
                    <w:lsdException w:uiPriority="99" w:name="HTML Keyboard"/>
                    <w:lsdException w:uiPriority="99" w:name="HTML Preformatted"/>
                    <w:lsdException w:uiPriority="99" w:name="HTML Sample"/>
                    <w:lsdException w:uiPriority="99" w:name="HTML Typewriter"/>
                    <w:lsdException w:uiPriority="99" w:name="HTML Variable"/>
                    <w:lsdException w:qFormat="1" w:uiPriority="99" w:semiHidden="0" w:name="Normal Table"/>
                    <w:lsdException w:uiPriority="99" w:name="annotation subject"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Simple 1"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Simple 2"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Simple 3"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Classic 1"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Classic 2"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Classic 3"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Classic 4"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Colorful 1"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Colorful 2"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Colorful 3"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Columns 1"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Columns 2"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Columns 3"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Columns 4"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Columns 5"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Grid 1"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Grid 2"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Grid 3"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Grid 4"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Grid 5"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Grid 6"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Grid 7"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Grid 8"/>
                    <w:lsdException w:uiPriority="99" w:name="Table List 1"/>
                    <w:lsdException w:uiPriority="99" w:name="Table List 2"/>
                    <w:lsdException w:uiPriority="99" w:name="Table List 3"/>
                    <w:lsdException w:uiPriority="99" w:name="Table List 4"/>
                    <w:lsdException w:uiPriority="99" w:name="Table List 5"/>
                    <w:lsdException w:uiPriority="99" w:name="Table List 6"/>
                    <w:lsdException w:uiPriority="99" w:name="Table List 7"/>
                    <w:lsdException w:uiPriority="99" w:name="Table List 8"/>
                    <w:lsdException w:uiPriority="99" w:name="Table 3D effects 1"/>
                    <w:lsdException w:uiPriority="99" w:name="Table 3D effects 2"/>
                    <w:lsdException w:uiPriority="99" w:name="Table 3D effects 3"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Contemporary"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Elegant"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Professional"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Subtle 1"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Subtle 2"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Web 1"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Web 2"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Web 3"/>
                    <w:lsdException w:uiPriority="99" w:semiHidden="0" w:name="Balloon Text"/>
                    <w:lsdException w:qFormat="1" w:unhideWhenUsed="0" w:uiPriority="59" w:semiHidden="0" w:name="Table Grid"/>
                    <w:lsdException w:uiPriority="99" w:name="Table Theme"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="60" w:semiHidden="0" w:name="Light Shading"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="61" w:semiHidden="0" w:name="Light List"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="62" w:semiHidden="0" w:name="Light Grid"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="63" w:semiHidden="0" w:name="Medium Shading 1"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="64" w:semiHidden="0" w:name="Medium Shading 2"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="65" w:semiHidden="0" w:name="Medium List 1"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="66" w:semiHidden="0" w:name="Medium List 2"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="67" w:semiHidden="0" w:name="Medium Grid 1"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="68" w:semiHidden="0" w:name="Medium Grid 2"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="69" w:semiHidden="0" w:name="Medium Grid 3"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="70" w:semiHidden="0" w:name="Dark List"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="71" w:semiHidden="0" w:name="Colorful Shading"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="72" w:semiHidden="0" w:name="Colorful List"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="73" w:semiHidden="0" w:name="Colorful Grid"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="60" w:semiHidden="0" w:name="Light Shading Accent 1"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="61" w:semiHidden="0" w:name="Light List Accent 1"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="62" w:semiHidden="0" w:name="Light Grid Accent 1"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="63" w:semiHidden="0" w:name="Medium Shading 1 Accent 1"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="64" w:semiHidden="0" w:name="Medium Shading 2 Accent 1"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="65" w:semiHidden="0" w:name="Medium List 1 Accent 1"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="66" w:semiHidden="0" w:name="Medium List 2 Accent 1"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="67" w:semiHidden="0" w:name="Medium Grid 1 Accent 1"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="68" w:semiHidden="0" w:name="Medium Grid 2 Accent 1"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="69" w:semiHidden="0" w:name="Medium Grid 3 Accent 1"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="70" w:semiHidden="0" w:name="Dark List Accent 1"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="71" w:semiHidden="0" w:name="Colorful Shading Accent 1"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="72" w:semiHidden="0" w:name="Colorful List Accent 1"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="73" w:semiHidden="0" w:name="Colorful Grid Accent 1"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="60" w:semiHidden="0" w:name="Light Shading Accent 2"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="61" w:semiHidden="0" w:name="Light List Accent 2"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="62" w:semiHidden="0" w:name="Light Grid Accent 2"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="63" w:semiHidden="0" w:name="Medium Shading 1 Accent 2"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="64" w:semiHidden="0" w:name="Medium Shading 2 Accent 2"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="65" w:semiHidden="0" w:name="Medium List 1 Accent 2"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="66" w:semiHidden="0" w:name="Medium List 2 Accent 2"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="67" w:semiHidden="0" w:name="Medium Grid 1 Accent 2"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="68" w:semiHidden="0" w:name="Medium Grid 2 Accent 2"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="69" w:semiHidden="0" w:name="Medium Grid 3 Accent 2"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="70" w:semiHidden="0" w:name="Dark List Accent 2"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="71" w:semiHidden="0" w:name="Colorful Shading Accent 2"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="72" w:semiHidden="0" w:name="Colorful List Accent 2"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="73" w:semiHidden="0" w:name="Colorful Grid Accent 2"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="60" w:semiHidden="0" w:name="Light Shading Accent 3"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="61" w:semiHidden="0" w:name="Light List Accent 3"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="62" w:semiHidden="0" w:name="Light Grid Accent 3"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="63" w:semiHidden="0" w:name="Medium Shading 1 Accent 3"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="64" w:semiHidden="0" w:name="Medium Shading 2 Accent 3"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="65" w:semiHidden="0" w:name="Medium List 1 Accent 3"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="66" w:semiHidden="0" w:name="Medium List 2 Accent 3"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="67" w:semiHidden="0" w:name="Medium Grid 1 Accent 3"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="68" w:semiHidden="0" w:name="Medium Grid 2 Accent 3"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="69" w:semiHidden="0" w:name="Medium Grid 3 Accent 3"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="70" w:semiHidden="0" w:name="Dark List Accent 3"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="71" w:semiHidden="0" w:name="Colorful Shading Accent 3"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="72" w:semiHidden="0" w:name="Colorful List Accent 3"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="73" w:semiHidden="0" w:name="Colorful Grid Accent 3"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="60" w:semiHidden="0" w:name="Light Shading Accent 4"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="61" w:semiHidden="0" w:name="Light List Accent 4"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="62" w:semiHidden="0" w:name="Light Grid Accent 4"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="63" w:semiHidden="0" w:name="Medium Shading 1 Accent 4"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="64" w:semiHidden="0" w:name="Medium Shading 2 Accent 4"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="65" w:semiHidden="0" w:name="Medium List 1 Accent 4"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="66" w:semiHidden="0" w:name="Medium List 2 Accent 4"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="67" w:semiHidden="0" w:name="Medium Grid 1 Accent 4"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="68" w:semiHidden="0" w:name="Medium Grid 2 Accent 4"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="69" w:semiHidden="0" w:name="Medium Grid 3 Accent 4"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="70" w:semiHidden="0" w:name="Dark List Accent 4"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="71" w:semiHidden="0" w:name="Colorful Shading Accent 4"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="72" w:semiHidden="0" w:name="Colorful List Accent 4"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="73" w:semiHidden="0" w:name="Colorful Grid Accent 4"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="60" w:semiHidden="0" w:name="Light Shading Accent 5"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="61" w:semiHidden="0" w:name="Light List Accent 5"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="62" w:semiHidden="0" w:name="Light Grid Accent 5"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="63" w:semiHidden="0" w:name="Medium Shading 1 Accent 5"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="64" w:semiHidden="0" w:name="Medium Shading 2 Accent 5"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="65" w:semiHidden="0" w:name="Medium List 1 Accent 5"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="66" w:semiHidden="0" w:name="Medium List 2 Accent 5"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="67" w:semiHidden="0" w:name="Medium Grid 1 Accent 5"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="68" w:semiHidden="0" w:name="Medium Grid 2 Accent 5"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="69" w:semiHidden="0" w:name="Medium Grid 3 Accent 5"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="70" w:semiHidden="0" w:name="Dark List Accent 5"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="71" w:semiHidden="0" w:name="Colorful Shading Accent 5"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="72" w:semiHidden="0" w:name="Colorful List Accent 5"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="73" w:semiHidden="0" w:name="Colorful Grid Accent 5"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="60" w:semiHidden="0" w:name="Light Shading Accent 6"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="61" w:semiHidden="0" w:name="Light List Accent 6"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="62" w:semiHidden="0" w:name="Light Grid Accent 6"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="63" w:semiHidden="0" w:name="Medium Shading 1 Accent 6"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="64" w:semiHidden="0" w:name="Medium Shading 2 Accent 6"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="65" w:semiHidden="0" w:name="Medium List 1 Accent 6"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="66" w:semiHidden="0" w:name="Medium List 2 Accent 6"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="67" w:semiHidden="0" w:name="Medium Grid 1 Accent 6"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="68" w:semiHidden="0" w:name="Medium Grid 2 Accent 6"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="69" w:semiHidden="0" w:name="Medium Grid 3 Accent 6"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="70" w:semiHidden="0" w:name="Dark List Accent 6"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="71" w:semiHidden="0" w:name="Colorful Shading Accent 6"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="72" w:semiHidden="0" w:name="Colorful List Accent 6"/>
                    <w:lsdException w:unhideWhenUsed="0" w:uiPriority="73" w:semiHidden="0" w:name="Colorful Grid Accent 6"/>
                </w:latentStyles>
                <w:style w:type="paragraph" w:default="1" w:styleId="1">
                    <w:name w:val="Normal"/>
                    <w:qFormat/>
                    <w:uiPriority w:val="0"/>
                    <w:pPr>
                        <w:widowControl w:val="0"/>
                        <w:jc w:val="both"/>
                    </w:pPr>
                    <w:rPr>
                        <w:rFonts w:ascii="Calibri" w:hAnsi="Calibri" w:eastAsia="宋体" w:cs="Times New Roman"/>
                        <w:kern w:val="2"/>
                        <w:sz w:val="21"/>
                        <w:szCs w:val="22"/>
                        <w:lang w:val="en-US" w:eastAsia="zh-CN" w:bidi="ar-SA"/>
                    </w:rPr>
                </w:style>
                <w:style w:type="paragraph" w:styleId="2">
                    <w:name w:val="heading 2"/>
                    <w:basedOn w:val="1"/>
                    <w:next w:val="1"/>
                    <w:unhideWhenUsed/>
                    <w:qFormat/>
                    <w:uiPriority w:val="9"/>
                    <w:pPr>
                        <w:keepNext/>
                        <w:keepLines/>
                        <w:numPr>
                            <w:ilvl w:val="0"/>
                            <w:numId w:val="1"/>
                        </w:numPr>
                        <w:spacing w:before="200" w:beforeLines="0" w:beforeAutospacing="0" w:afterLines="0" w:afterAutospacing="0" w:line="240" w:lineRule="auto"/>
                        <w:outlineLvl w:val="1"/>
                    </w:pPr>
                    <w:rPr>
                        <w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:eastAsia="微软雅黑"/>
                        <w:b/>
                        <w:sz w:val="26"/>
                        <w:szCs w:val="26"/>
                    </w:rPr>
                </w:style>
                <w:style w:type="character" w:default="1" w:styleId="8">
                    <w:name w:val="Default Paragraph Font"/>
                    <w:unhideWhenUsed/>
                    <w:uiPriority w:val="1"/>
                </w:style>
                <w:style w:type="table" w:default="1" w:styleId="6">
                    <w:name w:val="Normal Table"/>
                    <w:unhideWhenUsed/>
                    <w:qFormat/>
                    <w:uiPriority w:val="99"/>
                    <w:tblPr>
                        <w:tblStyle w:val="6"/>
                        <w:tblCellMar>
                            <w:top w:w="0" w:type="dxa"/>
                            <w:left w:w="108" w:type="dxa"/>
                            <w:bottom w:w="0" w:type="dxa"/>
                            <w:right w:w="108" w:type="dxa"/>
                        </w:tblCellMar>
                    </w:tblPr>
                </w:style>
                <w:style w:type="paragraph" w:styleId="3">
                    <w:name w:val="Balloon Text"/>
                    <w:basedOn w:val="1"/>
                    <w:link w:val="9"/>
                    <w:unhideWhenUsed/>
                    <w:uiPriority w:val="99"/>
                    <w:rPr>
                        <w:sz w:val="18"/>
                        <w:szCs w:val="18"/>
                    </w:rPr>
                </w:style>
                <w:style w:type="paragraph" w:styleId="4">
                    <w:name w:val="footer"/>
                    <w:basedOn w:val="1"/>
                    <w:link w:val="11"/>
                    <w:unhideWhenUsed/>
                    <w:qFormat/>
                    <w:uiPriority w:val="99"/>
                    <w:pPr>
                        <w:tabs>
                            <w:tab w:val="center" w:pos="4153"/>
                            <w:tab w:val="right" w:pos="8306"/>
                        </w:tabs>
                        <w:snapToGrid w:val="0"/>
                        <w:jc w:val="left"/>
                    </w:pPr>
                    <w:rPr>
                        <w:sz w:val="18"/>
                        <w:szCs w:val="18"/>
                    </w:rPr>
                </w:style>
                <w:style w:type="paragraph" w:styleId="5">
                    <w:name w:val="header"/>
                    <w:basedOn w:val="1"/>
                    <w:link w:val="10"/>
                    <w:unhideWhenUsed/>
                    <w:qFormat/>
                    <w:uiPriority w:val="99"/>
                    <w:pPr>
                        <w:pBdr>
                            <w:bottom w:val="single" w:color="auto" w:sz="6" w:space="1"/>
                        </w:pBdr>
                        <w:tabs>
                            <w:tab w:val="center" w:pos="4153"/>
                            <w:tab w:val="right" w:pos="8306"/>
                        </w:tabs>
                        <w:snapToGrid w:val="0"/>
                        <w:jc w:val="center"/>
                    </w:pPr>
                    <w:rPr>
                        <w:sz w:val="18"/>
                        <w:szCs w:val="18"/>
                    </w:rPr>
                </w:style>
                <w:style w:type="table" w:styleId="7">
                    <w:name w:val="Table Grid"/>
                    <w:basedOn w:val="6"/>
                    <w:qFormat/>
                    <w:uiPriority w:val="59"/>
                    <w:tblPr>
                        <w:tblStyle w:val="6"/>
                        <w:tblBorders>
                            <w:top w:val="single" w:color="000000" w:sz="4" w:space="0"/>
                            <w:left w:val="single" w:color="000000" w:sz="4" w:space="0"/>
                            <w:bottom w:val="single" w:color="000000" w:sz="4" w:space="0"/>
                            <w:right w:val="single" w:color="000000" w:sz="4" w:space="0"/>
                            <w:insideH w:val="single" w:color="000000" w:sz="4" w:space="0"/>
                            <w:insideV w:val="single" w:color="000000" w:sz="4" w:space="0"/>
                        </w:tblBorders>
                        <w:tblCellMar>
                            <w:top w:w="0" w:type="dxa"/>
                            <w:left w:w="108" w:type="dxa"/>
                            <w:bottom w:w="0" w:type="dxa"/>
                            <w:right w:w="108" w:type="dxa"/>
                        </w:tblCellMar>
                    </w:tblPr>
                </w:style>
                <w:style w:type="character" w:customStyle="1" w:styleId="9">
                    <w:name w:val="批注框文本 Char"/>
                    <w:basedOn w:val="8"/>
                    <w:link w:val="3"/>
                    <w:semiHidden/>
                    <w:uiPriority w:val="99"/>
                    <w:rPr>
                        <w:sz w:val="18"/>
                        <w:szCs w:val="18"/>
                    </w:rPr>
                </w:style>
                <w:style w:type="character" w:customStyle="1" w:styleId="10">
                    <w:name w:val="页眉 Char"/>
                    <w:basedOn w:val="8"/>
                    <w:link w:val="5"/>
                    <w:qFormat/>
                    <w:uiPriority w:val="99"/>
                    <w:rPr>
                        <w:sz w:val="18"/>
                        <w:szCs w:val="18"/>
                    </w:rPr>
                </w:style>
                <w:style w:type="character" w:customStyle="1" w:styleId="11">
                    <w:name w:val="页脚 Char"/>
                    <w:basedOn w:val="8"/>
                    <w:link w:val="4"/>
                    <w:qFormat/>
                    <w:uiPriority w:val="99"/>
                    <w:rPr>
                        <w:sz w:val="18"/>
                        <w:szCs w:val="18"/>
                    </w:rPr>
                </w:style>
            </w:styles>
        </pkg:xmlData>
    </pkg:part>
    <pkg:part pkg:name="/word/theme/theme1.xml" pkg:contentType="application/vnd.openxmlformats-officedocument.theme+xml">
        <pkg:xmlData>
            <a:theme xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" name="Office">
                <a:themeElements>
                    <a:clrScheme name="Office">
                        <a:dk1>
                            <a:sysClr val="windowText" lastClr="000000"/>
                        </a:dk1>
                        <a:lt1>
                            <a:sysClr val="window" lastClr="FFFFFF"/>
                        </a:lt1>
                        <a:dk2>
                            <a:srgbClr val="1F497D"/>
                        </a:dk2>
                        <a:lt2>
                            <a:srgbClr val="EEECE1"/>
                        </a:lt2>
                        <a:accent1>
                            <a:srgbClr val="4F81BD"/>
                        </a:accent1>
                        <a:accent2>
                            <a:srgbClr val="C0504D"/>
                        </a:accent2>
                        <a:accent3>
                            <a:srgbClr val="9BBB59"/>
                        </a:accent3>
                        <a:accent4>
                            <a:srgbClr val="8064A2"/>
                        </a:accent4>
                        <a:accent5>
                            <a:srgbClr val="4BACC6"/>
                        </a:accent5>
                        <a:accent6>
                            <a:srgbClr val="F79646"/>
                        </a:accent6>
                        <a:hlink>
                            <a:srgbClr val="0000FF"/>
                        </a:hlink>
                        <a:folHlink>
                            <a:srgbClr val="800080"/>
                        </a:folHlink>
                    </a:clrScheme>
                    <a:fontScheme name="Office">
                        <a:majorFont>
                            <a:latin typeface="Cambria"/>
                            <a:ea typeface=""/>
                            <a:cs typeface=""/>
                            <a:font script="Jpan" typeface="ＭＳ ゴシック"/>
                            <a:font script="Hang" typeface="맑은 고딕"/>
                            <a:font script="Hans" typeface="宋体"/>
                            <a:font script="Hant" typeface="新細明體"/>
                            <a:font script="Arab" typeface="Times New Roman"/>
                            <a:font script="Hebr" typeface="Times New Roman"/>
                            <a:font script="Thai" typeface="Angsana New"/>
                            <a:font script="Ethi" typeface="Nyala"/>
                            <a:font script="Beng" typeface="Vrinda"/>
                            <a:font script="Gujr" typeface="Shruti"/>
                            <a:font script="Khmr" typeface="MoolBoran"/>
                            <a:font script="Knda" typeface="Tunga"/>
                            <a:font script="Guru" typeface="Raavi"/>
                            <a:font script="Cans" typeface="Euphemia"/>
                            <a:font script="Cher" typeface="Plantagenet Cherokee"/>
                            <a:font script="Yiii" typeface="Microsoft Yi Baiti"/>
                            <a:font script="Tibt" typeface="Microsoft Himalaya"/>
                            <a:font script="Thaa" typeface="MV Boli"/>
                            <a:font script="Deva" typeface="Mangal"/>
                            <a:font script="Telu" typeface="Gautami"/>
                            <a:font script="Taml" typeface="Latha"/>
                            <a:font script="Syrc" typeface="Estrangelo Edessa"/>
                            <a:font script="Orya" typeface="Kalinga"/>
                            <a:font script="Mlym" typeface="Kartika"/>
                            <a:font script="Laoo" typeface="DokChampa"/>
                            <a:font script="Sinh" typeface="Iskoola Pota"/>
                            <a:font script="Mong" typeface="Mongolian Baiti"/>
                            <a:font script="Viet" typeface="Times New Roman"/>
                            <a:font script="Uigh" typeface="Microsoft Uighur"/>
                            <a:font script="Geor" typeface="Sylfaen"/>
                        </a:majorFont>
                        <a:minorFont>
                            <a:latin typeface="Calibri"/>
                            <a:ea typeface=""/>
                            <a:cs typeface=""/>
                            <a:font script="Jpan" typeface="ＭＳ 明朝"/>
                            <a:font script="Hang" typeface="맑은 고딕"/>
                            <a:font script="Hans" typeface="宋体"/>
                            <a:font script="Hant" typeface="新細明體"/>
                            <a:font script="Arab" typeface="Arial"/>
                            <a:font script="Hebr" typeface="Arial"/>
                            <a:font script="Thai" typeface="Cordia New"/>
                            <a:font script="Ethi" typeface="Nyala"/>
                            <a:font script="Beng" typeface="Vrinda"/>
                            <a:font script="Gujr" typeface="Shruti"/>
                            <a:font script="Khmr" typeface="DaunPenh"/>
                            <a:font script="Knda" typeface="Tunga"/>
                            <a:font script="Guru" typeface="Raavi"/>
                            <a:font script="Cans" typeface="Euphemia"/>
                            <a:font script="Cher" typeface="Plantagenet Cherokee"/>
                            <a:font script="Yiii" typeface="Microsoft Yi Baiti"/>
                            <a:font script="Tibt" typeface="Microsoft Himalaya"/>
                            <a:font script="Thaa" typeface="MV Boli"/>
                            <a:font script="Deva" typeface="Mangal"/>
                            <a:font script="Telu" typeface="Gautami"/>
                            <a:font script="Taml" typeface="Latha"/>
                            <a:font script="Syrc" typeface="Estrangelo Edessa"/>
                            <a:font script="Orya" typeface="Kalinga"/>
                            <a:font script="Mlym" typeface="Kartika"/>
                            <a:font script="Laoo" typeface="DokChampa"/>
                            <a:font script="Sinh" typeface="Iskoola Pota"/>
                            <a:font script="Mong" typeface="Mongolian Baiti"/>
                            <a:font script="Viet" typeface="Arial"/>
                            <a:font script="Uigh" typeface="Microsoft Uighur"/>
                            <a:font script="Geor" typeface="Sylfaen"/>
                        </a:minorFont>
                    </a:fontScheme>
                    <a:fmtScheme name="Office">
                        <a:fillStyleLst>
                            <a:solidFill>
                                <a:schemeClr val="phClr"/>
                            </a:solidFill>
                            <a:gradFill rotWithShape="1">
                                <a:gsLst>
                                    <a:gs pos="0">
                                        <a:schemeClr val="phClr">
                                            <a:tint val="50000"/>
                                            <a:satMod val="300000"/>
                                        </a:schemeClr>
                                    </a:gs>
                                    <a:gs pos="35000">
                                        <a:schemeClr val="phClr">
                                            <a:tint val="37000"/>
                                            <a:satMod val="300000"/>
                                        </a:schemeClr>
                                    </a:gs>
                                    <a:gs pos="100000">
                                        <a:schemeClr val="phClr">
                                            <a:tint val="15000"/>
                                            <a:satMod val="350000"/>
                                        </a:schemeClr>
                                    </a:gs>
                                </a:gsLst>
                                <a:lin ang="16200000" scaled="1"/>
                            </a:gradFill>
                            <a:gradFill rotWithShape="1">
                                <a:gsLst>
                                    <a:gs pos="0">
                                        <a:schemeClr val="phClr">
                                            <a:shade val="51000"/>
                                            <a:satMod val="130000"/>
                                        </a:schemeClr>
                                    </a:gs>
                                    <a:gs pos="80000">
                                        <a:schemeClr val="phClr">
                                            <a:shade val="93000"/>
                                            <a:satMod val="130000"/>
                                        </a:schemeClr>
                                    </a:gs>
                                    <a:gs pos="100000">
                                        <a:schemeClr val="phClr">
                                            <a:shade val="94000"/>
                                            <a:satMod val="135000"/>
                                        </a:schemeClr>
                                    </a:gs>
                                </a:gsLst>
                                <a:lin ang="16200000" scaled="0"/>
                            </a:gradFill>
                        </a:fillStyleLst>
                        <a:lnStyleLst>
                            <a:ln w="9525" cap="flat" cmpd="sng" algn="ctr">
                                <a:solidFill>
                                    <a:schemeClr val="phClr">
                                        <a:shade val="95000"/>
                                        <a:satMod val="105000"/>
                                    </a:schemeClr>
                                </a:solidFill>
                                <a:prstDash val="solid"/>
                            </a:ln>
                            <a:ln w="25400" cap="flat" cmpd="sng" algn="ctr">
                                <a:solidFill>
                                    <a:schemeClr val="phClr"/>
                                </a:solidFill>
                                <a:prstDash val="solid"/>
                            </a:ln>
                            <a:ln w="38100" cap="flat" cmpd="sng" algn="ctr">
                                <a:solidFill>
                                    <a:schemeClr val="phClr"/>
                                </a:solidFill>
                                <a:prstDash val="solid"/>
                            </a:ln>
                        </a:lnStyleLst>
                        <a:effectStyleLst>
                            <a:effectStyle>
                                <a:effectLst>
                                    <a:outerShdw blurRad="40000" dist="20000" dir="5400000" rotWithShape="0">
                                        <a:srgbClr val="000000">
                                            <a:alpha val="38000"/>
                                        </a:srgbClr>
                                    </a:outerShdw>
                                </a:effectLst>
                            </a:effectStyle>
                            <a:effectStyle>
                                <a:effectLst>
                                    <a:outerShdw blurRad="40000" dist="23000" dir="5400000" rotWithShape="0">
                                        <a:srgbClr val="000000">
                                            <a:alpha val="35000"/>
                                        </a:srgbClr>
                                    </a:outerShdw>
                                </a:effectLst>
                            </a:effectStyle>
                            <a:effectStyle>
                                <a:effectLst>
                                    <a:outerShdw blurRad="40000" dist="23000" dir="5400000" rotWithShape="0">
                                        <a:srgbClr val="000000">
                                            <a:alpha val="35000"/>
                                        </a:srgbClr>
                                    </a:outerShdw>
                                </a:effectLst>
                                <a:scene3d>
                                    <a:camera prst="orthographicFront">
                                        <a:rot lat="0" lon="0" rev="0"/>
                                    </a:camera>
                                    <a:lightRig rig="threePt" dir="t">
                                        <a:rot lat="0" lon="0" rev="1200000"/>
                                    </a:lightRig>
                                </a:scene3d>
                                <a:sp3d>
                                    <a:bevelT w="63500" h="25400"/>
                                </a:sp3d>
                            </a:effectStyle>
                        </a:effectStyleLst>
                        <a:bgFillStyleLst>
                            <a:solidFill>
                                <a:schemeClr val="phClr"/>
                            </a:solidFill>
                            <a:gradFill rotWithShape="1">
                                <a:gsLst>
                                    <a:gs pos="0">
                                        <a:schemeClr val="phClr">
                                            <a:tint val="40000"/>
                                            <a:satMod val="350000"/>
                                        </a:schemeClr>
                                    </a:gs>
                                    <a:gs pos="40000">
                                        <a:schemeClr val="phClr">
                                            <a:tint val="45000"/>
                                            <a:satMod val="350000"/>
                                            <a:shade val="99000"/>
                                        </a:schemeClr>
                                    </a:gs>
                                    <a:gs pos="100000">
                                        <a:schemeClr val="phClr">
                                            <a:shade val="20000"/>
                                            <a:satMod val="255000"/>
                                        </a:schemeClr>
                                    </a:gs>
                                </a:gsLst>
                                <a:path path="circle">
                                    <a:fillToRect l="50000" t="-80000" r="50000" b="180000"/>
                                </a:path>
                            </a:gradFill>
                            <a:gradFill rotWithShape="1">
                                <a:gsLst>
                                    <a:gs pos="0">
                                        <a:schemeClr val="phClr">
                                            <a:tint val="80000"/>
                                            <a:satMod val="300000"/>
                                        </a:schemeClr>
                                    </a:gs>
                                    <a:gs pos="100000">
                                        <a:schemeClr val="phClr">
                                            <a:shade val="30000"/>
                                            <a:satMod val="200000"/>
                                        </a:schemeClr>
                                    </a:gs>
                                </a:gsLst>
                                <a:path path="circle">
                                    <a:fillToRect l="50000" t="50000" r="50000" b="50000"/>
                                </a:path>
                            </a:gradFill>
                        </a:bgFillStyleLst>
                    </a:fmtScheme>
                </a:themeElements>
                <a:objectDefaults/>
            </a:theme>
        </pkg:xmlData>
    </pkg:part>
</pkg:package>