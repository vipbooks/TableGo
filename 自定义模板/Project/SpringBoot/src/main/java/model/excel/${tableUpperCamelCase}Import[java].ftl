<#-- 初始化需要导入导出Excel的字段信息 -->
<#assign importAndExportFields = FtlUtils.getJsonFieldInfoList(tableInfo, jsonParam.importAndExportFields) />
package ${jsonParam.packagePath}

<#if FtlUtils.fieldTypeExisted(importAndExportFields, "Date")>
import java.util.Date;
import cn.hutool.core.date.DatePattern;
import cn.idev.excel.annotation.format.DateTimeFormat;
</#if>
<#if FtlUtils.fieldTypeExisted(importAndExportFields, "BigDecimal")>
import java.math.BigDecimal;
</#if>
<#if FtlUtils.fieldTypeExisted(importAndExportFields, "BigInteger")>
import java.math.BigInteger;
</#if>
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;

<#if importAndExportFields?has_content>
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
</#if>
import lombok.Data;
import lombok.Builder;
import lombok.ToString;
import lombok.EqualsAndHashCode;

import ${jsonParam.basePackagePath}.common.model.BaseExcel;

/**
 * ${FtlUtils.emptyToDefault(tableInfo.simpleRemark, "${tableInfo.tableName}表")}导入参数
 *
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
@Data
@Builder
<#if importAndExportFields?has_content>
@NoArgsConstructor
@AllArgsConstructor
</#if>
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@ExcelIgnoreUnannotated
public class ${tableInfo.upperCamelCase}Import extends BaseExcel {
    /** 版本号 */
    private static final long serialVersionUID = ${tableInfo.serialVersionUID!'1'}L;
<#if importAndExportFields?has_content>
    <#list importAndExportFields as fieldInfo>

    /** ${fieldInfo.remark} */
    @ExcelProperty(value = "${fieldInfo.remark}", index = ${fieldInfo_index})
        <#if FtlUtils.fieldTypeEquals(fieldInfo, "Date", "Timestamp")>
    @DateTimeFormat(<#if fieldInfo.isDateTimeType>DatePattern.NORM_DATETIME_PATTERN<#else>DatePattern.NORM_DATE_PATTERN</#if>)
        </#if>
    private ${fieldInfo.javaType} ${fieldInfo.proName};
    </#list>
</#if>
}