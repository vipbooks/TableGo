<#-- 用于生成Service接口的自定义模板 -->
<#-- 初始化需要生成检查字段值是否已存在的接口的字段 -->
<#assign checkValueExistedFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.checkValueExistedFields) />
package ${jsonParam.packagePath}

<#if tableInfo.pkLowerCamelName?has_content>
import java.util.Map;
</#if>
import java.util.List;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;

import ${jsonParam.basePackagePath}.model.${tableInfo.upperCamelCase};
import ${jsonParam.basePackagePath}.model.condition.${tableInfo.upperCamelCase}Condition;

/**
 * ${tableInfo.simpleRemark}Service接口
 *
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
public interface ${tableInfo.upperCamelCase}Service extends IService<${tableInfo.upperCamelCase}> {
    /**
     * 分页查询${tableInfo.simpleRemark}列表
     *
     * @param condition 查询条件
     * @return 分页信息
     */
    IPage<${tableInfo.upperCamelCase}> find${tableInfo.upperCamelCase}Page(${tableInfo.upperCamelCase}Condition condition);

    /**
     * 查询${tableInfo.simpleRemark}列表
     * 
     * @param condition ${tableInfo.simpleRemark}查询条件
     * @return 列表数据
     */
    List<${tableInfo.upperCamelCase}> find${tableInfo.upperCamelCase}List(${tableInfo.upperCamelCase}Condition condition);

    /**
     * 查询${tableInfo.simpleRemark}
     *
     * @param condition 查询条件
     * @return ${tableInfo.simpleRemark}
     */
    ${tableInfo.upperCamelCase} get${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase}Condition condition);
<#if tableInfo.pkLowerCamelName?has_content>

    /**
     * 根据主键ID查询${tableInfo.simpleRemark}
     *
     * @param ${tableInfo.pkLowerCamelName} ${tableInfo.pkRemark}
     * @return ${tableInfo.simpleRemark}
     */
    ${tableInfo.upperCamelCase} get${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName});

    /**
     * 根据主键ID列表查询${tableInfo.simpleRemark}列表
     *
     * @param idList ${tableInfo.pkSimpleRemark}列表
     * @return 列表数据
     */
    List<${tableInfo.upperCamelCase}> find${tableInfo.upperCamelCase}ByIds(List<${tableInfo.pkJavaType}> idList);

    /**
     * 查询主键ID列表对应的${tableInfo.simpleRemark}集合
     *
     * @param idList ${tableInfo.pkSimpleRemark}列表
     * @return Map<${tableInfo.pkSimpleRemark}, ${tableInfo.simpleRemark}>
     */
    Map<${tableInfo.pkJavaType}, ${tableInfo.upperCamelCase}> map${tableInfo.upperCamelCase}ByIds(List<${tableInfo.pkJavaType}> idList);
</#if>
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
    Boolean delete${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName});

    /**
     * 根据主键ID列表批量删除${tableInfo.simpleRemark}
     *
     * @param idList ${tableInfo.pkRemark}列表
     * @return 是否成功
     */
    Boolean delete${tableInfo.upperCamelCase}ByIds(List<${tableInfo.pkJavaType}> idList);
</#if>
}