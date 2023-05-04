/*
Custom defines by Reeveli
1.1
	Some end of line ; fixes to clean rtp error printouts
*/
// Control types
#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUTBUTTON   16
#define CT_HITZONES         17
#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_LISTNBOX         102
#define CT_ITEMSLOT         103
#define CT_CHECKBOX         77

// Static styles
#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0C

#define ST_TYPE           0xF0
#define ST_SINGLE         0x00
#define ST_MULTI          0x10
#define ST_TITLE_BAR      0x20
#define ST_PICTURE        0x30
#define ST_FRAME          0x40
#define ST_BACKGROUND     0x50
#define ST_GROUP_BOX      0x60
#define ST_GROUP_BOX2     0x70
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE   0x90
#define ST_WITH_RECT      0xA0
#define ST_LINE           0xB0
#define ST_UPPERCASE      0xC0
#define ST_LOWERCASE      0xD0

#define ST_SHADOW         0x100
#define ST_NO_RECT        0x200
#define ST_KEEP_ASPECT_RATIO  0x800

// Slider styles
#define SL_DIR            0x400
#define SL_VERT           0
#define SL_HORZ           0x400

#define SL_TEXTURES       0x10

// progress bar
#define ST_VERTICAL       0x01
#define ST_HORIZONTAL     0

// Listbox styles
#define LB_TEXTURES       0x10
#define LB_MULTI          0x20

// Tree styles
#define TR_SHOWROOT       1
#define TR_AUTOCOLLAPSE   2

// Default grid
#define GUI_GRID_WAbs			((safezoneW / safezoneH) min 1.2)
#define GUI_GRID_HAbs			(GUI_GRID_WAbs / 1.2)
#define GUI_GRID_W			(GUI_GRID_WAbs / 40)
#define GUI_GRID_H			(GUI_GRID_HAbs / 25)
#define GUI_GRID_X			(safezoneX)
#define GUI_GRID_Y			(safezoneY + safezoneH - GUI_GRID_HAbs)

// Default text sizes
#define GUI_TEXT_SIZE_SMALL		(GUI_GRID_H * 0.8)
#define GUI_TEXT_SIZE_MEDIUM		(GUI_GRID_H * 1)
#define GUI_TEXT_SIZE_LARGE		(GUI_GRID_H * 1.2)

// Pixel grid
#define pixelScale	0.50
#define GRID_W (pixelW * pixelGrid * pixelScale)
#define GRID_H (pixelH * pixelGrid * pixelScale)

//Reeveli's defines
#define COLOR_REV_TITLE {0.1926,0.3515,1,0.8}
#define COLOR_REV_BG {0,0,0,0.8}
#define COLOR_REV_ARTY_PAPER {0.98,0.95,0.98,1}

#define REV_AIR_PANEL_W					safeZoneW * 0.1375
#define REV_AIR_PANEL_H					safeZoneH * 0.55
#define REV_AIR_STD_W					safeZoneW * 0.1345
#define REV_AIR_STD_H					safeZoneH * 0.037
#define REV_AIR_BUTTON_W				safeZoneW * 0.1175

#define REV_AIR_GAB_W_S					safeZoneW * 0.0015
#define REV_AIR_GAB_H_S					safeZoneH * 0.003

#define REV_AIR_X						safeZoneX + (safeZoneW * 0.5) - 2 * REV_AIR_PANEL_W - 0.5 * REV_AIR_GAB_W_S
#define REV_AIR_Y						safeZoneY + (safeZoneH * 0.5) - 0.5 * REV_AIR_PANEL_H - 0.5 * REV_AIR_GAB_H_S - 0.5 * REV_AIR_STD_H



//Base classes
import ctrlButton;
import ctrlControlsGroupNoScrollbars;


import RscActivePicture;
import RscButton;
import RscButtonMenu;
import RscButtonMenuCancel;
import RscCombo;
import RscCompass;
import RscEdit;
import RscFrame;
import RscListBox;
import RscListNBox;
import RscMapControl;
import RscObject;
import RscPicture;
import RscProgress;
import RscShortcutButton;
import RscStructuredText;
import RscText;
import RscToolbox;
import RscXSliderH;




//ARTILLERY SYSTEM BASE CLASSES
#define REV_ARTY_DIAG_CASE_GRID_SIZE	64
#define REV_ARTY_DIAG_CASE_X			safezoneX + (safezoneW * 0.50) - ((REV_ARTY_DIAG_CASE_GRID_SIZE * pixelGridNoUIScale * pixelW) * 0.5)
#define REV_ARTY_DIAG_CASE_Y			safezoneY + (safezoneH * 0.50) - ((REV_ARTY_DIAG_CASE_GRID_SIZE * pixelGridNoUIScale * pixelH) * 0.5)

//#define REV_ARTY_DIAG_CASE_X			(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)])
//#define REV_ARTY_DIAG_CASE_Y			(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)])

#define IDC_ARTY_DIAG_MAP 				6061
#define IDC_ARTY_DIAG_OK				6069
#define IDC_ARTY_DIAG_PEN				6070
#define IDC_ARTY_DIAG_UNDER				6071
#define IDC_ARTY_DIAG_WARNING			6072
#define IDC_ARTY_DIAG_CASE				6074
#define IDC_ARTY_IMG			  		6075
#define IDC_ARTY_COMPASS		  		6076


class Rev_arty_mapCase: RscPicture
{
	idc = IDC_ARTY_DIAG_CASE;
	moving = true;
	x = "uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]"; //REV_ARTY_DIAG_CASE_X
	y = "uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]"; //REV_ARTY_DIAG_CASE_Y
	w = REV_ARTY_DIAG_CASE_GRID_SIZE * pixelGridNoUIScale * pixelW;
	h = REV_ARTY_DIAG_CASE_GRID_SIZE * pixelGridNoUIScale * pixelH;
	text = "scripts\Reeveli_artillery\images\case_3.paa";
};

//Custom paper-ish map for artillery dialog
//onDraw & onLoad must be set for individual controls
class Rev_arty_map: RscMapControl
{
	idc = IDC_ARTY_DIAG_MAP;
	moving = false;
	x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 32 * pixelGridNoUIScale * pixelW"; //REV_ARTY_DIAG_CASE_X + 32 * pixelGridNoUIScale * pixelW;
	y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 9 * pixelGridNoUIScale * pixelH"; //REV_ARTY_DIAG_CASE_Y + 9 * pixelGridNoUIScale * pixelH;
	w = 30.5 * pixelGridNoUIScale * pixelW;
	h = 40 * pixelGridNoUIScale * pixelH;
	scaleMax = 1.8;
	scaleMin = 0.03;
	text = "#(argb,8,8,3)color(1,1,1,1)";
	colorLevels[] = {0.1,0.1,0.1,0.9};
	colorSea[] = {0.46, 0.65, 0.74, 0.5};
	colorForest[] = {0.02, 0.5, 0.01, 0.3};
	colorForestBorder[] = {0.02, 0.5, 0.01, 0.27};
	colorRocks[] = {0, 0, 0, 0.3};
	colorCountlines[] = {0.65, 0.45, 0.27, 0.7};
	colorMainCountlines[] = {1, 0.1, 0.1, 0.9};
	colorCountlinesWater[] = {0.25, 0.4, 0.5, 0.3};
	colorMainCountlinesWater[] = {0.25, 0.4, 0.5, 0.9};
	colorBuildings[] = {0.541, 0.216, 0.204, 0.95};
	colorBuilding[] = {0.541, 0.216, 0.204, 0.95};
	colorStructures[] = {0.541, 0.216, 0.204, 0.95};
	colorPowerLines[] = {0.1, 0.1, 0.1, 1};
	colorRailWay[] = {0.8, 0.2, 0, 1};
	colorTracks[] = {0.84, 0.76, 0.65, 0.15};
	colorTracksFill[] = {0.84, 0.76, 0.65, 1};
	colorRoads[] = {0.7, 0.7, 0.7, 1};
	colorRoadsFill[] = {1, 1, 1, 1};
	colorMainRoads[] = {0.9, 0.5, 0.3, 1};
	colorMainRoadsFill[] = {1, 0.62, 0.4, 1};
	colorRocksBorder[] = {0, 0, 0, 0};
	colorNames[] = {0.1, 0.1, 0.1, 0.9};
	colorInactive[] = {1, 1, 1, 0.5};
	colorOutside[] = {0.98,0.95,0.98,1};
	colorBackground[] = {0.98,0.95,0.98,1};
	colorText[] = {1, 1, 1, 0.85};
	colorGrid[] = {0.1, 0.1, 0.1, 0.6};
	colorGridMap[] = {0.1, 0.1, 0.1, 0.6};
	type = 101;
	style = 48;
	maxSatelliteAlpha = 0;
	alphaFadeStartScale = 0.1;
	alphaFadeEndScale = 3;
};

//Warning element
//Text must be defined for individual controls
class Rev_arty_warningText: RscText
{
	idc = IDC_ARTY_DIAG_WARNING;
	moving = true;
	x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 32 * pixelGridNoUIScale * pixelW"; //REV_ARTY_DIAG_CASE_X + 32 * pixelGridNoUIScale * pixelW;
	y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 49 * pixelGridNoUIScale * pixelH"; //REV_ARTY_DIAG_CASE_Y + 49 * pixelGridNoUIScale * pixelH;
	w = 30.5 * pixelGridNoUIScale * pixelW;
	h = 5 * pixelGridNoUIScale * pixelH;
	text = "Fill in the fire support request";
	style = ST_MULTI;
	linespacing = 1;
	shadow = 0;
	font = "Caveat";			
	SizeEx = 2 * pixelGridNoUIScale * pixelH;
	colorText[] = {0,0,0,1};
	colorBackground[] = {0.98,0.95,0.98,1};
	onLoad = "params ['_control', ['_config', configNull]]; _control ctrlEnable false;";
};
//night time warning layer
class Rev_arty_warningNight: RscText
{		
	moving = true;
	x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 32 * pixelGridNoUIScale * pixelW"; //REV_ARTY_DIAG_CASE_X + 32 * pixelGridNoUIScale * pixelW;
	y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 49 * pixelGridNoUIScale * pixelH"; //REV_ARTY_DIAG_CASE_Y + 49 * pixelGridNoUIScale * pixelH;
	w = 30.5 * pixelGridNoUIScale * pixelW;
	h = 5 * pixelGridNoUIScale * pixelH;
	text = "";
	colorBackground[] = {
		0,0,0,
		"(missionNamespace getvariable ['Rev_arty_n_alpha',[1,0,0.98,0.95,1,1]]) select 1",
	};
};

//Standard image
class Rev_arty_img: RscPicture
{
	idc = IDC_ARTY_IMG;	
	moving = true;
	x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 4 * pixelGridNoUIScale * pixelW";
	y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 13 * pixelGridNoUIScale * pixelH";
	w = 26 * pixelGridNoUIScale * pixelW;
	h = 13 * pixelGridNoUIScale * pixelH;
	colorBackground[] = {1,1,1,1};			
};
//Night time layer for aircraft image
class Rev_arty_imgNight: Rev_arty_warningNight
{	
	x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 4 * pixelGridNoUIScale * pixelW";
	y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 13 * pixelGridNoUIScale * pixelH";
	w = 26 * pixelGridNoUIScale * pixelW;
	h = 13 * pixelGridNoUIScale * pixelH;
};

//Frame
class Rev_arty_frame: RscFrame
{
	x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 4 * pixelGridNoUIScale * pixelW"; //REV_ARTY_DIAG_CASE_X + 4 * pixelGridNoUIScale * pixelW;
	y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 14 * pixelGridNoUIScale * pixelH"; //REV_ARTY_DIAG_CASE_Y + 14 * pixelGridNoUIScale * pixelH;
	w = 26 * pixelGridNoUIScale * pixelW;
	h = 2 * pixelGridNoUIScale * pixelH;
	colorText[] = {
		1,1,1,
		"(missionNamespace getvariable ['Rev_arty_n_alpha',[1,0,0.98,0.95,1,1]]) select 0",
	};
};

//Slider
//Idc, y, onSliderPosChanged, toolltip must be set individually
class Rev_arty_slider: RscXSliderH
{		
	x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 4 * pixelGridNoUIScale * pixelW"; //REV_ARTY_DIAG_CASE_X + 4 * pixelGridNoUIScale * pixelW;
	w = 26 * pixelGridNoUIScale * pixelW;
	h = 2 * pixelGridNoUIScale * pixelH;
	color[] = {
		0,0,0,
		"(missionNamespace getvariable ['Rev_arty_n_alpha',[1,0,0.98,0.95,1,1]]) select 4"};
	colorActive[] = {
		0,0,0,
		"(missionNamespace getvariable ['Rev_arty_n_alpha',[1,0,0.98,0.95,1,1]]) select 4"};
	type = CT_SLIDER;
};

//Custom buttons for atrillery dialogs
//Cancel
class Rev_arty_cancel: RscButton
{
	idc = -1;
	x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 5.5 * pixelGridNoUIScale * pixelW"; //REV_ARTY_DIAG_CASE_X + 5.5 * pixelGridNoUIScale * pixelW;
	y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 49 * pixelGridNoUIScale * pixelH"; //REV_ARTY_DIAG_CASE_Y + 49 * pixelGridNoUIScale * pixelH;
	w = 10 * pixelGridNoUIScale * pixelW;
	h = 2 * pixelGridNoUIScale * pixelH;
	text = "Cancel message";
	font = "Caveat";
	style = ST_CENTER;			
	shadow = 0;
	colorText[] = {0,0,0,1};			
	colorDisabled[] = {0,0,0,0.3};
	SizeEx = 2.5 * pixelGridNoUIScale * pixelH;
	colorBackground[] = {0.98,0.95,0.98,0};
	colorBackgroundActive[] = {0.98,0.95,0.98,0};
	colorBackgroundDisabled[] = {0.98,0.95,0.98,0};
	colorFocused[] = {0.98,0.95,0.98,0};
	colorFocused2[] = {0.98,0.95,0.98,0};
	tooltip = "Save current inputs and close menu";	
	onButtonClick = "params ['_control'];closeDialog 3;";	
};
//OK, inherited from cancel. IDC to be defined for each use case
class Rev_arty_ok: Rev_arty_cancel
{
	idc = IDC_ARTY_DIAG_OK;
	x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 18.5 * pixelGridNoUIScale * pixelW"; //REV_ARTY_DIAG_CASE_X + 18.5 * pixelGridNoUIScale * pixelW;
	text = "Send message";
	onLoad = "params ['_control', ['_config', configNull]]; _control ctrlEnable false;";
	onButtonClick = "params ['_control'];closeDialog 1;";
	tooltip = "";	
};


//Selection pen effects
class Rev_arty_pen: RscPicture
{
	show = 0;
	idc = IDC_ARTY_DIAG_PEN;
	//Text is randomised in Artillery_dialog\fn_dialgog_pen
	text = "\a3\UI_F_Enoch\Data\CfgMarkers\circle1_ca.paa";
	x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 5.5 * pixelGridNoUIScale * pixelW"; //REV_ARTY_DIAG_CASE_X + 5.5 * pixelGridNoUIScale * pixelW;
	y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 49 * pixelGridNoUIScale * pixelH"; //REV_ARTY_DIAG_CASE_Y + 49 * pixelGridNoUIScale * pixelH;
	w = 12 * pixelGridNoUIScale * pixelW;
	h = 4 * pixelGridNoUIScale * pixelH;
	colorText[] = {0,0,0,1};	
};
//Underscore pen effect
class Rev_arty_underscrore: Rev_arty_pen
{
	show = 0;
	idc = IDC_ARTY_DIAG_UNDER;
	text = "scripts\Reeveli_artillery\images\underscore.paa";
	x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 18.5 * pixelGridNoUIScale * pixelW"; //REV_ARTY_DIAG_CASE_X + 18.5 * pixelGridNoUIScale * pixelW
	y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 49 * pixelGridNoUIScale * pixelH"; //REV_ARTY_DIAG_CASE_Y + 49 * pixelGridNoUIScale * pixelH;
	w = 10 * pixelGridNoUIScale * pixelW;
};

//Buttons for supply selection dialog
//y, text, tooltip and onButtonClick need to be defined for each button
class Rev_arty_supply_button: RscButton
{
	idc = -1;
	x = "(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 5 * pixelGridNoUIScale * pixelW";
	y = "(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 13 * pixelGridNoUIScale * pixelH";
	w = 2 * pixelGridNoUIScale * pixelW;
	h = 2 * pixelGridNoUIScale * pixelH;
	style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
	text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_0_ca.paa";
	colorDisabled[] = {0,0,0,0.3};
	colorBackground[] = {0,0,0,0};
	colorBackgroundDisabled[] = {0,0,0,0};
	colorBackgroundActive[] = {0,0,0,0};
	colorFocused[] = {0,0,0,0};
	colorFocused2[] = {0,0,0,0};
	colorShadow[] = {0,0,0,0};
	colorBorder[] = {0,0,0,0};
	onButtonClick = "call Rev_arty_fnc_filter_added";
	onLoad = "params ['_control', ['_config', configNull]];_control ctrlSetTextColor [0, 0, 0, 1];";
	tooltip = "Added items";
	shadow = 0;
	font = "Caveat";			
	SizeEx = 2 * pixelGridNoUIScale * pixelH;
};

//GPS from ACE3 mod
class Rev_arty_gps: RscObject
{
	show = 0;
	onLoad = "params ['_control', '_selectedIndex']; [_control] call Rev_arty_fnc_dialog_gps;";
	idc = 913589;
	type = 82;
	model = "\z\ace\addons\maptools\data\MapGpsDisplay.p3d";
	scale = 0.333;
	direction[] = {0,1,0};
	up[] = {0,0,-1};
	//x = REV_ARTY_DIAG_CASE_X + (REV_ARTY_DIAG_CASE_GRID_SIZE + 12) * pixelGridNoUIScale * pixelW;
	//y = 0.9;
	x = "(uiNamespace getvariable ['Rev_arty_gps_x',1.4])"; //REV_ARTY_DIAG_CASE_X + (REV_ARTY_DIAG_CASE_GRID_SIZE + 12) * pixelGridNoUIScale * pixelW
	y = "(uiNamespace getvariable ['Rev_arty_gps_y',0.9])"; //0.9
	z = 0.3;
	//xBack = REV_ARTY_DIAG_CASE_X + (REV_ARTY_DIAG_CASE_GRID_SIZE + 12) * pixelGridNoUIScale * pixelW;
	//yBack = 0.9;
	xBack = "(uiNamespace getvariable ['Rev_arty_gps_x',1.4])"; //same as x
	yBack = "(uiNamespace getvariable ['Rev_arty_gps_y',0.9])"; //same as y
	zBack = 0.3;
	inBack = 1;
	enableZoom = 1;
	zoomDuration = 0.001;
	class Areas
	{
		class deviceScreen
		{
			selection = "deviceScreen";
			class controls
			{
				class Picture: RscPicture
				{
					text = "\z\ace\addons\maptools\UI\MapGpsDisplay_background_ca.paa";
					x = 0;
					y = 0;
					w = 1;
					h = 0.77;
				};
				class heading: RscText
				{
					idc = 913590;
					x = 0.15;
					y = 0;
					w = 0.35;
					h = 0.2;
					style = 0;
					text = "225";
					colorBackground[] = {0,0,0,0};
					colorText[] = {0.1235,0.1255,0.0785,1};
					shadowColor[] = {0,0,0,0};
					font = "PuristaSemibold";
					shadow = 0;
					sizeEx = 0.18;
				};
				class altitude: RscText
				{
					idc = 913591;
					x = 0.5;
					y = 0;
					w = 0.35;
					h = 0.2;
					style = 1;
					text = "55 m";
					colorBackground[] = {0,0,0,0};
					colorText[] = {0.1235,0.1255,0.0785,1};
					shadowColor[] = {0,0,0,0};
					font = "PuristaSemibold";
					shadow = 0;
					sizeEx = 0.18;
				};
				class coordinates: RscText
				{
					idc = 913592;
					x = 0;
					y = 0.225;
					w = 1;
					h = 0.35;
					style = 2;
					text = "12345 12345";
					colorBackground[] = {0,0,0,0};
					colorText[] = {0.1235,0.1255,0.0785,1};
					shadowColor[] = {0,0,0,0};
					font = "PuristaSemibold";
					shadow = 0;
					sizeEx = 0.333;
				};
			};
		};
	};
};