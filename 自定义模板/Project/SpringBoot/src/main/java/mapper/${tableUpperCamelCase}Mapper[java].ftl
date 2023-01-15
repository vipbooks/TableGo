<#-- 初始化是否不生成SQL查询的接口 -->
<#assign isNoSqlTable = FtlUtils.tableExisted(tableInfo, jsonParam.noSqlTables) />
package ${jsonParam.packagePath}

<#if !isNoSqlTable>
import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.baomidou.mybatisplus.core.metadata.IPage;
import ${jsonParam.basePackagePath}.model.condition.<#if jsonParam.moduleName?has_content>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Condition;
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
<#if !isNoSqlTable>
    /**
     * 分页查询${tableInfo.simpleRemark}列表
     * 
     * @param page      分页参数
     * @param condition 查询条件
     * @return 分页数据
     */
    IPage<${tableInfo.upperCamelCase}> find${tableInfo.upperCamelCase}List(IPage<${tableInfo.upperCamelCase}> page, @Param("condition") ${tableInfo.upperCamelCase}Condition condition);

    /**
     * 查询${tableInfo.simpleRemark}列表
     * 
     * @param condition ${tableInfo.simpleRemark}查询条件
     * @return 列表数据
     */
    List<${tableInfo.upperCamelCase}> find${tableInfo.upperCamelCase}List(@Param("condition") ${tableInfo.upperCamelCase}Condition condition);

    /**
     * 查询${tableInfo.simpleRemark}
     * 
     * @param condition 查询条件
     * @return ${tableInfo.simpleRemark}
     */
    List<${tableInfo.upperCamelCase}> get${tableInfo.upperCamelCase}(@Param("condition") ${tableInfo.upperCamelCase}Condition condition);
</#if>

}