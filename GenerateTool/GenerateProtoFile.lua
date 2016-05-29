
function TrimFrontSpace(strLine)

	return string.gsub(strLine, "^%s*", "")

end

function TransformFile(inFileName, outFileName1, outFileName2)

	local bFindEnum = false
	local bFindMessage = false
--	local bEnd = false
	local bBraces = false
	local inFile = io.input(inFileName)
	
	local outFile1 = assert(io.open(outFileName1, "w"))
	local outFile2 = assert(io.open(outFileName2, "w"))

	for line in io.lines() do
		local destLine = TrimFrontSpace(line)
		if string.find(destLine, "^enum") ~= nil then
			bFindEnum = true	
			bFindMessage = false
			outFile1:write(destLine .. "\n")			
			
		elseif string.find(destLine, "^message") ~= nil then
			bFindEnum = false	
			bFindMessage = true	
			outFile2:write(destLine .. "\n")	
	
		elseif bFindEnum then
			if string.find(destLine, "^{") ~= nil or string.find(destLine, "^}") ~= nil then
				outFile1:write(destLine .. "\n")					
			else 
				outFile1:write("\t" .. destLine .. "\n")		
			end
		elseif bFindMessage then
			if string.find(destLine, "^{") ~= nil or string.find(destLine, "^}") ~= nil then
				outFile2:write(destLine .. "\n")					
			else 
				outFile2:write("\t" .. destLine .. "\n")		
			end	
		end 
	end

	assert(outFile1:close())
	assert(outFile2:close())
end


if #arg ~= 3 then
	print("usage: programFileName inFileName outFileName1 outFileName2")
else
	TransformFile(arg[1], arg[2], arg[3])
end


