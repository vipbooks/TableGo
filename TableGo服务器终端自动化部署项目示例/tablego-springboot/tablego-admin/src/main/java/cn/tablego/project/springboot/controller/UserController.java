package cn.tablego.project.springboot.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Value;
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
import cn.tablego.project.springboot.model.User;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;

/**
 * 用户服务
 *
 * @author bianj
 * @version 1.0.0 2021-09-26
 */
@Slf4j
@Api(tags = "用户服务")
@RestController
@RequestMapping("/user")
public class UserController extends BaseController {
    @Value(value = "${spring.application.name}")
    private String appName;

    @ApiOperation(value = "分页查询用户列表")
    @PostMapping("/findUserPage")
    public Paging<User> findUserPage() {
        log.info("[{}] [{}] 分页查询用户列表", getServerHost(), appName);
        return new Paging<>();
    }

    @ApiOperation(value = "根据主键ID查询用户")
    @ApiImplicitParam(name = "id", value = "主键ID", required = true)
    @GetMapping(value = "/getUserById/{id}")
    public Result<User> getUserById(@PathVariable String id) {
        log.info("[{}] [{}] 根据主键ID查询用户: {}", getServerHost(), appName, id);
        User user = User.newInstance().setId(id);
        return Result.ok(user);
    }

    @ApiOperation(value = "新增用户")
    @ApiImplicitParam(name = "user", value = "用户", required = true, dataType = "User", paramType = "body")
    @PostMapping("/addUser")
    public Result<User> addUser(@RequestBody @Valid User user) {
        log.info("[{}] [{}] 新增用户: {}", getServerHost(), appName, user);
        return Result.ok(user);
    }

    @ApiOperation(value = "修改用户")
    @ApiImplicitParam(name = "user", value = "用户", required = true, dataType = "User", paramType = "body")
    @PutMapping(value = "/updateUser")
    public Result<Boolean> updateUser(@RequestBody User user) {
        log.info("[{}] [{}] 修改用户: {}", getServerHost(), appName, user);
        return Result.ok();
    }

    @ApiOperation(value = "根据主键ID删除用户")
    @ApiImplicitParam(name = "id", value = "主键ID", required = true)
    @DeleteMapping(value = "/deleteUserById/{id}")
    public Result<Boolean> deleteUserById(@PathVariable String id) {
        log.info("[{}] [{}] 根据主键ID删除用户: {}", getServerHost(), appName, id);
        return Result.ok();
    }
}