
-- Native Windows Stuff
local ffi = require("ffi");
ffi.cdef[[
bool LockWorkStation();
int ExitWindowsEx(int uFlags, int dwReason);
bool SetSuspendState(bool hibernate, bool forceCritical, bool disableWakeEvent);
]]
local PowrProf = ffi.load("PowrProf");

local win = libs.win;

local WM_SYSCOMMAND = 0x0112;
local SC_MONITORPOWER = 0xF170;
local HWND_BROADCAST = 0xffff;

--@help Force system restart
--@param sec:number Timeout in seconds (default 5)
actions.restart = function (sec)
	if not sec then sec = 5; end
	os.execute("shutdown /r /f /t " .. sec);
end

--@help Force system shutdown
--@param sec:number Timeout in seconds (default 5)
actions.shutdown = function (sec)
	if not sec then sec = 5; end
	os.execute("shutdown /s /f /t " .. sec);
end

--@help Turn monitor on
actions.turn_on = function()
	win.post(HWND_BROADCAST, WM_SYSCOMMAND, SC_MONITORPOWER, -1);
end

--@help Turn monitor off
actions.turn_off = function()
	win.post(HWND_BROADCAST, WM_SYSCOMMAND, SC_MONITORPOWER, 2);
end
