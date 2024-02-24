<#-- 用于生成Controller的自定义模板 -->
<#-- 初始化需要导入导出Excel的字段 -->
<#assign importAndExportFields = FtlUtils.getJsonFieldList(tableInfo, jsonParam.importAndExportFields) />
package ${jsonParam.packagePath}

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.ui.Model;

import org.apache.shiro.authz.annotation.RequiresPermissions;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.StringUtils;
<#if FtlUtils.fieldAtListExisted(tableInfo, importAndExportFields)>
import com.ruoyi.common.utils.poi.ExcelUtil;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.bind.annotation.RequestPart;
import java.io.InputStream;
</#if>
import ${jsonParam.basePackagePath}.${jsonParam.moduleName}.domain.${tableInfo.upperCamelCase};
import ${jsonParam.basePackagePath}.${jsonParam.moduleName}.service.I${tableInfo.upperCamelCase}Service;

/**
 * ${FtlUtils.emptyToDefault(tableInfo.simpleRemark, "${tableInfo.tableName}表")}Controller
 * 
 * @author ${paramConfig.author}
 * @since  ${dateTime}
 */
@Api(tags = "${tableInfo.simpleRemark!tableInfo.tableName}")
@RestController
@RequestMapping("/${jsonParam.moduleName}/${tableInfo.lowerCamelCase}")
public class ${tableInfo.upperCamelCase}Controller extends BaseController {
    private String prefix = "${jsonParam.moduleName}/${tableInfo.lowerCamelCase}";

    @Autowired
    private I${tableInfo.upperCamelCase}Service ${tableInfo.lowerCamelCase}Service;

    /**
     * ${tableInfo.simpleRemark!tableInfo.tableName}主页面
     * 
     * @return ModelAndView
     */
    @RequiresPermissions("${jsonParam.moduleName}:${tableInfo.lowerCamelCase}:view")
    @GetMapping()
    public ModelAndView ${tableInfo.lowerCamelCase}() {
        return new ModelAndView(prefix + "/${tableInfo.lowerCamelCase}");
    }

    @RequiresPermissions("${jsonParam.moduleName}:${tableInfo.lowerCamelCase}:list")
    @ApiOperation(value = "分页查询${tableInfo.simpleRemark}列表")
    @PostMapping("/list")
    public TableDataInfo list(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        this.startPage();
        List<${tableInfo.upperCamelCase}> list = ${tableInfo.lowerCamelCase}Service.select${tableInfo.upperCamelCase}List(${tableInfo.lowerCamelCase});
        return getDataTable(list);
    }

    /**
     * 新增${tableInfo.simpleRemark!tableInfo.tableName}页面
     * 
     * @return ModelAndView
     */
    @RequiresPermissions("${jsonParam.moduleName}:${tableInfo.lowerCamelCase}:add")
    @GetMapping("/add")
    public ModelAndView add() {
        return new ModelAndView(prefix + "/add");
    }

    @RequiresPermissions("${jsonParam.moduleName}:${tableInfo.lowerCamelCase}:add")
    @Log(title = "${tableInfo.simpleRemark}", businessType = BusinessType.INSERT)
    @ApiOperation(value = "新增保存${tableInfo.simpleRemark}")
    @PostMapping("/add")
    public AjaxResult addSave(@Validated ${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        return toAjax(${tableInfo.lowerCamelCase}Service.insert${tableInfo.upperCamelCase}(${tableInfo.lowerCamelCase}));
    }

    /**
     * 修改${tableInfo.simpleRemark!tableInfo.tableName}页面
     * 
     * @return ModelAndView
     */
    @RequiresPermissions("${jsonParam.moduleName}:${tableInfo.lowerCamelCase}:edit")
    @GetMapping("/edit/{${tableInfo.pkLowerCamelName}}")
    public ModelAndView edit(@PathVariable ${tableInfo.pkJavaType} ${tableInfo.pkLowerCamelName}, Model model) {
        ${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase} = ${tableInfo.lowerCamelCase}Service.select${tableInfo.upperCamelCase}ById(${tableInfo.pkLowerCamelName});
        model.addAttribute("${tableInfo.lowerCamelCase}", ${tableInfo.lowerCamelCase});
        return new ModelAndView(prefix + "/edit");
    }

    @RequiresPermissions("${jsonParam.moduleName}:${tableInfo.lowerCamelCase}:edit")
    @Log(title = "${tableInfo.simpleRemark}", businessType = BusinessType.UPDATE)
    @ApiOperation(value = "修改保存${tableInfo.simpleRemark}")
    @PostMapping(value = "/edit")
    public AjaxResult editSave(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        return toAjax(${tableInfo.lowerCamelCase}Service.update${tableInfo.upperCamelCase}(${tableInfo.lowerCamelCase}));
    }

    @RequiresPermissions("${jsonParam.moduleName}:${tableInfo.lowerCamelCase}:remove")
    @Log(title = "${tableInfo.simpleRemark}", businessType = BusinessType.DELETE)
    @ApiOperation(value = "删除${tableInfo.simpleRemark}")
    @ApiImplicitParam(name = "ids", value = "${tableInfo.pkRemark}，多个用英文逗号分隔", required = true, paramType = "query")
    @PostMapping("/remove")
    public AjaxResult remove(String ids) {
        if (StringUtils.isBlank(ids)) {
            return AjaxResult.warn("请选择需要删除的数据！");
        }
        <#if tableInfo.pkIsStringType>
        List<String> idList = Stream.of(ids.split(",")).filter(StringUtils::isNotBlank).map(String::trim).distinct().collect(Collectors.toList());
        <#else>
        List<Long> idList = Stream.of(ids.split(",")).filter(StringUtils::isNotBlank).map(String::trim).map(Long::valueOf).distinct().collect(Collectors.toList());
        </#if>
        return toAjax(${tableInfo.lowerCamelCase}Service.delete${tableInfo.upperCamelCase}ByIds(idList));
    }
<#if FtlUtils.fieldAtListExisted(tableInfo, importAndExportFields)>

    @RequiresPermissions("${jsonParam.moduleName}:${tableInfo.lowerCamelCase}:export")
    @Log(title = "${tableInfo.simpleRemark}", businessType = BusinessType.EXPORT)
    @ApiOperation(value = "导出${tableInfo.simpleRemark}列表")
    @PostMapping("/export")
    public AjaxResult export(${tableInfo.upperCamelCase} ${tableInfo.lowerCamelCase}) {
        List<${tableInfo.upperCamelCase}> list = ${tableInfo.lowerCamelCase}Service.select${tableInfo.upperCamelCase}List(${tableInfo.lowerCamelCase});
        ExcelUtil<${tableInfo.upperCamelCase}> excelUtil = new ExcelUtil<>(${tableInfo.upperCamelCase}.class);
        return excelUtil.exportExcel(list, "${tableInfo.simpleRemark}");
    }

    @RequiresPermissions("${jsonParam.moduleName}:${tableInfo.lowerCamelCase}:import")
    @ApiOperation(value = "下载${tableInfo.simpleRemark}模板")
    @GetMapping("/downloadTemplate")
    public AjaxResult downloadTemplate() {
        ExcelUtil<${tableInfo.upperCamelCase}> excelUtil = new ExcelUtil<>(${tableInfo.upperCamelCase}.class);
        return excelUtil.importTemplateExcel("${tableInfo.simpleRemark}");
    }

    @RequiresPermissions("${jsonParam.moduleName}:${tableInfo.lowerCamelCase}:import")
    @Log(title = "${tableInfo.simpleRemark}", businessType = BusinessType.IMPORT)
    @ApiOperation(value = "导入${tableInfo.simpleRemark}")
    @PostMapping("/import")
    public AjaxResult import${tableInfo.upperCamelCase}(@RequestPart("file") MultipartFile file, Boolean updateSupport) {
        if (file == null || file.isEmpty()) {
            return AjaxResult.error("导入文件不能为空");
        }
        ExcelUtil<${tableInfo.upperCamelCase}> excelUtil = new ExcelUtil<>(${tableInfo.upperCamelCase}.class);
        try(InputStream is = file.getInputStream()) {
            List<${tableInfo.upperCamelCase}> ${tableInfo.lowerCamelCase}List = excelUtil.importExcel(is);

            // TODO 业务处理

            return AjaxResult.success("导入${tableInfo.simpleRemark}成功");
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
        return AjaxResult.error("导入${tableInfo.simpleRemark}失败");
    }
</#if>
}