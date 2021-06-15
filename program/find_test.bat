@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set "scfile=整合.txt"
set "tgtstr=字符.txt"
set num=0
set "LF=###"
@REM set LF=^%=EMPTY=%
@echo "target key word : %tgtstr%" > result_find.txt
@echo "target file : %scfile%" >> result_find.txt
set /a start=-1
set writestr=
set tmp=
set remain=
set out_str=

set remain_main=%scfile%
@REM :main_loop

Copy 目标文件\*.txt 整合.txt

for /f "delims=" %%a in (!remain_main!) do (
    set "tmp=%%a"
    if "!tmp:~0,10!"=="----------" (
        @REM echo "into -----"
        if !start! equ -1 (
                @REM echo "start == -1"
            set /a start=!start!+1
            set writestr=!tmp!!LF!
        ) else (
            if !start! geq 1 (
                echo !writestr! | findstr /i /n /g:%tgtstr% >nul && (
                        echo "catch once"
                        set out_str=!out_str!!writestr!!LF!
                )
                set writestr=!tmp!!LF!
                set start=0
                @REM echo "done once"
            )
        )
    ) else (
        if "!tmp:~0,2!"=="\\" (
                @REM echo "into \\"
            if !start! equ 0 (
                @REM     echo "start == 0 \\"
                set /a start=!start!+1
                set writestr=!writestr!!tmp!!LF!
            ) else (
                if !start! equ 1 (
                        @REM echo "start == 1 \\"
                        set writestr=!writestr!!tmp!!LF!
                )
            )
        ) else (
            if !start! equ 1 (
                @REM     echo "start 1"
                set writestr=!writestr!!tmp!!LF!
            )
        )
    )
)

set remain=!out_str!
@REM echo !remain!
:write_out_loop
for /f "tokens=1* delims=###" %%d in ("!remain!") do (
        echo %%d >> result_find.txt
        if "%%e"=="" (
                @REM echo 1
                set remain=
        ) else (
                @REM echo 2
                set remain=%%e
                @REM echo %%e
        )
        @REM if defined remain goto :write_out_loop
)
if defined remain (goto write_out_loop)