@echo off
Setlocal EnableDelayedExpansion
set "compile_files=MyBot.run,MyBot.run.Watchdog"
set "compile_ext=_stripped.au3,.exe"
for %%i in (%compile_files%) do (
	for %%j in (%compile_ext%) do (
		set "file=%%i%%j"
		If Exist "!file!" (
			echo Deleting !file!
			del "!file!"
			If Exist "!file!" (
				echo Error deleting !file!... STOP BUILD!!!
				pause
				exit /b 2
			)
		)
	)
)
set "src=%cd%\"

for %%i in (%compile_files%) do (
	set "file=%%i"
	"build\au3check.exe" "%src%!file!.au3"
	"build\au3Stripper\Au3Stripper.exe" "%src%!file!.au3" 
	"build\au3check.exe" "%src%!file!_stripped.au3"
	echo Compiling !file!.exe
	"build\aut2exe\aut2exe.exe" /in "%src%!file!_stripped.au3" /nopack /comp 2

	If Not Exist "!file!.exe" (
		echo Compile error... STOP BUILD!!!
		pause
		exit /b 1
	)
)

Setlocal DisableDelayedExpansion
set "zip=MyBot.run.zip"
If Exist "%zip%" (
	echo Deleting %zip%
	del "%zip%"
)
echo Creating %zip%
"build\7z.exe" a -x!*.7z -x!*.zip -xr!BackUp -x!.git* -x!Profiles -x!build.bat -x!build -x!build\* -x!Zombies -x!Zombies\* -x!SkippedZombies -x!SkippedZombies\* -x!lib\ImgLocDebugData -x!lib\ImgLocDebugData\* -r "%zip%" *
pause