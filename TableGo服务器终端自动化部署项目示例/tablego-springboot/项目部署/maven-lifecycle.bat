@echo off
::Welcome to use the TableGo tools
::设置变量延迟扩展clean package
setlocal enabledelayedexpansion

set options=%~1
set projectPath=%~2

if not defined options (
    echo Maven options cannot be empty.
    @echo.
    goto error
)
if not defined projectPath (
    echo Project path cannot be empty.
    @echo.
    goto error
)

if exist !projectPath! (
    echo Project path: !projectPath!
    @echo.
    cd /d !projectPath!
    mvn !options!
) else (
    echo Project path is not exist: !projectPath!
    @echo.
    goto error
)

:error
exit 4