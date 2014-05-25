require("LoadFunc")

--[[
   Generates a table for a function of x
--]]
function Generate_Table(Func, Start, End, Step)
   local t = {}
   for i = Start, End, Step do
      table.insert(t, func_eval(Func, i))
   end
   return t
end

--[[
   Approximate numerical integration of a function by the Trapezoidal rule.

   h is the step size
   Y is a table containing values of the function at various points
--]]
function Trapezoidal(Y, h)
   local ans = Y[1] + Y[#Y]
   for i = 2, #Y-1 do
      ans = ans + 2 * Y[i]
   end
   return (1/2) * h * ans
end


--[[
   Simpson's 1/3rd Rule
]]--
function Simpsons_One_Third(Y, h)
   local ans = Y[1] + Y[#Y]
   for i = 2, #Y-1 do
      if ((i-1)%2 == 0) then
         ans = ans + 2 * Y[i]
      else
         ans = ans + 4 * Y[i]
      end
   end
   return (1/3) * h * ans
end

--[[
   Simpson's 3/8th Rule
]]--
function Simpsons_Three_Eighth(Y, h)
   local ans = Y[1] + Y[#Y]
   for i = 2, #Y-1 do
      if ((i-1)%3 == 0) then
         ans = ans + 2 * Y[i]
      else
         ans = ans + 3 * Y[i]
      end
   end
   return (3/8) * h * ans
end

--[[
   Boole's Rule
]]--
function Boole(Y, h)
   local ans = 7 * (Y[1] + Y[#Y])
   for i = 2, #Y-1 do
      if ((i-1)%4 == 0) then -- 4n
         ans = ans + 14 * Y[i]
      elseif ((i-1)%4 == 1) or ((i-1)%4 == 3) then -- 4n+1/4n+3
         ans = ans + 32 * Y[i]
      else -- 4n+2
         ans = ans + 12 * Y[i]
      end
   end
   return (2/45) * h * ans
end

--[[
   Weddle's Rule
]]--
function Weddle(Y, h)
   local ans = Y[1] + Y[#Y]
   for i = 2, #Y-1 do
      if ((i-1)%6 == 0) then -- 6n
         ans = ans + 2 * Y[i]
      elseif ((i-1)%6 == 1) or ((i-1)%6 == 5) then -- 6n+1/6n+5
         ans = ans + 5 * Y[i]
      elseif ((i-1)%6 == 2) or ((i-1)%6 == 4) then -- 6n+2/6n+4
         ans = ans + Y[i]
      else -- 6n+3
         ans = ans + 6 * Y[i]
      end
   end
   return (3/10) * h * ans
end

-- Testing Ground

f = " 1/(1+x^2) "

s = 0
e = 6
h = 1

ret = Generate_Table(f, s, e, h)

print("Function to integrate: " .. f)
print()

print("Table Generated: ")
print(unpack(ret))
print()

print("Approximatations by: ")
print("Trapezoidal : " .. Trapezoidal(ret, h))
print("Simpson's 1/3rd : " .. Simpsons_One_Third(ret, h))
print("Simpson's 3/8th : " .. Simpsons_Three_Eighth(ret, h))
print("Boole's : " .. Boole(ret, h))
print("Weddle's : " .. Weddle(ret, h))
print()

