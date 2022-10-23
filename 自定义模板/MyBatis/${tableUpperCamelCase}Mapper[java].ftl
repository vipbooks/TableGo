<#-- 用于生成Mapper接口的自定义模板 -->
<#-- 初始化需要生成检查字段值是否已存在的接口的字段 -->
<#assign checkValueExistedFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.checkValueExistedFields) />
package ${jsonParam.packagePath}

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Mapper;

import ${jsonParam.basePackagePath}.model.${tableInfo.upperCamelCase};
import ${jsonParam.basePackagePath}.model.condition.${tableInfo.upperCamelCase}Condition;

/**
 * ${tableInfo.simpleRemark}Mapper接口
 * 
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@Mapper
public interface ${tableInfo.upperCamelCase}Mapper {
    /**
     * 查询${tableInfo.simpleRemark}列表
     * 
     * @param condition 查询条件
     * @return 列表数据
     */
    List<${tableInfo.upperCamelCase}> find${tableInfo.upperCamelCase}List(@Param("condition") ${tableInfo.upperCamelCase}Condition condition);
<#if tableInfo.pkLowerCamelName?has_content>

    /**
     * 根据主键ID查询${tableInfo.simpleRemark}
     *
     * @param ${tableInfo.pkLowerCamelName} ${tableInfo.pkRemark}
     * @return ${tableInfo.simpleRemark}
     */
    ${tableInfo.upperCamelCase} get${tableInfo.upperCamelCase}ById(@Param("${tableInfo.pkLowerCamelName}") ${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName});
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

    /**
     * 新增${tableInfo.simpleRemark}
     *
     * @param ${tableInfo.lowerCamelCase} ${tableInfo.simpleRemark}
     * @return 是否成功
     */
    Boolean add${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase});

    /**
     * 修改${tableInfo.simpleRemark}
     *
     * @param ${tableInfo.lowerCamelCase} ${tableInfo.simpleRemark}
     * @return 是否成功
     */
    Boolean update${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase});
<#if tableInfo.pkLowerCamelName?has_content>

    /**
     * 根据主键ID删除${tableInfo.simpleRemark}
     *
     * @param ${tableInfo.pkLowerCamelName} ${tableInfo.pkRemark}
     * @return 是否成功
     */
    Boolean delete${tableInfo.upperCamelCase}ById(@Param("${tableInfo.pkLowerCamelName}") ${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName});

    /**
     * 批量删除${tableInfo.simpleRemark}
     *
     * @param idList ${tableInfo.pkRemark}列表
     * @return 是否成功
     */
    Boolean delete${tableInfo.upperCamelCase}ByIds(List<${tableInfo.pkJavaType}> idList);
    <#if FtlUtils.fieldExisted(tableInfo, "DELETE_FLAG")>

    /**
     * 批量逻辑删除${tableInfo.simpleRemark}
     *
     * @param idList ${tableInfo.pkRemark}列表
     * @param userId 登录用户ID
     * @return 是否成功
     */
    Boolean delete${tableInfo.upperCamelCase}LogicByIds(@Param("idList") List<${tableInfo.pkJavaType}> idList, @Param("userId") String userId);
    </#if>
</#if>
}