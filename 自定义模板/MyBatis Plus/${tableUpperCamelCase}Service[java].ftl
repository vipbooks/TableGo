<#-- 用于生成Service接口的自定义模板 -->
package ${jsonParam.packagePath}

import java.util.List;

import com.baomidou.mybatisplus.core.metadata.IPage;
import ${jsonParam.basePackagePath}.model.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase};
import ${jsonParam.basePackagePath}.model.condition.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Condition;

/**
 * ${tableInfo.simpleRemark}Service接口
 *
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
public interface ${tableInfo.upperCamelCase}Service {
    /**
     * 根据条件分页查询${tableInfo.simpleRemark}列表
     *
     * @param condition 查询条件
     * @return 分页信息
     */
    IPage<${tableInfo.upperCamelCase}> find${tableInfo.upperCamelCase}ByCondition(${tableInfo.upperCamelCase}Condition condition);

    /**
     * 根据主键ID查询${tableInfo.simpleRemark}信息
     *
     * @param ${tableInfo.pkLowerCamelName} 主键ID
     * @return ${tableInfo.simpleRemark}信息
     */
    ${tableInfo.upperCamelCase} get${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName});

    /**
     * 新增${tableInfo.simpleRemark}信息
     *
     * @param ${tableInfo.lowerCamelCase} ${tableInfo.simpleRemark}信息
     * @return 是否成功
     */
    Boolean add${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase});

    /**
     * 修改${tableInfo.simpleRemark}信息
     *
     * @param ${tableInfo.lowerCamelCase} ${tableInfo.simpleRemark}信息
     * @return 是否成功
     */
    Boolean update${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase});

    /**
     * 根据主键ID删除${tableInfo.simpleRemark}
     *
     * @param ${tableInfo.pkLowerCamelName} 主键ID
     * @return 是否成功
     */
    Boolean delete${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName});

    /**
     * 根据主键ID列表批量删除${tableInfo.simpleRemark}
     *
     * @param idList 主键ID列表
     * @return 是否成功
     */
    Boolean delete${tableInfo.upperCamelCase}ByIds(List<${tableInfo.pkJavaType}> idList);
}