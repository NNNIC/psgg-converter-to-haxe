@echo off
cd /d %~dp0
robocopy testdata testdata-tmp /MIR

::call :_work c\TestControl.psgg c\TestControl.c
call :_work rust\hoge_control.psgg rust\hoge_control.rs
call :_work tyranoscript\TestControl.psgg  tyranoscript\TestControl.ks

pause
goto :eof

:_work
set f=%1
set r=%2
out\c\Program.exe %cd%\testdata-tmp\%f%
fc /L /A /N testdata\%r% testdata-tmp\%r% 
cmd /k

pause