--[[
Script Name:		CryptEx
Script Features:	Crypto Functions
Script Author:		Psych0 C0d3r
Script Version:		0.3a

NOTE:-
--]]

CryptoEx = {};

--######################################################
--					 Helper Functions
--######################################################

--######################################################
--					Frequency Analysis
--######################################################
	
function CryptoEx.Frequency(str)
	local charFreq, str = {}, string.lower(str)
	for i = 1, 26 do
		_, charFreq[i] = string.gsub(str, string.char(i+96), "")
	end; return charFreq
end
