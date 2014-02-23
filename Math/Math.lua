--[[
Script Name:		Math
Script Features:	Math Functions
Script Author:		Psych0 C0d3r
Script Version:		0.3a

NOTE:-
	1.) Add arg check to EACH & EVERY function
	2.) Understand Round & Floor functions
	3.) Create an error table tblError[]


Function List:-
	Helpers:
		(i)	CheckArgNum
		(ii)	CheckArg

	Basic:
		(i) 		IsInteger
		(ii) 		IsNegative
		(iii) 	IsEven
		(iv) 		HCF
		(v) 		LCM
		(vi) 		IsPrime*
		(vii) 	AreCoPrimes
		(viii)	 IsFactor
		(ix)		Pythagoras
		(x)		Factorial
		(xi)		Permuations
		(xii)		Combinations

	Advanced:
		(i)		Solve*

	Modified:
		(i)		Divide
		(ii)		Floor
		(iii)		Round
		(iv)		RadToDeg
		(v)		DegToRad

	Bit:
		(i)		LeftShift
		(ii)		RightShift

--]]

MathEx = {};

-- Adds to the existing math module
--module("math", package.seeall)

--######################################################
--						Some Constants
--######################################################
MathEx.e = math.exp(1)

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
--					Normal Math Functions
--######################################################

function MathEx.IsInteger(...)
	CheckArgNum(arg, 1)
	local x = CheckArg(arg, 1, "number")
	--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

	return math.abs(x) == math.floor(x)
end

function MathEx.IsNegative(...)
	CheckArgNum(arg, 1)
	local x = CheckArg(arg, 1, "number")
	--<<<<<<<<<<<<<<<<<<<<<<<<<<<

	return x < 0
end

function MathEx.IsEven(...)
	CheckArgNum(arg, 1)
	local x = CheckArg(arg, 1, "number")
	--<<<<<<<<<<<<<<<<<<<<<<<<<<<

	return x % 2 == 0
end

function MathEx.Pythagoras(...)
	CheckArgNum(arg, 2)
	local x = CheckArg(arg, 1, "number")
	local y = CheckArg(arg, 2, "number")
	--<<<<<<<<<<<<<<<<<<<<<<<<<<<

	return math.sqrt(x^2 + y^2)
end


--######################################################
--					Modified Functions
--######################################################

function MathEx.Divide(...)
	CheckArgNum(arg, 2)
	local x = CheckArg(arg, 1, "number")
	local y = CheckArg(arg, 2, "number")
	--<<<<<<<<<<<<<<<<<<<<<<<<<<<

	if x == 0 then
		return 0, 0
	elseif y == 0 then
		return nil, nil
	else
		return math.floor(x / y) , x % y
	end
end

function MathEx.Floor(...)
	CheckArgNum(arg, 2)
	local x = CheckArg(arg, 1, "number")
	local y = CheckArg(arg, 2, "number")
	--<<<<<<<<<<<<<<<<<<<<<<<<<<<

	if y and y ~= 0 then
		local e = 10 ^ y
		return math.floor(x * e) / e
	else
		return math.floor(x)
	end
end

function MathEx.Round(...)
	CheckArgNum(arg, 2)
	local x = CheckArg(arg, 1, "number")
	local y = CheckArg(arg, 2, "number")
	--<<<<<<<<<<<<<<<<<<<<<<<<<<<

	local e = 10 ^ (y or 0)
	return math.floor(x * e + 0.5) / e
end

function MathEx.DegToRad(...)
	CheckArgNum(arg, 1)
	local x = CheckArg(arg, 1, "number")
	--<<<<<<<<<<<<<<<<<<<<<<<<<<<

	return MathEx.Round(x * 0.01745329252, 5)
end

function MathEx.RadToDeg(...)
	CheckArgNum(arg, 1)
	local x = CheckArg(arg, 1, "number")
	--<<<<<<<<<<<<<<<<<<<<<<<<<<<

	return MathEx.Round(x * 57.29578, 5)
end

--######################################################
--					  Bit Functions
--######################################################

function MathEx.BitShiftLeft(...)
	CheckArgNum(arg, 2)
	local x = CheckArg(arg, 1, "number")
	local y = CheckArg(arg, 2, "number")
	--<<<<<<<<<<<<<<<<<<<<<<<<<<<

	return math.floor(x * (2 ^ y))
end

function MathEx.BitShiftRight(...)
	CheckArgNum(arg, 2)
	local x = CheckArg(arg, 1, "number")
	local y = CheckArg(arg, 2, "number")
	--<<<<<<<<<<<<<<<<<<<<<<<<<<<

	return math.floor(x / (2 ^ y))
end


--######################################################
--					 Combinatorics
--######################################################

function MathEx.Factorial(...)
	CheckArgNum(arg, 1)
	local x = CheckArg(arg, 1, "number")
	--<<<<<<<<<<<<<<<<<<<<<<<<<<<
	fact = 1;

	if not MathEx.IsInteger(x) then
		return nil;
	end

	if x == 0 or x == 1 then
		return 1;
	end

	while x > 1 do
		fact = fact * x
		x = x - 1;
	end

	return fact;
end

function MathEx.Permutations(...)
	CheckArgNum(arg, 2)
	local x = CheckArg(arg, 1, "number")
	local y = CheckArg(arg, 2, "number")
	--<<<<<<<<<<<<<<<<<<<<<<<<<<<

	if not MathEx.IsInteger(x) or not MathEx.IsInteger(y) then
		return nil 	--non int
	end

	if x < 0 or y < 0 then
		return nil	--non negative
	end

	return MathEx.Factorial(x) / MathEx.Factorial(x - y)

end

function MathEx.Combinations(...)
	CheckArgNum(arg, 2)
	local x = CheckArg(arg, 1, "number")
	local y = CheckArg(arg, 2, "number")
	--<<<<<<<<<<<<<<<<<<<<<<<<<<<

	return MathEx.Permutations(x,y) / MathEx.Factorial(y)
end


--######################################################
--					 Number Theory
--######################################################

function MathEx.HCF(...)
	CheckArgNum(arg, 2)
	local x = CheckArg(arg, 1, "number")
	local y = CheckArg(arg, 2, "number")
	--<<<<<<<<<<<<<<<<<<<<<<<<<<<

	if x == y then return x
	elseif x == 0 or y == 0 then return 0 end

	local Dividend = math.max(x, y);
	local Divisor = math.min(x, y);

	while true do	--This is not an endless loop
		_, Remainder = MathEx.Divide(Dividend, Divisor)

		--Remainder will surely be zero
		if Remainder == 0 then
			return Divisor
		else
			Dividend = Divisor
			Divisor = Remainder
		end
	end

	--It would never reach here
	return 1	--in CASE it does :)
end

function MathEx.LCM(...)
	CheckArgNum(arg, 2)
	local x = CheckArg(arg, 1, "number")
	local y = CheckArg(arg, 2, "number")
	--<<<<<<<<<<<<<<<<<<<<<<<<<<<

	if x == y then return x
	elseif x == 0 or y == 0 then return 0 end

	return x * y / MathEx.HCF(x, y)
end

function MathEx.AreCoPrimes(...)
	CheckArgNum(arg, 2)
	local x = CheckArg(arg, 1, "number")
	local y = CheckArg(arg, 2, "number")
	--<<<<<<<<<<<<<<<<<<<<<<<<<<<

	return MathEx.HCF(x, y) == 1
end

function MathEx.IsFactor(...)
	CheckArgNum(arg, 2)
	local x = CheckArg(arg, 1, "number")
	local y = CheckArg(arg, 2, "number")
	--<<<<<<<<<<<<<<<<<<<<<<<<<<<

	return MathEx.IsInteger(x / y)
end

function MathEx.SumDigit(x)
	local a , n , s = 0, 0, tostring(x)

	for i = 1, #s do
		n = tonumber(string.sub(s, i, i))
		a = a + n;
	end

	return a
end

function MathEx.DigitSum(x)
	local mod9 = x%9;
	if mod9 == 0 then return 9
	else return mod9 end
end

function MathEx.IsPrime(x)
	if (x < 2) then return false
	elseif (x==2) or (x==3) then return true
	elseif (x%2 == 0) then return false, 2
	elseif (x%3 == 0) then return false, 3
	else
		local f = 5;
		while f <= math.floor(x^0.5) do
			if (x%f) == 0 then return false, f end
			if (x%(f+2)) == 0 then return false, f+2 end
			f = f + 6;
		end
	end

	return true, 1
end

local function modMult(x, y, N)
	x, y = x%N, y%N
	if x*y <= (10^13)-1 then
		return ((x*y)%N)
	else
		--if (y > x) then return modMult(y,x,N);
	end
end

local function lastDigits(x, pow, N)
	local m = x;
	for i=2, pow do m = (m*x)%(10^N) end
	return m
end

--######################################################
--######################################################

-- sT = os.clock()

print(MathEx.Floor(897))

-- eT = os.clock(); print((eT - sT)*1000 .. " msec")
