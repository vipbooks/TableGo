<#-- 用于生成ElasticSearch数据模型的自定义模板 -->
package ${jsonParam.packagePath}

<#if FtlUtils.fieldTypeExisted(tableInfo, "Date")>
import java.util.Date;
import cn.hutool.core.date.DatePattern;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;
import org.springframework.data.elasticsearch.annotations.DateFormat;
<#elseif FtlUtils.fieldTypeExisted(tableInfo, "Long")>
import com.fasterxml.jackson.annotation.JsonFormat;
</#if>
<#if FtlUtils.fieldTypeExisted(tableInfo, "BigDecimal")>
import java.math.BigDecimal;
</#if>
<#if FtlUtils.fieldTypeExisted(tableInfo, "BigInteger")>
import java.math.BigInteger;
</#if>
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.annotation.Id;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * <#if StringUtils.isNotBlank(tableInfo.remark)>${tableInfo.remark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if>
 * 
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@ApiModel(description = "${tableInfo.simpleRemark!tableInfo.tableName}")
@Document(indexName = "${tableInfo.lowerTableName}")
public class ${tableInfo.upperCamelCase}<#if StringUtils.isNotBlank(tableInfo.extendsClass)> extends ${tableInfo.extendsClass}</#if><#if StringUtils.isNotBlank(tableInfo.implementsClass)> implements ${tableInfo.implementsClass}</#if> {
    /** 版本号 */
    private static final long serialVersionUID = ${tableInfo.serialVersionUID!'1'}L;
<#if tableInfo.fieldInfos?has_content>
    <#if paramConfig.showMergeUpdateMark>

    /* ${String.format(paramConfig.mergeFileMarkBegin, 1)} */
    </#if>
    <#list tableInfo.fieldInfos as fieldInfo>

    @ApiModelProperty(value = "${fieldInfo.remark}", position = ${fieldInfo_index + 1})
    @JsonProperty(index = ${fieldInfo_index + 1})
    <#if fieldInfo.primaryKey>
    @Id
    </#if>
    <#if FtlUtils.fieldTypeEquals(fieldInfo, "Date", "Timestamp")>
    @JsonFormat(timezone = "GMT+8", pattern = <#if fieldInfo.isDateTimeType>DatePattern.NORM_DATETIME_PATTERN<#else>DatePattern.NORM_DATE_PATTERN</#if>)
    @Field(type = FieldType.Date, format = DateFormat.custom, pattern = <#if fieldInfo.isDateTimeType>DatePattern.NORM_DATETIME_PATTERN<#else>DatePattern.NORM_DATE_PATTERN</#if>)
    <#elseif fieldInfo.javaType == "Long">
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    </#if>
    private ${fieldInfo.javaType} ${fieldInfo.proName};
    </#list>
    <#if paramConfig.showMergeUpdateMark>

    /* ${String.format(paramConfig.mergeFileMarkEnd, 1)} */
    </#if>
    <#if paramConfig.showMergeUpdateMark>

    /* ${String.format(paramConfig.mergeFileMarkBegin, 2)} */
    </#if>
    <#list tableInfo.fieldInfos as fieldInfo>

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
    public void set${fieldInfo.upperCamelCase}(${fieldInfo.javaType} ${fieldInfo.proName}) {
        this.${fieldInfo.proName} = ${fieldInfo.proName};
    }
    </#list>
    <#if paramConfig.showMergeUpdateMark>

    /* ${String.format(paramConfig.mergeFileMarkEnd, 2)} */
    </#if>
</#if>
}