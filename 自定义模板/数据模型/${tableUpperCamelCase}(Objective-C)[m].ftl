<#-- 用于生成Objective-C数据模型的自定义模板 -->
//
// ${tableInfo.upperCamelCase}.m
// <#if StringUtils.isNotBlank(tableInfo.remark)>${tableInfo.remark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if>
//
// Created by ${paramConfig.author} on ${today}.
// Copyright (c) ${year}年 ${paramConfig.author}. All rights reserved.
//

#import "${tableInfo.upperCamelCase}.h"

@implementation ${tableInfo.upperCamelCase}


@end