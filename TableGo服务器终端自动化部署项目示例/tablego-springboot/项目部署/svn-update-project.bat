@echo off
::Welcome to use the TableGo tools
::pause: �����������
::���ñ����ӳ���չ
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
    cd /d C:\Program Files\TortoiseSVN\bin
    svn update !projectPath!
    exit 0
) else (
    echo Project path is not exist: !projectPath!
    @echo.
    goto error
)

:error
exit 4

