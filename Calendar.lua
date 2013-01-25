--[[
Script Name:		Calendar
Script Features:	Time, Day, Date Functions
Script Author:		Psych0 C0d3r
Script Version:		0.3a

--]]

Calendar = {};

local floor = math.floor
local mod = math.mod

--######################################################
--					Local Helper Functions
--######################################################

--[[
		Borrowed from DateLUA Library
]]--

-- day since year 0
local function dayfromyear(y)
	return 365 * y + floor(y/4) - floor(y/100) + floor(y/400)
end

-- day number from date, month is zero base
local function makedaynum(d, m, y)
	local mm = mod( mod(m,12) + 10, 12 )
	return dayfromyear( y + floor( m/12 ) - floor( mm/10 ) ) + floor( (mm*306 + 5) / 10 ) + d - 307
end

-- date from day number, month is zero base
local function breakdaynum(g)
	local g = g + 306
	local y = floor((10000*g + 14780)/3652425)
	local d = g - dayfromyear(y)
	if d < 0 then 
		y = y - 1
		d = g - dayfromyear(y) 
	end
	local mi = floor((100*d + 52)/3060)
	return (d - floor((mi*306 + 5)/10)), mod(mi + 2,12), (floor((mi + 2)/12) + y - 1)
end

--######################################################
--						Day & Date
--######################################################

function Calendar.FormatDate(D,M,Y,Del)
	if type(Del) == "nil" then
		Del = "/";
	end
	return string.format("%02d"..Del.."%02d"..Del.."%04d", D, M, Y);
end

function Calendar.UnFormatDate(Date,Del)
	if type(Del) == "nil" then
		return
	end
	_, _, D, M, Y = string.find(Date, "(%d+)"..Del.."(%d+)"..Del.."(%d+)");
  	return D, M, Y;
end

function Calendar.SubtractDate(Date1, Date2, Del, Type)
	local d1, m1, y1 = Calendar.UnFormatDate(Date1, Del)
	local d2, m2, y2 = Calendar.UnFormatDate(Date2, Del)
	local days = makedaynum(d1, m1, y1) - makedaynum(d2, m2, y2)
	
	if Type == "D" then
		return days
	elseif Type == "YMD" then
		local d, m, y = breakdaynum( days )
		
		if d ~= 0 and m == 0 and y == 0 then
			if d == 1 then return d.." Day" else return d.." Days" end
		elseif y == 0 and m <= 12 then
			return m.." Month(s) "..d.." Day(s)"
		else 
			return y.." Year(s) "..m.." Month(s) "..d.." Day(s)"
		end
	end
end