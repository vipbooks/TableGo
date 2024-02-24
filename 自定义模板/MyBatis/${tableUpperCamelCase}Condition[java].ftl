<#-- 用于生成Condition查询条件的自定义模板 -->
<#-- 初始化表的查询字段 -->
<#assign searchFields = FtlUtils.getJsonFieldInfoList(tableInfo, jsonParam.searchFields) />
<#-- 初始化表的批量查询字段 -->
<#assign batchSearchFields = FtlUtils.getJsonFieldInfoList(tableInfo, jsonParam.batchSearchFields) />
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
import ${jsonParam.basePackagePath}.common.BaseCondition;

/**
 * ${FtlUtils.emptyToDefault(tableInfo.simpleRemark, "${tableInfo.tableName}表")}查询条件
 *
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
@ApiModel(description = "${FtlUtils.emptyToDefault(tableInfo.simpleRemark, "${tableInfo.tableName}表")}查询条件")
public class ${tableInfo.upperCamelCase}Condition extends BaseCondition {
    /** 版本号 */
    private static final long serialVersionUID = ${tableInfo.serialVersionUID!'1'}L;

    /** 创建${tableInfo.simpleRemark}实例对象 */
    public static ${tableInfo.upperCamelCase} newInstance() {
        return new ${tableInfo.upperCamelCase}();
    }
<#if searchFields?has_content>
    <#list searchFields as fieldInfo>

        <#if FtlUtils.fieldTypeEquals(fieldInfo, "Date", "Timestamp")>
    @ApiModelProperty(value = "${fieldInfo.remark}(开始)")
    @JsonFormat(timezone = "GMT+8", pattern = DatePattern.NORM_DATE_PATTERN)
    private ${fieldInfo.javaType} ${fieldInfo.proName}Begin;

    @ApiModelProperty(value = "${fieldInfo.remark}(结束)")
    @JsonFormat(timezone = "GMT+8", pattern = DatePattern.NORM_DATE_PATTERN)
    private ${fieldInfo.javaType} ${fieldInfo.proName}End;
        <#else>
    @ApiModelProperty(value = "${fieldInfo.remark}")
    private ${fieldInfo.javaType} ${fieldInfo.proName};
        </#if>
    </#list>
    <#if batchSearchFields?has_content>
        <#list batchSearchFields as fieldInfo>

    /** ${fieldInfo.simpleRemark}列表 */
    @ApiModelProperty(value = "${fieldInfo.simpleRemark}列表")
    private List<${fieldInfo.javaType}> ${fieldInfo.proName}List;
        </#list>
    </#if>
    <#list searchFields as fieldInfo>

        <#if FtlUtils.fieldTypeEquals(fieldInfo, "Date", "Timestamp")>
    /**
     * 获取${fieldInfo.simpleRemark!fieldInfo.proName}(开始)
     * 
     * @return ${fieldInfo.simpleRemark!fieldInfo.proName}(开始)
     */
    public ${fieldInfo.javaType} get${fieldInfo.upperCamelCase}Begin() {
        return this.${fieldInfo.proName}Begin;
    }

    /**
     * 设置${fieldInfo.simpleRemark!fieldInfo.proName}(开始)
     * 
     * @param ${fieldInfo.proName}Begin<#if StringUtils.isNotBlank(fieldInfo.simpleRemark)> ${fieldInfo.simpleRemark}(开始)</#if>
     */
    public void set${fieldInfo.upperCamelCase}Begin(${fieldInfo.javaType} ${fieldInfo.proName}Begin) {
        this.${fieldInfo.proName}Begin = ${fieldInfo.proName}Begin;
    }

    /**
     * 获取${fieldInfo.simpleRemark!fieldInfo.proName}(结束)
     * 
     * @return ${fieldInfo.simpleRemark!fieldInfo.proName}(结束)
     */
    public ${fieldInfo.javaType} get${fieldInfo.upperCamelCase}End() {
        return this.${fieldInfo.proName}End;
    }

    /**
     * 设置${fieldInfo.simpleRemark!fieldInfo.proName}(结束)
     * 
     * @param ${fieldInfo.proName}End<#if StringUtils.isNotBlank(fieldInfo.simpleRemark)> ${fieldInfo.simpleRemark}(结束)</#if>
     */
    public void set${fieldInfo.upperCamelCase}End(${fieldInfo.javaType} ${fieldInfo.proName}End) {
        this.${fieldInfo.proName}End = ${fieldInfo.proName}End;
    }
        <#else>
    /**
     * 获取${fieldInfo.remark!fieldInfo.proName}
     * 
     * @return ${fieldInfo.simpleRemark!fieldInfo.proName}
     */
    public ${fieldInfo.javaType} get${fieldInfo.upperCamelCase}() {
        return this.${fieldInfo.proName};
    }

    /**
     * 设置${fieldInfo.remark!fieldInfo.proName}
     * 
     * @param ${fieldInfo.proName}<#if StringUtils.isNotBlank(fieldInfo.simpleRemark)> ${fieldInfo.simpleRemark}</#if>
     */
    public ${tableInfo.upperCamelCase} set${fieldInfo.upperCamelCase}(${fieldInfo.javaType} ${fieldInfo.proName}) {
        this.${fieldInfo.proName} = ${fieldInfo.proName};
        return this;
    }
        </#if>
    </#list>
    <#if batchSearchFields?has_content>
        <#list batchSearchFields as fieldInfo>

    /**
     * 获取${fieldInfo.simpleRemark}列表
     * 
     * @return ${fieldInfo.simpleRemark}列表
     */
    public List<${fieldInfo.javaType}> get${fieldInfo.upperCamelCase}List() {
        return this.${fieldInfo.proName}List;
    }

    /**
     * 设置${fieldInfo.simpleRemark}列表
     * 
     * @param ${fieldInfo.proName}List ${fieldInfo.simpleRemark}列表
     */
    public ${tableInfo.upperCamelCase} set${fieldInfo.upperCamelCase}List(List<${fieldInfo.javaType}> ${fieldInfo.proName}List) {
        this.${fieldInfo.proName}List = ${fieldInfo.proName}List;
        return this;
    }
        </#list>
    </#if>
</#if>
}