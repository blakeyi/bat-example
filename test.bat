@echo off
for /f "delims='LoadFile(' tokens=1,2,3" %%a in (test.txt) do (
    echo %%b
)

    