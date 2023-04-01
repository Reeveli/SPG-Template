
#define IDD_REV_ARTY_DIAG  				6060

#define IDC_ARTY_DIAG_OBSERVER			6062
#define IDC_ARTY_DIAG_DISTNACE			6063
#define IDC_ARTY_DIAG_BEARING			6064
#define IDC_ARTY_DIAG_TRP				6065
#define IDC_ARTY_DIAG_DELAY				6066
#define IDC_ARTY_DIAG_COUNT				6067
#define IDC_ARTY_DIAG_ORDNANCE			6068


class Rev_arty_dialog
{
	idd= IDD_REV_ARTY_DIAG;
	movingenable = true;
	onUnload = "params ['_display','_exitCode']; [_display,_exitCode] call Rev_arty_fnc_dialog_onUnload";
	
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
			onDraw = "params ['_control', ['_config', configNull]]; [ctrlText 6062,ctrlText 6063,ctrlText 6064,lbData [6065, lbCurSel 6065],lbCurSel 6065,ctrlText 6066,ctrlText 6067,((findDisplay 6060) displayCtrl 6068) lnbText [lnbCurSelRow 6068,0],lnbCurSelRow 6068,_control] call Rev_arty_fnc_dialog_update;[_control] call Rev_arty_fnc_dialog_light";
		};
		
		class Text_warning: Rev_arty_warningText {};		
		class Night_warning: Rev_arty_warningNight {};
		class Title_support: RscText
		{			
			moving = true;
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 8 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 10 * pixelGridNoUIScale * pixelH";
			w = 16 * pixelGridNoUIScale * pixelW;
			h = 3 * pixelGridNoUIScale * pixelH;
			text = "Fire support planner";
			font = "Caveat";			
			shadow = 2;
			SizeEx = 3 * pixelGridNoUIScale * pixelH;
			style = ST_CENTER;
			colorBackground[] = {0.98,0.95,0.98,0};
			colorText[] = {0,0,0,1};
		};
		class Frame_observer: Rev_arty_frame {};
		class Text_observer: Title_support
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 4 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 14 * pixelGridNoUIScale * pixelH";
			w = 13 * pixelGridNoUIScale * pixelW;
			h = 1.5 * pixelGridNoUIScale * pixelH;
			text = "Observer position:";
			SizeEx = 2 * pixelGridNoUIScale * pixelH;
			style = ST_LEFT;			
			shadow = 0;
		};
		class Field_observer: RscEdit
		{
			idc = IDC_ARTY_DIAG_OBSERVER;
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 19 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 14 * pixelGridNoUIScale * pixelH";
			w = 11 * pixelGridNoUIScale * pixelW;
			h = 1.5 * pixelGridNoUIScale * pixelH;
			text = "XXXXXYYYYY";
			font = "Caveat";			
			SizeEx = 2 * pixelGridNoUIScale * pixelH;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.98,0.95,0.98,0};
			forceDrawCaret = 0;
			maxChars = 10;
			style = ST_NO_RECT;						
			shadow = 0;
			tooltip = "Observer Location (6/8/10 Grid)";
		};
		class Frame_distance: Frame_observer
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 16 * pixelGridNoUIScale * pixelH";
		};
		class Text_distance: Text_observer
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 16 * pixelGridNoUIScale * pixelH";
			text = "Target distance:";
		};
		class Field_distance: Field_observer
		{
			idc = IDC_ARTY_DIAG_DISTNACE;
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 16 * pixelGridNoUIScale * pixelH";
			text = "500";
			tooltip = "Target Distance (Meters)";
		};
		class Frame_bearing: Frame_observer
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 18 * pixelGridNoUIScale * pixelH";
		};
		class Text_bearing: Text_distance
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 18 * pixelGridNoUIScale * pixelH";
			text = "Target bearing:";
		};
		class Field_bearing: Field_distance
		{
			idc = IDC_ARTY_DIAG_BEARING;
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 18 * pixelGridNoUIScale * pixelH";
			text = "0";
			tooltip = "Target Direction (Degrees)";
		};
		class Text_trp: Text_distance
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 20 * pixelGridNoUIScale * pixelH";
			text = "Target reference point:";
		};
		class List_trp: RscCombo
		{
			idc = IDC_ARTY_DIAG_TRP;
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 19 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 20 * pixelGridNoUIScale * pixelH";
			w = 11 * pixelGridNoUIScale * pixelW;
			h = 1.5 * pixelGridNoUIScale * pixelH;
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
			tooltip = "Selected target reference point";			
			arrowEmpty = "scripts\Reeveli_artillery\images\combobox_arrowD.paa";
			arrowFull = "scripts\Reeveli_artillery\images\combobox_arrowD.paa";
		};
		//Placement on top of list to make sure selection arrow is not clipping over it
		class Frame_trp: Frame_observer
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 20 * pixelGridNoUIScale * pixelH";
		};
		class Frame_delay: Frame_observer
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 22 * pixelGridNoUIScale * pixelH";
		};
		class Text_delay: Text_distance
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 22 * pixelGridNoUIScale * pixelH";
			text = "Round delay:";
		};
		class Field_delay: Field_distance
		{
			idc = IDC_ARTY_DIAG_DELAY;
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 22 * pixelGridNoUIScale * pixelH";
			text = "0";
			tooltip = "Delay between rounds (seconds)";
		};
		class Frame_count: Frame_observer
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 24 * pixelGridNoUIScale * pixelH";
		};
		class Text_count: Text_distance
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 24 * pixelGridNoUIScale * pixelH";
			text = "Round count:";
		};
		class Field_count: Field_distance
		{
			idc = IDC_ARTY_DIAG_COUNT;
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 24 * pixelGridNoUIScale * pixelH";
			text = "1";
			tooltip = "Amount of ammunition to be expended (whole numbers)";
		};



		//Ordnance Section
		class Title_select: Title_support
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 4 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 27 * pixelGridNoUIScale * pixelH";			
			w = 11 * pixelGridNoUIScale * pixelW;
			h = 2 * pixelGridNoUIScale * pixelH;
			text = "Select ammunition";			
			shadow = 0;
			SizeEx = 2.25 * pixelGridNoUIScale * pixelH;
			style = ST_LEFT;
			tooltip = "Select ammunition type to be used from the list bellow";		
		};
		class Title_available: Title_select
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 19 * pixelGridNoUIScale * pixelW";
			text = "Available";
			tooltip = "Available ordnance for each ammunition type";	
		};
		class List_ordnance: RscListNBox
		{
			idc = IDC_ARTY_DIAG_ORDNANCE;
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 4 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 30 * pixelGridNoUIScale * pixelH";
			w = 26 * pixelGridNoUIScale * pixelW;
			h = 18 * pixelGridNoUIScale * pixelH;
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
			tooltip = "Selected ordance type";
			tooltipPerColumn = false;
			onLBSelChanged = "params ['_control', '_selectedIndex'];[_control,_selectedIndex] call Rev_arty_fnc_dialog_pen";
		};
		//ordnanace selection frames		
		class Frame_slot1: Frame_observer
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 30 * pixelGridNoUIScale * pixelH";
		};		
		class Frame_slot2: Frame_observer
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 32 * pixelGridNoUIScale * pixelH";
		};		
		class Frame_slot3: Frame_observer
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 34 * pixelGridNoUIScale * pixelH";
		};		
		class Frame_slot4: Frame_observer
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 36 * pixelGridNoUIScale * pixelH";
		};		
		class Frame_slot5: Frame_observer
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 38 * pixelGridNoUIScale * pixelH";
		};		
		class Frame_slot6: Frame_observer
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 40 * pixelGridNoUIScale * pixelH";
		};		
		class Frame_slot7: Frame_observer
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 42 * pixelGridNoUIScale * pixelH";
		};		
		class Frame_slot8: Frame_observer
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 44 * pixelGridNoUIScale * pixelH";
		};		
		class Frame_slot9: Frame_observer
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 46 * pixelGridNoUIScale * pixelH";
		};


		//Buttons
		class Button_cancel: Rev_arty_cancel {};
		class Pen: Rev_arty_pen {};		
		class Underscrore: Rev_arty_underscrore {};
		//Button set on top of underscore to enable button tooltip to be visible
		class Button_ok: Rev_arty_ok {};
	};

	class Controls {};


	class Objects
	{ 
		class GPS: Rev_arty_gps {};
	};
};
