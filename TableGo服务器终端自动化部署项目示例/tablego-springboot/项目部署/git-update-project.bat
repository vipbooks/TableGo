@echo off
::Welcome to use the TableGo tools
::pause: �����������
::Git��ס�˺����룺
::  1���������������룺git config --global credential.helper store
::  2���������������룺git pull
::  3�������������������Ŀ�˺�����ͱ���ס��
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

