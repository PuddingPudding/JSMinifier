@echo off

REM 目標地址
echo target location %1 
REM MinifyJSTool原本的位置，需要跟closure-compiler放在一起
echo batch location %~dp0

echo %cd%

REM 加上/d才能跨槽轉換，先到原本的位子找出closure-compiler
cd /d %~dp0
echo %cd%
set minifier=closure-compiler-v20180402.jar
REM for %%m in (closure-compiler*.jar) do ( REM 若發現多於的closure-compiler的話僅挑選最新版來使用
REM     echo find %%m
REM     if %%m GTR %minifier%  (
REM         set minifier=%%m
REM         echo come in, now minifier is %minifier%
REM     ) 
REM )
echo %minifier%
java -jar minifier CookieManager.js

REM call :ScanFiles %1

REM cd /d %1
REM echo %cd%
REM for /d %%d in (*) do ( REM 用來找出路徑下所有js
REM     echo %%d
REM     cd %%d
REM     for %%i in (*.js) do (
REM         echo %%d - %%i
REM     )
REM     cd ..
REM )

REM for %%m in (closure-compiler*.jar) do (
REM     echo %%m is going to minify these js files
REM     for %%i in (*.js) do (
REM         echo %%i
REM         REM java -jar %%m %%i> temp
REM         REM type temp > %%i
REM     )
REM )
REM del temp

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
for %%i in (*.js) do (
    echo %%i
    java -jar minifier %%i
    REM java -jar minifier %%i> temp
    REM type temp > %%i
)

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