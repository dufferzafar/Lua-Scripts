MathEx = {}

--========================================|
-- MathEx.Divide                          |
--========================================|
function MathEx.Divide(nDividend, nDivisor)
	if nDividend == 0 then
		return {0, 0};
	elseif nDivisor == 0 then
		return {"Undefined", "Undefined"};
	else
		local nQuotient = math.floor(nDividend / nDivisor);
		local nRemainder = nDividend - (nQuotient * nDivisor);
		
		tAnswer = {};
		tAnswer.Quotient = nQuotient;
		tAnswer.Remainder = nRemainder;
	return tAnswer
	
	end
end

--========================================|
-- MathEx.Base10ToBaseX                   |
--========================================|
function MathEx.Base10ToBaseX(numNumber, nOutputBase)

	if nOutputBase > 1 and nOutputBase < 37 and numNumber ~= "" and numNumber ~= nil then

		tMathExLetters = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};

		local sCurrentNumber = "";
		nCurrentDividend = numNumber;

		repeat
			tAnswer = MathEx.Divide(nCurrentDividend, nOutputBase);
			nCurrentDividend = tAnswer.Quotient;
				
				if tAnswer.Remainder > 9 then
					tAnswer.Remainder = tMathExLetters[tAnswer.Remainder - 9];
				end
				
			sCurrentNumber = ""..tAnswer.Remainder..""..sCurrentNumber;
		until tAnswer.Quotient == 0

		return sCurrentNumber
	
	else 
		return -1
	end	
end