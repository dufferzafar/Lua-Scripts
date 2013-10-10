--[[
The libLua Project - A collection of pure lua functions.

libLua.Crypt 
	Cryptoography related functions.

--]]

libLua = {}
libLua.Crypt = {};

--######################################################
--					Frequency Analysis
--######################################################
	
function libLua.Crypt.Frequency(str)
	local charFreq, str = {}, string.lower(str)
	for i = 1, 26 do
		_, charFreq[i] = string.gsub(str, string.char(i+96), "")
	end; return charFreq
end
