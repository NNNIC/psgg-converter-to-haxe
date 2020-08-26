@echo off
set CS2HX=cs2hx\bin\debug\cs2hx.exe
cd /d %~dp0

echo :
echo : convert
echo :

rd /s /q src\psggConverter 2>nul
rd /s /q src\lib 2>nul
rd /s /q src\util 2>nul
rd /s /q src\wordstrage 2>nul
del /f src\Constructors.hx 2>nul
::pause

"%CS2HX%" /sln:..\psggConverter\psggConverter.sln  /out:src /extraTranslation:Translations.xml
::"%CS2HX%" /sln:..\psggConverter\psggConverter.sln /projects:psggConverterLib  /out:src\hx /extraTranslation:Translations.xml
::"%CS2HX%" /sln:..\psggConverter\psggConverter.sln /projects:psggConverterLib  /out:src\hx
cmd /k