
function TrimFrontSpace(strLine)

	return string.gsub(strLine, "^%s*", "")

end


function TrimAllSpace(strLine)

	return string.gsub(strLine, "%s*", "")

end

function HandleMemberVarLine(strLine)
	local memberVarName
	local expression

	if string.find(strLine, "#") ~= nil then
		expression, _ = string.match(strLine, "%s*(.+)%s*#(.*)")
	else
		expression = strLine
	end

	expression = TrimAllSpace(expression)
	if string.find(expression, "=") ~= nil then
		memberVarName, _ = string.match(expression, "(%S+)=(%S+)")
	else
		memberVarName = expression
	end

	return memberVarName
end


function OutputMemberLineForJS(strLine, outFile, nNum, strEnumName)

	local curMemberVarName = HandleMemberVarLine(strLine)
	assert(curMemberVarName ~= nil)

	outFile:write(strEnumName .. "." .. curMemberVarName .. " = " .. nNum..";\n")
end

function OutputMemberLineForErl(strLine, outFile, nNum)

	local curMemberVarName = HandleMemberVarLine(strLine)
	assert(curMemberVarName ~= nil)

	outFile:write("-define("..string.upper(curMemberVarName) .. ", " .. nNum..").\n")
end


function TransformFile(inFileName, outFileName1, outFileName2)

	local bFind = false
--	local bEnd = false
	local bBraces = false
	local inFile = io.input(inFileName)
	local nNum = 0
	
	local outFile1 = assert(io.open(outFileName1, "w"))
	local outFile2 = assert(io.open(outFileName2, "w"))

	local strEnumName = ""

	for line in io.lines() do

		local destLine = TrimFrontSpace(line)
		if string.find(destLine, "^enum") ~= nil then
			assert(not bFind)
			strEnumName = string.sub(destLine, 5)
			strEnumName = TrimFrontSpace(strEnumName)
			outFile1:write("\nvar " .. strEnumName .. " = ...{};\n")
			bFind = true
		elseif bFind then
			if string.find(destLine, "^{") ~= nil then
				--outFile1:write("\t" .. destLine .. "\n")
				nNum = 0
				bBraces = true
			elseif bBraces and string.find(destLine, "^}") ~= nil then
				--outFile1:write("\t" .. destLine .. "\n")
				bFind = false
--				bEnd = true
				bBraces = false
			elseif bBraces and string.len(destLine) ~= 0 and string.find(destLine, "^#") == nil then
				nNum = nNum + 1
				OutputMemberLineForJS(destLine, outFile1, nNum, strEnumName)
				OutputMemberLineForErl(destLine, outFile2, nNum)
			end

		end
	
--		if bEnd then
--			break
--		end
	end
	outFile1:write("}\n")

	assert(outFile1:close())
	assert(outFile2:close())
end


if #arg ~= 3 then
	print("usage: programFileName inFileName outFileName1 outFileName2")
else
	TransformFile(arg[1], arg[2], arg[3])
end


