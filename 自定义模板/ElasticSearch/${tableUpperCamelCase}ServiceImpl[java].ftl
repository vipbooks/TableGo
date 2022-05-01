<#-- 用于生成Service接口实现的自定义模板 -->
<#-- 初始化表的查询字段 -->
<#assign searchFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.searchFields) />
package ${jsonParam.packagePath}

import java.util.List;
import java.util.Date;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.elasticsearch.core.ElasticsearchTemplate;
import org.springframework.data.elasticsearch.core.query.GetQuery;
import org.springframework.data.elasticsearch.core.query.IndexQuery;
import org.springframework.data.elasticsearch.core.query.IndexQueryBuilder;
import org.springframework.data.elasticsearch.core.query.NativeSearchQueryBuilder;
import org.springframework.data.elasticsearch.core.query.SearchQuery;
<#if FtlUtils.fieldTypeAtListExisted(tableInfo, searchFields, "Date")>
import cn.hutool.core.date.DateUtil;
</#if>
import ${jsonParam.basePackagePath}.model.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase};
import ${jsonParam.basePackagePath}.model.condition.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Condition;
import ${jsonParam.basePackagePath}.service.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Service;

/**
 * ${tableInfo.simpleRemark}Service接口实现
 * 
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@Service
public class ${tableInfo.upperCamelCase}ServiceImpl implements ${tableInfo.upperCamelCase}Service {
    @Autowired
    private ElasticsearchTemplate elasticsearchTemplate;

    @Override
    public Page<${tableInfo.upperCamelCase}> list${tableInfo.upperCamelCase}Page(${tableInfo.upperCamelCase}Condition condition) {
        BoolQueryBuilder queryBuilder = QueryBuilders.boolQuery();
    <#if searchFields?has_content>

        <#list tableInfo.fieldInfos as fieldInfo>
            <#list searchFields as fieldName>
                <#if FtlUtils.fieldEquals(fieldInfo, fieldName)>
                    <#if fieldInfo.javaType == "Date">
        if (condition.get${fieldInfo.upperCamelCase}Begin() != null && condition.get${fieldInfo.upperCamelCase}End() != null) {
            String ${fieldInfo.lowerCamelCase}BeginStr = DateUtil.format(condition.get${fieldInfo.upperCamelCase}Begin(), DatePattern.NORM_DATE_PATTERN);
            String ${fieldInfo.lowerCamelCase}EndStr = DateUtil.format(DateUtil.endOfDay(condition.get${fieldInfo.upperCamelCase}End()), DatePattern.NORM_DATETIME_FORMAT);
            queryBuilder.must(QueryBuilders.rangeQuery("${fieldInfo.lowerCamelCase}").gte(${fieldInfo.lowerCamelCase}BeginStr).lte(${fieldInfo.lowerCamelCase}EndStr));
        } else if (condition.get${fieldInfo.upperCamelCase}Begin() != null) {
            String ${fieldInfo.lowerCamelCase}BeginStr = DateUtil.format(condition.get${fieldInfo.upperCamelCase}Begin(), DatePattern.NORM_DATE_PATTERN);
            queryBuilder.must(QueryBuilders.rangeQuery("${fieldInfo.lowerCamelCase}").gte(${fieldInfo.lowerCamelCase}BeginStr));
        } else if (condition.get${fieldInfo.upperCamelCase}End() != null) {
            String ${fieldInfo.lowerCamelCase}EndStr = DateUtil.format(DateUtil.endOfDay(condition.get${fieldInfo.upperCamelCase}End()), DatePattern.NORM_DATETIME_FORMAT);
            queryBuilder.must(QueryBuilders.rangeQuery("${fieldInfo.lowerCamelCase}").lte(${fieldInfo.lowerCamelCase}EndStr));
        }
                    <#elseif fieldInfo.javaType != "String">
        if (condition.get${fieldInfo.upperCamelCase}() != null) {
            queryBuilder.must(QueryBuilders.termQuery("${fieldInfo.lowerCamelCase}", condition.get${fieldInfo.upperCamelCase}()));
        }
                    <#elseif fieldInfo.primaryKey || fieldInfo.isDictType || fieldInfo.lowerColName?index_of("_id") != -1>
        if (StringUtils.isNotBlank(condition.get${fieldInfo.upperCamelCase}())) {
            queryBuilder.must(QueryBuilders.termQuery("${fieldInfo.lowerCamelCase}", condition.get${fieldInfo.upperCamelCase}()));
        }
                    <#else>
        if (StringUtils.isNotBlank(condition.get${fieldInfo.upperCamelCase}())) {
            queryBuilder.must(QueryBuilders.wildcardQuery("${fieldInfo.lowerCamelCase}", "*" + condition.get${fieldInfo.upperCamelCase}() + "*"));
        }
                    </#if>
                </#if>
            </#list>
        </#list>
    </#if>
        Pageable pageable = PageRequest.of(condition.getPage().intValue() - 1, condition.getRows().intValue(), Sort.by(Sort.Direction.DESC, "createTime"));

        SearchQuery searchQuery = new NativeSearchQueryBuilder()
                .withIndices("${tableInfo.lowerTableName}")
                .withQuery(queryBuilder)
                .withPageable(pageable)
                .build();

        return elasticsearchTemplate.queryForPage(searchQuery, ${tableInfo.upperCamelCase}.class);
    }

    @Override
    public ${tableInfo.upperCamelCase} get${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        ${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase} = elasticsearchTemplate.queryForObject(GetQuery.getById(${tableInfo.pkLowerCamelName}), ${tableInfo.upperCamelCase}.class);
        return ${tableInfo.lowerCamelCase};
    }

    @Override
    public Boolean save${tableInfo.upperCamelCase}(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        IndexQuery indexQuery = new IndexQueryBuilder()
                .withId(${tableInfo.lowerCamelCase}.get${tableInfo.pkUpperCamelName}())
                .withObject(${tableInfo.lowerCamelCase})
                .build();
        elasticsearchTemplate.index(indexQuery);
        return true;
    }

    @Override
    public Boolean batchSave${tableInfo.upperCamelCase}(List<${tableInfo.upperCamelCase}> ${tableInfo.lowerCamelCase}List) {
        List<IndexQuery> indexQueryList = new ArrayList<>();
        for (${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase} : ${tableInfo.lowerCamelCase}List) {
            IndexQuery indexQuery = new IndexQueryBuilder()
                    .withId(${tableInfo.lowerCamelCase}.get${tableInfo.pkUpperCamelName}())
                    .withObject(${tableInfo.lowerCamelCase})
                    .build();
            indexQueryList.add(indexQuery);
        }
        elasticsearchTemplate.bulkIndex(indexQueryList);
        return true;
    }

    @Override
    public Boolean delete${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        elasticsearchTemplate.delete(${tableInfo.upperCamelCase}.class, ${tableInfo.pkLowerCamelName});
        return true;
    }

    @Override
    public Boolean delete${tableInfo.upperCamelCase}ByIds(List<${tableInfo.pkJavaType}> idList) {
        idList.forEach(id -> delete${tableInfo.upperCamelCase}ById(idList));
        return true;
    }

    @Override
    public Boolean create${tableInfo.upperCamelCase}Index() {
        return elasticsearchTemplate.createIndex(${tableInfo.upperCamelCase}.class);
    }

    @Override
    public Boolean putMapping${tableInfo.upperCamelCase}Index() {
        return elasticsearchTemplate.putMapping(${tableInfo.upperCamelCase}.class);
    }

    @Override
    public Boolean delete${tableInfo.upperCamelCase}Index() {
        return elasticsearchTemplate.deleteIndex(${tableInfo.upperCamelCase}.class);
    }
}