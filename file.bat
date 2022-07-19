

REM for /f ('dir /s/b *.h') do (
REM     echo %i 
REM )


set SRC_DIR=D:\dep\c_dep\webrtc

for /f %%i in ('dir /s/b *.h') do (
	REM set str=%%~ni
	copy  /r  %%i %SRC_DIR%  
	REM set str=!str:~0,-7!
	REM echo !str!
	REM call:config_copy %SRC_DIR% %DST_DIR% !str!
)


#pause 