<#-- 用于生成Mapper接口的自定义模板 -->
package ${jsonParam.packagePath}

<#-- 判断是否是需要生成SQL的表 -->
<#if !FtlUtils.tableExisted(jsonParam.noSqlTables, tableInfo.tableName)>
import org.apache.ibatis.annotations.Param;
import com.baomidou.mybatisplus.core.metadata.IPage;
import ${jsonParam.basePackagePath}.model.condition.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Condition;
    <#assign isNoSqlTable = false />
</#if>
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import ${jsonParam.basePackagePath}.model.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase};

/**
 * ${tableInfo.simpleRemark}Mapper接口
 * 
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
public interface ${tableInfo.upperCamelCase}Mapper extends BaseMapper<${tableInfo.upperCamelCase}> {
<#if isNoSqlTable?? && !isNoSqlTable>
    /**
     * 根据条件分页查询${tableInfo.simpleRemark}列表
     * 
     * @param page      分页参数
     * @param condition 查询条件
     * @return 分页数据
     */
    IPage<${tableInfo.upperCamelCase}> list${tableInfo.upperCamelCase}Page(IPage<${tableInfo.upperCamelCase}> page, @Param("condition") ${tableInfo.upperCamelCase}Condition condition);
</#if>

}