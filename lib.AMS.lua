--[[
The libLua Project - A collection of pure lua functions.

libLua.AMS 
	Extensions of common Autoplay Media Studio functions.

Contains =>

System - Wrappers/Extensions for built-in system functions.

--]]

libLua = {}
libLua.AMS = {}

--######################################################
--					System Functions
--######################################################

libLua.AMS.System = {};

function libLua.AMS.System.IsEnglish()
	local tLangID = System.GetDefaultLangID();
	if tLangID.Primary == 9 then return true
	else return false end;
end

function libLua.AMS.System.IsRAM(Val)
	if System.GetRAM >= Val then return true
	else return false end;
end

function libLua.AMS.System.IsOS(Val)
	if System.GetOSName() == Val then return true;
	else return false end;
end

function libLua.AMS.System.GetRAM()
	return System.GetMemoryInfo().TotalRAM;
end

function libLua.AMS.System.GetCompName()
	return Registry.GetValue(HKEY_LOCAL_MACHINE, "System\\CurrentControlSet\\Control\\ComputerName\\ComputerName", "ComputerName", false);
end

function libLua.AMS.System.GetProcName()
	return String.TrimLeft(Registry.GetValue(HKEY_LOCAL_MACHINE, "HARDWARE\\DESCRIPTION\\System\\CentralProcessor\\1", "ProcessorNameString", false), nil);
end

function libLua.AMS.System.GetEnv(Val)
	Shell.Execute("cmd.exe", "open", "/C echo "..Val.." > env.tmp", _TempFolder, SW_HIDE, true);
	return String.TrimRight(TextFile.ReadToString(_TempFolder.."\\env.tmp"), nil);
end