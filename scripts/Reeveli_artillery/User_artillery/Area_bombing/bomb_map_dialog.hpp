/*
 * Author: Reeveli 
 * Part of Reeveli's User Artillery system, area bombing.
 * Main ddialog for area bombing ordnance option.
 *
 1.1
	Pattern list neutered
 */

#define IDD_REV_BOM  					6050

#define IDC_REV_BOM_ATTC_LIST  			6052
#define IDC_REV_BOM_AMOUNT_TXT			6053
#define IDC_REV_BOM_AMOUNT 				6054
#define IDC_REV_BOM_PATTERN				6057

class Rev_arty_bomb_dialog
{
	idd = IDD_REV_BOM;
	movingEnable = true;
	onUnload = "params ['_display','_exitCode'];[_display,_exitCode] call Rev_arty_fnc_bomb_map_dialog_onUnload";
	class ControlsBackground
	{
		//ControlsBackground used to prevent layer issues with Objects
		//Invisible title is needed for reasons beyond my understanding for the top most control to be visible
		class Title_filler: RscText
		{
			text = "";
		};
		class Map_case: Rev_arty_mapCase {};
		class Map: Rev_arty_map
		{
			onLoad = "params ['_control', ['_config', configNull]]; _control ctrlMapAnimAdd [0, 1, getMarkerPos 'Rev_arty_bom_tgt']; ctrlMapAnimCommit _control";
			onDraw = "params ['_control', ['_config', configNull]];[_control] call Rev_arty_fnc_dialog_light";
		};
		//Warning element
		class Text_warning: Rev_arty_warningText
		{
			text = "Select approach direction from outside the red circle.";
		};		
		//Night time layer for warning element
		class Night_warning: Rev_arty_warningNight {};
		class Title_aircraft: RscText
		{			
			moving = true;
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 4 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 11 * pixelGridNoUIScale * pixelH";
			w = 26 * pixelGridNoUIScale * pixelW;
			h = 2 * pixelGridNoUIScale * pixelH;
			onLoad = "params ['_control', ['_config', configNull]]; _control ctrlSetText (getText (configFile >> 'CfgVehicles' >> Rev_arty_BOM_class >> 'displayname'));";	
			font = "Caveat";			
			shadow = 0;
			SizeEx = 2.25 * pixelGridNoUIScale * pixelH;
			style = ST_LEFT;
			colorBackground[] = {0.98,0.95,0.98,0};
			colorText[] = {0,0,0,1};
		};
		//Aircraft name frame
		class Frame_aircraft: Rev_arty_frame
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 11 * pixelGridNoUIScale * pixelH";
		};
		//Aircraft image
		class Aircraft_img: Rev_arty_img {};
		//Night time layer for aircraft image
		class Night_plane: Rev_arty_imgNight{};
		//Ordnance selection
		class Title_ordnance: Title_aircraft
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 4 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 27 * pixelGridNoUIScale * pixelH";			
			w = 11 * pixelGridNoUIScale * pixelW;
			h = 2 * pixelGridNoUIScale * pixelH;
			text = "Select payload";			
			tooltip = "Select ammunition type to be used from the list bellow";	
			onLoad = "";
		};
		class Title_available: Title_ordnance
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 19 * pixelGridNoUIScale * pixelW";
			text = "Available";
			tooltip = "Available ordnance for each ammunition type";	
			onLoad = "";
		};
		//loadout selection frames		
		class Frame_slot1: Frame_aircraft
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 30 * pixelGridNoUIScale * pixelH";
		};		
		class Frame_slot2: Frame_aircraft
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 32 * pixelGridNoUIScale * pixelH";
		};		
		class Frame_slot3: Frame_aircraft
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 34 * pixelGridNoUIScale * pixelH";
		};
		class Ordnance_list: RscListNBox
		{
			idc = IDC_REV_BOM_ATTC_LIST;
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 4 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 30 * pixelGridNoUIScale * pixelH";
			w = 27 * pixelGridNoUIScale * pixelW;
			h = 10 * pixelGridNoUIScale * pixelH;
			columns[] = {
				-0.01,
				27.5 * pixelGridNoUIScale * pixelW
			};
			style = ST_LEFT;
			font = "Caveat";			
			SizeEx = 2 * pixelGridNoUIScale * pixelH;
			colorBackground[] = {0.98,0.95,0.98,0};
			colorText[] = {0,0,0,1};
			colorSelectBackground[] = {0.98,0.95,0.98,0};
			colorSelectBackground2[] = {0.98,0.95,0.98,0};
			wholeHeight = 6 * pixelGridNoUIScale * pixelH;
			tooltip = "Available paylod options";
			tooltipPerColumn = true;
			onLBSelChanged = "params ['_control', '_selectedIndex'];[_control,_selectedIndex] call Rev_arty_fnc_dialog_pen; if ((markerAlpha 'Rev_arty_bom_dir') == 1) then {private _display = ctrlParent _control; private _warning = _display displayCtrl 6072; private _ok = _display displayCtrl 6069; private _underscore = _display displayCtrl 6071; _warning ctrlSetTextColor [0,0,0,0.3];_ok ctrlEnable true;_underscore ctrlShow true;};";
		};	
		class Frame_ordnance: Frame_aircraft
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 39 * pixelGridNoUIScale * pixelH";
			h = 4 * pixelGridNoUIScale * pixelH;
		};	
		class Title_amount: Title_ordnance
		{
			idc = IDC_REV_BOM_AMOUNT_TXT;
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 4 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 40 * pixelGridNoUIScale * pixelH";
			w = 14 * pixelGridNoUIScale * pixelW;
			text = "Ordnance amount: ";
			tooltip = "";	
		};
		class Slider_amount: Rev_arty_slider
		{	
			idc = IDC_REV_BOM_AMOUNT;
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 18 * pixelGridNoUIScale * pixelW";
			w = 11.5 * pixelGridNoUIScale * pixelW;
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 40.5 * pixelGridNoUIScale * pixelH";
			onSliderPosChanged = "params ['_control', '_newValue']; ctrlSetText [6053, format ['Ordnance amount: %1',round _newValue]]; 'Rev_arty_bom_tgt' setMarkerSizeLocal [20, 12.5 * (round _newValue)];";
			tooltip = "How many bombs will be delivered";
		};	

	/* //Pattern control neutered, left as legacy
		class Frame_pattern: Frame_aircraft
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 43 * pixelGridNoUIScale * pixelH";
			h = 4 * pixelGridNoUIScale * pixelH;
		};	
		class Text_pattern: Title_amount
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 44 * pixelGridNoUIScale * pixelH";
			text = "Drop pattern:";
		};
		class List_pattern: RscCombo
		{
			idc = IDC_REV_BOM_PATTERN;
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 20 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 44 * pixelGridNoUIScale * pixelH";
			w = 9 * pixelGridNoUIScale * pixelW;
			h = 2 * pixelGridNoUIScale * pixelH;
			font = "Caveat";			
			SizeEx = 2 * pixelGridNoUIScale * pixelH;
			colorBackground[] = {
				"(missionNamespace getvariable ['Rev_arty_n_alpha',[1,0,0.98,0.95,1,1]]) select 2",
				"((missionNamespace getvariable ['Rev_arty_n_alpha',[1,0,0.98,0.95,1,1]]) select 3)",
				"(missionNamespace getvariable ['Rev_arty_n_alpha',[1,0,0.98,0.95,1,1]]) select 2",
				1
			};
			colorText[] = {0,0,0,1};
			colorActive[] = {1,0,0,0};
			colorSelect[] = {0,0,0,1};
			colorSelect2[] = {0,0,0,1};
			colorSelectBackground[] = {0,0,0,0};
			colorSelectBackground2[] = {0,0,0,0};
			wholeHeight = 10 * pixelGridNoUIScale * pixelH;		
			arrowEmpty = "scripts\Reeveli_artillery\images\combobox_arrowD.paa";
			arrowFull = "scripts\Reeveli_artillery\images\combobox_arrowD.paa";
			onLBSelChanged = "params ['_control', '_selectedIndex'];[_control,_selectedIndex] call Rev_arty_fnc_bomb_pattern";
		};
	*/
		
		//Buttons
		class Button_cancel: Rev_arty_cancel {};
		class Pen: Rev_arty_pen {};		
		class Underscrore: Rev_arty_underscrore {};
		//Button set on top of underscore to enable button tooltip to be visible
		class Button_ok: Rev_arty_ok {};
	};

	
	class Objects
	{ 
		class GPS: Rev_arty_gps {};
	};
	
};
