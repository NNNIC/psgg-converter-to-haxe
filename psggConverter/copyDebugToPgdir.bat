@echo off
cd /d %~dp0
echo :
echo : �{�o�b�`�́ADebug��exe�� C:\Program files(x86)\PSGG�ɃR�s�[���܂��B
echo : 
pause

::echo %ProgramFiles(x86)%\PSGG

robocopy psggConverterLib\bin\Debug "%ProgramFiles(x86)%\PSGG"

pause
