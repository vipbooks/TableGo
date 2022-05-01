package cn.tablego.project.springboot.controller;

import javax.validation.Valid;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import cn.tablego.project.springboot.common.controller.BaseController;
import cn.tablego.project.springboot.common.model.Paging;
import cn.tablego.project.springboot.common.model.Result;
import cn.tablego.project.springboot.model.SysParam;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;

/**
 * 系统参数服务
 * 
 * @author bianj
 * @version 1.0.0 2021-07-18
 */
@Slf4j
@Api(tags = "系统参数服务")
@RestController
@RequestMapping("/sysParam")
public class SysParamController extends BaseController {

    @ApiOperation(value = "分页查询系统参数列表")
    @PostMapping("/findSysParamPage")
    public Paging<SysParam> findSysParamPage() {
        log.info("分页查询系统参数列表");
        return new Paging<>();
    }

    @ApiOperation(value = "根据主键ID查询系统参数")
    @ApiImplicitParam(name = "id", value = "主键ID", required = true)
    @GetMapping(value = "/getSysParamById/{id}")
    public Result<SysParam> getSysParamById(@PathVariable String id) {
        log.info("根据主键ID查询系统参数: {}", id);
        SysParam sysParam = SysParam.newInstance().setId(id);
        return Result.ok(sysParam);
    }

    @ApiOperation(value = "新增系统参数")
    @ApiImplicitParam(name = "sysParam", value = "系统参数", required = true, dataType = "SysParam", paramType = "body")
    @PostMapping("/addSysParam")
    public Result<SysParam> addSysParam(@RequestBody @Valid SysParam sysParam) {
        log.info("新增系统参数: {}", sysParam);
        return Result.ok(sysParam);
    }

    @ApiOperation(value = "修改系统参数")
    @ApiImplicitParam(name = "sysParam", value = "系统参数", required = true, dataType = "SysParam", paramType = "body")
    @PutMapping(value = "/updateSysParam")
    public Result<Boolean> updateSysParam(@RequestBody SysParam sysParam) {
        log.info("修改系统参数: {}", sysParam);
        return Result.ok();
    }

    @ApiOperation(value = "根据主键ID删除系统参数")
    @ApiImplicitParam(name = "id", value = "主键ID", required = true)
    @DeleteMapping(value = "/deleteSysParamById/{id}")
    public Result<Boolean> deleteSysParamById(@PathVariable String id) {
        log.info("根据主键ID删除系统参数: {}", id);
        return Result.ok();
    }
}