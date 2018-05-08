@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

REM 目標地址
echo target location %1 
REM MinifyJSTool原本的位置，需要跟closure-compiler放在一起
echo batch location %~dp0

echo %cd%

REM 加上/d才能跨槽轉換，先到原本的位子找出closure-compiler
cd /d %~dp0
echo now at %~dp0
echo %cd%
set minifier=%~dp0
for %%m in (closure-compiler*.jar) do ( REM 若發現多於的closure-compiler的話僅挑選最新版來使用
    echo find %%m
    if %~dp0%%m GTR %minifier%  (
        set minifier=%~dp0%%m
        echo come in, now minifier is %minifier%
    ) 
)
echo %minifier%

call :ScanFiles %1

pause
exit
REM 程式結尾在此，下面為函式宣告，需要這麼寫的關係是因為批次檔做完上面的東西後還會自動去跑一次下面含是內的指令

:ScanFiles
cd /d %1
for /d %%f in (*) do (
    echo now at %%f
    call :ScanFiles %%f
    cd ..
)
echo end of scanning
echo %minifier%
for %%i in (*.js) do (
    echo %%i
    java -jar %minifier% %%i
    java -jar %minifier% %%i> temp
    type temp > %%i
)
del temp