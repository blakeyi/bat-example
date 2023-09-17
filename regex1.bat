@echo off
setlocal enabledelayedexpansion

set "WORKSPACE=d:\code\bat\test"

set "result="
set "startReading="

@rem 读取内容到result里面
for /f "delims=" %%a in (%WORKSPACE%\FailFileList\ConfigCheck.txt) do (
    if /i "%%a"=="{" (
        set "startReading=true"
    )
    if defined startReading (
        set "result=!result! %%a"
    )
)

@rem 循环按照括号进行分割
:loop
for /f "delims=() tokens=1,2*" %%a in ("!result!") do (
    @REM echo %%b
    set "substr=%%b"
    if "!substr:~-5!"==".json" (
        set "substr=%WORKSPACE%\E\MainCommon\SpeedGame\Content\RawInfo\!substr:~24!"
        set "substr=!substr:/=\!"
        echo !substr!
        copy "!substr!" "!WORKSPACE!\FailFileList"
    )
    set "result=%%c"
)

if not "!result!"=="" goto loop