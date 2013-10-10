--[[
The libLua Project - A collection of pure lua functions.

libLua.Table
	Basic Table related functions.

Functions:
	1. lSearch
	2. bSearch

--]]

libLua = {}
libLua.Table = {}

--- Copies a table into another.
-- @param t1 The host table to copy
-- @param t2 The table that would be filled
function libLua.Table.Copy(t1, t2)
	for i, v in ipairs(t1) do t2[i] = v end
end

--- Search for a target in a table linearly.
-- @param tab The host table (numbers in it should be in ascending order)
-- @param n Number to search
-- @return boolean Whether the target is found in the table
function libLua.Table.lSearch(tab, n)
	for i = 1, #tab do
		if n == tab[i] then	return true, i end
	end; return false
end

--- Search for a target in a table using binary algorithm.
-- @param tab The host table
-- @param n Number to search for
-- @return boolean Whether the target is found in the table
function libLua.Table.bSearch(tab, n)
	local beg, last = 1, #tab;
	if (n < tab[beg]) or (n > tab[last]) then return false end
	while beg <= last do
		mid = math.floor((beg + last)/2);

		if n == tab[mid] then
			return true, mid
		elseif n > tab[mid] then
			beg = mid + 1
		else
			last = mid - 1
		end
	end; return false
end