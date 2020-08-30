@echo off
cd /d %~dp0
robocopy testdata testdata-tmp /MIR

call :_work ang8\MainControl.psgg ang8\MainControl.ts
call :_work php\FizzBuzzControl.psgg php\FizzBuzzControl.php
call :_work unity-maze\MazeControl.psgg unity-maze\MazeControl.cs
call :_work win-bat\MainControl.psgg win-bat\MainControl.bat 
call :_work c\TestControl.psgg c\TestControl.c
call :_work rust\hoge_control.psgg rust\hoge_control.rs
call :_work tyranoscript\TestControl.psgg  tyranoscript\TestControl.ks
call :_work unity-sa\doc\UITest01Control.psgg unity-sa\src\UITest01Control_created.cs


pause
goto :eof

:_work
set f=%1
set r=%2

echo : 
echo : ------------- %f% %r% -----------------
echo : 
echo :

out\cs\bin\x64\Debug\Program.exe %cd%\testdata-tmp\%f%
fc /L /A /N testdata\%r% testdata-tmp\%r% 
::cmd /k
::pause
goto :eof