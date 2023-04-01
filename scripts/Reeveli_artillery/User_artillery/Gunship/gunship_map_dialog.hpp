#define IDD_REV_GUN_MAP  					6040

#define IDC_REV_GUN_MAP_LOITER_TXT  		6042
#define IDC_REV_GUN_MAP_LOITER  			6043
#define IDC_REV_GUN_MAP_ALT_TXT				6044
#define IDC_REV_GUN_MAP_ALT 				6045
#define IDC_REV_GUN_MAP_VIEW_TXT			6048
#define IDC_REV_GUN_MAP_VIEW 				6049

class Rev_arty_gun_map_dialog
{
	idd = IDD_REV_GUN_MAP;
	movingEnable = true;
	onUnload = "params ['_display','_exitCode']; [_display,_exitCode] call Rev_arty_fnc_gunship_map_dialog_onUnload";
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
			onLoad = "params ['_control', ['_config', configNull]]; _control ctrlMapAnimAdd [0, 1, getMarkerPos 'Rev_arty_gun_tgt']; ctrlMapAnimCommit _control";
			onDraw = "params ['_control', ['_config', configNull]];[_control] call Rev_arty_fnc_dialog_light";
		};
		//Warning element
		class Text_warning: Rev_arty_warningText
		{
			text = "Select approach direction from outside the red circle. Set loitering range, altitude and view rendering distace.";
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
			onLoad = "params ['_control', ['_config', configNull]]; _control ctrlSetText (getText (configFile >> 'CfgVehicles' >> 'B_T_VTOL_01_armed_F' >> 'displayname'));";
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
		
		//Loitering radius
		class Loiter_title: Title_aircraft
		{
			idc = IDC_REV_GUN_MAP_LOITER_TXT;
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 28 * pixelGridNoUIScale * pixelH";
			text = "Loiter Radius: ";
			tooltip = "";	
			onLoad = "";	
		};
		class Loiter_slider: Rev_arty_slider
		{
			idc = IDC_REV_GUN_MAP_LOITER;
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 31 * pixelGridNoUIScale * pixelH";
			onSliderPosChanged = "params ['_control', '_newValue']; [_newValue] call Rev_arty_fnc_gunship_loiter";
			tooltip = "What is the circling radius of the gunship";	
		};
		class Altitude_title: Loiter_title
		{
			idc = IDC_REV_GUN_MAP_ALT_TXT;
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 34 * pixelGridNoUIScale * pixelH";
			text = "Loiter Altitude: ";			
		};
		class Altitude_slider: Rev_arty_slider
		{
			idc = IDC_REV_GUN_MAP_ALT;
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 37 * pixelGridNoUIScale * pixelH";
			onSliderPosChanged = "params ['_control', '_newValue']; ctrlSetText [6044, format ['Loiterin Altitude: %1M',round _newValue]];";
			tooltip = "What altitude will the aircraft try to maintain";
		};
		class View_title: Loiter_title
		{
			idc = IDC_REV_GUN_MAP_VIEW_TXT;
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 40 * pixelGridNoUIScale * pixelH";
			text = "View Distance: ";			
		};
		class View_slider: Rev_arty_slider
		{
			idc = IDC_REV_GUN_MAP_VIEW;
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 43 * pixelGridNoUIScale * pixelH";
			onSliderPosChanged = "params ['_control', '_newValue']; ctrlSetText [6048, format ['View Distance: %1M',round _newValue]];";
			tooltip = "Increase your view distance for the duration of the gunship support";
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
