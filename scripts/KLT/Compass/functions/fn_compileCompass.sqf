("compassTitle" call BIS_fnc_rscLayer) cutRsc ["RscTitleDisplayEmpty", "PLAIN", -1, false];

with uiNamespace do {
	_display = uiNamespace getVariable "RscTitleDisplayEmpty";
	GTX_ctrlGrp = _display ctrlCreate ["RscControlsGroup", 7634];
	GTX_ctrlGrp ctrlSetPosition [0.4 * safezoneW + safezoneX,0.01111 * safezoneH + safezoneY,0.2 * safezoneW,10 * safezoneH];
	GTX_ctrlGrp ctrlCommit 0;

	GTX_grpBg = _display ctrlCreate ["RscStructuredText", 7635];
	GTX_grpBg ctrlSetBackgroundColor [0, 0, 0, 0.1];
	GTX_grpBg ctrlSetPosition [0.4 * safezoneW + safezoneX,0.01111 * safezoneH + safezoneY,0.2 * safezoneW,0.038 * safezoneH];
	GTX_grpBg ctrlCommit 0;

	GTX_compImg = _display ctrlCreate ["RscPicture", 7636, GTX_ctrlGrp];
	GTX_compImg ctrlSetText "scripts\KLT\Compass\imgs\default-sfp.paa";
	GTX_compImg ctrlCommit 0;

	GTX_compNeed = _display ctrlCreate ["RscStructuredText", 7637];
	GTX_compNeed ctrlSetPosition [(0.5 * safezoneW + safezoneX)- 0.05,0.01111 * safezoneH + safezoneY,0.1,0.09 * safezoneH];
	GTX_compNeed ctrlSetStructuredText parseText ("<t shadow=1><t align='center' size='0.4' font='PuristaLight'>I");
	GTX_compNeed ctrlCommit 0;
};

GTX_ctrlGrp = [uiNamespace getVariable "GTX_ctrlGrp"];
GTX_compNeed = [uiNamespace getVariable "GTX_compNeed"];
GTX_grpBg = [uiNamespace getVariable "GTX_grpBg"];
GTX_compImg = [uiNamespace getVariable "GTX_compImg"];
