<#-- 初始化表的查询字段 -->
<#assign searchFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.searchFields) />
<#-- 初始化需要生成检查字段值是否已存在的接口的字段 -->
<#assign checkValueExistedFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.checkValueExistedFields) />
<#-- 判断是否是需要生成SQL的表 -->
<#if FtlUtils.tableExisted(jsonParam.noSqlTables, tableInfo.tableName)>
    <#assign isNoSqlTable = true />
</#if>
package ${jsonParam.packagePath}

import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import lombok.extern.slf4j.Slf4j;

<#if isNoSqlTable?? && isNoSqlTable>
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
</#if>
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
<#if FtlUtils.fieldTypeAtListExisted(tableInfo, searchFields, "Date")>
import cn.hutool.core.date.DateUtil;
</#if>
<#if checkValueExistedFields?has_content>
import cn.hutool.core.util.BooleanUtil;
</#if>
import ${jsonParam.basePackagePath}.model.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase};
import ${jsonParam.basePackagePath}.model.condition.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Condition;
import ${jsonParam.basePackagePath}.mapper.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Mapper;

/**
 * ${tableInfo.simpleRemark}Service接口实现
 *
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@Slf4j
@Service
@Transactional(readOnly = true)
public class ${tableInfo.upperCamelCase}Service extends ServiceImpl<${tableInfo.upperCamelCase}Mapper, ${tableInfo.upperCamelCase}> {
    /**
     * 根据条件分页查询${tableInfo.simpleRemark}列表
     *
     * @param condition 查询条件
     * @return 分页数据
     */
    public IPage<${tableInfo.upperCamelCase}> find${tableInfo.upperCamelCase}Page(${tableInfo.upperCamelCase}Condition condition) {
        IPage<${tableInfo.upperCamelCase}> page = condition.buildPage();
<#assign fieldInfo = FtlUtils.getFieldByFieldTypeAtList(tableInfo, searchFields, "Date") />
<#if isNoSqlTable?? && isNoSqlTable>
        LambdaQueryWrapper<${tableInfo.upperCamelCase}> queryWrapper = condition.buildLambdaQueryWrapper(${tableInfo.upperCamelCase}.class);
    <#if fieldInfo?has_content>

        queryWrapper.ge(condition.get${fieldInfo.upperCamelCase}Begin() != null, ${tableInfo.upperCamelCase}::get${fieldInfo.upperCamelCase}, condition.get${fieldInfo.upperCamelCase}Begin());
        if (condition.get${fieldInfo.upperCamelCase}End() != null) {
            queryWrapper.lt(${tableInfo.upperCamelCase}::get${fieldInfo.upperCamelCase}, DateUtil.endOfDay(condition.get${fieldInfo.upperCamelCase}End()));
        }
    </#if>
    <#if FtlUtils.fieldExisted(tableInfo, "CREATION_DATE")>
        queryWrapper.orderByDesc(${tableInfo.upperCamelCase}::getCreationDate);
    </#if>

        return this.page(page, queryWrapper);
<#else>
    <#if fieldInfo?has_content>

        if (condition.get${fieldInfo.upperCamelCase}End() != null) {
            condition.set${fieldInfo.upperCamelCase}End(DateUtil.endOfDay(condition.get${fieldInfo.upperCamelCase}End()));
        }
    </#if>
        return this.baseMapper.find${tableInfo.upperCamelCase}Page(page, condition);
</#if>
    }
<#if tableInfo.pkLowerCamelName??>

    /**
     * 根据主键ID查询${tableInfo.simpleRemark}信息
     *
     * @param ${tableInfo.pkLowerCamelName} 主键ID
     * @return ${tableInfo.simpleRemark}信息
     */
    public ${tableInfo.upperCamelCase} get${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        return this.getById(${tableInfo.pkLowerCamelName});
    }
</#if>
<#if checkValueExistedFields?has_content>
    <#list tableInfo.fieldInfos as fieldInfo>
        <#list checkValueExistedFields as fieldName>
            <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>

    /**
     * 检查${fieldInfo.simpleRemark!fieldInfo.colName}是否存在
     *
     * @param ${fieldInfo.proName} ${fieldInfo.simpleRemark!fieldInfo.colName}
     * @return 是否存在
     */
    public Boolean check${fieldInfo.upperCamelCase}Existed(${fieldInfo.javaType} ${fieldInfo.proName}) {
        return BooleanUtil.toBoolean(this.baseMapper.check${fieldInfo.upperCamelCase}Existed(${fieldInfo.proName}));
    }
            </#if>
        </#list>
    </#list>
</#if>

    /**
     * 新增${tableInfo.simpleRemark}信息
     *
     * @param ${tableInfo.lowerCamelCase} ${tableInfo.simpleRemark}信息
     * @return 是否成功
     */
    @Transactional(rollbackFor = Exception.class)
    public Boolean add${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        return this.save(${tableInfo.lowerCamelCase});
    }

    /**
     * 修改${tableInfo.simpleRemark}信息
     *
     * @param ${tableInfo.lowerCamelCase} ${tableInfo.simpleRemark}信息
     * @return 是否成功
     */
    @Transactional(rollbackFor = Exception.class)
    public Boolean update${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        return this.updateById(${tableInfo.lowerCamelCase});
    }
<#if tableInfo.pkLowerCamelName??>

    /**
     * 根据主键ID删除${tableInfo.simpleRemark}
     *
     * @param ${tableInfo.pkLowerCamelName} 主键ID
     * @return 是否成功
     */
    @Transactional(rollbackFor = Exception.class)
    public Boolean delete${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        return this.removeById(${tableInfo.pkLowerCamelName});
    }

    /**
     * 根据主键ID列表批量删除${tableInfo.simpleRemark}
     *
     * @param idList 主键ID列表
     * @return 是否成功
     */
    @Transactional(rollbackFor = Exception.class)
    public Boolean delete${tableInfo.upperCamelCase}ByIds(List<${tableInfo.pkJavaType}> idList) {
        return this.removeByIds(idList);
    }
</#if>
}