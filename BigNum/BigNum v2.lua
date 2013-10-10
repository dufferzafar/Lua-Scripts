--[[
Bignum: a class for arbitrarily large numbers
 This class uses tables to stand in for numbers, allowing you to compute
 really large ones, instead of the limit that Lua places on you.

NEW:-
	Comparison
	Exponentiation	
	Signed Integers (0.2)
 
CHANGES:-
 Faster:
	41x		Big Number Multiplication
	4x		Lua Number Multiplication
	2x		Palindrome Detection
	4x		Addition
	
 Slower:
	16x		Digit Sum
	38x		No. of Digits
	
TODO:-
	Fully Support Signed Integers	
	Subtraction
	Long Division (remainder, decimal)
	GCD
	Primality Tests
	Square (& nth) Roots

Last Update - 2:05 PM Wednesday, February 22, 2012
--]]

--The bigNum Library, and its MetaTable
bigNum = {};

-- The Radix
local radix, rLen = 10^7, 7

--Aryabhattian Invention
local zero = "0"

--- Creates a new big number from a string or a standard Lua number.
-- @param x The source of the new number, either a string or a Lua number.
-- @return A big number that can be used in other calculations.
function bigNum.new(x, sign)
    local obNum = {val = {}, sign = sign or 1}

    if type(x) == "table" then --For internal use ONLY, table should be in 'LSB First' form
		obNum.val = x
    else
		local x = tostring(x)
		if x:sub(1,1) == "-" then obNum.sign = -1 end
		x = x:match("[1-9]%d*") or ""
		if x == "" then	obNum.val[1], obNum.sign = 0, 0
		else
			for i = #x, 1, -rLen do
				if i-rLen + 1 > 0 then
					obNum.val[#obNum.val + 1] = tonumber(x:sub(i-rLen +1,i))
				else
					obNum.val[#obNum.val + 1] = tonumber(x:sub(0,i))
				end
			end
		end
	end
	
	--Connect bNum to its meta-methods
	setmetatable(obNum, bigNum.mt)

    return obNum
end

-- @param A bigNum.
-- @param no Whether to include sign of the number (just used by isPalin).
-- @return A string that represents the number.
function bigNum:tostring(no)
	local temp, c = {}, 0
	for i = 1, #self.val do
		c = #tostring(self.val[i])
		if i ~= #self.val and c < rLen then
			temp[#self.val-i+1] = zero:rep(rLen-c)..self.val[i]
		else
			temp[#self.val-i+1] = self.val[i]
		end
	end;
	return ((self.sign == -1 and (not no)) and "-"..table.concat(temp) or table.concat(temp))
end

-- @param A bigNum.
-- @return The number of digits in the bigNum.
function bigNum:digits()
	return (rLen * (#self.val-1)) + #tostring(self.val[#self.val])
end

-- @param A bigNum.
-- @param repeated optional Whether to find the repeated digit sum of the number.
-- @return The sum of digits of the bigNum.
function bigNum:dSum(repeated)
	local sum = 0
	for i = 1, #self.val do
		for digit in tostring(self.val[i]):gmatch("%d") do sum = sum + digit end
	end;if repeated then return (sum%9==0 and 9 or sum%9) else return sum end
end

--######################
--    Add, Subtract
--######################

--Helper Function
local function addHelp(n, ns, m, ms) -- n > m
	local ans, carry, sgn = {}, 0, 0
	
	if ms * ns < 0 then sgn = -1 elseif ms * ns > 0 then sgn = 1 end

	for i = 1, #n do
		ans[i] = (n[i] + (sgn*(m[i] or 0)) + carry) % radix
		carry = math.floor((n[i] + (sgn*(m[i] or 0)) + carry) / radix)
	end; if carry ~= 0 then ans[#ans + 1] = carry end
	
	return ans
end

--- Add two big numbers.
-- @param num The 'other' number to add.
-- @return A big number that is the sum.
function bigNum:add(num)
	local num = (getmetatable(num) == bigNum.mt and num or bigNum.new(num))
	if self > num then	
		return bigNum.new(addHelp(self.val, self.sign, num.val, num.sign))
	else
		return bigNum.new(addHelp(num.val, num.sign, self.val, self.sign))
	end
end

--- Subtracts two big numbers.
-- @param num The 'other' number to subtract.
-- @return A big number that is the result of subtraction.
function bigNum:sub(num)
	local num = (getmetatable(num) == bigNum.mt and num or bigNum.new(num))
	if self > num then
		return bigNum.new(addHelp(self.val, self.sign, num.val, -1*num.sign))
	else
		return bigNum.new(addHelp(num.val, -1*num.sign, self.val, self.sign))
	end
end

--######################
--    Multiplication
--###################### 

--Helper Function: bigNum * lNum
function mulHelp1(b, lNum)
	local ans, carry = {}, 0
	for i = 1, #b do --Schoolbook Multiplication
		ans[i] = (b[i]*lNum + carry) % radix
		carry = math.floor((b[i]*lNum + carry) / radix)
	end
	while carry ~= 0 do --Handle Leftover Carry
		ans[#ans + 1] = carry % radix
		carry = math.floor(carry/radix)
	end; return ans;
end

--- Multiply a big number and a Lua number together.
-- @param num The other number to multiply with.
-- @usage bigNum.new(1111)*99; --bigNum should be first.
-- @return A big number that is the product of the numbers.
function bigNum:mul(num)
	if getmetatable(num) == bigNum.mt then --bigNum * bigNum
		local m, n, c, ans, carry = self.val, num.val, {}, {}, 0
		
		if #m > #n then m, n = n, m end -- m = min(m, n)

		for i = 1, #m do --Schoolbook Multiplication
			for j = 1, #n do
				c[i+j] = (c[i+j] or 0) + math.floor((m[i] * n[j])/radix)
				c[i+j-1] = (c[i+j-1] or 0) + (m[i] * n[j]) % radix		
			end
		end; if c[#c] == 0 then c[#c] = nil end
		
		for i = 1, #c do --Add
			ans[i] = (c[i] + carry) % radix
			carry = math.floor((c[i] + carry)/radix)			
		end; if carry ~= 0 then ans[#ans + 1] = carry end
		
		--Sign of the Answer
		local sgn = 0; if self.sign * num.sign < 0 then sgn = -1
		elseif self.sign * num.sign > 0 then sgn = 1 end
		return bigNum.new(ans, sgn)
	else --bigNum * luaNum
		local sgn = 0; if self.sign * num < 0 then sgn = -1
		elseif self.sign * num > 0 then sgn = 1 end
		return bigNum.new(mulHelp1(self.val, math.abs(num)), sgn)
	end
end

--- Exponentiates a big number.
-- @param expo The Exponent
-- @usage bigNum.new(1111) ^ 99; --bigNum should be first.
-- @return A big number that is the result of exponentiation.
function bigNum:pow(expo)
	local temp, b, e = bigNum.new(1), self, expo
	while e ~= 0 do
		if e%2 == 0 then b, e = b*b, e/2
		else temp, e = temp*b, e-1 end
	end; return temp
end

--######################
--		 Division
--###################### 

--Helper Function: bigNum / luaNum
local function divHelp1(m, lNum)
	local ans, carry = {}, 0
	for i = 1, #m do
		ans[i] = math.floor((carry + m[i])/lNum)
		carry = (radix * (carry + m[i])) % lNum
	end; return ans
end

--- Divides two big numbers.
-- @param num The Dividend.
-- @return A big number that is the Quotient.
-- @return A big number that is the Remainder.
function bigNum:div(num)
	-- local num = (getmetatable(num) == bigNum.mt and num or bigNum.new(num))
	return bigNum.new(divHelp1(self.val, num))
end

--######################
--      Comparison
--######################

--- Compares big numbers.
-- @param num The other number to compare with.
-- @return boolean value.
function bigNum:less(num)
	local m, n = self.val, bigNum.new(num)
	if getmetatable(num) ~= bigNum.mt then	n = n.val else n = num.val end
	if #m < #n then return true
	elseif #m > #n then return false
	else
		for i = #m, 1, -1 do
			if m[i] < n[i] then return true
			elseif m[i] > n[i] then return false end
		end
	end; return false
end

function bigNum:equal(num)
	local m, n = self.val, bigNum.new(num)
	if getmetatable(num) ~= bigNum.mt then	n = n.val else n = num.val end
	if #m ~= #n then return false
	else
		for i = #m, 1 do
			if m[i] ~= n[i] then
				return false
			end
		end
	end; return true
end

--The bigNum Meta-Table
bigNum.mt={ __index = bigNum,
			__add = bigNum.add,
			__sub = bigNum.sub,
			__mul = bigNum.mul,
			__div = bigNum.div,
			__pow = bigNum.pow,
			__lt = bigNum.less,
			__eq = bigNum.equal,
			__tostring = bigNum.tostring
}

local bg = bigNum
--###################################################
--				    TESTING TESTING
--###################################################
-- x = bg.new("7")