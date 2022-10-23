<#-- 用于生成Controller的自定义模板 -->
package ${jsonParam.packagePath}

import java.util.List;
import com.github.pagehelper.PageInfo;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Autowired;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;

import ${jsonParam.basePackagePath}.common.BaseController;
import ${jsonParam.basePackagePath}.common.Paging;
import ${jsonParam.basePackagePath}.common.Result;
import ${jsonParam.basePackagePath}.common.util.Assert;

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
    @PostMapping("/findPage")
    public Paging<${tableInfo.upperCamelCase}> findPage(@RequestBody ${tableInfo.upperCamelCase}Condition condition) {
        PageInfo<${tableInfo.upperCamelCase}> pageInfo = ${tableInfo.lowerCamelCase}Service.find${tableInfo.upperCamelCase}Page(condition);
        return Paging.buildPaging(pageInfo);
    }

    @ApiOperation(value = "查询${tableInfo.simpleRemark}列表")
    @ApiImplicitParam(name = "condition", value = "${tableInfo.simpleRemark}查询条件", required = true, dataType = "${tableInfo.upperCamelCase}Condition", paramType = "body")
    @PostMapping("/findList")
    public Result<${tableInfo.upperCamelCase}> findList(@RequestBody ${tableInfo.upperCamelCase}Condition condition) {
        List<${tableInfo.upperCamelCase}> list = ${tableInfo.lowerCamelCase}Service.find${tableInfo.upperCamelCase}List(condition);
        return Result.ok(list);
    }
<#if tableInfo.pkLowerCamelName?has_content>

    @ApiOperation(value = "根据主键ID查询${tableInfo.simpleRemark}")
    @ApiImplicitParam(name = "${tableInfo.pkLowerCamelName}", value = "${tableInfo.pkRemark}", required = true)
    @GetMapping(value = "/get/{${tableInfo.pkLowerCamelName}}")
    public Result<${tableInfo.upperCamelCase}> get(@PathVariable ${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        ${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase} = ${tableInfo.lowerCamelCase}Service.get${tableInfo.upperCamelCase}ById(${tableInfo.pkLowerCamelName});
        return Result.ok(${tableInfo.lowerCamelCase});
    }
</#if>

    @ApiOperation(value = "新增${tableInfo.simpleRemark}")
    @ApiImplicitParam(name = "${tableInfo.lowerCamelCase}", value = "${tableInfo.simpleRemark}", required = true, dataType = "${tableInfo.upperCamelCase}", paramType = "body")
    @PostMapping("/add")
    public Result<${tableInfo.upperCamelCase}> add(@RequestBody ${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        Boolean bool = ${tableInfo.lowerCamelCase}Service.add${tableInfo.upperCamelCase}(${tableInfo.lowerCamelCase});
        if (bool) {
            return Result.ok(${tableInfo.lowerCamelCase});
        }
        return Result.failed();
    }

    @ApiOperation(value = "修改${tableInfo.simpleRemark}")
    @ApiImplicitParam(name = "${tableInfo.lowerCamelCase}", value = "${tableInfo.simpleRemark}", required = true, dataType = "${tableInfo.upperCamelCase}", paramType = "body")
    @PutMapping(value = "/update")
    public Result<Boolean> update(@RequestBody ${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        Boolean bool = ${tableInfo.lowerCamelCase}Service.update${tableInfo.upperCamelCase}(${tableInfo.lowerCamelCase});
        return Result.okOrFailed(bool);
    }
<#if tableInfo.pkLowerCamelName?has_content>

    @ApiOperation(value = "根据主键ID删除${tableInfo.simpleRemark}")
    @ApiImplicitParam(name = "${tableInfo.pkLowerCamelName}", value = "${tableInfo.pkRemark}", required = true)
    @DeleteMapping(value = "/delete/{id}")
    public Result<Boolean> delete(@PathVariable ${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        Boolean bool = ${tableInfo.lowerCamelCase}Service.delete${tableInfo.upperCamelCase}ById(${tableInfo.pkLowerCamelName});
        return Result.okOrFailed(bool);
    }

    @ApiOperation(value = "批量删除${tableInfo.simpleRemark}")
    @ApiImplicitParam(name = "idList", value = "${tableInfo.pkRemark}列表", required = true, allowMultiple = true, paramType = "body")
    @DeleteMapping("/deleteList")
    public Result<Boolean> deleteList(@RequestBody List<${tableInfo.pkJavaType}> idList) {
        Assert.isNotEmpty(idList, "请选择需要删除的数据！");
        <#if FtlUtils.fieldExisted(tableInfo, "DELETE_FLAG")>
        Boolean bool = ${tableInfo.lowerCamelCase}Service.delete${tableInfo.upperCamelCase}LogicByIds(idList);
        <#else>
        Boolean bool = ${tableInfo.lowerCamelCase}Service.delete${tableInfo.upperCamelCase}ByIds(idList);
        </#if>
        return Result.okOrFailed(bool);
    }
</#if>
}