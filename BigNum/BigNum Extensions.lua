--[[
Functional Extensions to the BigNum Library

NEW:-
	Factorial
 
TODO:-
	Fibonacci Sequence

Last Update - 5:55 PM Thursday, February 23, 2012
--]]

require("BigNum v2")

--###################################################
--			 BigNum Implemented Functions
--###################################################
-- @param A bigNum.
-- @return Whether the number is palindrome or not.
function bigNum:isPalin()
	local s = self:tostring(true); return s == s:reverse()
end

--- Find factorial of a Lua Number.
-- @param lNum The Number
-- @return A big number that is the factorial
function bigNum.factorial(lNum)
	local ans = {1}
	for i = 1, lNum do	ans = mulHelp1(ans, i) end
	return bigNum.new(ans)
end

local bg = bigNum

--###################################################
--				    TESTING TESTING
--###################################################

print(bg.factorial(10000))