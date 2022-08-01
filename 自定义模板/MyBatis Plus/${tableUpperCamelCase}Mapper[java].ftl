<#-- 用于生成Mapper接口的自定义模板 -->
<#-- 初始化需要生成检查字段值是否已存在的接口的字段 -->
<#assign checkValueExistedFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.checkValueExistedFields) />
package ${jsonParam.packagePath}

<#-- 判断是否是需要生成SQL的表 -->
<#if !FtlUtils.tableExisted(jsonParam.noSqlTables, tableInfo.tableName)>
import org.apache.ibatis.annotations.Param;
import com.baomidou.mybatisplus.core.metadata.IPage;
import ${jsonParam.basePackagePath}.model.condition.<#if jsonParam.moduleName?has_content>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Condition;
    <#assign isNoSqlTable = false />
<#elseif checkValueExistedFields?has_content>
import org.apache.ibatis.annotations.Param;
</#if>
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import ${jsonParam.basePackagePath}.model.<#if jsonParam.moduleName?has_content>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase};

/**
 * ${tableInfo.simpleRemark}Mapper接口
 * 
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
public interface ${tableInfo.upperCamelCase}Mapper extends BaseMapper<${tableInfo.upperCamelCase}> {
<#if isNoSqlTable?? && !isNoSqlTable>
    /**
     * 分页查询${tableInfo.simpleRemark}列表
     * 
     * @param page      分页参数
     * @param condition 查询条件
     * @return 分页数据
     */
    IPage<${tableInfo.upperCamelCase}> find${tableInfo.upperCamelCase}Page(IPage<${tableInfo.upperCamelCase}> page, @Param("condition") ${tableInfo.upperCamelCase}Condition condition);
</#if>
<#if checkValueExistedFields?has_content>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#list checkValueExistedFields as fieldName>
            <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>

    /**
     * 检查${fieldInfo.simpleRemark!fieldInfo.colName}是否存在
     *
     * @param ${fieldInfo.proName} ${fieldInfo.simpleRemark}
                <#if tableInfo.pkLowerCamelName?has_content>
     * @param ${tableInfo.pkLowerCamelName} ${tableInfo.pkRemark}(排除)
                </#if>
     * @return 是否存在
     */
    String check${fieldInfo.upperCamelCase}Existed(@Param("${fieldInfo.proName}") ${fieldInfo.javaType} ${fieldInfo.proName}<#if tableInfo.pkLowerCamelName?has_content>, @Param("${tableInfo.pkLowerCamelName}") ${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}</#if>);
            </#if>
        </#list>
    </#list>
</#if>

}