#define IDD_REV_SUP_MAP  					6020

#define IDC_REV_SUP_MAP_PLANE_IMG  			6022
#define IDC_REV_SUP_MAP_ATTC_LIST  			6023
#define IDC_REV_SUP_MAP_ALT_TXT				6024
#define IDC_REV_SUP_MAP_ALT 				6025
#define IDC_REV_SUP_MAP_WARNING 			6026
#define IDC_REV_SUP_MAP_OK 					6027

class Rev_arty_supply_map_dialog
{
	idd = IDD_REV_SUP_MAP;
	movingEnable = true;
	onUnload = "params ['_display','_exitCode'];[_display,_exitCode] call Rev_arty_fnc_supply_map_dialog_onUnload";
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
			onLoad = "params ['_control', ['_config', configNull]]; _control ctrlMapAnimAdd [0, 1, getMarkerPos 'Rev_arty_sup_tgt']; ctrlMapAnimCommit _control";
			onDraw = "params ['_control', ['_config', configNull]];[_control] call Rev_arty_fnc_dialog_light";
		};
		//Warning element
		class Text_warning: Rev_arty_warningText
		{
			text = "Select approach direction from outside the red circle.";	
		};
		//Night time layer for warning element
		class Night_warning: Rev_arty_warningNight {};
		//Aircraft name frame
		class Frame_aircraft: Rev_arty_frame
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 11 * pixelGridNoUIScale * pixelH";
		};
		class Title_aircraft: RscText
		{			
			moving = true;
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 4 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 11 * pixelGridNoUIScale * pixelH";
			w = 26 * pixelGridNoUIScale * pixelW;
			h = 2 * pixelGridNoUIScale * pixelH;
			onLoad = "params ['_control', ['_config', configNull]]; _control ctrlSetText (getText (configFile >> 'CfgVehicles' >> Rev_arty_SUP_class >> 'displayname'));";	
			font = "Caveat";			
			shadow = 0;
			SizeEx = 2.25 * pixelGridNoUIScale * pixelH;
			style = ST_LEFT;
			colorBackground[] = {0.98,0.95,0.98,0};
			colorText[] = {0,0,0,1};
		};
		//Aircraft image
		class Aircraft_img: Rev_arty_img {};
		//Night time layer for aircraft image
		class Night_plane: Rev_arty_imgNight{};
		//Attachement selection
		class Title_attachement: Title_aircraft
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 4 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 27 * pixelGridNoUIScale * pixelH";			
			w = 20 * pixelGridNoUIScale * pixelW;
			h = 2 * pixelGridNoUIScale * pixelH;
			text = "Select attachement";			
			tooltip = "Select marker attachment added to the supply box";	
			onLoad = "";
		};
		//Attachment selection frames		
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
		class Frame_slot4: Frame_aircraft
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 36 * pixelGridNoUIScale * pixelH";
		};	
		class Frame_slot5: Frame_aircraft
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 38 * pixelGridNoUIScale * pixelH";
		};
		class Attachment_list: RscListNBox
		{
			idc = IDC_REV_SUP_MAP_ATTC_LIST;
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 4 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 30 * pixelGridNoUIScale * pixelH";
			w = 27 * pixelGridNoUIScale * pixelW;
			h = 10 * pixelGridNoUIScale * pixelH;
			columns[] = {
				-0.01,
				6 * pixelGridNoUIScale * pixelW,
				32 * pixelGridNoUIScale * pixelW
			};
			style = ST_LEFT;
			font = "Caveat";			
			SizeEx = 2 * pixelGridNoUIScale * pixelH;
			colorBackground[] = {0.98,0.95,0.98,0};
			colorText[] = {0,0,0,1};
			colorSelectBackground[] = {0.98,0.95,0.98,0};
			colorSelectBackground2[] = {0.98,0.95,0.98,0};
			colorPicture[] =
			{
				1,1,1,
				"(missionNamespace getvariable ['Rev_arty_n_alpha',[1,0,0.98,0.95,1,1]]) select 5"
			};
			colorPictureSelected[] =
			{
				1,1,1,
				"(missionNamespace getvariable ['Rev_arty_n_alpha',[1,0,0.98,0.95,1,1]]) select 5"
			};
			wholeHeight = 10 * pixelGridNoUIScale * pixelH;
			tooltipPerColumn = true;
			onLBSelChanged = "params ['_control', '_selectedIndex'];[_control,_selectedIndex] call Rev_arty_fnc_supply_map_dialog_onLBSelChanged;";
		};
		//Flying height
		class Title_altitude: Title_attachement
		{
			idc = IDC_REV_SUP_MAP_ALT_TXT;
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 42 * pixelGridNoUIScale * pixelH";
			text = "Chute opening altitude: ";
			tooltip = "";		
		};
		class Altitude_slider: Rev_arty_slider
		{
			idc = IDC_REV_SUP_MAP_ALT;			
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 4 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 45 * pixelGridNoUIScale * pixelH";
			onSliderPosChanged = "params ['_control', '_newValue']; ctrlSetText [6024, format ['Chute opening altitude: %1M',round _newValue]];";
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
