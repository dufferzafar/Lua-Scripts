--[[
Script Name:		Calendar
Script Features:	Time, Day, Date Functions
Script Author:		Psych0 C0d3r
Script Version:		0.3a

NOTE:-	Would work in Autoplay Media Studio only,
		Uses its inbuilt functions.
--]]

Calendar = {};

--######################################################
--						Day & Date
--######################################################
function Calendar.Day()
	return System.GetDate(5);
end

function Calendar.Month()
	return System.GetDate(4);
end

function Calendar.Year()
	return System.GetDate(6);
end

function Calendar.DayOfWeek()
	return System.GetDate(7);
end

function Calendar.Date(Format)
	if Format == "DD/MM/YYYY" then
		return System.GetDate(1);
	elseif Format == "MM/DD/YYYY" then
		return System.GetDate(0);
	elseif Format == "YYYY-MM-DD" then
		return System.GetDate(2);
	elseif Format == "Julian" then
		return System.GetDate(3);	
	end
end

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