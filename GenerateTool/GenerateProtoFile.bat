@echo off 
lua.exe GenerateProtoFile.lua ..\proto\cl_gw.pl ..\proto\cl_gw_enum.proto ..\proto\cl_gw_message.proto
pause