@echo off
::Welcome to use the TableGo tools
::pause: 按任意键继续
::Git记住账号密码：
::  1、在命令行下输入：git config --global credential.helper store
::  2、在命令行下输入：git pull
::  3、输入密码密码更新项目账号密码就被记住了
::设置变量延迟扩展
setlocal enabledelayedexpansion

set projectPath=%1

if not defined projectPath (
    echo Project path cannot be empty.
    @echo.
    goto error
)

if exist !projectPath! (
    echo Project path: !projectPath!
    @echo.
    cd /d !projectPath!
    git pull
    exit 0
) else (
    echo Project path is not exist: !projectPath!
    @echo.
    goto error
)

:error
exit 4

