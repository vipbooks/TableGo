<#-- 初始化表的查询字段 -->
<#assign searchFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.searchFields) />
<#-- 初始化表的批量查询字段 -->
<#assign batchSearchFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.batchSearchFields) />
package ${jsonParam.packagePath}

<#if FtlUtils.fieldTypeAtListExisted(tableInfo, searchFields, "Date")>
import java.util.Date;
import cn.hutool.core.date.DatePattern;
import com.fasterxml.jackson.annotation.JsonFormat;
</#if>
<#if FtlUtils.fieldTypeAtListExisted(tableInfo, searchFields, "BigDecimal")>
import java.math.BigDecimal;
</#if>
<#if FtlUtils.fieldTypeExisted(tableInfo, "BigInteger")>
import java.math.BigInteger;
</#if>
<#if jsonParam.enableSwagger>
import io.swagger.annotations.ApiModel;
    <#if searchFields?has_content>
import io.swagger.annotations.ApiModelProperty;
    </#if>
</#if>
<#if batchSearchFields?has_content>
import java.util.List;
</#if>
<#if searchFields?has_content || batchSearchFields?has_content>
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
</#if>
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import ${jsonParam.basePackagePath}.common.model.BaseCondition;

/**
 * ${tableInfo.simpleRemark!tableInfo.tableName}查询条件
 *
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@Setter
@Getter
@Builder
<#if searchFields?has_content || batchSearchFields?has_content>
@NoArgsConstructor
@AllArgsConstructor
</#if>
@Accessors(chain = true)
<#if jsonParam.enableSwagger>
@ApiModel(description = "${tableInfo.simpleRemark!tableInfo.tableName}查询条件")
</#if>
public class ${tableInfo.upperCamelCase}Condition extends BaseCondition {
    /** 版本号 */
    private static final long serialVersionUID = ${tableInfo.serialVersionUID!'1'}L;
<#if searchFields?has_content>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#list searchFields as fieldName>
            <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>

    <#if FtlUtils.fieldTypeEquals(fieldInfo, "Date", "Timestamp")>
    /** ${fieldInfo.remark!fieldInfo.colName}(开始) */
        <#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "${fieldInfo.remark!fieldInfo.colName}(开始)")
        </#if>
    @JsonFormat(timezone = "GMT+8", pattern = DatePattern.NORM_DATE_PATTERN)
    private ${fieldInfo.javaType} ${fieldInfo.proName}Begin;

    /** ${fieldInfo.remark!fieldInfo.colName}(结束) */
        <#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "${fieldInfo.remark!fieldInfo.colName}(结束)")
        </#if>
    @JsonFormat(timezone = "GMT+8", pattern = DatePattern.NORM_DATE_PATTERN)
    private ${fieldInfo.javaType} ${fieldInfo.proName}End;
    <#else>
    /** ${fieldInfo.remark} */
        <#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "${fieldInfo.remark}")
        </#if>
    private ${fieldInfo.javaType} ${fieldInfo.proName};
    </#if>
            </#if>
        </#list>
    </#list>
</#if>
<#if batchSearchFields?has_content>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#list batchSearchFields as fieldName>
            <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>

    /** ${fieldInfo.simpleRemark}列表 */
        <#if jsonParam.enableSwagger>
    @ApiModelProperty(value = "${fieldInfo.simpleRemark}列表")
        </#if>
    private List<${fieldInfo.javaType}> ${fieldInfo.proName}List;
            </#if>
        </#list>
    </#list>
</#if>
}