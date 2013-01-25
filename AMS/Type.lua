--[[
Script Name:		Type
Script Features:	Type Verifications & Conversions
Script Author:		Psych0 C0d3r
Script Version:		1.0a
--]]

Type = {};

--######################################################
--					Type Conversions
--######################################################

function Type.ToString(Value) return tostring(Value) end

function Type.ToNumber(Value) return tonumber(Value) end

--######################################################
--					Type Verifications
--######################################################

function Type.IsNumber(Value)
	if (type(Value) == "number") then return true
	else return false end
end

function Type.IsBoolean(Value)
	if (type(Value) == "boolean") then return true
	else return false end
end

function Type.IsString(Value)
	if (type(Value) == "string") then return true
	else return false end
end

function Type.IsTable(Value)
	if (type(Value) == "table") then return true
	else return false end
end

function Type.IsFunction(Value)
	if (type(Value) == "function") then	return true
	else return false end
end

function Type.DoesExist(Value)
	if (type(Value) == "nil") then return false
	else return true end
end

function Type.DecToBin(DecNum)		--Convert a decimal number to Binary
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

print(Type.DecToBin(34))