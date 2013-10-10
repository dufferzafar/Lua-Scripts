--[[
The libLua Project - A collection of pure lua functions.

libLua.Type 
	Basic type wrappers and base conversion fucntions.

--]]

libLua = {}
libLua.Type = {}

--######################################################
--					Type Conversions
--######################################################

function libLua.Type.ToString(Value) return tostring(Value) end

function libLua.Type.ToNumber(Value) return tonumber(Value) end

--######################################################
--					Type Verifications
--######################################################

function libLua.Type.IsNumber(Value)
	if (type(Value) == "number") then return true
	else return false end
end

function libLua.Type.IsBoolean(Value)
	if (type(Value) == "boolean") then return true
	else return false end
end

function libLua.Type.IsString(Value)
	if (type(Value) == "string") then return true
	else return false end
end

function libLua.Type.IsTable(Value)
	if (type(Value) == "table") then return true
	else return false end
end

function libLua.Type.IsFunction(Value)
	if (type(Value) == "function") then	return true
	else return false end
end

function libLua.Type.DoesExist(Value)
	if (type(Value) == "nil") then return false
	else return true end
end

--######################################################
--				Numeric Base Conversions
--######################################################

function libLua.Type.DecToBin(DecNum)		--Convert a decimal number to Binary
	local Quot = DecNum;
	local Remainder;
	local Binary = "";
	
	while (Quot ~= 1) do
		Remainder = Quot % 2;
		Quot = math.floor(Quot / 2);
		Binary = Remainder..Binary;
	end
	
	Binary = "1"..Binary;
	
	--if string.len(Binary) >= 8 then return Binary end;
	--while (string.len(Binary) ~= 8) do Binary = "0"..Binary	end;
	
	return Binary;
end