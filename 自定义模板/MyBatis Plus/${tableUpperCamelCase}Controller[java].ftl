<#-- 用于生成Controller的自定义模板 -->
package ${jsonParam.packagePath}

import java.util.List;

<#if FtlUtils.fieldSpecifyType(tableInfo, tableInfo.pkLowerCamelName, "String")>
import org.apache.commons.lang3.StringUtils;
</#if>
import org.apache.commons.collections4.CollectionUtils;
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

    @ApiOperation(value = "根据参数分页查询${tableInfo.simpleRemark}列表")
    @ApiImplicitParam(name = "condition", value = "${tableInfo.simpleRemark}查询条件", required = true, dataType = "${tableInfo.upperCamelCase}Condition", paramType = "body")
    @PostMapping("/list")
    public Paging<${tableInfo.upperCamelCase}> list(@RequestBody ${tableInfo.upperCamelCase}Condition condition) {
        IPage<${tableInfo.upperCamelCase}> page = ${tableInfo.lowerCamelCase}Service.find${tableInfo.upperCamelCase}ByCondition(condition);
        return Paging.buildPaging(page);
    }

    @ApiOperation(value = "根据主键ID查询${tableInfo.simpleRemark}信息")
    @ApiImplicitParam(name = "${tableInfo.pkLowerCamelName}", value = "主键ID", required = true)
    @GetMapping(value = "/get/{${tableInfo.pkLowerCamelName}}")
    public Result<${tableInfo.upperCamelCase}> get(@PathVariable ${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        if (<#if tableInfo.pkJavaType == "String">StringUtils.isBlank(${tableInfo.pkLowerCamelName})<#else>${tableInfo.pkLowerCamelName} == null</#if>) {
            return Result.failed("请选择需要查询的数据！");
        }
        ${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase} = ${tableInfo.lowerCamelCase}Service.get${tableInfo.upperCamelCase}ById(${tableInfo.pkLowerCamelName});
        return Result.ok(${tableInfo.lowerCamelCase});
    }

    @ApiOperation(value = "新增${tableInfo.simpleRemark}信息")
    @ApiImplicitParam(name = "${tableInfo.lowerCamelCase}", value = "${tableInfo.simpleRemark}", required = true, dataType = "${tableInfo.upperCamelCase}", paramType = "body")
    @PostMapping("/add")
    public Result<${tableInfo.upperCamelCase}> add(@RequestBody ${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        Boolean bool = ${tableInfo.lowerCamelCase}Service.add${tableInfo.upperCamelCase}(${tableInfo.lowerCamelCase});
        if (bool) {
            return Result.ok(${tableInfo.lowerCamelCase});
        }
        return Result.failed();
    }

    @ApiOperation(value = "修改${tableInfo.simpleRemark}信息")
    @ApiImplicitParam(name = "${tableInfo.lowerCamelCase}", value = "${tableInfo.simpleRemark}", required = true, dataType = "${tableInfo.upperCamelCase}", paramType = "body")
    @PutMapping(value = "/update")
    public Result<Boolean> update(@RequestBody ${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        ${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName} = ${tableInfo.lowerCamelCase}.get${tableInfo.pkUpperCamelName}();
        if (<#if tableInfo.pkJavaType == "String">StringUtils.isBlank(${tableInfo.pkLowerCamelName})<#else>${tableInfo.pkLowerCamelName} == null</#if>) {
            return Result.failed("请选择需要修改的数据！");
        }
        Boolean bool = ${tableInfo.lowerCamelCase}Service.update${tableInfo.upperCamelCase}(${tableInfo.lowerCamelCase});
        return Result.okOrFailed(bool);
    }

    @ApiOperation(value = "根据主键ID删除${tableInfo.simpleRemark}")
    @ApiImplicitParam(name = "${tableInfo.pkLowerCamelName}", value = "主键ID", required = true)
    @DeleteMapping(value = "/delete/{id}")
    public Result<Boolean> delete(@PathVariable ${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        if (<#if tableInfo.pkJavaType == "String">StringUtils.isBlank(${tableInfo.pkLowerCamelName})<#else>${tableInfo.pkLowerCamelName} == null</#if>) {
            return Result.failed("请选择需要删除的数据！");
        }
        Boolean bool = ${tableInfo.lowerCamelCase}Service.delete${tableInfo.upperCamelCase}ById(${tableInfo.pkLowerCamelName});
        return Result.okOrFailed(bool);
    }

    @ApiOperation(value = "根据主键ID列表批量删除${tableInfo.simpleRemark}")
    @ApiImplicitParam(name = "idList", value = "主键ID列表", required = true, allowMultiple = true, paramType = "body")
    @DeleteMapping("/deleteList")
    public Result<Boolean> deleteList(@RequestBody List<${tableInfo.pkJavaType}> idList) {
        if (CollectionUtils.isEmpty(idList)) {
            return Result.failed("请选择需要删除的数据！");
        }
        Boolean bool = ${tableInfo.lowerCamelCase}Service.delete${tableInfo.upperCamelCase}ByIds(idList);
        return Result.okOrFailed(bool);
    }
}