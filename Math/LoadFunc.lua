-- Trigonometric Functions
sin, asin, sinh = math.sin, math.asin, math.sinh
cos, acos, cosh = math.cos, math.acos, math.cosh
tan, atan, atan2 = math.tan, math.atan, math.atan2

-- Exponentiation and Logarithms
exp, ln, log = math.exp, math.log, math.log10

-- Powers
pow, sqrt = math.pow, math.sqrt

-- Rounding
floor, ceil = math.floor, math.ceil

-- Radians, Degree
rad, deg = math.rad, math.deg

-- Random
rand, srand = math.random, math.randomseed

--------------------------------------------------

function func_eval(func, point)
   x = point
   assert(loadstring("y="..func)) ()
   return y
end

-- Test
-- print(func_eval("cos(x)", 0))
