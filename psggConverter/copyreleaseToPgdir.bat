@echo off
cd /d %~dp0
echo :
echo : �{�o�b�`�́ARelease��exe�� C:\Program files(x86)\PSGG�ɃR�s�[���܂��B
echo : �� Release�ł����o�Ȃ��o�O��T�邽�߂ł��B
pause

::echo %ProgramFiles(x86)%\PSGG

robocopy psggConverterLib\bin\Release "%ProgramFiles(x86)%\PSGG"

pause
