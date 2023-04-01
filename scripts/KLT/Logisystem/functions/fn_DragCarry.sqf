
params ["_object"]; 
diag_log text format ["Making %1 [%2] Carrable", _object, typeOf _object]; 
[_object, true, [0, 1.5, 0], 0] call ace_dragging_fnc_setDraggable;
[_object, true, [0, 1.5, 0.1], 0] call ace_dragging_fnc_setCarryable;

if (isServer) then {[format ["%1 Set up as draggeble object", _object], "Ace_Drag_Carry"] call KLT_fnc_log;};