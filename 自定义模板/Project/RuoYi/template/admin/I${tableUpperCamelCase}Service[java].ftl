<#-- 用于生成Service接口的自定义模板 -->
<#-- 初始化需要生成检查字段值是否已存在的接口的字段 -->
<#assign checkValueExistedFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.checkValueExistedFields) />
package ${jsonParam.packagePath}

import java.util.List;
import java.util.Map;
import ${jsonParam.basePackagePath}.${jsonParam.moduleName}.domain.${tableInfo.upperCamelCase};

/**
 * ${FtlUtils.emptyToDefault(tableInfo.simpleRemark, "${tableInfo.tableName}表")}Service接口
 *
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
public interface I${tableInfo.upperCamelCase}Service {
    /**
     * 分页查询${tableInfo.simpleRemark}列表
     *
     * @param ${tableInfo.lowerCamelCase} ${tableInfo.simpleRemark}
     * @return ${tableInfo.simpleRemark}列表
     */
    List<${tableInfo.upperCamelCase}> select${tableInfo.upperCamelCase}List(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase});

    /**
     * 查询${tableInfo.simpleRemark}
     *
     * @param ${tableInfo.pkLowerCamelName} ${tableInfo.pkRemark}
     * @return ${tableInfo.simpleRemark}
     */
    ${tableInfo.upperCamelCase} select${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName});

    /**
     * 根据主键ID列表查询${tableInfo.simpleRemark}列表
     *
     * @param idList ${tableInfo.pkSimpleRemark}列表
     * @return 列表数据
     */
    List<${tableInfo.upperCamelCase}> select${tableInfo.upperCamelCase}ByIds(List<${tableInfo.pkJavaType}> idList);

    /**
     * 根据主键ID列表查询${tableInfo.simpleRemark}集合
     *
     * @param idList ${tableInfo.pkSimpleRemark}列表
     * @return Map<${tableInfo.pkSimpleRemark}, ${tableInfo.simpleRemark}>
     */
    Map<${tableInfo.pkJavaType}, ${tableInfo.upperCamelCase}> map${tableInfo.upperCamelCase}ByIds(List<${tableInfo.pkJavaType}> idList);
<#if checkValueExistedFields?has_content>

    /**
     * 检查${tableInfo.simpleRemark}是否存在
     *
     * @param ${tableInfo.lowerCamelCase} ${tableInfo.simpleRemark}
     * @return 是否存在
     */
    Boolean check${tableInfo.upperCamelCase}Existed(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase});
</#if>

    /**
     * 新增${tableInfo.simpleRemark}
     *
     * @param ${tableInfo.lowerCamelCase} ${tableInfo.simpleRemark}
     * @return 结果数据
     */
    int insert${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase});

    /**
     * 修改${tableInfo.simpleRemark}
     *
     * @param ${tableInfo.lowerCamelCase} ${tableInfo.simpleRemark}
     * @return 结果数据
     */
    int update${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase});

    /**
     * 删除${tableInfo.simpleRemark}
     *
     * @param ${tableInfo.pkLowerCamelName} ${tableInfo.pkRemark}
     * @return 结果数据
     */
    int delete${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName});

    /**
     * 批量删除${tableInfo.simpleRemark}
     *
     * @param idList ${tableInfo.pkRemark}列表
     * @return 结果数据
     */
    int delete${tableInfo.upperCamelCase}ByIds(List<${tableInfo.pkJavaType}> idList);
    <#if FtlUtils.fieldExisted(tableInfo, "DEL_FLAG")>

    /**
     * 批量逻辑删除${tableInfo.simpleRemark}
     *
     * @param idList ${tableInfo.pkRemark}列表
     * @return 结果数据
     */
    int delete${tableInfo.upperCamelCase}LogicByIds(List<${tableInfo.pkJavaType}> idList);
    </#if>
}