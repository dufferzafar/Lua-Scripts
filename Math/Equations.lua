require("LoadFunc")

-- Next iteration by various methods
function bisection_next(a, b)
   return 0.5 * (a + b)
end

function regula_next(a, b, f)
   return (a*f(b) - b*f(a))/(f(b) - f(a))
end

function raphson_next(a, f, fdash)
   return a - f(a)/fdash(x1)
end

-- Generic Equation Solver
-- More methods can be added
function Solve(method, eq, a, b, precision)
   local old, err = 0, precision + 1

   local function f(x)
      return func_eval(eq, x)
   end

   while(err > precision) do

      if method == "bisection" then
         x = bisection_next(a, b)
      elseif method == "regula" then
         x = regula_next(a, b, f)
      end

      if (f(x) < 0) then
         a = x
      elseif (f(x) > 0) then
         b = x
      end

      err = math.abs(x - old)
      old = x
   end

   return x
end

-- Tests and Samples

print(Solve("bisection", "x^3-4*x-9", 2, 3, 0.0001))
print(Solve("regula",    "x^3-4*x-9", 2, 3, 0.0001))

print()

print(Solve("bisection", "cos(x)-x*exp(x)", 0, 1, 0.0001))
print(Solve("regula",    "cos(x)-x*exp(x)", 0, 1, 0.0001))

print()

print(Solve("bisection", "x*log(x) - 1.2", 2, 3, 0.0001))
print(Solve("regula",    "x*log(x) - 1.2", 2, 3, 0.0001))

