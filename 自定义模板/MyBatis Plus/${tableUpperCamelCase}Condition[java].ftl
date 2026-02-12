<#-- 用于生成Condition查询条件的自定义模板 -->
<#-- 初始化表的简单查询字段 -->
<#assign searchFields = FtlUtils.getAdvanceSearchFieldSimpleList(tableInfo, jsonParam.searchFields, jsonParam.advanceSearch) />
<#-- 初始化表的批量查询字段 -->
<#assign batchSearchFields = FtlUtils.getAdvanceSearchFieldBatchList(tableInfo, jsonParam.batchSearchFields, jsonParam.advanceSearch) />
package ${jsonParam.packagePath}

<#if FtlUtils.fieldTypeExisted(searchFields, "Date")>
import java.util.Date;
import cn.hutool.core.date.DatePattern;
import com.fasterxml.jackson.annotation.JsonFormat;
</#if>
<#if FtlUtils.fieldTypeExisted(searchFields, "BigDecimal")>
import java.math.BigDecimal;
</#if>
<#if FtlUtils.fieldTypeExisted(searchFields, "BigInteger")>
import java.math.BigInteger;
</#if>
<#if batchSearchFields?has_content>
import java.util.List;
</#if>
<#if searchFields?has_content || batchSearchFields?has_content>
import io.swagger.annotations.ApiModelProperty;
</#if>
import io.swagger.annotations.ApiModel;
<#if searchFields?has_content || batchSearchFields?has_content>
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
</#if>
import lombok.Data;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import ${jsonParam.basePackagePath}.common.model.BaseCondition;

/**
 * ${FtlUtils.emptyToDefault(tableInfo.simpleRemark, "${tableInfo.tableName}表")}查询条件
 *
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
@Data
@Builder
<#if searchFields?has_content || batchSearchFields?has_content>
@NoArgsConstructor
@AllArgsConstructor
</#if>
@Accessors(chain = true)
@EqualsAndHashCode(callSuper = true)
@ApiModel(description = "${FtlUtils.emptyToDefault(tableInfo.simpleRemark, "${tableInfo.tableName}表")}查询条件")
public class ${tableInfo.upperCamelCase}Condition extends BaseCondition {
    /** 版本号 */
    private static final long serialVersionUID = ${tableInfo.serialVersionUID!'1'}L;
<#if searchFields?has_content>
    <#list searchFields as fieldInfo>

        <#if FtlUtils.fieldTypeEquals(fieldInfo, "Date", "Timestamp")>
    /** ${fieldInfo.remark}(开始) */
    @ApiModelProperty(value = "${fieldInfo.remark}(开始)")
    @JsonFormat(timezone = "GMT+8", pattern = DatePattern.NORM_DATE_PATTERN)
    private ${fieldInfo.javaType} ${fieldInfo.proName}Begin;

    /** ${fieldInfo.remark}(结束)" */
    @ApiModelProperty(value = "${fieldInfo.remark}(结束)")
    @JsonFormat(timezone = "GMT+8", pattern = DatePattern.NORM_DATE_PATTERN)
    private ${fieldInfo.javaType} ${fieldInfo.proName}End;
        <#else>
    /** ${fieldInfo.remark} */
    @ApiModelProperty(value = "${fieldInfo.remark}")
    private ${fieldInfo.javaType} ${fieldInfo.proName};
        </#if>
    </#list>
</#if>
<#if batchSearchFields?has_content>
    <#list batchSearchFields as fieldInfo>

    /** ${fieldInfo.simpleRemark}列表 */
    @ApiModelProperty(value = "${fieldInfo.simpleRemark}列表")
    private List<${fieldInfo.javaType}> ${fieldInfo.proName}List;
    </#list>
</#if>
}