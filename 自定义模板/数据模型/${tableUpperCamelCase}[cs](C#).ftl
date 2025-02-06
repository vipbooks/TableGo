<#-- 用于生成C#数据模型的自定义模板 -->

/**
 * <#if StringUtils.isNotBlank(tableInfo.remark)>${tableInfo.remark}(${tableInfo.tableName})<#else>${tableInfo.tableName}</#if>
 * 
 * Created by ${paramConfig.author} on ${today}.
 */
namespace ${paramConfig.packagePath}
{
    /// <summary>
    /// ${tableInfo.remark!tableInfo.tableName}
    /// </summary>
    public class ${tableInfo.upperCamelCase}<#if StringUtils.isNotBlank(tableInfo.extendsClass)> : ${tableInfo.extendsClass}</#if>
    {
<#if tableInfo.fieldInfos?has_content>
    <#list tableInfo.fieldInfos as fieldInfo>
        /// <summary>
        /// ${fieldInfo.remark!fieldInfo.colName}
        /// </summary>
        <#if fieldInfo.fieldType == "Date">
        public DateTime ${fieldInfo.proName} { set; get; }
        <#elseif fieldInfo.fieldType == "BigDecimal">
        public decimal ${fieldInfo.proName} { set; get; }
        <#elseif fieldInfo.fieldType == "Integer">
        public int ${fieldInfo.proName} { set; get; }
        <#else>
        public string ${fieldInfo.proName} { set; get; }
        </#if>

    </#list>
</#if>
    }
}