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
import cn.tablego.project.springboot.model.Department;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;

/**
 * 部门服务
 * 
 * @author bianj
 * @version 1.0.0 2021-07-18
 */
@Slf4j
@Api(tags = "部门服务")
@RestController
@RequestMapping("/department")
public class DepartmentController extends BaseController {

    @ApiOperation(value = "分页查询部门列表")
    @PostMapping("/findDepartmentPage")
    public Paging<Department> findDepartmentPage() {
        log.info("分页查询部门列表");
        return new Paging<>();
    }

    @ApiOperation(value = "根据主键ID查询部门")
    @ApiImplicitParam(name = "id", value = "主键ID", required = true)
    @GetMapping(value = "/getDepartmentById/{id}")
    public Result<Department> getDepartmentById(@PathVariable String id) {
        log.info("根据主键ID查询部门: {}", id);
        Department department = Department.newInstance().setId(id);
        return Result.ok(department);
    }

    @ApiOperation(value = "新增部门")
    @ApiImplicitParam(name = "department", value = "部门", required = true, dataType = "Department", paramType = "body")
    @PostMapping("/addDepartment")
    public Result<Department> addDepartment(@RequestBody @Valid Department department) {
        log.info("新增部门: {}", department);
        return Result.ok(department);
    }

    @ApiOperation(value = "修改部门")
    @ApiImplicitParam(name = "department", value = "部门", required = true, dataType = "Department", paramType = "body")
    @PutMapping(value = "/updateDepartment")
    public Result<Boolean> updateDepartment(@RequestBody Department department) {
        log.info("修改部门: {}", department);
        return Result.ok();
    }

    @ApiOperation(value = "根据主键ID删除部门")
    @ApiImplicitParam(name = "id", value = "主键ID", required = true)
    @DeleteMapping(value = "/deleteDepartmentById/{id}")
    public Result<Boolean> deleteDepartmentById(@PathVariable String id) {
        log.info("根据主键ID删除部门: {}", id);
        return Result.ok();
    }
}