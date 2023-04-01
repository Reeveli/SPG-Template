#define IDD_REV_MIS_MAP  				6030

#define IDC_REV_MIS_LIST  				6033
#define IDC_REV_MIS_ALT_TXT				6034
#define IDC_REV_MIS_ALT 				6035
#define IDC_REV_MIS_WARNING 			6036
#define IDC_REV_MIS_OK 					6037

class Rev_arty_fnc_missile_map
{
	idd = IDD_REV_MIS_MAP;
	movingEnable = true;
	onUnload = "params ['_display','_exitCode'];[_display,_exitCode] call Rev_arty_fnc_missile_map_dialog_onUnload;";
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
			onLoad = "params ['_control', ['_config', configNull]]; _control ctrlMapAnimAdd [0, 1, getMarkerPos 'Rev_arty_mis_tgt']; ctrlMapAnimCommit _control";
			onDraw = "params ['_control', ['_config', configNull]];[_control] call Rev_arty_fnc_dialog_light";
		};
		//Warning element
		class Text_warning: Rev_arty_warningText
		{
			text = "Select approach direction from outside the red circle.";	
		};
		//Night time layer for warning element
		class Night_warning: Rev_arty_warningNight {};
		//Platfrom title
		class Title_platform: RscText
		{			
			moving = true;
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 4 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 11 * pixelGridNoUIScale * pixelH";
			w = 26 * pixelGridNoUIScale * pixelW;
			h = 2 * pixelGridNoUIScale * pixelH;
			text = "Launch platform";
			font = "Caveat";			
			shadow = 0;
			SizeEx = 2.25 * pixelGridNoUIScale * pixelH;
			style = ST_LEFT;
			colorBackground[] = {0.98,0.95,0.98,0};
			colorText[] = {0,0,0,1};
		};
		//Platfrom title frame
		class Frame_Platform: Rev_arty_frame
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 11 * pixelGridNoUIScale * pixelH";
		};
		class Image_platform: Rev_arty_img
		{	
			text = "\A3\EditorPreviews_F_Destroyer\Data\CfgVehicles\Destroyer_01_assembled.jpg";			
		};
		//Night time layer for platform image
		class Night_platform: Rev_arty_imgNight{};
		//Ordnance selection
		class Title_ordnance: Title_platform
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 4 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 29 * pixelGridNoUIScale * pixelH";			
			w = 11 * pixelGridNoUIScale * pixelW;
			h = 2 * pixelGridNoUIScale * pixelH;
			text = "Select missile type";	
			tooltip = "Select missile type to be used from the list bellow";		
		};
		class Title_available: Title_ordnance
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 19 * pixelGridNoUIScale * pixelW";
			text = "Available";
			tooltip = "Available ordnance for each ammunition type";	
		};
		class List_ordnance: RscListNBox
		{
			idc = IDC_REV_MIS_LIST;
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 4 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 32 * pixelGridNoUIScale * pixelH";
			w = 26 * pixelGridNoUIScale * pixelW;
			h = 6 * pixelGridNoUIScale * pixelH;
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
			wholeHeight = 10 * pixelGridNoUIScale * pixelH;
			tooltip = "";
			tooltipPerColumn = false;
			onLBSelChanged = "params ['_control', '_selectedIndex'];[_control,_selectedIndex] call Rev_arty_fnc_dialog_pen;[_control,_selectedIndex] call Rev_arty_fnc_missile_selection";
		};
		//Ordnance selection frames		
		class Frame_slot1: Rev_arty_frame
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 32 * pixelGridNoUIScale * pixelH";
		};		
		class Frame_slot2: Frame_slot1
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 34 * pixelGridNoUIScale * pixelH";
		};	
		//Flying height
		class Title_altitude: Title_platform
		{
			idc = IDC_REV_MIS_ALT_TXT;
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 40 * pixelGridNoUIScale * pixelH";
			text = "Flying Altitude: ";
			tooltip = "";		
		};
		class Altitude_slider: Rev_arty_slider
		{
			idc = IDC_REV_MIS_ALT;		
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 43 * pixelGridNoUIScale * pixelH";
			onSliderPosChanged = "params ['_control', '_newValue']; ctrlSetText [6034, format ['Flying Altitude: %1M',round _newValue]];";
			tooltip = "Flying altitude of the missile";
		};


		//Buttons
		class Button_cancel: Rev_arty_cancel {};
		class Pen: Rev_arty_pen {};		
		class Underscrore: Rev_arty_underscrore {};
		//Button set on top of underscore to enable button tooltip to be visible
		class Button_ok: Rev_arty_ok {}	
	};	
	
	class Objects
	{ 
		class GPS: Rev_arty_gps {};
	};
	
};