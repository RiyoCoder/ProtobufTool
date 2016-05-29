@echo off

cd GenerateTool
lua.exe GenerateProtoFile.lua ..\proto\cl_gw.pl ..\proto\cl_gw_enum.proto ..\proto\cl_gw_message.proto

lua.exe EnumSwitch.lua ..\proto\cl_gw_enum.proto ..\proto\cl_gw_enum.js ..\proto\cl_gw_define.hrl


cd ..

setlocal enabledelayedexpansion
set SCRIPT_PATH=%~dp0
set PROTO_PATH=%SCRIPT_PATH%proto\*message.proto
for %%I in (erl.exe) do if "%%~$PATH:I"=="" (
	echo cannot find erl.exe, please install erlang and put the path into PATH
	goto saygoodbye
)

cd erl_protobuffs
for /f "delims=" %%I in ('dir /b /a-d /s %PROTO_PATH%') do (
	set filename=%%I
	for %%a in ("!filename!") do echo compile: %%~na%%~xa
	erl -pa ..\erl_protobuffs\ebin -noshell -s protobuffs_compile scan_file_src %%I -s erlang halt
)

move * ../proto

cd ../proto
for %%I in (*message.proto) do (
	set filename=%%I
	for %%a in ("!filename!") do pbjs %SCRIPT_PATH%proto\%%I -t js -o %SCRIPT_PATH%proto\%%~na.js
)

::copy *.hrl ..\..\..\GameServer\include\protobuf\
::copy *.erl ..\..\..\GameServer\src\protobuf\
::copy *.cs ..\..\..\GameClient\Assets\Script\Protobuf\

pause
