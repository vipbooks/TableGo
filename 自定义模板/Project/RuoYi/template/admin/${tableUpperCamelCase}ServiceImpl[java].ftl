<#-- 用于生成Service接口实现的自定义模板 -->
<#-- 初始化表的查询字段 -->
<#assign searchFields = FtlUtils.getJsonFieldInfoList(tableInfo, jsonParam.searchFields) />
<#-- 初始化查询字段中的日期字段 -->
<#assign dateFieldInfo = FtlUtils.getFieldInfoByType(searchFields, "Date") />
<#-- 初始化需要生成检查字段值是否已存在的接口的字段 -->
<#assign checkValueExistedFields = FtlUtils.getJsonFieldInfoList(tableInfo, jsonParam.checkValueExistedFields) />
package ${jsonParam.packagePath}

<#if checkValueExistedFields?has_content>
import cn.hutool.core.util.StrUtil;
import cn.hutool.core.util.BooleanUtil;
import com.ruoyi.common.exception.ServiceException;
</#if>
<#if FtlUtils.fieldTypeExisted(searchFields, "Date")>
import cn.hutool.core.date.DateUtil;
</#if>
<#if tableInfo.pkIsStringType && !checkValueExistedFields?has_content>
import cn.hutool.core.util.StrUtil;
<#else>
import java.util.Objects;
</#if>
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Collections;
import java.util.stream.Collectors;

import cn.hutool.core.collection.CollUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
<#if FtlUtils.fieldAllExisted(tableInfo.allFieldNameList, jsonParam.commonFields)>

import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.ShiroUtils;
</#if>

import ${jsonParam.basePackagePath}.${jsonParam.moduleName}.domain.${tableInfo.upperCamelCase};
import ${jsonParam.basePackagePath}.${jsonParam.moduleName}.mapper.${tableInfo.upperCamelCase}Mapper;
import ${jsonParam.basePackagePath}.${jsonParam.moduleName}.service.I${tableInfo.upperCamelCase}Service;

/**
 * ${FtlUtils.emptyToDefault(tableInfo.simpleRemark, "${tableInfo.tableName}表")}Service接口实现
 *
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
@Service
public class ${tableInfo.upperCamelCase}ServiceImpl implements I${tableInfo.upperCamelCase}Service {
    private static final Logger logger = LoggerFactory.getLogger(${tableInfo.upperCamelCase}ServiceImpl.class);

    @Autowired
    private ${tableInfo.upperCamelCase}Mapper ${tableInfo.lowerCamelCase}Mapper;

    @Override
    public List<${tableInfo.upperCamelCase}> select${tableInfo.upperCamelCase}List(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
    <#if dateFieldInfo?has_content>
        if (${tableInfo.lowerCamelCase}.get${dateFieldInfo.upperCamelCase}End() != null) {
            ${tableInfo.lowerCamelCase}.set${dateFieldInfo.upperCamelCase}End(DateUtil.endOfDay(${tableInfo.lowerCamelCase}.get${dateFieldInfo.upperCamelCase}End()));
        }
    </#if>
        return ${tableInfo.lowerCamelCase}Mapper.select${tableInfo.upperCamelCase}List(${tableInfo.lowerCamelCase});
    }

    @Override
    public ${tableInfo.upperCamelCase} select${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        return ${tableInfo.lowerCamelCase}Mapper.select${tableInfo.upperCamelCase}ById(${tableInfo.pkLowerCamelName});
    }

    @Override
    public List<${tableInfo.upperCamelCase}> select${tableInfo.upperCamelCase}ByIds(List<${tableInfo.pkJavaType}> idList) {
        if (CollUtil.isEmpty(idList)) {
            return Collections.emptyList();
        }
        <#if tableInfo.pkIsStringType>
        return ${tableInfo.lowerCamelCase}Mapper.select${tableInfo.upperCamelCase}ByIds(idList.stream().filter(StrUtil::isNotBlank).distinct().collect(Collectors.toList()));
        <#else>
        return ${tableInfo.lowerCamelCase}Mapper.select${tableInfo.upperCamelCase}ByIds(idList.stream().filter(Objects::nonNull).distinct().collect(Collectors.toList()));
        </#if>
    }

    @Override
    public Map<${tableInfo.pkJavaType}, ${tableInfo.upperCamelCase}> map${tableInfo.upperCamelCase}ByIds(List<${tableInfo.pkJavaType}> idList) {
        List<${tableInfo.upperCamelCase}> list = select${tableInfo.upperCamelCase}ByIds(idList);
        return Optional.ofNullable(list).orElse(Collections.emptyList()).stream().collect(Collectors.toMap(${tableInfo.upperCamelCase}::get${tableInfo.pkUpperCamelName}, ${tableInfo.upperCamelCase} -> ${tableInfo.upperCamelCase}));
    }
<#if checkValueExistedFields?has_content>

    @Override
    public Boolean check${tableInfo.upperCamelCase}Existed(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        return BooleanUtil.toBoolean(this.${tableInfo.lowerCamelCase}Mapper.check${tableInfo.upperCamelCase}Existed(${tableInfo.lowerCamelCase}));
    }
</#if>

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int insert${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
<#if checkValueExistedFields?has_content>
        check${tableInfo.upperCamelCase}Valid(${tableInfo.lowerCamelCase});
</#if>
<#if FtlUtils.fieldAllExisted(tableInfo.allFieldNameList, jsonParam.commonFields)>
        ${tableInfo.lowerCamelCase}.setCreateBy(ShiroUtils.getLoginName());
        ${tableInfo.lowerCamelCase}.setCreateTime(DateUtils.getNowDate());
</#if>
        return ${tableInfo.lowerCamelCase}Mapper.insert${tableInfo.upperCamelCase}(${tableInfo.lowerCamelCase});
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int update${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
<#if checkValueExistedFields?has_content>
        check${tableInfo.upperCamelCase}Valid(${tableInfo.lowerCamelCase});
</#if>
<#if FtlUtils.fieldAllExisted(tableInfo.allFieldNameList, jsonParam.commonFields)>
        ${tableInfo.lowerCamelCase}.setCreateBy(ShiroUtils.getLoginName());
        ${tableInfo.lowerCamelCase}.setCreateTime(DateUtils.getNowDate());
</#if>
        return ${tableInfo.lowerCamelCase}Mapper.update${tableInfo.upperCamelCase}(${tableInfo.lowerCamelCase});
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int delete${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        return ${tableInfo.lowerCamelCase}Mapper.delete${tableInfo.upperCamelCase}ById(${tableInfo.pkLowerCamelName});
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int delete${tableInfo.upperCamelCase}ByIds(List<${tableInfo.pkJavaType}> idList) {
        if (CollUtil.isEmpty(idList)) {
            return 0;
        }
        return ${tableInfo.lowerCamelCase}Mapper.delete${tableInfo.upperCamelCase}ByIds(idList);
    }
<#if FtlUtils.fieldExisted(tableInfo, "DEL_FLAG")>

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int delete${tableInfo.upperCamelCase}LogicByIds(List<${tableInfo.pkJavaType}> idList) {
        String loginName = ShiroUtils.getLoginName();
        return ${tableInfo.lowerCamelCase}Mapper.delete${tableInfo.upperCamelCase}LogicByIds(idList, loginName);
    }
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
            if(${fieldInfo.proName}Existed) {
                throw new ServiceException("${fieldInfo.simpleRemark}已存在，请重新输入！");
            }
        }
    </#list>
    }
</#if>
}