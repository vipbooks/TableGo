@echo off
::Welcome to use the TableGo tools
::pause: �����������
::���ñ����ӳ���չclean package
setlocal enabledelayedexpansion

set options=%~1
set projectPath=%~2

if not defined options (
    echo NPM options cannot be empty.
    @echo.
    goto error
)
if not defined projectPath (
    echo Vue project path cannot be empty.
    @echo.
    goto error
)

if exist !projectPath! (
    echo NPM options: ${options}
    echo Vue project path: !projectPath!
    @echo.
    cd /d !projectPath!
    npm run !options!
) else (
    echo Vue project path is not exist: !projectPath!
    @echo.
    goto error
)

:error
exit 4