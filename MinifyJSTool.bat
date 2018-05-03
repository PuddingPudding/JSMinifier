@echo off

REM 目標地址
echo target location %1 
REM MinifyJSTool原本的位置，需要跟closure-compiler放在一起
echo batch location %~dp0

echo %cd%

REM 加上/d才能跨槽轉換，先到原本的位子找出closure-compiler
cd /d %~dp0
echo %cd%
for %%m in (closure-compiler*.jar) do ( REM 若發現多於的closure-compiler的話先刪掉舊版
    echo find %%m
)

cd /d %1
echo %cd%
for /d %%d in (*) do ( REM 用來找出路徑下所有js
    echo %%d
    cd %%d
    for %%i in (*.js) do (
        echo %%d - %%i
    )
    cd ..
)

for %%m in (closure-compiler*.jar) do (
    echo %%m is going to minify these js files
    for %%i in (*.js) do (
        echo %%i
        REM java -jar %%m %%i> temp
        REM type temp > %%i
    )
)
REM del temp

REM type motherfucker.txt
REM type motherfucker.txt > Frank.txt
REM type motherfucker.txt > motherfucker.txt
REM for /f %%a in (motherfucker.txt) do ( 
REM     echo %%a 
REM )
REM java -jar closure-compiler-v20180402.jar CookieManager.js
REM java -jar closure-compiler-v20180402.jar CookieManager.js > fuck.js

REM set var=Peter
REM set var=John
REM echo %var%
pause