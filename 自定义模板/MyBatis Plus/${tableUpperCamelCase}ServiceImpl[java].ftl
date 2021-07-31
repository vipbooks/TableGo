<#-- 用于生成Service接口实现的自定义模板 -->
<#-- 初始化表的查询字段 -->
<#assign searchFeilds = FtlUtils.getJsonFieldList(jsonParam.searchFeilds, tableInfo.tableName) />
<#-- 判断是否是需要多表关联查询的表 -->
<#if FtlUtils.tableExisted(jsonParam.joinTables, tableInfo.tableName)>
    <#assign isJoinTable = true />
</#if>
package ${jsonParam.packagePath}

import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
<#if FtlUtils.fieldTypeAtListExisted(tableInfo, searchFeilds, "Date")>
import cn.hutool.core.date.DateUtil;
</#if>
<#if !isJoinTable??>
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
</#if>
import ${jsonParam.basePackagePath}.model.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase};
import ${jsonParam.basePackagePath}.model.condition.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Condition;
import ${jsonParam.basePackagePath}.mapper.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Mapper;
import ${jsonParam.basePackagePath}.service.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Service;

/**
 * ${tableInfo.simpleRemark}Service接口实现
 *
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@Service
@Transactional(readOnly = true)
public class ${tableInfo.upperCamelCase}ServiceImpl extends ServiceImpl<${tableInfo.upperCamelCase}Mapper, ${tableInfo.upperCamelCase}> implements ${tableInfo.upperCamelCase}Service {
    private static final Logger logger = LoggerFactory.getLogger(${tableInfo.upperCamelCase}Service.class);

    @Override
    public IPage<${tableInfo.upperCamelCase}> find${tableInfo.upperCamelCase}ByCondition(${tableInfo.upperCamelCase}Condition condition) {
        IPage<${tableInfo.upperCamelCase}> page = condition.buildPage();
<#assign fieldInfo = FtlUtils.getFieldByFieldTypeAtList(tableInfo, searchFeilds, "Date") />
<#if isJoinTable?? && isJoinTable>
    <#if fieldInfo?has_content>

        if (condition.get${fieldInfo.upperCamelCase}End() != null) {
            condition.set${fieldInfo.upperCamelCase}End(DateUtil.endOfDay(condition.get${fieldInfo.upperCamelCase}End()));
        }
    </#if>
        return baseMapper.list${tableInfo.upperCamelCase}Page(page, condition);
<#else>
        QueryWrapper<${tableInfo.upperCamelCase}> queryWrapper = condition.buildQueryWrapper(${tableInfo.upperCamelCase}.class);
    <#if fieldInfo?has_content>

        if (condition.get${fieldInfo.upperCamelCase}Begin() != null) {
            queryWrapper.lambda().ge(${tableInfo.upperCamelCase}::get${fieldInfo.upperCamelCase}, condition.get${fieldInfo.upperCamelCase}Begin());
        }
        if (condition.get${fieldInfo.upperCamelCase}End() != null) {
            queryWrapper.lambda().lt(${tableInfo.upperCamelCase}::get${fieldInfo.upperCamelCase}, DateUtil.endOfDay(condition.get${fieldInfo.upperCamelCase}End()));
        }
    </#if>
        return this.page(page, queryWrapper);
</#if>
    }

    @Override
    public ${tableInfo.upperCamelCase} get${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        return this.getById(${tableInfo.pkLowerCamelName});
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Boolean add${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        return this.save(${tableInfo.lowerCamelCase});
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Boolean update${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        return this.updateById(${tableInfo.lowerCamelCase});
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Boolean delete${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        return this.removeById(${tableInfo.pkLowerCamelName});
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Boolean delete${tableInfo.upperCamelCase}ByIds(List<${tableInfo.pkJavaType}> idList) {
        return this.removeByIds(idList);
    }
}