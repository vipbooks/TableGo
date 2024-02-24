<#-- 用于生成Controller的自定义模板 -->
package ${jsonParam.packagePath}

import java.util.List;
import javax.validation.Valid;
import com.baomidou.mybatisplus.core.metadata.IPage;

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

import ${jsonParam.basePackagePath}.common.controller.BaseController;
import ${jsonParam.basePackagePath}.common.model.Paging;
import ${jsonParam.basePackagePath}.common.model.Result;
import ${jsonParam.basePackagePath}.common.util.Assert;

import ${jsonParam.basePackagePath}.model.${tableInfo.upperCamelCase};
import ${jsonParam.basePackagePath}.model.condition.${tableInfo.upperCamelCase}Condition;
import ${jsonParam.basePackagePath}.service.${tableInfo.upperCamelCase}Service;

/**
 * ${FtlUtils.emptyToDefault(tableInfo.simpleRemark, "${tableInfo.tableName}表")}Controller
 * 
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
@Api(tags = "${FtlUtils.emptyToDefault(tableInfo.simpleRemark, "${tableInfo.tableName}")}")
@RestController
@RequestMapping("/${tableInfo.lowerCamelCase}")
public class ${tableInfo.upperCamelCase}Controller extends BaseController {
    @Autowired
    private ${tableInfo.upperCamelCase}Service ${tableInfo.lowerCamelCase}Service;

    @ApiOperation(value = "分页查询${tableInfo.simpleRemark}列表")
    @ApiImplicitParam(name = "condition", value = "${tableInfo.simpleRemark}查询条件", required = true, dataType = "${tableInfo.upperCamelCase}Condition", paramType = "body")
    @PostMapping("/findPage")
    public Paging<${tableInfo.upperCamelCase}> findPage(@RequestBody ${tableInfo.upperCamelCase}Condition condition) {
        IPage<${tableInfo.upperCamelCase}> page = ${tableInfo.lowerCamelCase}Service.find${tableInfo.upperCamelCase}Page(condition);
        return Paging.buildPaging(page);
    }

    @ApiOperation(value = "查询${tableInfo.simpleRemark}列表")
    @ApiImplicitParam(name = "condition", value = "${tableInfo.simpleRemark}查询条件", required = true, dataType = "${tableInfo.upperCamelCase}Condition", paramType = "body")
    @PostMapping("/findList")
    public Result<List<${tableInfo.upperCamelCase}>> findList(@RequestBody ${tableInfo.upperCamelCase}Condition condition) {
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
    public Result<${tableInfo.upperCamelCase}> add(@RequestBody @Valid ${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
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
        <#if tableInfo.pkUpperCamelName?has_content>
            <#if tableInfo.pkIsStringType>
        Assert.isNotBlank(${tableInfo.lowerCamelCase}.get${tableInfo.pkUpperCamelName}(), "请选择需要修改的数据！");
            <#else>
        Assert.isNotNull(${tableInfo.lowerCamelCase}.get${tableInfo.pkUpperCamelName}(), "请选择需要修改的数据！");
            </#if>
        </#if>
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

    @ApiOperation(value = "根据主键ID列表批量删除${tableInfo.simpleRemark}")
    @ApiImplicitParam(name = "idList", value = "${tableInfo.pkRemark}列表", required = true, allowMultiple = true, paramType = "body")
    @DeleteMapping("/deleteList")
    public Result<Boolean> deleteList(@RequestBody List<${tableInfo.pkJavaType}> idList) {
        Assert.isNotEmpty(idList, "请选择需要删除的数据！");
        Boolean bool = ${tableInfo.lowerCamelCase}Service.delete${tableInfo.upperCamelCase}ByIds(idList);
        return Result.okOrFailed(bool);
    }
</#if>
}