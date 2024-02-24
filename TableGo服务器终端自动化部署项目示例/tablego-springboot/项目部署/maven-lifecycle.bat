@echo off
::Welcome to use the TableGo tools
::pause: �����������
::���ñ����ӳ���չclean package
setlocal enabledelayedexpansion

set options=%~1
set projectPath=%~2

if not defined options (
    echo Maven options cannot be empty.
    @echo.
    goto error
)
if not defined projectPath (
    echo Maven project path cannot be empty.
    @echo.
    goto error
)

if exist !projectPath! (
    echo Maven options: !options!
    echo Maven project path: !projectPath!
    @echo.
    cd /d !projectPath!
    mvn !options! -Dmaven.test.skip=true
) else (
    echo Maven project path is not exist: !projectPath!
    @echo.
    goto error
)

:error
exit 4