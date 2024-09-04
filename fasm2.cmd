@echo off
setlocal
REM	project includes superceed fasm2 distribution
set include=%~dp0include;%~dp0fasm2\include;%include%
"%~dp0fasm2\fasmg.exe" -iInclude('fasm2.inc') %*
endlocal