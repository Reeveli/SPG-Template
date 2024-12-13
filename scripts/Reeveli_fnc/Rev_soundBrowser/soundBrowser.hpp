/*
 * Arma 3 Simple Sound Browser orogonal config by Rydygier.
 * Modified by Reeveli.
 * Created from Rev_fnc_soundB_init
 */

#define UI_GRID_W (pixelW * pixelGrid) // One grid width
#define UI_GRID_H (pixelH * pixelGrid) // One grid height
#define UI_GUTTER_W (pixelW * 2)       // One �gutter� width
#define UI_GUTTER_H (pixelH * 2)       // One �gutter� height


class RscSoundBrowser: ctrlControlsGroupNoScrollbars {
	x = safeZoneX + (safeZoneW/2) - UI_GRID_W * 40;
	y = safeZoneY + UI_GRID_H * 20;
	w = UI_GRID_W * 80;
	h = UI_GRID_H * 80;  
	IDD = 8080;
	colorBackground[] = {1,0,0,0.35};
	class controls {
		class RscBack_SB: RscText {
			x = 0;
			y = 0;
			w = UI_GRID_W * 80;
			h = UI_GRID_H * 80;  
			colorBackground[] = {0,0,0,0.8};
		};		
		class RscFrame_SB: RscFrame {
			text = "Simple Sound Browser";
			x = UI_GRID_W * 2;
			y = UI_GRID_H * 1;
			w = UI_GRID_W * 76;
			h = UI_GRID_H * 77.25; 
			sizeEx = 3 * UI_GRID_H;
			font = "Puristamedium";
			colorText[] = {1,1,1,1};
		};
			
		class RscList_SB: RscListBox {
			onLoad = "params ['_control','_config'];localNameSpace setVariable ['Rev_soundB_list',_control]";
			idc = -1;
			x = UI_GRID_W * 3;
			y = UI_GRID_H * 6.1;
			w = UI_GRID_W * 74;
			h = UI_GRID_H * 40; 
			rowHeight = 3 * UI_GRID_H;
			sizeEx = 3 * UI_GRID_H;
 			font = "PuristaMedium";
			onLBSelChanged = "params ['_control', '_selectedIndex'];[_control, _selectedIndex] call Rev_fnc_soundB_lbSelect;";
		};

		class RscEdit_SB_Filter: RscEdit {
			idc = -1;
			x = UI_GRID_W * 3;
			y = UI_GRID_H * 48;
			w = UI_GRID_W * 74;
			h = UI_GRID_H * 4; 
			offsetX = 0.003;
			offsetY = 0.003;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			text = "";
			sizeEx = 3 * UI_GRID_H;
			autocomplete = "";	
			onKeyUp = "params ['_control', '_key', '_shift', '_ctrl', '_alt']; [_control,_key] call Rev_fnc_soundB_filter";		
		};

		class RscButton_SB_COPY: RscButton {
			onLoad = "params ['_control','_config'];localNameSpace setVariable ['Rev_soundB_copy',_control]";
			idc = -1;
			text = "COPY";
			tooltip = "Saves the sound class into the RPT and clipboard";
 			font = "PuristaMedium";
			x = UI_GRID_W * 3;
			y = UI_GRID_H * 54;
			w = UI_GRID_W * 74;
			h = UI_GRID_H * 22; 			
			sizeEx = 8 * UI_GRID_H;
			action = "private _class = localNameSpace getVariable ['Rev_soundB_current',nil];copyToClipBoard _class;diag_log format ['Sound class: %1',_class]";
		};
			
	};
};

