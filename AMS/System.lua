--[[
Script Name:		SystemEx
Script Features:	System Functions
Script Author:		Psych0 C0d3r
Script Version:		0.3a

NOTE:-	Would work in Autoplay Media Studio only,
		Uses its inbuilt functions.
--]]

SystemEx = {};

--######################################################
--						Processes
--######################################################

function SystemEx.IsEnglish()
	local tLangID = System.GetDefaultLangID();
	if tLangID.Primary == 9 then return true
	else return false end;
end

function SystemEx.IsRAM(Val)
	if SystemEx.GetRAM >= Val then return true
	else return false end;
end

function SystemEx.IsOS(Val)
	if System.GetOSName() == Val then return true;
	else return false end;
end

function SystemEx.GetRAM()
	return System.GetMemoryInfo().TotalRAM;
end

function SystemEx.GetCompName()
	return Registry.GetValue(HKEY_LOCAL_MACHINE, "System\\CurrentControlSet\\Control\\ComputerName\\ComputerName", "ComputerName", false);
end

function SystemEx.GetProcName()
	return String.TrimLeft(Registry.GetValue(HKEY_LOCAL_MACHINE, "HARDWARE\\DESCRIPTION\\System\\CentralProcessor\\1", "ProcessorNameString", false), nil);
end

function SystemEx.GetEnv(Val)
	Shell.Execute("cmd.exe", "open", "/C echo "..Val.." > env.tmp", _TempFolder, SW_HIDE, true);
	return String.TrimRight(TextFile.ReadToString(_TempFolder.."\\env.tmp"), nil);
end