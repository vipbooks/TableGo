<#-- 生成Controller -->
package ${jsonParam.packagePath}

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;

import java.util.List;
import javax.validation.Valid;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import common.bean.Paging;
import common.bean.ResultJsonWrap;
import common.controller.BaseController;

import entity.${jsonParam.moduleName}.${tableInfo.upperCamelCase}Entity;
import ${jsonParam.moduleName}.service.${tableInfo.upperCamelCase}Service;

/**
 * ${tableInfo.simpleRemark}管理模块Controller
 * 
 * @author ${paramConfig.author}
 * @version 1.0.0 ${today}
 */
@Api(tags = { "${tableInfo.simpleRemark}管理模块" })
@Lazy
@RestController
@RequestMapping(value = "/${jsonParam.moduleName}/${tableInfo.lowerCamelCase}")
public class ${tableInfo.upperCamelCase}Controller extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(${tableInfo.upperCamelCase}Controller.class);

	@Autowired
	private ${tableInfo.upperCamelCase}Service ${tableInfo.lowerCamelCase}Service;
	
    /**
     * 根据参数查询${tableInfo.simpleRemark}列表和分页数据
     * 
     * @param ${tableInfo.lowerCamelCase}
     *            查询参数
     * @param paging
     *            分页参数
     * @return 分页数据
     */
    @ApiOperation(value = "根据参数查询${tableInfo.simpleRemark}列表和分页数据", notes = "根据参数查询${tableInfo.simpleRemark}列表和分页数据")
	@PostMapping(value = "/list")
	public Paging<${tableInfo.upperCamelCase}Entity> list(${tableInfo.upperCamelCase}Entity ${tableInfo.lowerCamelCase}, Paging<${tableInfo.upperCamelCase}Entity> paging) {
		paging.clearRows();

		try {
			${tableInfo.lowerCamelCase}Service.find${tableInfo.upperCamelCase}ByCondition(${tableInfo.lowerCamelCase}, paging);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			paging.setExceptionMsg(e.getMessage());
		}

		return paging;
	}

    /**
     * 根据主键ID查询${tableInfo.simpleRemark}数据
     * 
     * @param id
     *            主键ID
     * @return 结果数据
     */
    @ApiOperation(value = "根据主键ID查询${tableInfo.simpleRemark}数据", notes = "根据主键ID查询${tableInfo.simpleRemark}数据")
    @ApiImplicitParam(name = "id", value = "主键ID", required = true)
    @PostMapping(value = "/findById/{id}")
    public ResultJsonWrap<${tableInfo.upperCamelCase}Entity> findById(@PathVariable ${tableInfo.pkJavaType} id) {
        if (StringUtils.isBlank(id)) {
            return ResultJsonWrap.failed("请选择需要查询的数据！");
        }

        try {
            ${tableInfo.upperCamelCase}Entity ${tableInfo.lowerCamelCase} = ${tableInfo.lowerCamelCase}Service.find${tableInfo.upperCamelCase}ById(id);
            return ResultJsonWrap.ok(null, ${tableInfo.lowerCamelCase});
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            return ResultJsonWrap.error("查询${tableInfo.simpleRemark}数据失败！", e);
        }
    }

    /**
     * 新增${tableInfo.simpleRemark}
     * 
     * @param ${tableInfo.lowerCamelCase}
     *            ${tableInfo.simpleRemark}参数
     * @return 结果数据
     */
    @ApiOperation(value = "新增${tableInfo.simpleRemark}", notes = "新增${tableInfo.simpleRemark}")
    @PostMapping(value = "/add")
    public ResultJsonWrap<String> add(@Valid ${tableInfo.upperCamelCase}Entity ${tableInfo.lowerCamelCase}) {
        try {
            ${tableInfo.lowerCamelCase}Service.add${tableInfo.upperCamelCase}(${tableInfo.lowerCamelCase});
            return ResultJsonWrap.ok("新增${tableInfo.simpleRemark}成功！");
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            return ResultJsonWrap.error("新增${tableInfo.simpleRemark}失败！", e);
        }
    }

    /**
     * 修改${tableInfo.simpleRemark}
     * 
     * @param ${tableInfo.lowerCamelCase}
     *            ${tableInfo.simpleRemark}参数
     * @return 结果数据
     */
    @ApiOperation(value = "修改${tableInfo.simpleRemark}", notes = "修改${tableInfo.simpleRemark}")
    @PostMapping(value = "/modify")
    public ResultJsonWrap<String> modify(@Valid ${tableInfo.upperCamelCase}Entity ${tableInfo.lowerCamelCase}) {
        ${tableInfo.pkJavaType} id = ${tableInfo.lowerCamelCase}.getId();
        if (<#if tableInfo.pkJavaType == "String">StringUtils.isBlank(id)<#else>id == null</#if>) {
            return ResultJsonWrap.failed("请选择需要修改的数据！");
        }

        try {
            ${tableInfo.lowerCamelCase}Service.modify${tableInfo.upperCamelCase}(${tableInfo.lowerCamelCase});
            return ResultJsonWrap.ok("修改${tableInfo.simpleRemark}成功！");
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            return ResultJsonWrap.error("修改${tableInfo.simpleRemark}失败！", e);
        }
    }

    /**
     * 批量删除${tableInfo.simpleRemark}
     * 
     * @param idList
     *            ID列表
     * @return 结果数据
     */
    @ApiOperation(value = "批量删除${tableInfo.simpleRemark}", notes = "批量删除${tableInfo.simpleRemark}")
    @ApiImplicitParam(name = "idList", value = "ID列表", allowMultiple = true)
    @PostMapping(value = "/deleteList")
    public ResultJsonWrap<String> deleteList(@RequestBody List<${tableInfo.pkJavaType}> idList) {
        if (CollectionUtils.isEmpty(idList)) {
            return ResultJsonWrap.failed("请选择需要删除的数据！");
        }

        try {
            ${tableInfo.lowerCamelCase}Service.delete${tableInfo.upperCamelCase}ByIds(idList);
            return ResultJsonWrap.ok("删除${tableInfo.simpleRemark}成功！");
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            return ResultJsonWrap.error("删除${tableInfo.simpleRemark}失败！", e);
        }
    }
}