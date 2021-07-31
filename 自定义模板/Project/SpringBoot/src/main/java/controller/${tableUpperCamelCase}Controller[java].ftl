package ${jsonParam.packagePath}

import java.util.List;
import javax.validation.Valid;

<#if FtlUtils.fieldSpecifyType(tableInfo, tableInfo.pkLowerCamelName, "String")>
import cn.hutool.core.util.StrUtil;
</#if>
import cn.hutool.core.collection.CollUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;

import ${jsonParam.basePackagePath}.common.BaseController;
import ${jsonParam.basePackagePath}.common.Paging;
import ${jsonParam.basePackagePath}.common.Result;
import ${jsonParam.basePackagePath}.model.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase};
import ${jsonParam.basePackagePath}.model.condition.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Condition;
import ${jsonParam.basePackagePath}.service.<#if jsonParam.moduleName??>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Service;

/**
 * ${tableInfo.simpleRemark}Controller
 * 
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@Api(tags = "${tableInfo.simpleRemark!tableInfo.tableName}服务")
@RestController
@RequestMapping("/${tableInfo.lowerCamelCase}")
public class ${tableInfo.upperCamelCase}Controller extends BaseController {
    @Autowired
    private ${tableInfo.upperCamelCase}Service ${tableInfo.lowerCamelCase}Service;

    @ApiOperation(value = "根据条件分页查询${tableInfo.simpleRemark}列表")
    @ApiImplicitParam(name = "condition", value = "${tableInfo.simpleRemark}查询条件", required = true, dataType = "${tableInfo.upperCamelCase}Condition", paramType = "body")
    @PostMapping("/find${tableInfo.upperCamelCase}Page")
    public Paging<${tableInfo.upperCamelCase}> find${tableInfo.upperCamelCase}Page(@RequestBody ${tableInfo.upperCamelCase}Condition condition) {
        IPage<${tableInfo.upperCamelCase}> page = ${tableInfo.lowerCamelCase}Service.find${tableInfo.upperCamelCase}Page(condition);
        return Paging.buildPaging(page);
    }

    @ApiOperation(value = "根据主键ID查询${tableInfo.simpleRemark}信息")
    @ApiImplicitParam(name = "${tableInfo.pkLowerCamelName}", value = "主键ID", required = true)
    @GetMapping(value = "/get${tableInfo.upperCamelCase}ById/{${tableInfo.pkLowerCamelName}}")
    public Result<${tableInfo.upperCamelCase}> get${tableInfo.upperCamelCase}ById(@PathVariable ${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        if (<#if tableInfo.pkJavaType == "String">StrUtil.isBlank(${tableInfo.pkLowerCamelName})<#else>${tableInfo.pkLowerCamelName} == null</#if>) {
            return Result.failed("请选择需要查询的数据！");
        }
        ${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase} = ${tableInfo.lowerCamelCase}Service.get${tableInfo.upperCamelCase}ById(${tableInfo.pkLowerCamelName});
        return Result.ok(${tableInfo.lowerCamelCase});
    }

    @ApiOperation(value = "新增${tableInfo.simpleRemark}信息")
    @ApiImplicitParam(name = "${tableInfo.lowerCamelCase}", value = "${tableInfo.simpleRemark}", required = true, dataType = "${tableInfo.upperCamelCase}", paramType = "body")
    @PostMapping("/add${tableInfo.upperCamelCase}")
    public Result<${tableInfo.upperCamelCase}> add${tableInfo.upperCamelCase}(@RequestBody @Valid ${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        Boolean bool = ${tableInfo.lowerCamelCase}Service.add${tableInfo.upperCamelCase}(${tableInfo.lowerCamelCase});
        if (bool) {
            return Result.ok(${tableInfo.lowerCamelCase});
        }
        return Result.failed();
    }

    @ApiOperation(value = "修改${tableInfo.simpleRemark}信息")
    @ApiImplicitParam(name = "${tableInfo.lowerCamelCase}", value = "${tableInfo.simpleRemark}", required = true, dataType = "${tableInfo.upperCamelCase}", paramType = "body")
    @PutMapping(value = "/update${tableInfo.upperCamelCase}")
    public Result<Boolean> update${tableInfo.upperCamelCase}(@RequestBody ${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        ${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName} = ${tableInfo.lowerCamelCase}.get${tableInfo.pkUpperCamelName}();
        if (<#if tableInfo.pkJavaType == "String">StrUtil.isBlank(${tableInfo.pkLowerCamelName})<#else>${tableInfo.pkLowerCamelName} == null</#if>) {
            return Result.failed("请选择需要修改的数据！");
        }
        Boolean bool = ${tableInfo.lowerCamelCase}Service.update${tableInfo.upperCamelCase}(${tableInfo.lowerCamelCase});
        return Result.okOrFailed(bool);
    }

    @ApiOperation(value = "根据主键ID删除${tableInfo.simpleRemark}")
    @ApiImplicitParam(name = "${tableInfo.pkLowerCamelName}", value = "主键ID", required = true)
    @DeleteMapping(value = "/delete${tableInfo.upperCamelCase}ById/{id}")
    public Result<Boolean> delete${tableInfo.upperCamelCase}ById(@PathVariable ${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        if (<#if tableInfo.pkJavaType == "String">StrUtil.isBlank(${tableInfo.pkLowerCamelName})<#else>${tableInfo.pkLowerCamelName} == null</#if>) {
            return Result.failed("请选择需要删除的数据！");
        }
        Boolean bool = ${tableInfo.lowerCamelCase}Service.delete${tableInfo.upperCamelCase}ById(${tableInfo.pkLowerCamelName});
        return Result.okOrFailed(bool);
    }

    @ApiOperation(value = "根据主键ID列表批量删除${tableInfo.simpleRemark}")
    @ApiImplicitParam(name = "idList", value = "主键ID列表", required = true, allowMultiple = true, paramType = "body")
    @DeleteMapping("/delete${tableInfo.upperCamelCase}ByIds")
    public Result<Boolean> delete${tableInfo.upperCamelCase}ByIds(@RequestBody List<${tableInfo.pkJavaType}> idList) {
        if (CollUtil.isEmpty(idList)) {
            return Result.failed("请选择需要删除的数据！");
        }
        Boolean bool = ${tableInfo.lowerCamelCase}Service.delete${tableInfo.upperCamelCase}ByIds(idList);
        return Result.okOrFailed(bool);
    }
}