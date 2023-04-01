
params [
    ["_text", "", [""]],
    ["_tag", "INFO", [""]]
];

if (_text isEqualTo "" || _tag isEqualTo "") exitWith {["Empty string given"] call BIS_fnc_error; false};

private _msg = text ([
    "[KLT_Logi] [",
    _tag,
    "] ",
    _text
] joinString "");

diag_log _msg;

true
