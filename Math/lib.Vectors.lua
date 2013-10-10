MathEx = {};
MathEx.Vector = {};

--######################################################
--	@@@@@@@@@@@@@@	HELPER Functions   @@@@@@@@@@@@@@@@@
--######################################################
local function CheckArgNum(tArgs, nArgs)
	if #tArgs < nArgs then error(nArgs.." Arguments expected, "..#tArgs.." Arguments passed.",3) end
end

local function CheckArg(tArgs, nPos, sType)
	if type(tArgs[nPos]) == sType then 
		return tArgs[nPos]
	elseif sType == "number" then
		if tonumber(tArgs[nPos]) then 
			return tonumber(tArgs[nPos])
		else
			error("Bad argument #"..nPos..", must be a number, you passed a "..type(tArgs[nPos]).." which couldn't be converted to number.",3)
		end		
	else 
		error("Bad argument #"..nPos..", must be a "..sType..", you passed a "..type(tArgs[nPos])..".",3) 
	end
end

--######################################################
--					 Vector Functions
--######################################################

local function MakeNum(P)	--Helper Function
	if P then return tonumber(P) else return 0 end
end

function MathEx.Vector.Split(...)
	CheckArgNum(arg, 1)
	local vect = CheckArg(arg, 1, "string")
	--<<<<<<<<<<<<<<<<<<<<<<<<<<<
	
	vect = string.lower(string.gsub(vect, "%s", ""))
	
	local cI, cJ, cK = 0, 0, 0
	
	--Count No.
	_, nI = string.gsub(vect, "i", "i")
	_, nJ = string.gsub(vect, "j", "j")
	_, nK = string.gsub(vect, "k", "k")
	
	if (nI ~= 1) and (nJ ~= 1) and (nK ~= 1) then
		return "ERROR: Vector Should be of Form = xI + yJ + zK"
	end
	
	--Get Positions
	local pI = string.find(vect, "i")
	local pJ = string.find(vect, "j") 
	local pK = string.find(vect, "k") 
	
	
	if (not pI) and (not pJ) and (not pK) then
		return "ERROR: Not a Vector"
	elseif pI and pJ and pK then
		if (pI > pJ) or (pJ > pK) then
			return "ERROR: Vector Should be of Form = xI + yJ + zK"
		end
	end
	
	if pI then	-- i
		cI = string.sub(vect, 1, pI - 1);		
		if pJ then	-- i && j
			cJ = string.sub(vect, pI + 1, pJ - 1);
			if pK then	-- i && j && k
				cK = string.sub(vect, pJ + 1, pK - 1);
			end
		elseif pK then	-- i && k
			cK = string.sub(vect, pI + 1, pK - 1);
		end
	elseif pJ then	-- j
		cJ = string.sub(vect, 1, pJ - 1);
		if pK then	-- j && k
			cK = string.sub(vect, pJ + 1, pK - 1);
		end
	elseif pK then	-- k
		cK = string.sub(vect, 1, pK - 1);
	end
	
	return MakeNum(cI), MakeNum(cJ), MakeNum(cK)
end

function MathEx.Vector.Add(...)
	CheckArgNum(arg, 2)
	local vectA = CheckArg(arg, 1, "string")
	local vectB = CheckArg(arg, 2, "string")
	--<<<<<<<<<<<<<<<<<<<<<<<<<<<
	
	local iA, jA, kA = MathEx.Vector.Split(vectA)
	local iB, jB, kB = MathEx.Vector.Split(vectB)
	
	return tostring(iA + iB).." "..tostring(jA + jB).." "..tostring(kA + kB)
end

--##############################################################


--print(string.gsub("10i + 7j + 6k", "%s", ""))
--print(MathEx.Vector.Split("4i - 46k"))
--print(MathEx.Vector.Add("10i + 7j + 8k", "1i + 3j + 2k"))
--print(MathEx.AreCoPrimes(120, 23))