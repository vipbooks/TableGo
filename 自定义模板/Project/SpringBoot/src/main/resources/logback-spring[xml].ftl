<?xml version="1.0" encoding="UTF-8"?>
<!-- 日志级别从低到高分为TRACE < DEBUG < INFO < WARN < ERROR < FATAL，如果设置为WARN，则低于WARN的信息都不会输出 -->
<!-- scan:当此属性设置为true时，配置文档如果发生改变，将会被重新加载，默认值为true -->
<!-- scanPeriod:设置监测配置文档是否有修改的时间间隔，如果没有给出时间单位，默认单位是毫秒，当scan为true时此属性生效，默认的时间间隔为1分钟 -->
<!-- debug:当此属性设置为true时，将打印出logback内部日志信息，实时查看logback运行状态，默认值为false -->
<configuration debug="false" scan="true" scanPeriod="1200 seconds">
    <property name="LOG_HOME" value="/logs/${jsonParam.appName}"/>
    <property name="FILE_NAME" value="${jsonParam.appName}"/>
    <property name="PATTERN_LAYOUT" value="%d{yyyy-MM-dd HH:mm:ss.SSS} %-5level ${"$"}{PID:-} --- [%thread] %c:%L : %msg%n"/>

    <!-- 输出到控制台 -->
    <appender name="console" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>${"$"}{PATTERN_LAYOUT}</pattern>
            <charset>UTF-8</charset>
        </encoder>
    </appender>

    <!-- 输出到文件 -->
    <appender name="file" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>${"$"}{LOG_HOME}/${"$"}{FILE_NAME}.log</file>
        <rollingPolicy class="ch.qos.logback.core.rolling.SizeAndTimeBasedRollingPolicy">
            <fileNamePattern>${"$"}{LOG_HOME}/%d{yyyy-MM, aux}/${"$"}{FILE_NAME}_%d{yyyyMMdd}_%i.log.zip</fileNamePattern>
            <maxFileSize>50MB</maxFileSize>
            <maxHistory>20</maxHistory>
        </rollingPolicy>
        <encoder>
            <pattern>${"$"}{PATTERN_LAYOUT}</pattern>
            <charset>UTF-8</charset>
        </encoder>
    </appender>

    <!-- 异步输出到控制台 -->
    <appender name="consoleAsync" class="ch.qos.logback.classic.AsyncAppender">
        <includeCallerData>true</includeCallerData>
        <appender-ref ref="console"/>
    </appender>

    <!-- 异步输出到文件 -->
    <appender name="fileAsync" class="ch.qos.logback.classic.AsyncAppender">
        <includeCallerData>true</includeCallerData>
        <appender-ref ref="file"/>
    </appender>

    <!-- 开发环境: 输出到控制台 -->
    <springProfile name="dev">
        <root level="INFO">
            <appender-ref ref="consoleAsync"/>
        </root>
        <logger name="${jsonParam.basePackagePath}" level="DEBUG"/>
    </springProfile>

    <!-- 测试环境: 输出到控制台和文件 -->
    <springProfile name="test">
        <root level="INFO">
            <appender-ref ref="consoleAsync"/>
            <appender-ref ref="fileAsync"/>
        </root>
        <logger name="${jsonParam.basePackagePath}" level="DEBUG"/>
    </springProfile>

    <!-- 生产环境: 输出到控制台和文件 -->
    <springProfile name="prod">
        <root level="WARN">
            <appender-ref ref="consoleAsync"/>
            <appender-ref ref="fileAsync"/>
        </root>
    </springProfile>
</configuration>
