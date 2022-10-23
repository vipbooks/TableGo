<#-- 用于生成Controller的自定义模板 -->
package ${jsonParam.packagePath}

<#if FtlUtils.fieldSpecifyType(tableInfo, tableInfo.pkLowerCamelName, "String")>
import org.apache.commons.lang3.StringUtils;
</#if>
import java.util.List;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.data.domain.Page;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;

import ${jsonParam.basePackagePath}.common.BaseController;
import ${jsonParam.basePackagePath}.common.Paging;

import ${jsonParam.basePackagePath}.model.${tableInfo.upperCamelCase};
import ${jsonParam.basePackagePath}.model.condition.${tableInfo.upperCamelCase}Condition;
import ${jsonParam.basePackagePath}.service.${tableInfo.upperCamelCase}Service;

/**
 * ${tableInfo.simpleRemark!tableInfo.tableName}Controller
 * 
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@Api(tags = "${tableInfo.simpleRemark!tableInfo.tableName}")
@RestController
@RequestMapping("/${tableInfo.lowerCamelCase}")
public class ${tableInfo.upperCamelCase}Controller extends BaseController {
    @Autowired
    private ${tableInfo.upperCamelCase}Service ${tableInfo.lowerCamelCase}Service;

    @ApiOperation(value = "分页查询${tableInfo.simpleRemark}列表")
    @ApiImplicitParam(name = "condition", value = "${tableInfo.simpleRemark}查询条件", required = true, dataType = "${tableInfo.upperCamelCase}Condition", paramType = "body")
    @PostMapping("/list${tableInfo.upperCamelCase}Page")
    public PageQueryResult<${tableInfo.upperCamelCase}> list${tableInfo.upperCamelCase}Page(@RequestBody ${tableInfo.upperCamelCase}Condition condition) {
        Page<${tableInfo.upperCamelCase}> page = ${tableInfo.lowerCamelCase}Service.list${tableInfo.upperCamelCase}Page(condition);
        return new Paging<>(condition.getPageSize(), condition.getPage(), page.getTotalElements(), page.getTotalPages(), page.getContent());
    }

    @ApiOperation(value = "根据主键ID查询${tableInfo.simpleRemark}")
    @ApiImplicitParam(name = "${tableInfo.pkLowerCamelName}", value = "${tableInfo.pkRemark}", required = true, dataType = "${tableInfo.pkJavaType?uncap_first}", paramType = "query")
    @PostMapping("/get${tableInfo.upperCamelCase}ById")
    public ${tableInfo.upperCamelCase} get${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        if (<#if tableInfo.pkJavaType == "String">StringUtils.isBlank(${tableInfo.pkLowerCamelName})<#else>${tableInfo.pkLowerCamelName} == null</#if>) {
            return null;
        }
        return ${tableInfo.lowerCamelCase}Service.get${tableInfo.upperCamelCase}ById(${tableInfo.pkLowerCamelName});
    }

    @ApiOperation(value = "新增${tableInfo.simpleRemark}")
    @ApiImplicitParam(name = "${tableInfo.lowerCamelCase}", value = "${tableInfo.simpleRemark}", required = true, dataType = "${tableInfo.upperCamelCase}", paramType = "body")
    @PostMapping("/save${tableInfo.upperCamelCase}")
    public ${tableInfo.upperCamelCase} save${tableInfo.upperCamelCase}(@RequestBody ${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        return ${tableInfo.lowerCamelCase}Service.save${tableInfo.upperCamelCase}(${tableInfo.lowerCamelCase});
    }

    @ApiOperation(value = "修改${tableInfo.simpleRemark}")
    @ApiImplicitParam(name = "${tableInfo.lowerCamelCase}", value = "${tableInfo.simpleRemark}", required = true, dataType = "${tableInfo.upperCamelCase}", paramType = "body")
    @PostMapping("/update${tableInfo.upperCamelCase}")
    public Boolean update${tableInfo.upperCamelCase}(@RequestBody ${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        return ${tableInfo.lowerCamelCase}Service.update${tableInfo.upperCamelCase}(${tableInfo.lowerCamelCase});
    }

    @ApiOperation(value = "根据主键ID删除${tableInfo.simpleRemark}")
    @ApiImplicitParam(name = "${tableInfo.pkLowerCamelName}", value = "${tableInfo.pkRemark}", required = true, dataType = "${tableInfo.pkJavaType?uncap_first}", paramType = "query")
    @PostMapping("/delete${tableInfo.upperCamelCase}ById")
    public Boolean delete${tableInfo.upperCamelCase}ById(${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        if (<#if tableInfo.pkJavaType == "String">StringUtils.isBlank(${tableInfo.pkLowerCamelName})<#else>${tableInfo.pkLowerCamelName} == null</#if>) {
            return false;
        }
        return ${tableInfo.lowerCamelCase}Service.delete${tableInfo.upperCamelCase}ById(${tableInfo.pkLowerCamelName});
    }

    @ApiOperation(value = "根据主键ID列表批量删除${tableInfo.simpleRemark}")
    @ApiImplicitParam(name = "idList", value = "${tableInfo.pkRemark}列表", required = true, paramType = "body", allowMultiple = true)
    @PostMapping("/delete${tableInfo.upperCamelCase}ByIds")
    public Boolean delete${tableInfo.upperCamelCase}ByIds(@RequestBody List<${tableInfo.pkJavaType}> idList) {
        if (CollectionUtils.isEmpty(idList)) {
            return false;
        }
        return ${tableInfo.lowerCamelCase}Service.delete${tableInfo.upperCamelCase}ByIds(idList);
    }
}