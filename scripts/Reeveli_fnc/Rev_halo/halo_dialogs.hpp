#define IDD_REV_HALO  					4060

#define IDC_REV_HALO_PLANE_TXT  		4061
#define IDC_REV_HALO_PLANE_IMG  		4062
#define IDC_REV_HALO_WEA_IMG  			4063
#define IDC_REV_HALO_TEMP				4064
#define IDC_REV_HALO_WIND				4065
#define IDC_REV_HALO_DIR 				4066
#define IDC_REV_HALO_LIST 				4067
#define IDC_REV_HALO_OK 				4068

#define REV_HALO_X						safeZoneX + (safeZoneW * 0.5) - 2.5 * REV_AIR_PANEL_W - REV_AIR_GAB_W_S

class Rev_halo_map
{
	idd = IDD_REV_HALO;
	movingEnable = true;
	onUnload = "removeMissionEventHandler ['MapSingleClick', missionNameSpace getVariable ['halo_map_event',-1]];removeMissionEventHandler ['EachFrame', missionNameSpace getVariable ['halo_player_list',-1]];deleteMarkerLocal 'Rev_drop_zone'";
	class ControlsBackground
	{
		class Map: RscMapControl
		{
			moving = true;
			x = REV_HALO_X + REV_AIR_PANEL_W + REV_AIR_GAB_W_S;
			y = REV_AIR_Y + REV_AIR_STD_H + REV_AIR_GAB_H_S;
			w = 3 * REV_AIR_PANEL_W;
			h = REV_AIR_PANEL_H;
		};
		class Title_bar: RscText
		{
			x = REV_HALO_X + REV_AIR_PANEL_W + REV_AIR_GAB_W_S;
			y = REV_AIR_Y;
			w = 3 * REV_AIR_PANEL_W;
			h = REV_AIR_STD_H;
			text = "Select Your Drop Zone";
			font = "PuristaSemiBold";
			style = 2+512;
			colorBackground[] = COLOR_REV_TITLE;
			moving = true;
			
		};
		class Title_aircraft_bar: Title_bar
		{
			x = REV_HALO_X;
			w = REV_AIR_PANEL_W;
			text = "Aircraft";			
		};
		class Aircraft_bg: RscText
		{
			x = REV_HALO_X;
			y = REV_AIR_Y + REV_AIR_STD_H + REV_AIR_GAB_H_S;
			w = REV_AIR_PANEL_W;
			h = REV_AIR_PANEL_H;
			colorBackground[] = COLOR_REV_BG;			
		};
		class Title_players: Title_bar
		{
			x = REV_HALO_X + 4 * REV_AIR_PANEL_W + 2 * REV_AIR_GAB_W_S;
			w = REV_AIR_PANEL_W;
			text = "Players To Deploy";
			
		};
		class Players_bg: Aircraft_bg
		{
			x = REV_HALO_X + 4 * REV_AIR_PANEL_W + 2 * REV_AIR_GAB_W_S;
			y = REV_AIR_Y + REV_AIR_STD_H + REV_AIR_GAB_H_S;
			w = REV_AIR_PANEL_W;
			h = REV_AIR_PANEL_H;
			colorBackground[] = COLOR_REV_BG;			
		};
		
	};
	class Controls
	{
		class Aircraft_title: RscText
		{
			idc = IDC_REV_HALO_PLANE_TXT;
			x = REV_HALO_X + REV_AIR_GAB_W_S;
			y = REV_AIR_Y + REV_AIR_STD_H + 2 * REV_AIR_GAB_H_S;
			w = REV_AIR_STD_W;
			h = REV_AIR_STD_H;
			text = "Aircraft";
			font = "PuristaSemiBold";			
		};
		class Aircraft_img: RscPicture
		{
			idc = IDC_REV_HALO_PLANE_IMG;
			x = REV_HALO_X + REV_AIR_GAB_W_S;
			y = REV_AIR_Y + 2 * REV_AIR_STD_H + 3 * REV_AIR_GAB_H_S;
			w = REV_AIR_STD_W;
			h = 3 * REV_AIR_STD_H;
			colorBackground[] = {1,1,1,1};
			
		};
		class Weather_title: RscText
		{
			x = REV_HALO_X + REV_AIR_GAB_W_S;
			y = REV_AIR_Y + 5 * REV_AIR_STD_H + 4 * REV_AIR_GAB_H_S;
			w = REV_AIR_STD_W;
			h = REV_AIR_STD_H;
			text = "Current Weather";
			font = "PuristaSemiBold";
			style = 0+2;
			
		};		
		class Weather_img: RscPicture
		{
			idc = IDC_REV_HALO_WEA_IMG;
			x = REV_HALO_X +  (0.5 * REV_AIR_PANEL_W) - ((REV_AIR_BUTTON_W / 3)) / 2;
			y = REV_AIR_Y + 6 * REV_AIR_STD_H + 5 * REV_AIR_GAB_H_S;
			w = REV_AIR_BUTTON_W / 3;
			h = 2 * REV_AIR_STD_H;
			font = "PuristaMedium";			
		};
		class Weather_temp: RscText
		{
			idc = IDC_REV_HALO_TEMP;
			x = REV_HALO_X + REV_AIR_GAB_W_S;
			y = REV_AIR_Y + 9 * REV_AIR_STD_H + 6 * REV_AIR_GAB_H_S;
			style = 0+512;
			text = "Temperature:";
			colorBackground[] = {0.6,0.302,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			
		};
		class Weather_wind: Weather_temp
		{
			idc = IDC_REV_HALO_WIND;
			y = REV_AIR_Y + 10 * REV_AIR_STD_H + 7 * REV_AIR_GAB_H_S;
			text = "Wind speed:";
		};
		class Weather_dir: Weather_temp
		{
			idc = IDC_REV_HALO_DIR;
			y = REV_AIR_Y + 11 * REV_AIR_STD_H + 8 * REV_AIR_GAB_H_S;
			text = "Wind direction: ";
		};
		class Deploy: RscButton
		{
			idc = IDC_REV_HALO_OK;
			x = REV_HALO_X + 0.5 * REV_AIR_PANEL_W - 0.5 * REV_AIR_BUTTON_W;
			y = REV_AIR_Y + 12 * REV_AIR_STD_H + 9 * REV_AIR_GAB_H_S;
			w = REV_AIR_BUTTON_W;
			h = REV_AIR_STD_H;
			text = "Deploy";
			font = "PuristaSemiBold";
			colorBackground[] = {0,0,0,1};
			colorBackgroundActive[] = {0.302,0.302,0.302,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			onLoad = "params ['_control', ['_config', configNull]]; _control ctrlEnable false;";
			action = "call Rev_fnc_halo_plane;closeDialog 1;";			
		};
		class Cancel: Deploy
		{
			idc = 2;
			y = REV_AIR_Y + 13.5 * REV_AIR_STD_H + 9 * REV_AIR_GAB_H_S;
			text = "Cancel";
			onLoad = "";
			action = "";			
		};
		class Player_list: RscStructuredText
		{
			idc = IDC_REV_HALO_LIST;
			x = REV_HALO_X + 4 * REV_AIR_PANEL_W + 2 * REV_AIR_GAB_W_S;
			y = REV_AIR_Y + REV_AIR_STD_H + REV_AIR_GAB_H_S;
			w = REV_AIR_PANEL_W;
			h = REV_AIR_PANEL_H;
			colorBackground[] = {1,1,1,0};
			lineSpacing = 1;
			onLoad = "uiNamespace setVariable ['Rev_halo_list', _this select 0]";
			onUnLoad = "uiNamespace setVariable ['Rev_halo_list', DisplayNull]";
			shadow = 0;			
		};
		
	};
	
};