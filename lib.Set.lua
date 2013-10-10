--[[
The libLua Project - A collection of pure lua functions.

libLua.Set 
	Set theory related functions.

	(i)		Union*
	(ii)	Intersection
	(iii)	NoOfSubsets
	(iv)	IsSubset*
	(v)		RemoveDuplicates*
	(vi)	Sort
	(vi)	AreEqual*
	(vii)	ToString*

--]]

libLua = {}

libLua.Set = {};

--- Creates a new set from a standard lua table.
-- @param x The source of the new set, a Table.
-- @return A set that can be used in other operations.
function libLua.Set.new(tab)
	local obSet = {}
	if tab then
		for _, v in ipairs(tab) do
			obSet[v] = true
		end		
	end
	
	--Connect set to its meta-methods
	setmetatable(obSet, libLua.Set.mt)
	
	return obSet
end

function libLua.Set:union(s)
	local res = libLua.Set.new()
	for k in pairs(self) do res[k] = true end
	for k in pairs(s) do res[k] = true end
	return res
end

function libLua.Set:intersec(s)
	local res = libLua.Set.new()
	for k in pairs(self) do res[k] = s[k] end
	return res
end

function libLua.Set.sub(s1,s2)
	local res = libLua.Set.new()
	for k in pairs(s1) do 
		if not s2[k] then
			res[k] = s1[k]
		end
	end; return res
end

local function bubbleSort(t)
	local change, iCount = false, #t
	repeat
		change, iCount = false, iCount - 1
		for i = 1, iCount do
			if t[i] > t[i + 1] then
				t[i], t[i + 1] = t[i + 1], t[i]
				change = true
			end
		end
	until change == false
end

function libLua.Set.tostring(s1)
	local res = {}
	for k in pairs(s1) do
		res[#res + 1] = k
	end; bubbleSort(res);
	return "{"..table.concat(res, ",").."}"
end

--The Set Meta-Table
libLua.Set.mt = {	__index = libLua.Set,
			__add = libLua.Set.union,
			__mul = libLua.Set.intersec,
			__sub = libLua.Set.sub,
			__tostring = libLua.Set.tostring
};

local s = libLua.Set
--###################################################
--				    TESTING TESTING
--###################################################
x = s.new({1,2,3,9,81,810})
y = s.new({1,2,3,23})
-- print(x, y); 
print(x+y);
-- print(x*y); 
-- print(x-y)
-- print(y-x)