@echo off


p4 edit
set checkResult=%errorlevel%
if "%checkResult%"=="0" (
    echo "check success"
) else (
    echo "check failed"
)



pause
