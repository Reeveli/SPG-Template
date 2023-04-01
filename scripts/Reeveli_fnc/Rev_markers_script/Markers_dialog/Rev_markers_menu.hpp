
//Base classes and defines
#define BORDER	0.002

class small_button
{
	x = safeZoneX + safeZoneW * (0.675 + BORDER);
	type = 1;
	idc = -1;
	w = safeZoneW * 0.0665;
	h = safeZoneH * 0.035;
	style = 0+2;
	borderSize = 0;
	colorBackground[] = {0,0,0,1};
	colorBackgroundActive[] = {0.2,0.2,0.2,1};
	colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
	colorBorder[] = {1,1,1,1};
	colorDisabled[] = {0.5,0.5,0.5,1};
	colorFocused[] = {0.2,0.2,0.2,1};
	colorShadow[] = {0,0,0,1};
	colorText[] = {1,1,1,1};
	font = "PuristaMedium";
	offsetPressedX = 0;
	offsetPressedY = 0;
	offsetX = 0;
	offsetY = 0;
	sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
	soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
};

class big_button: small_button
{
	x = safeZoneX + safeZoneW * (0.743 + BORDER);
	w = safeZoneW * 0.0765;
};

class Title_bar
{
	type = 0;
	idc = -1;
	x = 0;
	y = safeZoneY + safeZoneH * 0.248;
	text = "";
	w = safeZoneW * 0.149;
	h = safeZoneH * 0.025;
	style = 2;
	colorBackground[] = {0.1926,0.3515,1,0.8};
	colorText[] = {1,1,1,1};
	font = "PuristaMedium";
	sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
	moving = true;
	shadow = 0;	
};






//Marker menu
class Rev_marker_menu2
{
	idd = 4220;
	movingEnable = true;
	onLoad = "uiNamespace setVariable ['Rev_marker_menu', _this select 0]";
    onUnload = "uiNamespace setVariable ['Rev_marker_menu', displayNull];";
	onMouseMoving = "call Rev_markers2_fnc_update_menu";
	onMouseButtonDown = "call Rev_markers2_fnc_update_menu";
	
	class ControlsBackground
	{
		class Main_title: Title_bar
		{
			x = safeZoneX + safeZoneW * 0.675;
			text = "Reeveli's User Marker System";			
		};
		class Tausta
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.675;
			y = safeZoneY + safeZoneH * 0.273 + (2 * BORDER);
			w = safeZoneW * 0.149;
			h = safeZoneH * 0.265;
			style = 96;
			text = "";
			colorBackground[] = {0,0,0,0.8};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			moving = true;
			
		};
		class Profile_title: Title_bar
		{
			x = safeZoneX + safeZoneW * 0.826;
			w = safeZoneW * 0.12;
			text = "User profile";			
		};
		class Profile_tausta: Tausta
		{
			x = safeZoneX + safeZoneW * 0.826;
			w = safeZoneW * 0.12;		
		};

	};
	class Controls
	{
		class Button_setArray: small_button
		{
			idc = 4026;
			y = safeZoneY + safeZoneH * 0.277 + BORDER;
			text = "Create array";
			action = "call Rev_markers2_fnc_Array_create";
			tooltip = "Create array of current map markers";
			
		};
		class Button_loadFromArray: big_button
		{
			idc = 4024;
			y = safeZoneY + safeZoneH * 0.277 + BORDER;
			text = "Load from array";
			action = "call Rev_markers2_fnc_Array_load";
			tooltip = "Load map markers from array";
			
		};
		class Field_saveTo
		{
			type = 2;
			idc = 4021;
			x = safeZoneX + safeZoneW * (0.675 + BORDER);
			y = safeZoneY + safeZoneH * (0.314 + BORDER);
			w = safeZoneW * 0.1465;
			h = safeZoneH * 0.035;
			style = 0;
			text = "";
			onKeyDown = "call Rev_markers2_fnc_update_menu";
			autocomplete = "";
			colorBackground[] = {0.302,0.302,0.302,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelection[] = {1,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			forceDrawCaret = true;
			shadow = 0;
			
		};
		class Combo_channels
		{
			type = 4;
			idc = 4022;
			x = safeZoneX + safeZoneW * (0.675 + BORDER);
			y = safeZoneY + safeZoneH * (0.351 + BORDER);
			w = safeZoneW * 0.145;
			h = safeZoneH * 0.035;
			style = 16;
			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
			colorBackground[] = {0,0,0,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {1,1,1,1};
			colorSelectBackground[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaSemiBold";
			maxHistoryDelay = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1.0};
			soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1.0};
			soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1.0};
			wholeHeight = 0.3;
			onLBSelChanged = "params ['_control', '_selectedIndex']; setCurrentChannel (parsenumber (_control lbData _selectedIndex))";
			onLoad = "call Rev_markers2_fnc_menu_channels";
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
		};
		class Button_save: small_button
		{
			idc = 4025;
			y = safeZoneY + safeZoneH * (0.388 + BORDER);
			text = "Save to profile";
			action = "call Rev_markers2_fnc_save";
			tooltip = "Saves currently placed user markers to you profile. Specify the marker set name in the text field above.";			
		};
		class Button_load: big_button
		{			
			idc = 4023;
			y = safeZoneY + safeZoneH * (0.388 + BORDER);
			text = "Load from profile";
			action = "call Rev_markers2_fnc_load";
			tooltip = "Load currently selected profile marker set.";			
		};
		class Button_clearMap: small_button
		{
			idc = 4028;
			y = safeZoneY + safeZoneH * (0.425 + BORDER);
			text = "Clear map";
			action = "call Rev_markers2_fnc_clear";
			tooltip = "Clears your map of player map markers";		
		};
		class Button_clearProfile: big_button
		{
			idc = 4027;
			y = safeZoneY + safeZoneH * (0.425 + BORDER);
			text = "Delete selected";
			action = "call Rev_markers2_fnc_delete";
			tooltip = "Delete selected marker set from your profile.";
		};
		class Button_close: small_button
		{
			idc = 2;
			y = safeZoneY + safeZoneH * (0.462 + BORDER);
			text = "Close";
			tooltip = "Close menu";
		};
		class Button_deleteAll: big_button
		{
			idc = 4029;
			y = safeZoneY + safeZoneH * (0.462 + BORDER);
			text = "Delete profile";
			action = "(uiNamespace getVariable ['Rev_marker_menu', DisplayNull]) closeDisplay 2;(uiNamespace getVariable ['Rev_marker_menu', DisplayNull]) createDisplay 'Rev_marker_confirmation'";
			tooltip = "Delete all saved marker sets from your user profile";
		};
		class Button_url: small_button
		{
			y = safeZoneY + safeZoneH * 0.502;
			w = safeZoneW * 0.145;
			text = "Open documentation";
			url = "https://docs.google.com/document/d/1v2NwtL5S1k7O54kIimPlOhjQqLtxF0DVTB81fbSFIBk/edit";			
		};
		class Profile_filter: Combo_channels
		{
			idc = 4050;
			x = safeZoneX + safeZoneW * (0.826 + BORDER);
			y = safeZoneY + safeZoneH * 0.277 + BORDER;
			w = safeZoneW * 0.116;
			font = "PuristaMedium";
			onLBSelChanged = "call Rev_markers2_fnc_world_list"; 		
		};
		class Marker_listbox: RscListBox {
			idc = 4051;
			x = safeZoneX + safeZoneW * 0.828;
			y = safeZoneY + safeZoneH * 0.316;
			w = safeZoneW * 0.116;
			h = safeZoneH * 0.22;
			font = "PuristaMedium";
			colorText[] = {1,1,1,1};
			sizeEx = 0.018 * safezoneH;
			rowHeight = 0.018 * safezoneH * 1.25;
			colorBackground[] = {0,0,0,0};
			colorSelect[] = {1,1,1,1};
			colorSelect2[] = {1,1,1,1};
			colorSelectBackground[] = {0.86,0.86,0.86,0.5};
			colorSelectBackground2[] = {0.86,0.86,0.86,0.5};
			colorActive[] = {1,1,1,1};
			colorDisabled[] = {0.2, 0.23, 0.18, 0};
			period = 0.3;
			maxHistoryDelay = 1.0;
			onLBSelChanged = "params ['_control', '_selectedIndex']; if (_selectedIndex > -1) then {((uiNamespace getVariable ['Rev_marker_menu', DisplayNull]) displayCtrl 4023) ctrlEnable true;((uiNamespace getVariable ['Rev_marker_menu', DisplayNull]) displayCtrl 4027) ctrlEnable true} else {((uiNamespace getVariable ['Rev_marker_menu', DisplayNull]) displayCtrl 4023) ctrlEnable false; ((uiNamespace getVariable ['Rev_marker_menu', DisplayNull]) displayCtrl 4027) ctrlEnable false};"; 
			text = "";
		};
	};
	
};






class Rev_marker_confirmation
{
	idd = -1;
	onLoad = "uiNamespace setVariable ['Rev_marker_confirm', _this select 0]";
    onUnload = "uiNamespace setVariable ['Rev_marker_confirm', displayNull]";
	
	class ControlsBackground
	{
		class C_Title_bar: Title_bar
		{
			x = safeZoneX + safeZoneW * (0.526 - BORDER);
			text = "Deleting profile!";
		};
		class Bacground
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * (0.526 - BORDER);
			y = safeZoneY + safeZoneH * 0.273 + (2 * BORDER);
			w = safeZoneW * 0.149;
			h = safeZoneH * 0.265;
			style = 96;
			text = "";
			colorBackground[] = {0,0,0,0.8};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			moving = true;
			
		};
		
	};
	class Controls
	{
		class Main_text
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * (0.526);
			y = safeZoneY + safeZoneH * 0.273 + (2 * BORDER);
			w = safeZoneW * 0.145;
			h = safeZoneH * 0.228;
			style = 0+16+512;
			text = "Warning! You are about to delete all saved map makers from your user profile. This process is irreversible.";
			colorBackground[] = {0.302,0.302,0.302,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			lineSpacing = 1;
			moving = false;
			shadow = 0;
			
		};
		class Close: small_button
		{
			x = safeZoneX + safeZoneW * (0.526);
			y = safeZoneY + safeZoneH * 0.502;
			w = safeZoneW * 0.0715;
			text = "Cancel";
			action = "(uiNamespace getVariable ['Rev_marker_confirm', DisplayNull]) closeDisplay 2;call Rev_markers2_fnc_menu_start;";
			
		};
		class Confirm: big_button
		{
			x = safeZoneX + safeZoneW * 0.59995;
			y = safeZoneY + safeZoneH * 0.502;
			w = safeZoneW * 0.0715;
			text = "Delete profile";
			action = "call Rev_markers2_fnc_delete_all";
			
		};
		
	};
	
};
