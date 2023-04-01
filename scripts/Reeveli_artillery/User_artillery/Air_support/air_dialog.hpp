#define IDD_ARTY_AIR  					4080

#define IDC_ARTY_AIR_PLANE_LIST  		4081
#define IDC_ARTY_AIR_LOAD_SEL	  		4083
#define IDC_ARTY_AIR_ALT_TXT			4084
#define IDC_ARTY_AIR_ALT 				4085
#define IDC_ARTY_AIR_LOAD_LIST			4086

class Rev_arty_air_map
{
	idd = IDD_ARTY_AIR;
	movingEnable = true;
	onUnload = "params ['_display','_exitCode']; [_display,_exitCode] call Rev_arty_fnc_air_map_dialog_onUnload";
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
			onLoad = "params ['_control', ['_config', configNull]]; _control ctrlMapAnimAdd [0, 1, getMarkerPos 'Rev_arty_air_tgt']; ctrlMapAnimCommit _control";
			onDraw = "params ['_control', ['_config', configNull]];[_control] call Rev_arty_fnc_dialog_light";
		};
		//Warning element
		class Text_warning: Rev_arty_warningText
		{
			text = "Select aircraft and loadout. Select approach direction from outside the red circle.";
		};		
		//Night time layer for warning element
		class Night_warning: Rev_arty_warningNight {};

		class Title_aircraft: RscText
		{			
			moving = true;
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 4 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 11 * pixelGridNoUIScale * pixelH";
			w = 16 * pixelGridNoUIScale * pixelW;
			h = 2 * pixelGridNoUIScale * pixelH;
			text = "Select aircraft:";
			font = "Caveat";			
			shadow = 0;
			SizeEx = 2.25 * pixelGridNoUIScale * pixelH;
			style = ST_LEFT;
			colorBackground[] = {0.98,0.95,0.98,0};
			colorText[] = {0,0,0,1};
		};
		class Aircraft_list: RscCombo
		{
			idc = IDC_ARTY_AIR_PLANE_LIST;
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 15 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 11 * pixelGridNoUIScale * pixelH";
			w = 15 * pixelGridNoUIScale * pixelW;
			h = 2 * pixelGridNoUIScale * pixelH;
			font = "Caveat";		
			SizeEx = 2 * pixelGridNoUIScale * pixelH;
			colorBackground[] = {
				"(missionNamespace getvariable ['Rev_arty_n_alpha',[1,0,0.98,0.95,1,1]]) select 2",
				"(missionNamespace getvariable ['Rev_arty_n_alpha',[1,0,0.98,0.95,1,1]]) select 3",
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
			tooltip = "Selected aircraft";			
			arrowEmpty = "scripts\Reeveli_artillery\images\combobox_arrowD.paa";
			arrowFull = "scripts\Reeveli_artillery\images\combobox_arrowD.paa";
			onLBSelChanged = "params ['_control', '_selectedIndex'];[_control lbData _selectedIndex] call Rev_arty_fnc_air_selection;";			
		};
		//Aircraft list frame
		class Frame_aircraft: Rev_arty_frame 
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 4 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 11 * pixelGridNoUIScale * pixelH";
		};
		//Aircraft image
		class Aircraft_img: Rev_arty_img {};
		//Night time layer for aircraft image
		class Night_plane: Rev_arty_imgNight{};

		//Loadout title
		class Title_loadout: Title_aircraft
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 26 * pixelGridNoUIScale * pixelH";			
			w = 16 * pixelGridNoUIScale * pixelW;
			h = 2 * pixelGridNoUIScale * pixelH;
			text = "Select loadout:";			
			shadow = 0;
			SizeEx = 2.25 * pixelGridNoUIScale * pixelH;
		};
		//Loadout Selection
		class Loadout_selection: Aircraft_list
		{
			idc = IDC_ARTY_AIR_LOAD_SEL;
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 22 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 26 * pixelGridNoUIScale * pixelH";
			w = 8 * pixelGridNoUIScale * pixelW;
			tooltip = "Selected aircraft loadout";			
			onLBSelChanged = "params ['_control', '_selectedIndex'];[lbData  [4081, lbCurSel 4081],_control lbData _selectedIndex,_control] call Rev_arty_fnc_air_loadout_parse;";			
		};
		//Loadout list frame
		class Frame_lodout: Frame_aircraft
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 26 * pixelGridNoUIScale * pixelH";
		};
		class List_loadout: RscListNBox
		{
			idc = IDC_ARTY_AIR_LOAD_LIST;
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 4 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 31 * pixelGridNoUIScale * pixelH";
			w = 27 * pixelGridNoUIScale * pixelW;
			h = 10 * pixelGridNoUIScale * pixelH;
			columns[] = {
				-0.01,
				10 * pixelGridNoUIScale * pixelW
			};
			style = ST_LEFT;
			font = "Caveat";			
			SizeEx = 2 * pixelGridNoUIScale * pixelH;
			colorBackground[] = {0.98,0.95,0.98,0};
			colorText[] = {0,0,0,1};
			colorSelectBackground[] = {0.98,0.95,0.98,0};
			colorSelectBackground2[] = {0.98,0.95,0.98,0};
			wholeHeight = 10 * pixelGridNoUIScale * pixelH;
			tooltip = "Weapons of selected loadout";
			tooltipPerColumn = true;
		};
		//loadout selection frames		
		class Frame_slot1: Frame_aircraft
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 31 * pixelGridNoUIScale * pixelH";
		};		
		class Frame_slot2: Frame_aircraft
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 33 * pixelGridNoUIScale * pixelH";
		};		
		class Frame_slot3: Frame_aircraft
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 35 * pixelGridNoUIScale * pixelH";
		};		
		class Frame_slot4: Frame_aircraft
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 37 * pixelGridNoUIScale * pixelH";
		};		
		class Frame_slot5: Frame_aircraft
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 39 * pixelGridNoUIScale * pixelH";
		};
		//Flying height
		class Title_altitude: Title_loadout
		{
			idc = IDC_ARTY_AIR_ALT_TXT;
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 42 * pixelGridNoUIScale * pixelH";
			text = "Flying Altitude: ";
			tooltip = "";		
		};
		class Altitude_slider: Rev_arty_slider
		{
			idc = IDC_ARTY_AIR_ALT;			
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 4 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 45 * pixelGridNoUIScale * pixelH";
			onSliderPosChanged = "params ['_control', '_newValue']; ctrlSetText [4084, format ['Flying altitude: %1M',round _newValue]];";
			tooltip = "On what altitude will the aircraft be spawned in";
		};


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