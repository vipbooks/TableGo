<#-- 用于生成Service接口的自定义模板 -->
package ${jsonParam.packagePath}

import java.util.List;
import org.springframework.data.domain.Page;
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
     * @return 分页数据
     */
    Page<${tableInfo.upperCamelCase}> list${tableInfo.upperCamelCase}Page(${tableInfo.upperCamelCase}Condition condition);

    /**
     * 根据主键ID查询${tableInfo.simpleRemark}
     * 
     * @param ${tableInfo.pkLowerCamelName} 主键ID
     * @return ${tableInfo.simpleRemark}
     */
    ${tableInfo.upperCamelCase} get${tableInfo.upperCamelCase}ById(String ${tableInfo.pkLowerCamelName});

    /**
     * 保存${tableInfo.simpleRemark}
     * 
     * @param ${tableInfo.lowerCamelCase} ${tableInfo.simpleRemark}信息
     * @return 是否成功
     */
    Boolean save${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase});

    /**
     * 批量保存${tableInfo.simpleRemark}
     * 
     * @param ${tableInfo.lowerCamelCase}List ${tableInfo.simpleRemark}列表
     * @return 是否成功
     */
    Boolean batchSave${tableInfo.upperCamelCase}(List<${tableInfo.upperCamelCase}> ${tableInfo.lowerCamelCase}List);

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

    /**
     * 创建${tableInfo.simpleRemark}索引
     *
     * @return 是否成功
     */
    Boolean create${tableInfo.upperCamelCase}Index();

    /**
     * 映射${tableInfo.simpleRemark}索引字段类型
     *
     * @return 是否成功
     */
    Boolean putMapping${tableInfo.upperCamelCase}Index();

    /**
     * 删除${tableInfo.simpleRemark}索引
     *
     * @return 是否成功
     */
    Boolean delete${tableInfo.upperCamelCase}Index();
}