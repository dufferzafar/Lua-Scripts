function NumDigits(x)
	return floor(math.log10(x)) + 1
end

n = 100

log10 = math.log10; floor = math.floor; sqrt = math.sqrt
pi = math.pi; e = math.exp(1)

dig = floor((log10(2*pi)+log10(n))/2 + n*(log10(n)-log10(e))) + 1
print(dig)

--fact = sqrt(2*math.pi*n) * (n/e)^n
--fact = 1
--for i = 1, n do
--	fact = fact * i
--end

--print(dig)