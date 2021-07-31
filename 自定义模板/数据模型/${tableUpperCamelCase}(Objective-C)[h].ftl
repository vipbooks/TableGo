<#-- 用于生成Objective-C数据模型的自定义模板 -->
//
// ${tableInfo.upperCamelCase}.h
// <#if StringUtils.isNotBlank(tableInfo.remark)>${tableInfo.remark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if>
//
// Created by ${paramConfig.author} on ${today}.
// Copyright (c) ${year}年 ${paramConfig.author}. All rights reserved.
//

@interface ${tableInfo.upperCamelCase} : NSObject
<#if tableInfo.fieldInfos?has_content>
    <#list tableInfo.fieldInfos as fieldInfo>
    // ${fieldInfo.remark!fieldInfo.colName}
        <#if fieldInfo.isNumericType>
    @property (nonatomic, strong) NSNumber *${fieldInfo.lowerCamelCase};
        <#else>
    @property (nonatomic, strong) NSString *${fieldInfo.lowerCamelCase};
        </#if>

    </#list>
</#if>
@end