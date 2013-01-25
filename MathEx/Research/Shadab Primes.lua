--[[
			Shadab Primes
In Search of Numbers larger than : 73,939,133
]]--

--Functions
function isPrime(x)
	if (x%3 == 0) then return false
	else
		local f = 5;
		while f <= floor(sqrt(x)) do
			if (x%f) == 0 then return false end
			if (x%(f+2)) == 0 then return false end
			f = f + 6;
		end
	end

	return true
end

function factorise(n)
	for i = 3, math.floor(math.sqrt(n)), 2 do
		if (n % i) == 0 then return i end
	end; return 1
end

-- n = 3737
-- t = IsPrime(n)
-- f = factorise(n)
-- print(t, f.."*"..n/f)

--[[				Pure 'ShadabPrimes' Search
--Input & Output
iFile = io.open("7 Digit.txt", "r")
oFile = io.open("8 Digit.txt", "a+")

--Task
for line in iFile:lines() do 
	for i = 1, 9, 2 do 
		strNum = line..i; num = tonumber(strNum);
		if IsPrime(num) then 
			oFile:write(num.."\n");
		end		
	end
end

--Cleanup
iFile:close()
oFile:close()
]]--
