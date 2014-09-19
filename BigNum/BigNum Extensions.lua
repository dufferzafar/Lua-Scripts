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
    for i = 1, lNum do  ans = mulHelp1(ans, i) end
    return bigNum.new(ans)
end

--- Find factorial of a Lua Number.
-- @param digits Number of digits
-- @return A random big number that has digits
function bigNum.random(...)
    local args = {...}
    local digits = args[1] or math.floor(10^5 * math.random())

	local ans = {}
    local radix = 7
    for i = 1, math.floor(digits/radix) do
        ans[i] = math.floor(10^radix * math.random())
    end
    ans[#ans+1] = math.floor(10^(digits%radix) * math.random())
    return bigNum.new(ans)
end

local bg = bigNum

--###################################################
--                  TESTING TESTING
--###################################################

math.randomseed(os.time())

r = bg.random(10000000)

for i=1, 100000000 do
    r:digits()
end
