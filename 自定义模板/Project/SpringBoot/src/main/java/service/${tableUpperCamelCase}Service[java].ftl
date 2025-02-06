<#-- 初始化表的查询字段 -->
<#assign searchFields = FtlUtils.getJsonFieldInfoList(tableInfo, jsonParam.searchFields) />
<#-- 初始化表的批量查询字段 -->
<#assign batchSearchFields = FtlUtils.getJsonFieldInfoList(tableInfo, jsonParam.batchSearchFields) />
<#-- 初始化查询字段中的日期字段 -->
<#assign dateFieldInfo = FtlUtils.getFieldInfoByType(searchFields, "Date") />
<#-- 初始化需要生成检查字段值是否已存在的接口的字段 -->
<#assign checkValueExistedFieldInfos = FtlUtils.getJsonFieldInfoList(tableInfo, jsonParam.checkValueExistedFields) />
<#assign checkValueExistedFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.checkValueExistedFields) />
<#-- 初始化是否不生成SQL查询的接口 -->
<#assign isNoSqlTable = FtlUtils.tableExisted(tableInfo, jsonParam.noSqlTables) />
<#-- 初始化是否是使用缓存的表 -->
<#assign isUseCacheTable = FtlUtils.tableExisted(tableInfo, jsonParam.useCacheTables) />
<#-- 初始化需要导入导出Excel的字段 -->
<#assign importAndExportFields = FtlUtils.getJsonFieldInfoList(tableInfo, jsonParam.importAndExportFields) />
package ${jsonParam.packagePath}

<#if FtlUtils.fieldTypeExisted(searchFields, "Date")>
import cn.hutool.core.date.DateUtil;
</#if>
<#if checkValueExistedFieldInfos?has_content || tableInfo.pkLowerCamelName?has_content>
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
</#if>
<#if checkValueExistedFieldInfos?has_content>
import cn.hutool.core.util.BooleanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import ${jsonParam.basePackagePath}.common.util.Assert;
</#if>
<#if tableInfo.pkLowerCamelName?has_content>
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.Collections;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
</#if>
<#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
</#if>
<#if !tableInfo.pkIsStringType>
import java.util.Objects;
</#if>
<#if jsonParam.enableEasyExcel && importAndExportFields?has_content>
import cn.hutool.core.bean.BeanUtil;

import ${jsonParam.basePackagePath}.common.util.EasyExcelUtils;
import ${jsonParam.basePackagePath}.model.<#if jsonParam.moduleName?has_content>${jsonParam.moduleName}.</#if>excel.${tableInfo.upperCamelCase}Import;
</#if>
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import cn.hutool.core.util.StrUtil;
import cn.hutool.core.collection.CollUtil;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import ${jsonParam.basePackagePath}.model.<#if jsonParam.moduleName?has_content>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase};
import ${jsonParam.basePackagePath}.model.<#if jsonParam.moduleName?has_content>${jsonParam.moduleName}.</#if>condition.${tableInfo.upperCamelCase}Condition;
import ${jsonParam.basePackagePath}.mapper.<#if jsonParam.moduleName?has_content>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Mapper;

/**
 * ${FtlUtils.emptyToDefault(tableInfo.simpleRemark, "${tableInfo.tableName}表")}Service接口实现
 *
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
@Slf4j
@Service
@Transactional(readOnly = true)
<#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
@CacheConfig(cacheNames = "${tableInfo.lowerCamelCase}Cache")
</#if>
public class ${tableInfo.upperCamelCase}Service extends ServiceImpl<${tableInfo.upperCamelCase}Mapper, ${tableInfo.upperCamelCase}> {
    /**
     * 分页查询${tableInfo.simpleRemark}列表
     *
     * @param condition 查询条件
     * @return 分页数据
     */
<#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
    @Cacheable
</#if>
    public IPage<${tableInfo.upperCamelCase}> find${tableInfo.upperCamelCase}Page(${tableInfo.upperCamelCase}Condition condition) {
        IPage<${tableInfo.upperCamelCase}> page = condition.buildPage();
<#if isNoSqlTable>
        return this.page(page, getListQueryWrapper(condition));
<#else>
    <#if dateFieldInfo?has_content && dateFieldInfo.isDateTimeType>
        if (condition.get${dateFieldInfo.upperCamelCase}End() != null) {
            condition.set${dateFieldInfo.upperCamelCase}End(DateUtil.endOfDay(condition.get${dateFieldInfo.upperCamelCase}End()));
        }
    </#if>
        return this.baseMapper.find${tableInfo.upperCamelCase}List(page, condition);
</#if>
    }

    /**
     * 查询${tableInfo.simpleRemark}列表
     * 
     * @param condition ${tableInfo.simpleRemark}查询条件
     * @return 列表数据
     */
<#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
    @Cacheable
</#if>
    public List<${tableInfo.upperCamelCase}> find${tableInfo.upperCamelCase}List(${tableInfo.upperCamelCase}Condition condition) {
<#if isNoSqlTable>
        return this.list(getListQueryWrapper(condition));
<#else>
    <#if dateFieldInfo?has_content && dateFieldInfo.isDateTimeType>
        if (condition.get${dateFieldInfo.upperCamelCase}End() != null) {
            condition.set${dateFieldInfo.upperCamelCase}End(DateUtil.endOfDay(condition.get${dateFieldInfo.upperCamelCase}End()));
        }
    </#if>
        return this.baseMapper.find${tableInfo.upperCamelCase}List(condition);
</#if>
    }

    /**
     * 查询${tableInfo.simpleRemark}
     *
     * @param condition 查询条件
     * @return ${tableInfo.simpleRemark}
     */
<#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
    @Cacheable
</#if>
    public ${tableInfo.upperCamelCase} get${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase}Condition condition) {
        LambdaQueryWrapper<${tableInfo.upperCamelCase}> queryWrapper = condition.buildLambdaQueryWrapper();
    <#if searchFields?has_content>
        <#assign searchFieldList = FtlUtils.tableFieldFilter(searchFields, "IGNORE_DATE") />
        <#list searchFieldList as fieldInfo>
            <#if fieldInfo_index == 0>
        queryWrapper.eq(<#if fieldInfo.isStringType>StrUtil.isNotBlank(condition.get${fieldInfo.upperCamelCase}())<#else>condition.get${fieldInfo.upperCamelCase}() != null</#if>, ${tableInfo.upperCamelCase}::get${fieldInfo.upperCamelCase}, condition.get${fieldInfo.upperCamelCase}())<#if !fieldInfo_has_next>;</#if>
            <#else>
                .eq(<#if fieldInfo.isStringType>StrUtil.isNotBlank(condition.get${fieldInfo.upperCamelCase}())<#else>condition.get${fieldInfo.upperCamelCase}() != null</#if>, ${tableInfo.upperCamelCase}::get${fieldInfo.upperCamelCase}, condition.get${fieldInfo.upperCamelCase}())<#if !fieldInfo_has_next>;</#if>
            </#if>
        </#list>
    </#if>
        return this.getOne(queryWrapper, false);
    }
<#if tableInfo.pkLowerCamelName?has_content>

    /**
     * 根据主键ID查询${tableInfo.simpleRemark}
     *
     * @param ${tableInfo.pkLowerCamelName} ${tableInfo.pkRemark}
     * @return ${tableInfo.simpleRemark}
     */
    <#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
    @Cacheable
    </#if>
    public ${tableInfo.upperCamelCase} get${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        return this.getById(${tableInfo.pkLowerCamelName});
    }

    /**
     * 根据主键ID列表查询${tableInfo.simpleRemark}列表
     *
     * @param idList ${tableInfo.pkSimpleRemark}列表
     * @return 列表数据
     */
    <#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
    @Cacheable
    </#if>
    public List<${tableInfo.upperCamelCase}> find${tableInfo.upperCamelCase}ByIds(List<${tableInfo.pkJavaType}> idList) {
        if (CollUtil.isEmpty(idList)) {
            return Collections.emptyList();
        }
        LambdaQueryWrapper<${tableInfo.upperCamelCase}> queryWrapper = Wrappers.lambdaQuery();
        queryWrapper.in(${tableInfo.upperCamelCase}::get${tableInfo.pkUpperCamelName}, idList.stream().filter(<#if tableInfo.pkIsStringType>StrUtil::isNotBlank<#else>Objects::nonNull</#if>).distinct().collect(Collectors.toList()));
        return this.list(queryWrapper);
    }

    /**
     * 查询主键ID列表对应的${tableInfo.simpleRemark}集合
     *
     * @param idList ${tableInfo.pkSimpleRemark}列表
     * @return Map<${tableInfo.pkSimpleRemark}, ${tableInfo.simpleRemark}>
     */
    <#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
    @Cacheable
    </#if>
    public Map<${tableInfo.pkJavaType}, ${tableInfo.upperCamelCase}> map${tableInfo.upperCamelCase}ByIds(List<${tableInfo.pkJavaType}> idList) {
        List<${tableInfo.upperCamelCase}> list = find${tableInfo.upperCamelCase}ByIds(idList);
        return Optional.ofNullable(list).orElse(CollUtil.toList()).stream().collect(Collectors.toMap(${tableInfo.upperCamelCase}::get${tableInfo.pkUpperCamelName}, ${tableInfo.upperCamelCase} -> ${tableInfo.upperCamelCase}));
    }
</#if>
<#if checkValueExistedFieldInfos?has_content>

    /**
     * 检查${tableInfo.simpleRemark}是否存在
     *
     * @param ${tableInfo.lowerCamelCase} ${tableInfo.simpleRemark}
     * @return 是否存在
     */
    <#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
    @Cacheable
    </#if>
    public Boolean check${tableInfo.upperCamelCase}Existed(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        QueryWrapper<${tableInfo.upperCamelCase}> queryWrapper = Wrappers.query();
        queryWrapper.select("1").lambda()
    <#list checkValueExistedFieldInfos as fieldInfo>
                .eq(<#if fieldInfo.isStringType>StrUtil.isNotBlank(${tableInfo.lowerCamelCase}.get${fieldInfo.upperCamelCase}())<#else>${tableInfo.lowerCamelCase}.get${fieldInfo.upperCamelCase}() != null</#if>, ${tableInfo.upperCamelCase}::get${fieldInfo.upperCamelCase}, ${tableInfo.lowerCamelCase}.get${fieldInfo.upperCamelCase}())
    </#list>
    <#if tableInfo.pkUpperCamelName?has_content>
                .ne(<#if tableInfo.pkIsStringType>StrUtil.isNotBlank(${tableInfo.lowerCamelCase}.get${tableInfo.pkUpperCamelName}())<#else>${tableInfo.lowerCamelCase}.get${tableInfo.pkUpperCamelName}() != null</#if>, ${tableInfo.upperCamelCase}::get${tableInfo.pkUpperCamelName}, ${tableInfo.lowerCamelCase}.get${tableInfo.pkUpperCamelName}())
    </#if>
                .last("LIMIT 1");
        return BooleanUtil.toBoolean(this.getObj(queryWrapper, Object::toString));
    }
</#if>

    /**
     * 新增${tableInfo.simpleRemark}
     *
     * @param ${tableInfo.lowerCamelCase} ${tableInfo.simpleRemark}
     * @return 是否成功
     */
<#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
    @CacheEvict(allEntries = true)
</#if>
    @Transactional(rollbackFor = Exception.class)
    public Boolean add${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
<#if checkValueExistedFieldInfos?has_content>
        check${tableInfo.upperCamelCase}Valid(${tableInfo.lowerCamelCase});
</#if>
        return this.save(${tableInfo.lowerCamelCase});
    }

    /**
     * 修改${tableInfo.simpleRemark}
     *
     * @param ${tableInfo.lowerCamelCase} ${tableInfo.simpleRemark}
     * @return 是否成功
     */
<#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
    @CacheEvict(allEntries = true)
</#if>
    @Transactional(rollbackFor = Exception.class)
    public Boolean update${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
<#if checkValueExistedFieldInfos?has_content>
        check${tableInfo.upperCamelCase}Valid(${tableInfo.lowerCamelCase});
</#if>
        return this.updateById(${tableInfo.lowerCamelCase});
    }

    /**
     * 批量新增或修改${tableInfo.simpleRemark}列表
     *
     * @param ${tableInfo.lowerCamelCase}List ${tableInfo.simpleRemark}列表
     * @return 是否成功
     */
<#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
    @CacheEvict(allEntries = true)
</#if>
    @Transactional(rollbackFor = Exception.class)
    public Boolean batchSaveOrUpdate(List<${tableInfo.upperCamelCase}> ${tableInfo.lowerCamelCase}List) {
        if (CollUtil.isEmpty(${tableInfo.lowerCamelCase}List)) {
            return false;
        }
<#if checkValueExistedFieldInfos?has_content>
        ${tableInfo.lowerCamelCase}List.forEach(this::check${tableInfo.upperCamelCase}Valid);
</#if>
        return this.saveOrUpdateBatch(${tableInfo.lowerCamelCase}List);
    }
<#if tableInfo.pkLowerCamelName?has_content>

    /**
     * 根据主键ID删除${tableInfo.simpleRemark}
     *
     * @param ${tableInfo.pkLowerCamelName} ${tableInfo.pkRemark}
     * @return 是否成功
     */
    <#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
    @CacheEvict(allEntries = true)
    </#if>
    @Transactional(rollbackFor = Exception.class)
    public Boolean delete${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        return this.removeById(${tableInfo.pkLowerCamelName});
    }

    /**
     * 根据主键ID列表批量删除${tableInfo.simpleRemark}
     *
     * @param idList ${tableInfo.pkRemark}列表
     * @return 是否成功
     */
    <#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
    @CacheEvict(allEntries = true)
    </#if>
    @Transactional(rollbackFor = Exception.class)
    public Boolean delete${tableInfo.upperCamelCase}ByIds(List<${tableInfo.pkJavaType}> idList) {
        return this.removeByIds(idList);
    }
    <#if FtlUtils.fieldExisted(tableInfo, "is_enable")>

    /**
     * 启用或禁用${tableInfo.simpleRemark}
     *
     * @param idList ${tableInfo.pkRemark}列表
     * @param isEnable 是否启用，0：禁用；1：启用
     * @return 是否成功
     */
        <#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
    @CacheEvict(allEntries = true)
        </#if>
    @Transactional(rollbackFor = Exception.class)
    public Boolean enableOrDisable(List<${tableInfo.pkJavaType}> idList, Integer isEnable) {
        return this.lambdaUpdate().set(${tableInfo.upperCamelCase}::getIsEnable, isEnable)
                .in(${tableInfo.upperCamelCase}::get${tableInfo.pkUpperCamelName}, idList)
                .update();
    }
    </#if>
</#if>
<#if jsonParam.enableEasyExcel && importAndExportFields?has_content>

    /**
     * 导入${tableInfo.simpleRemark}
     *
     * @param dataList ${tableInfo.simpleRemark}数据列表
     * @return 报错数据列表
     */
    <#if isUseCacheTable && (jsonParam.enableEhCache || jsonParam.enableRedis)>
    @CacheEvict(allEntries = true)
    </#if>
    @Transactional(rollbackFor = Exception.class)
    public List<String> import${tableInfo.upperCamelCase}(List<${tableInfo.upperCamelCase}Import> dataList) {
        List<String> errorList = importExcelDataVerify(dataList);
        if (CollUtil.isNotEmpty(errorList)) {
            return errorList;
        }
        List<${tableInfo.upperCamelCase}> saveList = BeanUtil.copyToList(dataList, ${tableInfo.upperCamelCase}.class);
        this.saveBatch(saveList);
        return errorList;
    }
</#if>
<#if checkValueExistedFieldInfos?has_content>

    /**
     * 检查${tableInfo.simpleRemark}是否有效
     *
     * @param ${tableInfo.lowerCamelCase} ${tableInfo.simpleRemark}
     */
    private void check${tableInfo.upperCamelCase}Valid(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
    <#list checkValueExistedFieldInfos as fieldInfo>
        ${fieldInfo.javaType} ${fieldInfo.proName} = ${tableInfo.lowerCamelCase}.get${fieldInfo.upperCamelCase}();
        if (<#if fieldInfo.isStringType>StrUtil.isNotBlank(${fieldInfo.proName})<#else>${fieldInfo.proName} != null</#if>) {
            ${tableInfo.upperCamelCase} condition = ${tableInfo.upperCamelCase}.builder()<#if tableInfo.pkUpperCamelName?has_content>.${tableInfo.pkLowerCamelName}(${tableInfo.lowerCamelCase}.get${tableInfo.pkUpperCamelName}())</#if>.${fieldInfo.proName}(${fieldInfo.proName}).build();
            Boolean ${fieldInfo.proName}Existed = check${tableInfo.upperCamelCase}Existed(condition);
            Assert.isFalse(${fieldInfo.proName}Existed, "${fieldInfo.simpleRemark}已存在，请重新输入！");
        }
    </#list>
    }
</#if>
<#if isNoSqlTable>

    /**
     * 获取查询列表的QueryWrapper
     *
     * @param condition ${tableInfo.simpleRemark}查询条件
     * @return LambdaQueryWrapper
     */
    private LambdaQueryWrapper<${tableInfo.upperCamelCase}> getListQueryWrapper(${tableInfo.upperCamelCase}Condition condition) {
        LambdaQueryWrapper<${tableInfo.upperCamelCase}> queryWrapper = condition.buildLambdaQueryWrapper();
    <#if searchFields?has_content>
        <#assign searchFieldList = FtlUtils.tableFieldFilter(searchFields, "IGNORE_DATE") />
        <#assign orderByFieldExisted = FtlUtils.fieldExisted(tableInfo, "created_time") />
        <#assign queryWrapperExisted = false />
        <#list searchFieldList as fieldInfo>
            <#if fieldInfo_index == 0>
                <#assign queryWrapperExisted = true />
        queryWrapper.<#if fieldInfo.isStringType && !FtlUtils.strContainsAny(fieldInfo.colName, "_id") && !fieldInfo.isDictType>like<#else>eq</#if>(<#if fieldInfo.isStringType>StrUtil.isNotBlank(condition.get${fieldInfo.upperCamelCase}())<#else>condition.get${fieldInfo.upperCamelCase}() != null</#if>, ${tableInfo.upperCamelCase}::get${fieldInfo.upperCamelCase}, condition.get${fieldInfo.upperCamelCase}())<#if !fieldInfo_has_next && !dateFieldInfo?has_content && !batchSearchFields?has_content && !orderByFieldExisted>;</#if>
            <#else>
                .<#if fieldInfo.isStringType && !FtlUtils.strContainsAny(fieldInfo.colName, "_id") && !fieldInfo.isDictType>like<#else>eq</#if>(<#if fieldInfo.isStringType>StrUtil.isNotBlank(condition.get${fieldInfo.upperCamelCase}())<#else>condition.get${fieldInfo.upperCamelCase}() != null</#if>, ${tableInfo.upperCamelCase}::get${fieldInfo.upperCamelCase}, condition.get${fieldInfo.upperCamelCase}())<#if !fieldInfo_has_next && !dateFieldInfo?has_content && !batchSearchFields?has_content && !orderByFieldExisted>;</#if>
            </#if>
        </#list>
    </#if>
    <#if dateFieldInfo?has_content>
        <#if queryWrapperExisted>
                .ge(condition.get${dateFieldInfo.upperCamelCase}Begin() != null, ${tableInfo.upperCamelCase}::get${dateFieldInfo.upperCamelCase}, condition.get${dateFieldInfo.upperCamelCase}Begin())
                <#if dateFieldInfo.isDateTimeType>
                .lt(condition.get${dateFieldInfo.upperCamelCase}End() != null, ${tableInfo.upperCamelCase}::get${dateFieldInfo.upperCamelCase}, condition.get${dateFieldInfo.upperCamelCase}End() != null ? DateUtil.endOfDay(condition.get${dateFieldInfo.upperCamelCase}End()) : null)<#if !batchSearchFields?has_content && !orderByFieldExisted>;</#if>
                <#else>
                .le(condition.get${dateFieldInfo.upperCamelCase}End() != null, ${tableInfo.upperCamelCase}::get${dateFieldInfo.upperCamelCase}, condition.get${dateFieldInfo.upperCamelCase}End())<#if !batchSearchFields?has_content && !orderByFieldExisted>;</#if>
                </#if>
        <#else>
            <#assign queryWrapperExisted = true />
        queryWrapper.ge(condition.get${dateFieldInfo.upperCamelCase}Begin() != null, ${tableInfo.upperCamelCase}::get${dateFieldInfo.upperCamelCase}, condition.get${dateFieldInfo.upperCamelCase}Begin())
                <#if dateFieldInfo.isDateTimeType>
                .lt(condition.get${dateFieldInfo.upperCamelCase}End() != null, ${tableInfo.upperCamelCase}::get${dateFieldInfo.upperCamelCase}, condition.get${dateFieldInfo.upperCamelCase}End() != null ? DateUtil.endOfDay(condition.get${dateFieldInfo.upperCamelCase}End()) : null)<#if !batchSearchFields?has_content && !orderByFieldExisted>;</#if>
                <#else>
                .le(condition.get${dateFieldInfo.upperCamelCase}End() != null, ${tableInfo.upperCamelCase}::get${dateFieldInfo.upperCamelCase}, condition.get${dateFieldInfo.upperCamelCase}End())<#if !batchSearchFields?has_content && !orderByFieldExisted>;</#if>
                </#if>
        </#if>
    </#if>
    <#if batchSearchFields?has_content>
        <#list batchSearchFields as fieldInfo>
            <#if queryWrapperExisted>
                .in(CollUtil.isNotEmpty(condition.get${fieldInfo.upperCamelCase}List()), ${tableInfo.upperCamelCase}::get${fieldInfo.upperCamelCase}, condition.get${fieldInfo.upperCamelCase}List())<#if !fieldInfo_has_next && !orderByFieldExisted>;</#if>
            <#else>
                <#assign queryWrapperExisted = true />
        queryWrapper.in(CollUtil.isNotEmpty(condition.get${fieldInfo.upperCamelCase}List()), ${tableInfo.upperCamelCase}::get${fieldInfo.upperCamelCase}, condition.get${fieldInfo.upperCamelCase}List())<#if !fieldInfo_has_next && !orderByFieldExisted>;</#if>
            </#if>
        </#list>
    </#if>
    <#if orderByFieldExisted>
            <#if queryWrapperExisted>
                .orderByDesc(${tableInfo.upperCamelCase}::getCreatedTime);
            <#else>
        queryWrapper.orderByDesc(${tableInfo.upperCamelCase}::getCreatedTime);
            </#if>
    </#if>
        return queryWrapper;
    }
</#if>
<#if jsonParam.enableEasyExcel && importAndExportFields?has_content>

    /**
     * 导入Excel的业务数据校验
     *
     * @param dataList ${tableInfo.simpleRemark}数据列表
     * @return 报错数据列表
     */
    private List<String> importExcelDataVerify(List<${tableInfo.upperCamelCase}Import> dataList) {
        Map<String, String> valueMap = EasyExcelUtils.getExcelPropertyAnnotationValueMap(${tableInfo.upperCamelCase}Import.builder().build());
        List<String> errorList = CollUtil.toList();
        for (${tableInfo.upperCamelCase}Import data : dataList) {
            Integer rowNumber = data.getRowNumber();
    <#list importAndExportFields as fieldInfo>
        <#if fieldInfo.primaryKey><#continue></#if>
        <#if fieldInfo.isNotNull && FtlUtils.fieldExisted(fieldInfo, checkValueExistedFields)>
            String ${fieldInfo.lowerCamelCase} = data.get${fieldInfo.upperCamelCase}();
            if (<#if fieldInfo.isStringType>StrUtil.isBlank(${fieldInfo.lowerCamelCase})<#else>${fieldInfo.lowerCamelCase} == null</#if>) {
                errorList.add(String.format("第 %s 行，%s不能为空", rowNumber, valueMap.get("${fieldInfo.lowerCamelCase}")));
            } else if (check${tableInfo.upperCamelCase}Existed(${tableInfo.upperCamelCase}.builder().${fieldInfo.lowerCamelCase}(${fieldInfo.lowerCamelCase}).build())) {
                errorList.add(String.format("第 %s 行，%s已存在", rowNumber, valueMap.get("${fieldInfo.lowerCamelCase}")));
            }
        <#elseif fieldInfo.isNotNull>
            String ${fieldInfo.lowerCamelCase} = data.get${fieldInfo.upperCamelCase}();
            if (<#if fieldInfo.isStringType>StrUtil.isBlank(${fieldInfo.lowerCamelCase})<#else>${fieldInfo.lowerCamelCase} == null</#if>) {
                errorList.add(String.format("第 %s 行，%s不能为空", rowNumber, valueMap.get("${fieldInfo.lowerCamelCase}")));
            }
        <#elseif FtlUtils.fieldExisted(fieldInfo, checkValueExistedFields)>
            String ${fieldInfo.lowerCamelCase} = data.get${fieldInfo.upperCamelCase}();
            if (${fieldInfo.lowerCamelCase} != null && check${tableInfo.upperCamelCase}Existed(${tableInfo.upperCamelCase}.builder().${fieldInfo.lowerCamelCase}(${fieldInfo.lowerCamelCase}).build())) {
                errorList.add(String.format("第 %s 行，%s已存在", rowNumber, valueMap.get("${fieldInfo.lowerCamelCase}")));
            }
        </#if>
    </#list>
        }
        return errorList;
    }
</#if>
}