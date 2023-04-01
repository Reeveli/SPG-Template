//Addonn keybindings
#include "\a3\ui_f\hpp\defineDIKCodes.inc"

["UGTX Compass","UGTX_on", "Toggle UGTX Compass", {[] call UGTX_fnc_compass_toggle}, ""] call CBA_fnc_addKeybind;
["UGTX Compass","UGTX_pos", "Switch compass position", {[] call UGTX_fnc_switch_compass}, ""] call CBA_fnc_addKeybind;

UGTX_toggle = false;
UGTX_posTop = true;

UGTX_imgCompImg = "scripts\KLT\Compass\imgs\default-sfp.paa";
UGTX_imgScrollLock = "scripts\KLT\Compass\imgs\key-scrolllock.paa";
UGTX_imgEnd = "scripts\KLT\Compass\imgs\key-end.paa";
UGTX_imgPgUp = "scripts\KLT\Compass\imgs\key-pageup.paa";