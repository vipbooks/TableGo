package cn.tablego.project.springboot.common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;

/**
 * 用于其他Controller继承的基础Controller
 *
 * @author bianj
 * @version 1.0.0 2021-09-23
 */
public abstract class BaseController {
    @Autowired
    protected HttpServletRequest request;

    @Autowired
    protected HttpServletResponse response;

}
