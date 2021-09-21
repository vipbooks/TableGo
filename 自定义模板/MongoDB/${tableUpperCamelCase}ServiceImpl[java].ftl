<#-- 用于生成Service接口实现的自定义模板 -->
<#-- 初始化表的查询字段 -->
<#assign searchFeilds = FtlUtils.getJsonFieldList(tableInfo, jsonParam.searchFeilds) />
package ${jsonParam.packagePath}

import java.util.List;
import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.repository.support.PageableExecutionUtils;
import ${jsonParam.basePackagePath}.model.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase};
import ${jsonParam.basePackagePath}.model.condition.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Condition;
import ${jsonParam.basePackagePath}.service.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Service;
<#if FtlUtils.fieldTypeAtListExisted(tableInfo, searchFeilds, "Date")>
import cn.hutool.core.date.DateUtil;
</#if>

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
        Criteria criteria = Criteria.where("deleteFlag").is("1");
    <#if searchFeilds?has_content>

        <#list tableInfo.fieldInfos as fieldInfo>
            <#list searchFeilds as fieldName>
                <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>
                    <#if fieldInfo.javaType == "Date">
        if (condition.get${fieldInfo.upperCamelCase}Begin() != null && condition.get${fieldInfo.upperCamelCase}End() != null) {
            criteria.and("${fieldInfo.lowerCamelCase}").gte(condition.get${fieldInfo.upperCamelCase}Begin()).lte(DateUtil.endOfDay(condition.get${fieldInfo.upperCamelCase}End()));
        } else if (condition.get${fieldInfo.upperCamelCase}Begin() != null) {
            criteria.and("${fieldInfo.lowerCamelCase}").gte(condition.get${fieldInfo.upperCamelCase}Begin());
        } else if (condition.get${fieldInfo.upperCamelCase}End() != null) {
            criteria.and("${fieldInfo.lowerCamelCase}").lte(DateUtil.endOfDay(condition.get${fieldInfo.upperCamelCase}End()));
        }
                    <#elseif fieldInfo.javaType != "String">
        if (condition.get${fieldInfo.upperCamelCase}() != null) {
            criteria.and("${fieldInfo.lowerCamelCase}").is(condition.get${fieldInfo.upperCamelCase}());
        }
                    <#elseif fieldInfo.primaryKey || fieldInfo.isDictType || fieldInfo.lowerColName?index_of("_id") != -1>
        if (StringUtils.isNotBlank(condition.get${fieldInfo.upperCamelCase}())) {
            criteria.and("${fieldInfo.lowerCamelCase}").is(condition.get${fieldInfo.upperCamelCase}());
        }
                    <#else>
        if (StringUtils.isNotBlank(condition.get${fieldInfo.upperCamelCase}())) {
            criteria.and("${fieldInfo.lowerCamelCase}").regex(Pattern.compile("^.*" + condition.get${fieldInfo.upperCamelCase}() + ".*$", Pattern.CASE_INSENSITIVE));
        }
                    </#if>
                </#if>
            </#list>
        </#list>
    </#if>
        query.addCriteria(criteria);

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