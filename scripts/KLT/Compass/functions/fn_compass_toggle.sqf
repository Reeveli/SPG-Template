//Master function by Reeveli to enable toggle function
if !(hasInterface) exitWith {};
if !(Enable_UTGX) exitWith {};

UGTX_toggle = !UGTX_toggle;

if (UGTX_toggle) then {
	_comp = [] spawn UGTX_fnc_compileCompass;
    _compassInit = [] spawn UGTX_fnc_showCompass;
} else {
	["864", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
	ctrlDelete (GTX_ctrlGrp#0);
	ctrlDelete (GTX_compNeed#0);
	ctrlDelete (GTX_grpBg#0);
	terminate _comp;
	terminate _compassInit;
};

UGTX_toggle;