/*
 * Author: Reeveli
 * Part of Reeveli's teleport system.
 * Custom defines and dialog for teleportation menu UI
 *
 SPG -version
	Removed define imports as they are only needed here in the standalone version
 */

#define IDD_REV_TP  					7000	

#define IDC_REV_TP_MAP 					7001
#define IDC_REV_TP_LIST					7002
#define IDC_REV_TP_OK					7003
#define IDC_REV_TP_CANCEL				7004

#define REV_REV_TP_GRID_SIZE			54

#define REV_TP_PANEL_W					REV_REV_TP_GRID_SIZE * pixelGridNoUIScale * pixelW
#define REV_TP_STD_H					REV_REV_TP_GRID_SIZE * 0.5 * pixelGridNoUIScale * pixelH
#define REV_TP_BAR_H					2 * pixelGridNoUIScale * pixelH
#define REV_TP_GAB_W					0.2 * pixelGridNoUIScale * pixelW
#define REV_TP_GAB_H					0.2 * pixelGridNoUIScale * pixelH
#define REV_TP_BUTTON_W					REV_TP_PANEL_W * 0.2
#define REV_TP_BUTTON_H					REV_TP_PANEL_H * 0.8


#define REV_TP_X						safezoneX + (safezoneW * 0.50) - ((REV_REV_TP_GRID_SIZE * pixelGridNoUIScale * pixelW) * 0.5)
#define REV_TP_Y						safeZoneY + (safeZoneH * 0.50) - (REV_TP_BAR_H * 0.5) - (REV_TP_GAB_H * 0.5) - (REV_TP_STD_H * 0.5)



class Rev_tp_dialog
{
	idd = IDD_REV_TP;
	movingEnable = true;
	onLoad = "uiNamespace setVariable ['Rev_tp_display', _this select 0]; private _map = uiNamespace getVariable ['Rev_tp_map', controlNull]; _map ctrlMapAnimAdd [0, 0.3, (getMarkerPos 'Rev_tp_marker')]; ctrlMapAnimCommit _map";
	onUnLoad = "uiNamespace setVariable ['Rev_tp_display', DisplayNull]; deleteMarkerLocal 'Rev_tp_marker';";
	class ControlsBackground
	{
		class Bar_title: RscText
		{
			x = REV_TP_X;
			y = REV_TP_Y;
			w = REV_TP_PANEL_W;
			h = REV_TP_BAR_H;
			text = "Teleport list";
			font = "PuristaSemibold";
			style = 2+512;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
			moving = true;
			SizeEx = 1.6 * pixelGridNoUIScale * pixelH;			
		};
		class Map: RscMapControl
		{
			idc = IDC_REV_TP_MAP;
			moving = false;
			x = REV_TP_X;
			y = REV_TP_Y + REV_TP_BAR_H + REV_TP_GAB_H;
			w = REV_TP_PANEL_W * 0.5;
			h = REV_TP_STD_H;
			onLoad = "uiNamespace setVariable ['Rev_tp_map', _this select 0];";
			onUnLoad = "uiNamespace setVariable ['Rev_tp_map', controlNull]";
		};
		class BG_main: RscText
		{
			x = REV_TP_X + REV_TP_PANEL_W * 0.5;
			y = REV_TP_Y + REV_TP_BAR_H + REV_TP_GAB_H;
			w = REV_TP_PANEL_W * 0.5;
			h = REV_TP_STD_H;
			colorBackground[] = {0,0,0,0.8};
			moving = true;			
		};
	};
	class Controls
	{
		class ListBox_locations: RscListBox
		{
			idc = IDC_REV_TP_LIST;
			onLoad = "params ['_control', ['_config', configNull]]; uiNamespace setVariable ['Rev_tp_list', _control];[_control] call Rev_fnc_tp_onLoad";
			onUnLoad = "uiNamespace setVariable ['Rev_tp_list', controlNull]";
			onLBSelChanged = "params ['_control', '_lbCurSel']; [_control, _lbCurSel] call Rev_fnc_tp_onLBSelChanged";
			x = REV_TP_X + REV_TP_PANEL_W * 0.5 + REV_TP_GAB_W;
			y = REV_TP_Y + REV_TP_BAR_H + 2 * REV_TP_GAB_H;
			w = REV_TP_PANEL_W * 0.5 - (REV_TP_GAB_W * 2);
			h = REV_TP_STD_H - (REV_TP_GAB_H * 3) - REV_TP_BAR_H;
			colorBackground[] = {1,1,1,0};
			sizeEx = 1.4 * pixelGridNoUIScale * pixelH;
		};
		class Button_ok: RscButton
		{
			idc = IDC_REV_TP_OK;
			x = REV_TP_X + REV_TP_PANEL_W - REV_TP_GAB_W - REV_TP_BUTTON_W;
			y = REV_TP_Y + REV_TP_STD_H;
			w = REV_TP_BUTTON_W;
			h = REV_TP_BAR_H;
			text = "Ok";
			colorBackground[] = {0,0,0,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorBackgroundActive[] = {0.2,0.2,0.2,1};
			sizeEx = 1.5 * pixelGridNoUIScale * pixelH;
			onButtonClick = "params ['_control'];[] call Rev_fnc_tp_onButtonClick;";	
		};
		class Button_cancel: Button_ok
		{
			idc = IDC_REV_TP_CANCEL;
			x = REV_TP_X + REV_TP_PANEL_W * 0.5 + REV_TP_GAB_W;
			text = "Cancel";
			onButtonClick = "params ['_control'];closeDialog 2;";
		};
	};
};