--[[
The libLua Project - A collection of pure lua functions.

libLua.Primes 
	Prime Number related functions.

Functions:
	1. IsPrime
		i. Trial Division

--]]

libLua = {}
libLua.Primes = {}

--######################
--	 Helper Functions
--######################
local function modExp(b, e, n)
	local temp = 1	
	while e ~= 0 do
		if e%2 == 0 then
			b, e = (b*b) % n, e/2
		else
			temp, e = (temp*b) % n, e-1
		end
	end; return temp
end

local function isWitness(b, q, k, n)
	local a = modExp(b,q,n)
	if a == 1 then return false
	else
		for i = 1, k do
			if a == n-1 then return false end
			a = (a*a) % n
		end
	end; return true
end

--- Checks whether a number is prime.
-- @param x The Candidate
-- @return boolean Whether 'x' is prime
-- @return Smallest prime factor of 'x', if it is composite
function libLua.Primes.IsPrime(x, method, times)
	if (x < 2) then return false 
	elseif (x==2) or (x==3) then return true
	elseif (x%2 == 0) then return false, 2
	elseif (x%3 == 0) then return false, 3
	else
		method = method or "Trial-Division"
		
		-- Naive Approach
		if method == "Trial-Division" then
			local f, limit = 5, math.floor(x^0.5)
			while f <= limit do
				if (x%f) == 0 then return false, f end
				if (x%(f+2)) == 0 then return false, f+2 end
				f = f + 6;
			end; return true
			
		-- Rabin-Miller's Primality Test
		elseif method == "Rabin-Miller" then
			
			--Factorise x-1 to the form Q * (2^K)		
			local n, k = x-1, 0;
			while n%2 == 0 do n, k = n/2, k+1 end
			local q = (x-1)/(2^k)
			
			--Check Different Bases for Witness
			for i = 1, times or 10 do
				if isWitness(math.floor(math.random() * (x - 1)) + 1, q, k, x) then
					return false
				end
			end; return true
			
		-- Fermat's Method
		elseif method == "Fermat" then
			for i = 1, times or 10 do
				if modExp(math.floor(math.random() * (x - 1)) + 1, x - 1, x) ~= 1 then return false end
			end; return true
		end
	end
end

--Seed The Random Generator
math.randomseed(os.time())

local p = libLua.Primes
--###################################################
--				    TESTING TESTING
--###################################################
local countf, countrm = 0, 0

for i = 1, 1000 do
	local num = math.random(100000000,10000000000)
	local s = p.IsPrime(num)
	local f = p.IsPrime(num,"Fermat")
	local rm = p.IsPrime(num,"Rabin-Miller")
	
	if f ~= s then
		-- print("Fermat:",num,f,s)
		countf = countf + 1
	end
	if rm ~= s then	
		-- print("Rabin:",num,rm,s)
		-- print()
		countrm = countrm + 1
	end
end

print("Fermat - Failures:",countf)
print("Rabin Miller - Failures:",countf)