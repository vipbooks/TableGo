<#-- 用于生成Service接口实现的自定义模板 -->
<#-- 初始化表的查询字段 -->
<#assign searchFields = FtlUtils.getJsonFieldInfoList(tableInfo, jsonParam.searchFields) />
<#-- 初始化查询字段中的日期字段 -->
<#assign dateFieldInfo = FtlUtils.getFieldInfoByType(searchFields, "Date") />
<#-- 初始化需要生成检查字段值是否已存在的接口的字段 -->
<#assign checkValueExistedFields = FtlUtils.getJsonFieldInfoList(tableInfo, jsonParam.checkValueExistedFields) />
package ${jsonParam.packagePath}

<#if checkValueExistedFields?has_content>
import cn.hutool.core.util.BooleanUtil;
import ${jsonParam.basePackagePath}.common.util.Assert;
</#if>
<#if FtlUtils.fieldTypeExisted(searchFields, "Date")>
import cn.hutool.core.date.DateUtil;
</#if>
<#if tableInfo.pkLowerCamelName?has_content>
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.Collections;
</#if>
import java.util.List;
import cn.hutool.core.util.StrUtil;
import cn.hutool.core.collection.CollUtil;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.github.pagehelper.Page;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ${jsonParam.basePackagePath}.model.${tableInfo.upperCamelCase};
import ${jsonParam.basePackagePath}.model.condition.${tableInfo.upperCamelCase}Condition;
import ${jsonParam.basePackagePath}.mapper.${tableInfo.upperCamelCase}Mapper;
import ${jsonParam.basePackagePath}.service.${tableInfo.upperCamelCase}Service;

/**
 * ${FtlUtils.emptyToDefault(tableInfo.simpleRemark, "${tableInfo.tableName}表")}Service接口实现
 *
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
@Service
@Transactional(readOnly = true)
public class ${tableInfo.upperCamelCase}ServiceImpl implements ${tableInfo.upperCamelCase}Service {
    private static final Logger logger = LoggerFactory.getLogger(${tableInfo.upperCamelCase}ServiceImpl.class);

    @Autowired
    private ${tableInfo.upperCamelCase}Mapper ${tableInfo.lowerCamelCase}Mapper;

    @Override
    public PageInfo<${tableInfo.upperCamelCase}> find${tableInfo.upperCamelCase}Page(${tableInfo.upperCamelCase}Condition condition) {
        Page<${tableInfo.upperCamelCase}> page = condition.buildPage();
    <#if dateFieldInfo?has_content>

        if (condition.get${dateFieldInfo.upperCamelCase}End() != null) {
            condition.set${dateFieldInfo.upperCamelCase}End(DateUtil.endOfDay(condition.get${dateFieldInfo.upperCamelCase}End()));
        }
    </#if>
        PageHelper.startPage(page.getPageNum(), page.getPageSize());
        List<${tableInfo.upperCamelCase}> list = ${tableInfo.lowerCamelCase}Mapper.find${tableInfo.upperCamelCase}List(condition);
        PageInfo<${tableInfo.upperCamelCase}> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public List<${tableInfo.upperCamelCase}> find${tableInfo.upperCamelCase}List(${tableInfo.upperCamelCase}Condition condition) {
        List<${tableInfo.upperCamelCase}> list = ${tableInfo.lowerCamelCase}Mapper.find${tableInfo.upperCamelCase}List(condition);
        return list;
    }

    @Override
    public ${tableInfo.upperCamelCase} get${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase}Condition condition) {
        List<${tableInfo.upperCamelCase}> list = ${tableInfo.lowerCamelCase}Mapper.get${tableInfo.upperCamelCase}(condition);
        if (CollUtil.isNotEmpty(list)) {
            if (list.size() > 1) {
                logger.warn("Expected one result (or null) to be returned by get${tableInfo.upperCamelCase}(), but found: {}", list.size());
            }
            return list.get(0);
        }
        return null;
    }
<#if tableInfo.pkLowerCamelName?has_content>

    @Override
    public ${tableInfo.upperCamelCase} get${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        return ${tableInfo.upperCamelCase}Mapper.get${tableInfo.upperCamelCase}ById(${tableInfo.pkLowerCamelName});
    }

    @Override
    public List<${tableInfo.upperCamelCase}> find${tableInfo.upperCamelCase}ByIds(List<${tableInfo.pkJavaType}> idList) {
        if (CollUtil.isEmpty(idList)) {
            return Collections.emptyList();
        }
        return ${tableInfo.lowerCamelCase}Mapper.find${tableInfo.upperCamelCase}ByIds(idList.stream().filter(StrUtil::isNotBlank).distinct().collect(Collectors.toList()));
    }

    @Override
    public Map<${tableInfo.pkJavaType}, ${tableInfo.upperCamelCase}> map${tableInfo.upperCamelCase}ByIds(List<${tableInfo.pkJavaType}> idList) {
        List<${tableInfo.upperCamelCase}> list = find${tableInfo.upperCamelCase}ByIds(idList);
        return Optional.ofNullable(list).orElse(CollUtil.toList()).stream().collect(Collectors.toMap(${tableInfo.upperCamelCase}::get${tableInfo.pkUpperCamelName}, ${tableInfo.upperCamelCase} -> ${tableInfo.upperCamelCase}));
    }
</#if>
<#if checkValueExistedFields?has_content>

    @Override
    public Boolean check${tableInfo.upperCamelCase}Existed(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        return BooleanUtil.toBoolean(this.${tableInfo.lowerCamelCase}Mapper.check${tableInfo.upperCamelCase}Existed(${tableInfo.lowerCamelCase}));
    }
</#if>

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Boolean add${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
<#if checkValueExistedFields?has_content>
        check${tableInfo.upperCamelCase}Valid(${tableInfo.lowerCamelCase});
</#if>
        return ${tableInfo.upperCamelCase}Mapper.add${tableInfo.upperCamelCase}(${tableInfo.lowerCamelCase});
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Boolean update${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
<#if checkValueExistedFields?has_content>
        check${tableInfo.upperCamelCase}Valid(${tableInfo.lowerCamelCase});
</#if>
        return ${tableInfo.upperCamelCase}Mapper.update${tableInfo.upperCamelCase}(${tableInfo.lowerCamelCase});
    }
<#if tableInfo.pkLowerCamelName?has_content>

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Boolean delete${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        return ${tableInfo.upperCamelCase}Mapper.delete${tableInfo.upperCamelCase}ById(${tableInfo.pkLowerCamelName});
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Boolean delete${tableInfo.upperCamelCase}ByIds(List<${tableInfo.pkJavaType}> idList) {
        return ${tableInfo.upperCamelCase}Mapper.delete${tableInfo.upperCamelCase}ByIds(idList);
    }
    <#if FtlUtils.fieldExisted(tableInfo, "IS_DELETED")>

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Boolean delete${tableInfo.upperCamelCase}LogicByIds(List<String> idList) {
        String userId = null;
        return ${tableInfo.lowerCamelCase}Mapper.delete${tableInfo.upperCamelCase}LogicByIds(idList, userId);
    }
    </#if>
</#if>
<#if checkValueExistedFields?has_content>

    /**
     * 检查${tableInfo.simpleRemark}是否有效
     *
     * @param ${tableInfo.lowerCamelCase} ${tableInfo.simpleRemark}
     */
    private void check${tableInfo.upperCamelCase}Valid(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
    <#list checkValueExistedFields as fieldInfo>
        ${fieldInfo.javaType} ${fieldInfo.proName} = ${tableInfo.lowerCamelCase}.get${fieldInfo.upperCamelCase}();
        if (<#if fieldInfo.isStringType>StrUtil.isNotBlank(${fieldInfo.proName})<#else>${fieldInfo.proName} != null</#if>) {
            Boolean ${fieldInfo.proName}Existed = check${tableInfo.upperCamelCase}Existed(${tableInfo.upperCamelCase}.newInstance()<#if tableInfo.pkUpperCamelName?has_content>.set${tableInfo.pkUpperCamelName}(${tableInfo.lowerCamelCase}.get${tableInfo.pkUpperCamelName}())</#if>.set${fieldInfo.upperCamelCase}(${fieldInfo.proName}));
            Assert.isFalse(${fieldInfo.proName}Existed, "${fieldInfo.simpleRemark}已存在，请重新输入！");
        }
    </#list>
    }
</#if>
}