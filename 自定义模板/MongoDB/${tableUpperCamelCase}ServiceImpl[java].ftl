<#-- 用于生成Service接口实现的自定义模板 -->
<#-- 初始化表的查询字段 -->
<#assign searchFields = FtlUtils.getJsonFieldInfoList(tableInfo, jsonParam.searchFields) />
package ${jsonParam.packagePath}

<#if FtlUtils.fieldTypeExisted(searchFields, "Date")>
import cn.hutool.core.date.DateUtil;
</#if>
import java.util.List;
import java.util.Date;
import org.apache.commons.lang3.StringUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.repository.support.PageableExecutionUtils;

import ${jsonParam.basePackagePath}.model.${tableInfo.upperCamelCase};
import ${jsonParam.basePackagePath}.model.condition.${tableInfo.upperCamelCase}Condition;
import ${jsonParam.basePackagePath}.service.${tableInfo.upperCamelCase}Service;

/**
 * ${tableInfo.simpleRemark}Service接口实现
 * 
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@Service
public class ${tableInfo.upperCamelCase}ServiceImpl implements ${tableInfo.upperCamelCase}Service {
    @Autowired
    private MongoTemplate mongoTemplate;

    @Override
    public Page<${tableInfo.upperCamelCase}> list${tableInfo.upperCamelCase}Page(${tableInfo.upperCamelCase}Condition condition) {
        Query query = new Query();
        <#if FtlUtils.fieldExisted(tableInfo, "DELETE_FLAG")>
        query.addCriteria(Criteria.where("DELETE_FLAG").is("1"));
        </#if>
    <#if searchFields?has_content>

        <#list searchFields as fieldInfo>
            <#if fieldInfo.isDateType>
        if (condition.get${fieldInfo.upperCamelCase}Begin() != null && condition.get${fieldInfo.upperCamelCase}End() != null) {
            Criteria criteria = Criteria.where("${fieldInfo.colName}").gte(condition.get${fieldInfo.upperCamelCase}Begin()).lte(DateUtil.endOfDay(condition.get${fieldInfo.upperCamelCase}End()));
            query.addCriteria(criteria);
        } else if (condition.get${fieldInfo.upperCamelCase}Begin() != null) {
            Criteria criteria = Criteria.where("${fieldInfo.colName}").gte(condition.get${fieldInfo.upperCamelCase}Begin());
            query.addCriteria(criteria);
        } else if (condition.get${fieldInfo.upperCamelCase}End() != null) {
            Criteria criteria = Criteria.where("${fieldInfo.colName}").lte(DateUtil.endOfDay(condition.get${fieldInfo.upperCamelCase}End()));
            query.addCriteria(criteria);
        }
            <#elseif !fieldInfo.isStringType>
        if (condition.get${fieldInfo.upperCamelCase}() != null) {
            Criteria criteria = Criteria.where("${fieldInfo.colName}").is(condition.get${fieldInfo.upperCamelCase}());
            query.addCriteria(criteria);
        }
            <#elseif fieldInfo.primaryKey || fieldInfo.isDictType || fieldInfo.lowerColName?index_of("_id") != -1>
        if (StrUtil.isNotBlank(condition.get${fieldInfo.upperCamelCase}())) {
            Criteria criteria = Criteria.where("${fieldInfo.colName}").is(condition.get${fieldInfo.upperCamelCase}());
            query.addCriteria(criteria);
        }
            <#else>
        if (StrUtil.isNotBlank(condition.get${fieldInfo.upperCamelCase}())) {
            Criteria criteria = Criteria.where("${fieldInfo.colName}").regex(Pattern.compile("^.*" + condition.get${fieldInfo.upperCamelCase}() + ".*$", Pattern.CASE_INSENSITIVE));
            query.addCriteria(criteria);
        }
            </#if>
        </#list>
    </#if>

        long totalCount = mongoTemplate.count(query, ${tableInfo.upperCamelCase}.class);
        Pageable pageable = PageRequest.of(condition.getPage().intValue() - 1, condition.getRows().intValue(), Sort.by(Sort.Direction.DESC, "createTime"));
        List<${tableInfo.upperCamelCase}> result = mongoTemplate.find(query.with(pageable), ${tableInfo.upperCamelCase}.class);

        return PageableExecutionUtils.getPage(result, pageable, () -> totalCount);
    }

    @Override
    public ${tableInfo.upperCamelCase} get${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        ${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase} = mongoTemplate.findById(${tableInfo.pkLowerCamelName}, ${tableInfo.upperCamelCase}.class);
        return ${tableInfo.lowerCamelCase};
    }

    @Override
    public ${tableInfo.upperCamelCase} save${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        return mongoTemplate.save(${tableInfo.lowerCamelCase});
    }

    @Override
    public Boolean update${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        mongoTemplate.save(${tableInfo.lowerCamelCase});
        return true;
    }

    @Override
    public Boolean delete${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        ${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase} = mongoTemplate.findById(${tableInfo.pkLowerCamelName}, ${tableInfo.upperCamelCase}.class);
        if(${tableInfo.lowerCamelCase} == null) {
            return false;
        }
        DeleteResult result = mongoTemplate.remove(${tableInfo.lowerCamelCase});
        return result.getDeletedCount() > 0;
    }

    @Override
    public Boolean delete${tableInfo.upperCamelCase}ByIds(List<${tableInfo.pkJavaType}> idList) {
        idList.forEach(this::delete${tableInfo.upperCamelCase}ById);
        return true;
    }
}