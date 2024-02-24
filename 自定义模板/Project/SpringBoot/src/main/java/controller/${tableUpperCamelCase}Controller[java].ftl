<#-- 初始化需要导入导出Excel的字段 -->
<#assign importAndExportFields = FtlUtils.getJsonFieldInfoList(tableInfo, jsonParam.importAndExportFields) />
<#-- 初始化需要生成检查字段值是否已存在的接口的字段 -->
<#assign checkValueExistedFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.checkValueExistedFields) />
package ${jsonParam.packagePath}

<#if jsonParam.enableSwagger>
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
</#if>
import java.util.List;
import javax.validation.Valid;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Autowired;

import com.baomidou.mybatisplus.core.metadata.IPage;
<#if jsonParam.enableEasyExcel && importAndExportFields?has_content>
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.core.collection.CollUtil;
import java.util.Map;

import ${jsonParam.basePackagePath}.common.util.EasyExcelUtils;
import ${jsonParam.basePackagePath}.model.<#if jsonParam.moduleName?has_content>${jsonParam.moduleName}.</#if>excel.${tableInfo.upperCamelCase}Export;
import ${jsonParam.basePackagePath}.model.<#if jsonParam.moduleName?has_content>${jsonParam.moduleName}.</#if>excel.${tableInfo.upperCamelCase}Import;
</#if>

import ${jsonParam.basePackagePath}.common.controller.BaseController;
import ${jsonParam.basePackagePath}.common.model.Paging;
import ${jsonParam.basePackagePath}.common.model.Result;
import ${jsonParam.basePackagePath}.common.util.Assert;

import ${jsonParam.basePackagePath}.model.<#if jsonParam.moduleName?has_content>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase};
import ${jsonParam.basePackagePath}.model.<#if jsonParam.moduleName?has_content>${jsonParam.moduleName}.</#if>condition.${tableInfo.upperCamelCase}Condition;
import ${jsonParam.basePackagePath}.service.<#if jsonParam.moduleName?has_content>${jsonParam.moduleName}.</#if>${tableInfo.upperCamelCase}Service;

/**
 * ${tableInfo.simpleRemark!tableInfo.tableName}Controller
 * 
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
<#if jsonParam.enableSwagger>
@Api(tags = "${tableInfo.simpleRemark!tableInfo.tableName}")
</#if>
@RestController
@RequestMapping("/${tableInfo.lowerCamelCase}")
public class ${tableInfo.upperCamelCase}Controller extends BaseController {
    @Autowired
    private ${tableInfo.upperCamelCase}Service ${tableInfo.lowerCamelCase}Service;

<#if !jsonParam.enableSwagger>
    /**
     * 分页查询${tableInfo.simpleRemark}列表
     *
     * @param condition ${tableInfo.simpleRemark}查询条件
     * @return 分页数据
     */
<#else>
    @ApiOperation(value = "分页查询${tableInfo.simpleRemark}列表")
    @ApiImplicitParam(name = "condition", value = "${tableInfo.simpleRemark}查询条件", required = true, dataType = "${tableInfo.upperCamelCase}Condition", paramType = "body")
</#if>
    @PostMapping("/find${tableInfo.upperCamelCase}Page")
    public Paging<${tableInfo.upperCamelCase}> find${tableInfo.upperCamelCase}Page(@RequestBody ${tableInfo.upperCamelCase}Condition condition) {
        IPage<${tableInfo.upperCamelCase}> page = ${tableInfo.lowerCamelCase}Service.find${tableInfo.upperCamelCase}Page(condition);
        return Paging.buildPaging(page);
    }

<#if !jsonParam.enableSwagger>
    /**
     * 查询${tableInfo.simpleRemark}列表
     *
     * @param condition ${tableInfo.simpleRemark}查询条件
     * @return 列表数据
     */
<#else>
    @ApiOperation(value = "查询${tableInfo.simpleRemark}列表")
    @ApiImplicitParam(name = "condition", value = "${tableInfo.simpleRemark}查询条件", required = true, dataType = "${tableInfo.upperCamelCase}Condition", paramType = "body")
</#if>
    @PostMapping("/find${tableInfo.upperCamelCase}List")
    public Result<List<${tableInfo.upperCamelCase}>> find${tableInfo.upperCamelCase}List(@RequestBody ${tableInfo.upperCamelCase}Condition condition) {
        List<${tableInfo.upperCamelCase}> list = ${tableInfo.lowerCamelCase}Service.find${tableInfo.upperCamelCase}List(condition);
        return Result.ok(list);
    }
<#if tableInfo.pkLowerCamelName?has_content>

    <#if !jsonParam.enableSwagger>
    /**
     * 根据主键ID查询${tableInfo.simpleRemark}
     *
     * @param ${tableInfo.pkLowerCamelName} ${tableInfo.pkRemark}
     * @return 结果数据
     */
    <#else>
    @ApiOperation(value = "根据主键ID查询${tableInfo.simpleRemark}")
    @ApiImplicitParam(name = "${tableInfo.pkLowerCamelName}", value = "${tableInfo.pkRemark}", required = true)
    </#if>
    @GetMapping(value = "/get${tableInfo.upperCamelCase}ById/{${tableInfo.pkLowerCamelName}}")
    public Result<${tableInfo.upperCamelCase}> get${tableInfo.upperCamelCase}ById(@PathVariable ${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        ${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase} = ${tableInfo.lowerCamelCase}Service.get${tableInfo.upperCamelCase}ById(${tableInfo.pkLowerCamelName});
        return Result.ok(${tableInfo.lowerCamelCase});
    }
</#if>

<#if !jsonParam.enableSwagger>
    /**
     * 新增${tableInfo.simpleRemark}
     *
     * @param ${tableInfo.lowerCamelCase} ${tableInfo.simpleRemark}
     * @return 结果数据
     */
<#else>
    @ApiOperation(value = "新增${tableInfo.simpleRemark}")
    @ApiImplicitParam(name = "${tableInfo.lowerCamelCase}", value = "${tableInfo.simpleRemark}", required = true, dataType = "${tableInfo.upperCamelCase}", paramType = "body")
</#if>
    @PostMapping("/add${tableInfo.upperCamelCase}")
    public Result<${tableInfo.upperCamelCase}> add${tableInfo.upperCamelCase}(@RequestBody @Valid ${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        Boolean bool = ${tableInfo.lowerCamelCase}Service.add${tableInfo.upperCamelCase}(${tableInfo.lowerCamelCase});
        if (bool) {
            return Result.ok(${tableInfo.lowerCamelCase});
        }
        return Result.failed();
    }

<#if !jsonParam.enableSwagger>
    /**
     * 修改${tableInfo.simpleRemark}
     *
     * @param ${tableInfo.lowerCamelCase} ${tableInfo.simpleRemark}
     * @return 结果数据
     */
<#else>
    @ApiOperation(value = "修改${tableInfo.simpleRemark}")
    @ApiImplicitParam(name = "${tableInfo.lowerCamelCase}", value = "${tableInfo.simpleRemark}", required = true, dataType = "${tableInfo.upperCamelCase}", paramType = "body")
</#if>
    @PutMapping(value = "/update${tableInfo.upperCamelCase}")
    public Result<Boolean> update${tableInfo.upperCamelCase}(@RequestBody ${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
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

    <#if !jsonParam.enableSwagger>
    /**
     * 根据主键ID删除${tableInfo.simpleRemark}
     *
     * @param ${tableInfo.pkLowerCamelName} ${tableInfo.pkRemark}
     * @return 结果数据
     */
    <#else>
    @ApiOperation(value = "根据主键ID删除${tableInfo.simpleRemark}")
    @ApiImplicitParam(name = "${tableInfo.pkLowerCamelName}", value = "${tableInfo.pkRemark}", required = true)
    </#if>
    @DeleteMapping(value = "/delete${tableInfo.upperCamelCase}ById/{id}")
    public Result<Boolean> delete${tableInfo.upperCamelCase}ById(@PathVariable ${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}) {
        Boolean bool = ${tableInfo.lowerCamelCase}Service.delete${tableInfo.upperCamelCase}ById(${tableInfo.pkLowerCamelName});
        return Result.okOrFailed(bool);
    }

    <#if !jsonParam.enableSwagger>
    /**
     * 根据主键ID列表批量删除${tableInfo.simpleRemark}
     *
     * @param idList ${tableInfo.pkRemark}列表
     * @return 结果数据
     */
    <#else>
    @ApiOperation(value = "根据主键ID列表批量删除${tableInfo.simpleRemark}")
    @ApiImplicitParam(name = "idList", value = "${tableInfo.pkRemark}列表", required = true, allowMultiple = true, paramType = "body")
    </#if>
    @DeleteMapping("/delete${tableInfo.upperCamelCase}ByIds")
    public Result<Boolean> delete${tableInfo.upperCamelCase}ByIds(@RequestBody List<${tableInfo.pkJavaType}> idList) {
        Assert.isNotEmpty(idList, "请选择需要删除的数据！");
        Boolean bool = ${tableInfo.lowerCamelCase}Service.delete${tableInfo.upperCamelCase}ByIds(idList);
        return Result.okOrFailed(bool);
    }
</#if>
<#if jsonParam.enableEasyExcel && importAndExportFields?has_content>

    @ApiOperation(value = "导入${tableInfo.simpleRemark}")
    @ApiImplicitParam(name = "file", value = "Excel文件", required = true, dataType = "__file")
    @PostMapping("/import${tableInfo.upperCamelCase}")
    public Result<Object> import${tableInfo.upperCamelCase}(@RequestPart("file") MultipartFile file) {
        Result<Object> result = Result.ok();
        EasyExcelUtils.importExcel(file, ${tableInfo.upperCamelCase}Import.class, dataList -> {
            List<String> errorList = excelImportVerify(dataList);
            if (CollUtil.isNotEmpty(errorList)) {
                result.setFailed(errorList);
                return;
            }
            List<${tableInfo.upperCamelCase}> list = BeanUtil.copyToList(dataList, ${tableInfo.upperCamelCase}.class);
            ${tableInfo.lowerCamelCase}Service.saveBatch(list);
        });
        return result;
    }

    @ApiOperation(value = "下载${tableInfo.simpleRemark}模板")
    @GetMapping("/downExcelTemplate")
    public void downExcelTemplate() {
        EasyExcelUtils.exportEmptyExcel("${tableInfo.simpleRemark}模板", ${tableInfo.upperCamelCase}Import.class, response);
    }

    @ApiOperation(value = "导出${tableInfo.simpleRemark}")
    @ApiImplicitParam(name = "condition", value = "${tableInfo.simpleRemark}查询条件", required = true, dataType = "${tableInfo.upperCamelCase}Condition", paramType = "body")
    @PostMapping("/export${tableInfo.upperCamelCase}")
    public void export${tableInfo.upperCamelCase}(@RequestBody ${tableInfo.upperCamelCase}Condition condition) {
        List<${tableInfo.upperCamelCase}> list = ${tableInfo.lowerCamelCase}Service.find${tableInfo.upperCamelCase}List(condition);
        List<${tableInfo.upperCamelCase}Export> dataList = BeanUtil.copyToList(list, ${tableInfo.upperCamelCase}Export.class);
        EasyExcelUtils.exportExcel("${tableInfo.simpleRemark}", dataList, ${tableInfo.upperCamelCase}Export.class, response);
    }

    /**
     * Excel导入业务数据校验
     *
     * @param dataList ${tableInfo.simpleRemark}导入参数列表
     * @return 报错数据列表
     */
    private List<String> excelImportVerify(List<${tableInfo.upperCamelCase}Import> dataList) {
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
            } else if (${tableInfo.lowerCamelCase}Service.check${tableInfo.upperCamelCase}Existed(${tableInfo.upperCamelCase}.builder().${fieldInfo.lowerCamelCase}(${fieldInfo.lowerCamelCase}).build())) {
                errorList.add(String.format("第 %s 行，%s已存在", rowNumber, valueMap.get("${fieldInfo.lowerCamelCase}")));
            }
            <#elseif fieldInfo.isNotNull>
            String ${fieldInfo.lowerCamelCase} = data.get${fieldInfo.upperCamelCase}();
            if (<#if fieldInfo.isStringType>StrUtil.isBlank(${fieldInfo.lowerCamelCase})<#else>${fieldInfo.lowerCamelCase} == null</#if>) {
                errorList.add(String.format("第 %s 行，%s不能为空", rowNumber, valueMap.get("${fieldInfo.lowerCamelCase}")));
            }
            <#elseif FtlUtils.fieldExisted(fieldInfo, checkValueExistedFields)>
            String ${fieldInfo.lowerCamelCase} = data.get${fieldInfo.upperCamelCase}();
            if (${fieldInfo.lowerCamelCase} != null && ${tableInfo.lowerCamelCase}Service.check${tableInfo.upperCamelCase}Existed(${tableInfo.upperCamelCase}.builder().${fieldInfo.lowerCamelCase}(${fieldInfo.lowerCamelCase}).build())) {
                errorList.add(String.format("第 %s 行，%s已存在", rowNumber, valueMap.get("${fieldInfo.lowerCamelCase}")));
            }
        </#if>
    </#list>
        }
        return errorList;
    }
</#if>
}