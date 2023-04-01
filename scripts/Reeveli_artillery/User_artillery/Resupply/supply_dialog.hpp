#define IDD_REV_SUPPLY     			5013

#define IDC_REV_SUPPLY_LIST			5014
#define IDC_REV_SUPPLY_ADD			5015
#define IDC_REV_SUPPLY_SUB			5016
#define IDC_REV_SUPPLY_BAR			5017
#define IDC_REV_SUPPLY_SEARCH		5018
#define IDC_REV_SUPPLY_SORT_N_A		5019
#define IDC_REV_SUPPLY_SORT_N_T		5020
#define IDC_REV_SUPPLY_SORT_A_A		5021
#define IDC_REV_SUPPLY_SORT_A_T		5022
#define IDC_REV_SUPPLY_SORT_WEAP	5023

class Rev_arty_supply_dialog
{
	idd= IDD_REV_SUPPLY;
	movingenable = true;
	onUnload = "params ['_display','_exitCode']; [_display,_exitCode] call Rev_arty_fnc_supply_dialog_onUnload";
	
	class ControlsBackground
	{
		//ControlsBackground used to prevent layer issues with Objects
		class Map_case: Rev_arty_mapCase {};
		class Map: Rev_arty_map
		{
			onDraw = "params ['_control', ['_config', configNull]];[_control] call Rev_arty_fnc_dialog_light";
		};
		//Warning element
		class Text_warning: Rev_arty_warningText
		{
			text = "Select items for the supply drop and press continue.";	
		};
		//Night time layer for warning element
		class Night_warning: Rev_arty_warningNight {}
		class Title_main: RscText
		{			
			moving = true;
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 8 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 10 * pixelGridNoUIScale * pixelH";
			w = 16 * pixelGridNoUIScale * pixelW;
			h = 2 * pixelGridNoUIScale * pixelH;
			text = "Supply order request";
			font = "Caveat";			
			shadow = 0;
			SizeEx = 2.25 * pixelGridNoUIScale * pixelH;
			style = ST_CENTER;
			colorBackground[] = {0.98,0.95,0.98,0};
			colorText[] = {0,0,0,1};
		};


		//Category buttons
		class Button_all: Rev_arty_supply_button
		{
			text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_0_ca.paa";
			onButtonClick = "call Rev_arty_fnc_filter_added";
			tooltip = "Added items";
		};
		class Button_rifle:Button_all
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 7 * pixelGridNoUIScale * pixelW";
			text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_1_ca.paa";
			onButtonClick = "[0] call Rev_arty_fnc_filter";
			tooltip = "Primary weapons";
		};
		class Button_launcher:Button_all
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 9 * pixelGridNoUIScale * pixelW";
			text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_4_ca.paa";
			onButtonClick = "[1] call Rev_arty_fnc_filter";
			tooltip = "Launchers";
		};
		class Button_pistol:Button_all
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 11 * pixelGridNoUIScale * pixelW";
			text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_5_ca.paa";
			onButtonClick = "[2] call Rev_arty_fnc_filter";
			tooltip = "Secondary weapons";
		};
		class Button_optic:Button_all
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 13 * pixelGridNoUIScale * pixelW";
			text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_7_ca.paa";
			onButtonClick = "[3] call Rev_arty_fnc_filter";
			tooltip = "Optics";
		};
		class Button_attachment:Button_all
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 15 * pixelGridNoUIScale * pixelW";
			text = "\A3\ui_f\data\GUI\Rsc\RscDisplayArsenal\itemAcc_ca.paa";
			onButtonClick = "[4] call Rev_arty_fnc_filter";
			tooltip = "Weapon attachments";
		};
		class Button_muzzle:Button_all
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 17 * pixelGridNoUIScale * pixelW";
			text = "\A3\ui_f\data\GUI\Rsc\RscDisplayArsenal\itemMuzzle_ca.paa";
			onButtonClick = "[5] call Rev_arty_fnc_filter";
			tooltip = "Weapon muzzles";
		};
		class Button_bipod:Button_all
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 19 * pixelGridNoUIScale * pixelW";
			text = "\A3\ui_f\data\GUI\Rsc\RscDisplayArsenal\itemBipod_ca.paa";
			onButtonClick = "[6] call Rev_arty_fnc_filter";
			tooltip = "Weapon bipods";
		};
		class Button_mag_all:Button_all
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 21 * pixelGridNoUIScale * pixelW";
			text = "\A3\ui_f\data\GUI\Rsc\RscDisplayArsenal\cargoMagAll_ca.paa";
			onButtonClick = "[7] call Rev_arty_fnc_filter";
			tooltip = "Magazines";
		};
		class Button_headgear:Button_all
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 23 * pixelGridNoUIScale * pixelW";
			text = "\A3\ui_f\data\GUI\Rsc\RscDisplayArsenal\headgear_ca.paa";
			onButtonClick = "[8] call Rev_arty_fnc_filter";
			tooltip = "Headgear";
		};
		class Button_uniform:Button_all
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 25 * pixelGridNoUIScale * pixelW";
			text = "\A3\ui_f\data\GUI\Rsc\RscDisplayArsenal\uniform_ca.paa";
			onButtonClick = "[9] call Rev_arty_fnc_filter";
			tooltip = "Uniforms";
		};
		class Button_vest:Button_all
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 27 * pixelGridNoUIScale * pixelW";
			text = "\A3\ui_f\data\GUI\Rsc\RscDisplayArsenal\vest_ca.paa";
			onButtonClick = "[10] call Rev_arty_fnc_filter";
			tooltip = "Vests";
		};
		class Button_backpacks:Button_all
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 15 * pixelGridNoUIScale * pixelH";
			text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_10_ca.paa";
			onButtonClick = "[11] call Rev_arty_fnc_filter";
			tooltip = "Backpacks";
		};
		class Button_glasses:Button_backpacks
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 7 * pixelGridNoUIScale * pixelW";
			text = "\A3\ui_f\data\GUI\Rsc\RscDisplayArsenal\goggles_ca.paa";
			onButtonClick = "[12] call Rev_arty_fnc_filter";
			tooltip = "Facewear";
		};
		class Button_nvgs:Button_backpacks
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 9 * pixelGridNoUIScale * pixelW";
			text = "\A3\ui_f\data\GUI\Rsc\RscDisplayArsenal\nvgs_ca.paa";
			onButtonClick = "[13] call Rev_arty_fnc_filter";
			tooltip = "Goggles";
		};
		class Button_binos:Button_backpacks
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 11 * pixelGridNoUIScale * pixelW";
			text = "\A3\ui_f\data\GUI\Rsc\RscDisplayArsenal\binoculars_ca.paa";
			onButtonClick = "[14] call Rev_arty_fnc_filter";
			tooltip = "Binoculars";
		};
		class Button_map:Button_backpacks
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 13 * pixelGridNoUIScale * pixelW";
			text = "\A3\ui_f\data\GUI\Rsc\RscDisplayArsenal\map_ca.paa";
			onButtonClick = "[15] call Rev_arty_fnc_filter";
			tooltip = "Map";
		};
		class Button_compass:Button_backpacks
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 15 * pixelGridNoUIScale * pixelW";
			text = "\A3\ui_f\data\GUI\Rsc\RscDisplayArsenal\compass_ca.paa";
			onButtonClick = "[16] call Rev_arty_fnc_filter";
			tooltip = "Compass";
		};
		class Button_radios:Button_backpacks
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 17 * pixelGridNoUIScale * pixelW";
			text = "\A3\ui_f\data\GUI\Rsc\RscDisplayArsenal\radio_ca.paa";
			onButtonClick = "[17] call Rev_arty_fnc_filter";
			tooltip = "Radios";
		};
		class REV_SUP_BUTTON_Watches:Button_backpacks
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 19 * pixelGridNoUIScale * pixelW";
			text = "\A3\ui_f\data\GUI\Rsc\RscDisplayArsenal\watch_ca.paa";
			onButtonClick = "[18] call Rev_arty_fnc_filter";
			tooltip = "Watches";
		};
		class Button_terminals:Button_backpacks
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 21 * pixelGridNoUIScale * pixelW";
			text = "\A3\ui_f\data\GUI\Rsc\RscDisplayArsenal\gps_ca.paa";
			onButtonClick = "[19] call Rev_arty_fnc_filter";
			tooltip = "Terminals";
		};
		class Button_grenades:Button_backpacks
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 23 * pixelGridNoUIScale * pixelW";
			text = "\A3\ui_f\data\GUI\Rsc\RscDisplayArsenal\cargoThrow_ca.paa";
			onButtonClick = "[20] call Rev_arty_fnc_filter";
			tooltip = "Grenades";
		};
		class Button_mines:Button_backpacks
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 25 * pixelGridNoUIScale * pixelW";
			text = "\A3\ui_f\data\GUI\Rsc\RscDisplayArsenal\cargoPut_ca.paa";
			onButtonClick = "[21] call Rev_arty_fnc_filter";
			tooltip = "Explosives";
		};
		class Button_misc:Button_backpacks
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 27 * pixelGridNoUIScale * pixelW";
			text = "\A3\ui_f\data\GUI\Rsc\RscDisplayArsenal\cargoMisc_ca.paa";
			onButtonClick = "[22] call Rev_arty_fnc_filter";
			tooltip = "Miscellaneous";
		};




		//Sorting buttons
		class Button_sort_name:Button_backpacks
		{
			idc = IDC_REV_SUPPLY_SORT_N_A;
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 19 * pixelGridNoUIScale * pixelH";
			w = 2 * pixelGridNoUIScale * pixelW;
			h = 2 * pixelGridNoUIScale * pixelH;
			text = "\A3\ui_f\data\GUI\Rsc\RscDisplayMultiplayer\arrow_up_ca.paa";
			onButtonClick = "params ['_control'];[_control,1,false] call Rev_arty_fnc_supply_sort_name";
			tooltip = "Sort items by name";
		};
		class Button_sort_name_t:Button_sort_name
		{
			idc = IDC_REV_SUPPLY_SORT_N_T;
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 7 * pixelGridNoUIScale * pixelW";
			w = 10 * pixelGridNoUIScale * pixelW;
			style = ST_LEFT;
			text = "Name";
		};
		class Button_sort_amount:Button_sort_name
		{
			idc = IDC_REV_SUPPLY_SORT_A_A;
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 21 * pixelGridNoUIScale * pixelW";
			tooltip = "Sort items by amount";
			onButtonClick = "params ['_control'];[_control,2,false] call Rev_arty_fnc_supply_sort_amount";
		};
		class Button_sort_amount_t:Button_sort_name_t
		{
			idc = IDC_REV_SUPPLY_SORT_A_T;
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 23 * pixelGridNoUIScale * pixelW";
			w = 5 * pixelGridNoUIScale * pixelW;
			text = "Amount";
			tooltip = "Sort items by amount";
			onButtonClick = "params ['_control'];[_control,2,false] call Rev_arty_fnc_supply_sort_amount";
		};





		//Main list
		class button_plus: RscButton
		{
			idc = IDC_REV_SUPPLY_ADD;
			style = ST_CENTER;
			text = "+";
			x = -1;
			y = -1;
			w = -1;
			h = -1;
			onButtonClick = "[1] call Rev_arty_fnc_supply_add";
			font = "Caveat";
			SizeEx = 2.25 * pixelGridNoUIScale * pixelH;
			shadow = 0;
			tooltip = "Add item";			
			colorText[] = {0,0,0,1};
			colorDisabled[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,1};			
		};
		class minus: button_plus
		{
			idc = IDC_REV_SUPPLY_SUB;
			text = "-";
			onButtonClick = "[-1] call Rev_arty_fnc_supply_add";
			tooltip = "Remove item";			
		};
		class Item_list: RscListNBox
		{
			idc = IDC_REV_SUPPLY_LIST;
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 4 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 21 * pixelGridNoUIScale * pixelH";
			w = 26 * pixelGridNoUIScale * pixelW;
			//Slightly extra height to enable left and right buttons text to be visible even on last row
			h = 22.2 * pixelGridNoUIScale * pixelH;
			onKeyDown = "if (_this select 2) then {uiNamespace setVariable ['Rev_supply_shift',true]}";
			onKeyUp = "uiNamespace setVariable ['Rev_supply_shift', nil]";
			onLBSelChanged = "params ['_control', '_selectedIndex'];[_control,_selectedIndex] call Rev_arty_fnc_supply_weapon_check";
			idcLeft = IDC_REV_SUPPLY_SUB;
			idcRight = IDC_REV_SUPPLY_ADD;
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
			font = "Caveat";
			SizeEx = 2 * pixelGridNoUIScale * pixelH;
			columns[] =
			{
				0.05,
				0.2,
				0.8
        	};			
		};
		
		//ordnanace selection frames	
		class Frame_slot_sorting: Rev_arty_frame
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 19 * pixelGridNoUIScale * pixelH";
		};		
		class Frame_slot0: Rev_arty_frame
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 21 * pixelGridNoUIScale * pixelH";
		};		
		class Frame_slot1: Rev_arty_frame
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 23 * pixelGridNoUIScale * pixelH";
		};		
		class Frame_slot2: Rev_arty_frame
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 25 * pixelGridNoUIScale * pixelH";
		};		
		class Frame_slot3: Rev_arty_frame
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 27 * pixelGridNoUIScale * pixelH";
		};		
		class Frame_slot4: Rev_arty_frame
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 29 * pixelGridNoUIScale * pixelH";
		};		
		class Frame_slot5: Rev_arty_frame
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 31 * pixelGridNoUIScale * pixelH";
		};		
		class Frame_slot6: Rev_arty_frame
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 33 * pixelGridNoUIScale * pixelH";
		};		
		class Frame_slot7: Rev_arty_frame
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 35 * pixelGridNoUIScale * pixelH";
		};						
		class Frame_slot8: Rev_arty_frame
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 37 * pixelGridNoUIScale * pixelH";
		};		
		class Frame_slot9: Rev_arty_frame
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 39 * pixelGridNoUIScale * pixelH";
		};	
		class Frame_slot10: Rev_arty_frame
		{
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 41 * pixelGridNoUIScale * pixelH";
		};	

		//Additional buttons and fields relating to items
		class Button_search:Button_all
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 4 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 45 * pixelGridNoUIScale * pixelH";
			text = "\A3\ui_f\data\gui\RscCommon\RscButtonSearch\search_start_ca.paa";
			tooltip = "Search items";
			onButtonClick = "params ['_control'];[findDisplay 5013 displayCtrl 5018] call Rev_arty_fnc_filter_search";
					
		};
		class Edit_search: RscEdit
		{
			idc = IDC_REV_SUPPLY_SEARCH;
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 6 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 45 * pixelGridNoUIScale * pixelH";
			w = 8 * pixelGridNoUIScale * pixelW;
			h = 2 * pixelGridNoUIScale * pixelH;
			text = "";
			autocomplete = "";
			colorBackground[] = {0,0,0,0};
			colorDisabled[] = {0,0,0,0};
			colorSelection[] = {0,0,0,0.3};
			colorText[] = {0,0,0,1};
			shadow = 0;
			font = "Caveat";
			sizeEx = 2.25 * pixelGridNoUIScale * pixelH;
			onKeyDown = "params ['_control', '_charCode'];[_control] call Rev_arty_fnc_filter_search";
			tooltip = "Search items";	
			
		};
		class Button_clear:Button_search
		{
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 14.5 * pixelGridNoUIScale * pixelW";
			text = "\a3\3den\data\cfg3den\history\deleteitems_ca.paa";
			tooltip = "Reset item list";
			onButtonClick = "call Rev_arty_fnc_filter_clear";					
		};
		class Button_Weapon:Button_clear
		{
			idc = IDC_REV_SUPPLY_SORT_WEAP;
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 17.5 * pixelGridNoUIScale * pixelW";
			text = "\a3\3den\data\displays\display3den\entitymenu\arsenal_ca.paa";
			tooltip = "Show compatible items for current weapon";
			onButtonClick = "call Rev_arty_fnc_filter_weapon";	
		};
		class Progress_bar
		{
			type = 8;
			idc = IDC_REV_SUPPLY_BAR;
			x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 20 * pixelGridNoUIScale * pixelW";
			y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 45 * pixelGridNoUIScale * pixelH";
			w = 10 * pixelGridNoUIScale * pixelW;
			h = 2 * pixelGridNoUIScale * pixelH;
			style = 0;
			colorBar[] = {0,0,0,0.7};
			colorFrame[] = {0,0,0,1};
			texture = "#(argb,8,8,3)color(1,1,1,1)";
			tooltip = "Current container usage";
		};

		//Buttons
		class Button_cancel: Rev_arty_cancel
		{
			text = "Cancel";
			tooltip = "Close menu";	
		};
		class Button_ok: Rev_arty_ok 
		{
			text = "Continue";
			tooltip = "Proceed to next step";
			onLoad = "params ['_control', ['_config', configNull]];";
		};
	};

	class Controls {};


	class Objects
	{ 
		class GPS: Rev_arty_gps {};
	};
};