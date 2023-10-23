package cn.tablego.project.springboot.common.controller;

import java.net.InetAddress;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;

import cn.hutool.core.util.StrUtil;

/**
 * 用于其他Controller继承的基础Controller
 *
 * @author bianj
 * @version 1.0.0 2021-09-26
 */
public abstract class BaseController {
    @Autowired
    protected HttpServletRequest request;

    @Autowired
    protected HttpServletResponse response;

    @Autowired
    protected Environment environment;

    /**
     * 获取服务器地址
     *
     * @return 服务器地址
     */
    protected String getServerHost() {
        try {
            return InetAddress.getByName(request.getServerName()).getHostAddress() + ":" + request.getServerPort();
        } catch (Exception ignored) {
        }
        return StrUtil.EMPTY;
    }
}
