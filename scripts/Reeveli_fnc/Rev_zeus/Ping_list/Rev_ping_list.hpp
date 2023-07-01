/*
 * Author: Reeveli
 * Controls for curator pinglist
 *
1.1.1
	Fixed a two missing semicolons
1.1
	Updated onLoad EHs for Ping_list_bg, Ping_list_frame, Ping_list
		Gave varibale idents
		Added ctrlShow commands based on if they should be visible
 */
class Rev_ping_list: ctrlControlsGroupNoScrollbars
{	
	x = "safeZoneX + (([1.5, 0] select (missionNamespace getVariable [""zen_editor_moveDisplayToEdge"", false]))) + 11* (((safezoneW / safezoneH) min 1.2)/ 40)";
	y = "safeZoneY + ([0.5, 0] select (missionNamespace getVariable [""zen_editor_moveDisplayToEdge"", false]))* ((((safezoneW / safezoneH) min 1.2)/ 1.2)/ 25)";
	w = "11 * 							(			((safezoneW / safezoneH) min 1.2)/ 40)"; //0.5 offset to leave room for frame
	h = "4 * 							(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"; //0.5 offset to leave room for frame	
	onLoad = "uiNamespace setVariable ['Rev_ping_list_ctrlGroup', _this select 0];";
	onUnLoad = "uiNamespace setVariable ['Rev_ping_list_ctrlGroup', controlNull];";
	
	class controls
	{
		class Ping_list_title_frame: RscFrame
		{
			x = 0;
			y = 0;
			w = "11 * 							(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 							(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorText[] = {0,0,0,1};
		};
		class Ping_list_title: RscButton
		{
			text = "PING LIST";
			x = 0;
			y = 0;
			w = "11 * 							(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 							(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			style = ST_CENTER;
			sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";	
			colorBackground[] = {0,0,0,0};
			onButtonClick = "params ['_control','_config']; [_control] call Rev_fnc_pingList_onButtonClick";
		};
		//Extra background since listbox is offset to line up with entities tree. width as not to go over frame
		class Ping_list_bg: RscText
		{
			idc = 6085;
			colorBackground[] = {0.1,0.1,0.1,0.5};
			x = 0;
			y = "1 * 							(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "10.95 * 							(			((safezoneW / safezoneH) min 1.2)/ 40)";
			h = "3 * 							(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			onLoad = "params ['_control','_config']; uiNamespace setVariable ['Rev_Ping_list_bg', _control]; _control ctrlShow (uiNamespace getVariable ['Rev_pinglist_visibility',true]) AND (ctrlShown (ctrlParentControlsGroup _control))";
		};
		class Ping_list_frame: Ping_list_title_frame
		{
			idc = 6083;
			y = "1 * 							(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			h = "3 * 							(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			onLoad = "params ['_control','_config']; uiNamespace setVariable ['Rev_Ping_list_frame', _control]; _control ctrlShow (uiNamespace getVariable ['Rev_pinglist_visibility',true]) AND (ctrlShown (ctrlParentControlsGroup _control))";
		};
		class Ping_list_listbox: RscListBox
		{
			idc = 6084;
			colorBackground[] = {0.1,0.1,0.1,0};
			x = 0;
			y = "1.22 * 							(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "10.95 *							(			((safezoneW / safezoneH) min 1.2)/ 40)";
			h = "3 * 							(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.8 * 							(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			onLoad = "params ['_control','_config']; uiNamespace setVariable ['Rev_Ping_list_listbox', _control]; [_control] call Rev_fnc_pingList_onLoad;";	
			onLBSelChanged = "params ['_control', '_lbCurSel'];[_control, _lbCurSel] call Rev_fnc_pingList_onLBSelChanged;";
		};
	};
};