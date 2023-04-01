//Base classes and defines
#define IDD_REV_RZ_GROUP_ATTRIBUTE  	5050
#define IDD_REV_RZ_VEHICLE_ATTRIBUTE  	5080

#define IDC_REV_RZ_GROUP_TITLE   		5051
#define IDC_REV_RZ_FORMATION_WEDGE  	5052
#define IDC_REV_RZ_FORMATION_VEE  		5053
#define IDC_REV_RZ_FORMATION_LINE  		5054
#define IDC_REV_RZ_FORMATION_COLUMN 	5055
#define IDC_REV_RZ_FORMATION_FILE 		5056
#define IDC_REV_RZ_FORMATION_STAG  		5057
#define IDC_REV_RZ_FORMATION_ECH_L  	5058
#define IDC_REV_RZ_FORMATION_ECH_R  	5059
#define IDC_REV_RZ_FORMATION_DIAMOND	5060
#define IDC_REV_RZ_FORMATION_DEFAULT  	5061
#define IDC_REV_RZ_BEHAVIOUR_SAFE  		5062
#define IDC_REV_RZ_BEHAVIOUR_AWARE  	5063
#define IDC_REV_RZ_BEHAVIOUR_COMBAT  	5064
#define IDC_REV_RZ_BEHAVIOUR_STEALTH  	5065
#define IDC_REV_RZ_BEHAVIOUR_CARELESS  	5066
#define IDC_REV_RZ_COMBAT_BLUE  		5067
#define IDC_REV_RZ_COMBAT_GREEN	  		5068
#define IDC_REV_RZ_COMBAT_WHITE  		5069
#define IDC_REV_RZ_COMBAT_YELLOW  		5070
#define IDC_REV_RZ_COMBAT_RED  			5071
#define IDC_REV_RZ_SPEED_LIMITED 		5072
#define IDC_REV_RZ_SPEED_NORMAL 		5073
#define IDC_REV_RZ_SPEED_FULL	 		5074
#define IDC_REV_RZ_POS_DOWN  			5075
#define IDC_REV_RZ_POS_MIDDLE 			5076
#define IDC_REV_RZ_POS_UP		 		5077
#define IDC_REV_RZ_POS_AUTO		 		5078

#define IDC_REV_RZ_VEHICLE_TITLE 		5081
#define IDC_REV_RZ_FUEL_BAR		 		5082
#define IDC_REV_RZ_AMMO_BAR		 		5083
#define IDC_REV_RZ_ENG_OFF		 		5084
#define IDC_REV_RZ_ENG_ON		 		5085
#define IDC_REV_RZ_LIGHTS_OFF		 	5086
#define IDC_REV_RZ_LIGHTS_ON	 		5087

#define IDC_REV_RZ_EMCOM	 			5088
#define IDC_REV_RZ_DATA_SEND 			5089
#define IDC_REV_RZ_DATA_RECEIVE			5090
#define IDC_REV_RZ_DATA_POS	 			5091


#define RZ_X							9 * (((safezoneW / safezoneH) min 1.2) / 40) + 	(safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)
#define RZ_X2							14 * (((safezoneW / safezoneH) min 1.2) / 40) + 	(safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)
#define RZ_Y							-1.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
#define RZ_Y2							((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
#define RZ_BASE_W 						25 * (((safezoneW / safezoneH) min 1.2) / 40)
#define RZ_GAB_MEDIUM_W					0.5 * (((safezoneW / safezoneH) min 1.2) / 40)
#define RZ_GAB_SMALL_H					0.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
#define RZ_GAB_MEDIUM_H					0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)

#define RZ_BAR_H						1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
#define RZ_TITLEBOX_W					8 * (((safezoneW / safezoneH) min 1.2) / 40)

#define RZ_BUTTON_H_BASE				0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
#define RZ_BUTTON_H_LARGE				5 * RZ_BUTTON_H_BASE
#define RZ_BUTTON_H_SMALL				3 * RZ_BUTTON_H_BASE
#define RZ_BUTTON_W_BASE				0.5 * ((safezoneW / safezoneH) min 1.2) / 40)
#define RZ_BUTTON_W_LARGE				5 * RZ_BUTTON_W_BASE
#define RZ_BUTTON_W_SMALL				3 * RZ_BUTTON_W_BASE

class Rev_RZ_group_attributes 
{	
	idd = IDD_REV_RZ_GROUP_ATTRIBUTE;
	movingEnable = true;

	class ControlsBackground
	{
		class Title: RscText
		{
			moving = true;
			colorBackground[] = COLOR_REV_TITLE;
			idc = IDC_REV_RZ_GROUP_TITLE;
			text = "";
			x = RZ_X;
			y = RZ_Y;
			w = 2 * RZ_GAB_MEDIUM_W + RZ_TITLEBOX_W + 5 * RZ_BUTTON_W_LARGE;
			h = RZ_BAR_H;
		};
		class Background: RscText
		{
			moving = true;
			colorBackground[] = {0,0,0,0.7};
			x = RZ_X;
			y = RZ_Y + RZ_BAR_H + RZ_GAB_SMALL_H;
			w = 2 * RZ_GAB_MEDIUM_W + RZ_TITLEBOX_W + 5 * RZ_BUTTON_W_LARGE;
			h = 2 * RZ_GAB_MEDIUM_H + 6 * RZ_BUTTON_H_LARGE + 8 * RZ_GAB_SMALL_H;
		};
	};
	class controls
	{
		class Formation_Title: RscText
		{
			text = "Formation";
			x = RZ_X + RZ_GAB_MEDIUM_W;
			y = RZ_Y + RZ_BAR_H + 1 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H;
			w = RZ_TITLEBOX_W;
			h = 2 * RZ_BUTTON_H_LARGE;
			colorBackground[] = {0,0,0,0.5};
		};
		class Formation_Background: Formation_Title
		{
			x = RZ_X + RZ_GAB_MEDIUM_W + RZ_TITLEBOX_W;
			w = 5 * RZ_BUTTON_W_LARGE;
			colorBackground[] = {1,1,1,0.1};
			text = "";
		};
		class Formation_Wedge: RscActivePicture
		{
			idc = IDC_REV_RZ_FORMATION_WEDGE;
			text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\wedge_ca.paa";
			x = RZ_X + RZ_GAB_MEDIUM_W + RZ_TITLEBOX_W;
			y = RZ_Y + RZ_BAR_H + 1 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H;
			w = RZ_BUTTON_W_LARGE;
			h = RZ_BUTTON_H_LARGE;
			tooltip = "Wedge";
			color[] = {1,1,1,0.5};
			colorActive[] = {1,1,1,1};
			action = "[0,0] call Rev_RZ_fnc_group_button";
		};
		class Formation_Vee: Formation_Wedge
		{
			idc = IDC_REV_RZ_FORMATION_VEE;
			text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\vee_ca.paa";
			x = RZ_X + RZ_GAB_MEDIUM_W + RZ_TITLEBOX_W + 1 * RZ_BUTTON_W_LARGE;
			tooltip = "Vee";
			action = "[0,1] call Rev_RZ_fnc_group_button";
		};
		class Formation_Line: Formation_Wedge
		{
			idc = IDC_REV_RZ_FORMATION_LINE;
			text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\line_ca.paa";
			x = RZ_X + RZ_GAB_MEDIUM_W + RZ_TITLEBOX_W + 2 * RZ_BUTTON_W_LARGE;
			tooltip = "Line";
			action = "[0,2] call Rev_RZ_fnc_group_button";
		};
		class Formation_Column: Formation_Wedge
		{
			idc = IDC_REV_RZ_FORMATION_COLUMN;
			text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\column_ca.paa";
			x = RZ_X + RZ_GAB_MEDIUM_W + RZ_TITLEBOX_W + 3 * RZ_BUTTON_W_LARGE;
			tooltip = "Column";
			action = "[0,3] call Rev_RZ_fnc_group_button";
		};
		class Formation_File: Formation_Wedge
		{
			idc = IDC_REV_RZ_FORMATION_FILE;
			text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\file_ca.paa";
			x = RZ_X + RZ_GAB_MEDIUM_W + RZ_TITLEBOX_W + 4 * RZ_BUTTON_W_LARGE;
			tooltip = "File";
			action = "[0,4] call Rev_RZ_fnc_group_button";
		};
		class Formation_Stag_Column: Formation_Wedge
		{
			idc = IDC_REV_RZ_FORMATION_STAG;
			text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\stag_column_ca.paa";
			y = RZ_Y + RZ_BAR_H + 1 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + RZ_BUTTON_H_LARGE;
			tooltip = "Staggered Col.";
			action = "[0,5] call Rev_RZ_fnc_group_button";
		};
		class Formation_Ech_Left: Formation_Stag_Column
		{
			idc = IDC_REV_RZ_FORMATION_ECH_L;
			text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\ech_left_ca.paa";
			x = RZ_X + RZ_GAB_MEDIUM_W + RZ_TITLEBOX_W + 1 * RZ_BUTTON_W_LARGE;
			tooltip = "Echelon L.";
			action = "[0,6] call Rev_RZ_fnc_group_button";
		};
		class Formation_Ech_Right: Formation_Stag_Column
		{
			idc = IDC_REV_RZ_FORMATION_ECH_R;
			text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\ech_right_ca.paa";
			x = RZ_X + RZ_GAB_MEDIUM_W + RZ_TITLEBOX_W + 2 * RZ_BUTTON_W_LARGE;
			tooltip = "Echelon R.";
			action = "[0,7] call Rev_RZ_fnc_group_button";
		};
		class Formation_Diamond: Formation_Stag_Column
		{
			idc = IDC_REV_RZ_FORMATION_DIAMOND;
			text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\diamond_ca.paa";
			x = RZ_X + RZ_GAB_MEDIUM_W + RZ_TITLEBOX_W + 3 * RZ_BUTTON_W_LARGE;
			tooltip = "Diamond";
			action = "[0,8] call Rev_RZ_fnc_group_button";
		};




		class Behaviour_Title: Formation_Title
		{
			text = "Behavior";
			y = RZ_Y + RZ_BAR_H + 3 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 2 * RZ_BUTTON_H_LARGE;
			h = RZ_BUTTON_H_LARGE;
		};
		class Behaviour_Background: Formation_Background
		{
			y = RZ_Y + RZ_BAR_H + 3 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 2 * RZ_BUTTON_H_LARGE;
			h = RZ_BUTTON_H_LARGE;
		};
		class Behaviour_Safe: RscActivePicture
		{
			idc = IDC_REV_RZ_BEHAVIOUR_SAFE;
			text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\safe_ca.paa";
			x = RZ_X + RZ_GAB_MEDIUM_W + RZ_TITLEBOX_W + 6 * RZ_BUTTON_W_BASE;
			y = RZ_Y + RZ_BAR_H + 3 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 2 * RZ_BUTTON_H_LARGE + 1 * RZ_BUTTON_H_BASE;
			w = RZ_BUTTON_W_SMALL;
			h = RZ_BUTTON_H_SMALL;
			tooltip = "Safe";
			color[] = {0,1,0,0.5};
			colorActive[] = {0,1,0,1};
			action = "[1,0] call Rev_RZ_fnc_group_button";
		};
		class Behaviour_Aware: Behaviour_Safe
		{
			idc = IDC_REV_RZ_BEHAVIOUR_AWARE;
			text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\aware_ca.paa";
			x = RZ_X + RZ_GAB_MEDIUM_W + RZ_TITLEBOX_W + 11 * RZ_BUTTON_W_BASE;				
			tooltip = "Aware";
			color[] = {1,1,0,0.5};
			colorActive[] = {1,1,0,1};
			action = "[1,1] call Rev_RZ_fnc_group_button";
		};
		class Behaviour_Combat: Behaviour_Safe
		{
			idc = IDC_REV_RZ_BEHAVIOUR_COMBAT;
			text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\combat_ca.paa";
			x = RZ_X + RZ_GAB_MEDIUM_W + RZ_TITLEBOX_W + 16 * RZ_BUTTON_W_BASE;
			tooltip = "Combat";
			color[] = {1,0,0,0.5};
			colorActive[] = {1,0,0,1};
			action = "[1,2] call Rev_RZ_fnc_group_button";
		};
		class Behaviour_Stealth: Behaviour_Safe
		{
			idc = IDC_REV_RZ_BEHAVIOUR_STEALTH;
			text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\stealth_ca.paa";
			x = RZ_X + RZ_GAB_MEDIUM_W + RZ_TITLEBOX_W + 21 * RZ_BUTTON_W_BASE;
			tooltip = "Stealth";
			color[] = {0,1,1,0.5};
			colorActive[] = {0,1,1,1};
			action = "[1,3] call Rev_RZ_fnc_group_button";
		};
		class Behaviour_Careless: Behaviour_Safe
		{
			idc = IDC_REV_RZ_BEHAVIOUR_CARELESS;
			text = "\x\zen\addons\attributes\ui\careless_ca.paa";
			x = RZ_X + RZ_GAB_MEDIUM_W + RZ_TITLEBOX_W + 1 * RZ_BUTTON_W_BASE;
			tooltip = "Careless";
			color[] = {1,1,1,0.5};
			colorActive[] = {1,1,1,1};
			action = "[1,4] call Rev_RZ_fnc_group_button";
		};
		



		class Combat_Title: Behaviour_Title
		{
			text = "Combat Mode";
			y = RZ_Y + RZ_BAR_H + 5 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 3 * RZ_BUTTON_H_LARGE;
		};
		class Combat_Background: Behaviour_Background
		{
			y = RZ_Y + RZ_BAR_H + 5 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 3 * RZ_BUTTON_H_LARGE;
		};
		class Combat_blue: Behaviour_Careless
		{
			idc = IDC_REV_RZ_COMBAT_BLUE;
			text = "\x\zen\addons\attributes\ui\hold_ca.paa";
			y = RZ_Y + RZ_BAR_H + 5 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 3 * RZ_BUTTON_H_LARGE + 1 * RZ_BUTTON_H_BASE;
			tooltip = "Never fire, keep formation";
			color[] = {1,0,0,0.5};
			colorActive[] = {1,0,0,1};
			action = "[2,0] call Rev_RZ_fnc_group_button";
		};
		class Combat_Green: Behaviour_Safe
		{
			idc = IDC_REV_RZ_COMBAT_GREEN;
			text = "\x\zen\addons\attributes\ui\defend_ca.paa";
			y = RZ_Y + RZ_BAR_H + 5 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 3 * RZ_BUTTON_H_LARGE + 1 * RZ_BUTTON_H_BASE;				
			tooltip = "Hold fire, keep formation";
			color[] = {1,0,0,0.5};
			colorActive[] = {1,0,0,1};
			action = "[2,1] call Rev_RZ_fnc_group_button";
		};
		class Combat_White: Behaviour_Aware
		{
			idc = IDC_REV_RZ_COMBAT_WHITE;
			text = "\x\zen\addons\attributes\ui\engage_ca.paa";
			y = RZ_Y + RZ_BAR_H + 5 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 3 * RZ_BUTTON_H_LARGE + 1 * RZ_BUTTON_H_BASE;
			tooltip = "Hold fire, engage at will/loose formation";
			color[] = {1,0,0,0.5};
			colorActive[] = {1,0,0,1};
			action = "[2,2] call Rev_RZ_fnc_group_button";
		};
		class Combat_Yellow: Behaviour_Combat
		{
			idc = IDC_REV_RZ_COMBAT_YELLOW;
			text = "\x\zen\addons\attributes\ui\hold_ca.paa";
			y = RZ_Y + RZ_BAR_H + 5 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 3 * RZ_BUTTON_H_LARGE + 1 * RZ_BUTTON_H_BASE;
			tooltip = "Fire at will, keep formation";
			color[] = {1,1,1,0.5};
			colorActive[] = {1,1,1,1};
			action = "[2,3] call Rev_RZ_fnc_group_button";
		};
		class Combat_Red: Behaviour_Stealth
		{
			idc = IDC_REV_RZ_COMBAT_RED;
			text = "\x\zen\addons\attributes\ui\engage_ca.paa";
			y = RZ_Y + RZ_BAR_H + 5 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 3 * RZ_BUTTON_H_LARGE + 1 * RZ_BUTTON_H_BASE;
			tooltip = "Fire at will, engage at will/loose formation";
			color[] = {1,1,1,0.5};
			colorActive[] = {1,1,1,1};
			action = "[2,4] call Rev_RZ_fnc_group_button";
		};





		
		class Speed_Title: Combat_Title
		{
			text = "Speed";
			y = RZ_Y + RZ_BAR_H + 7 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 4 * RZ_BUTTON_H_LARGE;
		};
		class Speed_Background: Combat_Background
		{
			y = RZ_Y + RZ_BAR_H + 7 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 4 * RZ_BUTTON_H_LARGE;
		};
		class Speed_Limited: Formation_Vee
		{
			idc = IDC_REV_RZ_SPEED_LIMITED;
			text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\limited_ca.paa";
			y = RZ_Y + RZ_BAR_H + 7 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 4 * RZ_BUTTON_H_LARGE;				
			tooltip = "Limited";
			action = "[3,0] call Rev_RZ_fnc_group_button";
		};
		class Speed_Normal: Formation_Line
		{
			idc = IDC_REV_RZ_SPEED_NORMAL;
			text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\normal_ca.paa";
			y = RZ_Y + RZ_BAR_H + 7 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 4 * RZ_BUTTON_H_LARGE;
			tooltip = "Normal";
			action = "[3,1] call Rev_RZ_fnc_group_button";
		};
		class Speed_Full: Formation_Column
		{
			idc = IDC_REV_RZ_SPEED_FULL;
			text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\full_ca.paa";
			y = RZ_Y + RZ_BAR_H + 7 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 4 * RZ_BUTTON_H_LARGE;
			tooltip = "Full";
			action = "[3,2] call Rev_RZ_fnc_group_button";
		};









		
		class Pos_Title: Speed_Title
		{
			text = "Stance";
			y = RZ_Y + RZ_BAR_H + 9 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 5 * RZ_BUTTON_H_LARGE;
		};
		class Pos_Background: Speed_Background
		{
			y = RZ_Y + RZ_BAR_H + 9 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 5 * RZ_BUTTON_H_LARGE;
		};
		class Pos_Down: Formation_Vee
		{
			idc = IDC_REV_RZ_POS_DOWN;
			text = "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_prone_ca.paa";
			y = RZ_Y + RZ_BAR_H + 9 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 5 * RZ_BUTTON_H_LARGE;				
			tooltip = "Prone";
			action = "[4,0] call Rev_RZ_fnc_group_button";
		};
		class Pos_Middle: Formation_Line
		{
			idc = IDC_REV_RZ_POS_MIDDLE;
			text = "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_crouch_ca.paa";
			y = RZ_Y + RZ_BAR_H + 9 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 5 * RZ_BUTTON_H_LARGE;
			tooltip = "Kneeling";
			action = "[4,1] call Rev_RZ_fnc_group_button";
		};
		class Pos_Up: Formation_Column
		{
			idc = IDC_REV_RZ_POS_UP;
			text = "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_stand_ca.paa";
			y = RZ_Y + RZ_BAR_H + 9 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 5 * RZ_BUTTON_H_LARGE;
			tooltip = "Standing";
			action = "[4,2] call Rev_RZ_fnc_group_button";
		};
		class Pos_Auto: Combat_Red
		{
			idc = IDC_REV_RZ_POS_AUTO;
			text = "\a3\ui_f_curator\Data\default_ca.paa";
			y = RZ_Y + RZ_BAR_H + 9 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 5 * RZ_BUTTON_H_LARGE + 1* RZ_BUTTON_H_BASE;
			tooltip = "Automatic";
			action = "[4,3] call Rev_RZ_fnc_group_button";
		};




		class Button_Cancel: RscButtonMenuCancel
		{
			x = RZ_X;
			y = RZ_Y + RZ_BAR_H + 10 * RZ_GAB_SMALL_H + 2 * RZ_GAB_MEDIUM_H + 6 * RZ_BUTTON_H_LARGE;
			w = 2 * RZ_BUTTON_W_LARGE;
			h = RZ_BAR_H;
		};
		class Button_Ok: Button_Cancel
		{
			idc = -1;
			Text = "OK";
			x = RZ_X + 2 * RZ_GAB_MEDIUM_W + RZ_TITLEBOX_W + 3 * RZ_BUTTON_W_LARGE;
			action = "call Rev_RZ_fnc_button_ok";
		};
	};
};















class Rev_RZ_vehicle_attributes 
{	
	idd = IDD_REV_RZ_VEHICLE_ATTRIBUTE;
	movingEnable = true;

	class ControlsBackground
	{
		class Title: RscText
		{
			moving = true;
			colorBackground[] = COLOR_REV_TITLE;
			idc = IDC_REV_RZ_VEHICLE_TITLE;
			text = "";
			x = RZ_X2;
			y = RZ_Y2;
			w = 2 * RZ_GAB_MEDIUM_W + RZ_TITLEBOX_W + 12 * RZ_BUTTON_W_BASE;
			h = RZ_BAR_H;
		};
		class Background: Title
		{
			moving = true;
			colorBackground[] = {0,0,0,0.7};
			y = RZ_Y2 + RZ_BAR_H + RZ_GAB_SMALL_H;
			h = 2 * RZ_GAB_MEDIUM_H + 2 * RZ_BUTTON_H_LARGE + 14 * RZ_GAB_SMALL_H + 6 * RZ_BAR_H;
		};
	};
	class controls
	{
		class Fuel_title: RscText
		{
			text = "Fuel";
			x = RZ_X2 + RZ_GAB_MEDIUM_W;	
			y = RZ_Y2 + 1 * RZ_BAR_H + 1 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H;
			w = RZ_TITLEBOX_W - RZ_BUTTON_W_LARGE;
			h = RZ_BAR_H;
			colorBackground[] = {0,0,0,0.5};
		};
		class Fuel_background: RscText
		{
			text = "";
			x = RZ_X2 + RZ_GAB_MEDIUM_W + RZ_TITLEBOX_W - RZ_BUTTON_W_LARGE;
			y = RZ_Y2 + 1 * RZ_BAR_H + 1 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H;	
			h = RZ_BAR_H;
			w = 17 * RZ_BUTTON_W_BASE;
			colorBackground[] = {1,1,1,0.1};
		};
		class Fuel_bar: RscProgress
		{
			idc = IDC_REV_RZ_FUEL_BAR;
			x = RZ_X2 + RZ_GAB_MEDIUM_W + RZ_TITLEBOX_W - RZ_BUTTON_W_LARGE;
			y = RZ_Y2 + 1 * RZ_BAR_H + 1 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H;	
			h = RZ_BAR_H;
			w = 17 * RZ_BUTTON_W_BASE;
			colorBar[] = {1,1,1,1};
			colorFrame[] = {0,0,0,0};		
		};
		class Ammo_title: Fuel_title
		{
			text = "Ammunition";	
			y = RZ_Y2 + 2 * RZ_BAR_H + 3 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H;
			colorBackground[] = {0,0,0,0.5};
		};
		class Ammo_background: Fuel_background
		{
			y = RZ_Y2 + 2 * RZ_BAR_H + 3 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H;
		};
		class Ammo_bar: Fuel_bar
		{
			idc = IDC_REV_RZ_AMMO_BAR;
			y = RZ_Y2 + 2 * RZ_BAR_H + 3 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H;	
			colorBar[] = {1,1,1,1};
			colorFrame[] = {0,0,0,0};		
		};			
		class Engine_Title: Fuel_title
		{
			text = "Engine";
			y = RZ_Y2 + 3 * RZ_BAR_H + 5 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H;
			h = RZ_BUTTON_H_LARGE;
		};
		class Engine_Background: Engine_Title
		{
			x = RZ_X2 + RZ_GAB_MEDIUM_W + RZ_TITLEBOX_W - RZ_BUTTON_W_LARGE;
			w = 17 * RZ_BUTTON_W_BASE;
			colorBackground[] = {1,1,1,0.1};
			text = "";
		};
		class Engine_off: RscActivePicture
		{
			idc = IDC_REV_RZ_ENG_OFF;
			text = "\x\zen\addons\attributes\ui\engine_off_ca.paa";
			x = RZ_X2 + RZ_GAB_MEDIUM_W + RZ_TITLEBOX_W - 3 * RZ_BUTTON_W_BASE;	
			y = RZ_Y2 + 3 * RZ_BAR_H + 5 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H;
			w = RZ_BUTTON_W_LARGE;
			h = RZ_BUTTON_H_LARGE;
			tooltip = "Engine Off";
			color[] = {1,1,1,0.5};
			colorActive[] = {1,1,1,1};
			action = "[0,0] call Rev_RZ_fnc_vehicle_button";
		};
		class Engine_on: Engine_off
		{
			idc = IDC_REV_RZ_ENG_ON;
			text = "\x\zen\addons\attributes\ui\engine_on_ca.paa";
			x = RZ_X2 + RZ_GAB_MEDIUM_W + RZ_TITLEBOX_W + 5 * RZ_BUTTON_W_BASE;			
			tooltip = "Engine On";
			color[] = {0,1,0,0.5};
			colorActive[] = {1,1,1,1};
			action = "[0,1] call Rev_RZ_fnc_vehicle_button";
		};			
		class Lights_Title: Fuel_title
		{
			text = "Lights";
			y = RZ_Y2 + 3 * RZ_BAR_H + 7 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + RZ_BUTTON_H_LARGE;
			h = RZ_BUTTON_H_LARGE;
		};
		class Lights_Background: Engine_Background
		{
			y = RZ_Y2 + 3 * RZ_BAR_H + 7 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + RZ_BUTTON_H_LARGE;
		};
		class Lights_off: Engine_off
		{
			idc = IDC_REV_RZ_LIGHTS_OFF;
			text = "\x\zen\addons\attributes\ui\lights_off_ca.paa";	
			y = RZ_Y2 + 3 * RZ_BAR_H + 7 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + RZ_BUTTON_H_LARGE;
			tooltip = "Lights Off";
			color[] = {1,1,1,0.5};
			colorActive[] = {1,1,1,1};
			action = "[1,0] call Rev_RZ_fnc_vehicle_button";
		};
		class Lights_on: Lights_off
		{
			idc = IDC_REV_RZ_LIGHTS_ON;
			text = "\x\zen\addons\attributes\ui\lights_on_ca.paa";
			x = RZ_X2 + RZ_GAB_MEDIUM_W + RZ_TITLEBOX_W + 5 * RZ_BUTTON_W_BASE;		
			tooltip = "Lights On";
			color[] = {0,1,0,0.5};
			colorActive[] = {0,1,0,1};
			action = "[1,1] call Rev_RZ_fnc_vehicle_button";
		};
		class Emcom_title: Fuel_title
		{
			text = "Emission Control";	
			y = RZ_Y2 + 3 * RZ_BAR_H + 9 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 2 * RZ_BUTTON_H_LARGE;
		};
		class Emcom_box: RscCombo
		{
			idc = IDC_REV_RZ_EMCOM;
			x = RZ_X2 + RZ_GAB_MEDIUM_W + RZ_TITLEBOX_W - RZ_BUTTON_W_LARGE;
			y = RZ_Y2 + 3 * RZ_BAR_H + 9 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 2 * RZ_BUTTON_H_LARGE;	
			h = RZ_BAR_H;
			w = 17 * RZ_BUTTON_W_BASE;
			rows = 3;
			wholeHeight = 4 * RZ_BAR_H;
			onLBSelChanged = "params ['_control', '_selectedIndex'];[2,_selectedIndex] call Rev_RZ_fnc_vehicle_button";
			class Items
			{
				class Default
				{
					text = "Default";
					tooltip = "AI will use radar when in aware or combat behaviour.";
					default = 1;
					value = 0;
				};
				class Active
				{
					text = "Active";
					tooltip = "AI will keep radar active and emitting at all times.";
					value = 1;
				};
				class Off
				{
					text = "Off";
					tooltip = "AI will keep radar silent at all times.";
					value = 2;
				};
			}
		};
		class Data_send_title: Fuel_title
		{
			text = "Data Link Send";	
			y = RZ_Y2 + 4 * RZ_BAR_H + 11 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 2 * RZ_BUTTON_H_LARGE;
		};
		class Data_send_toolbox: RscToolbox
		{
			idc = IDC_REV_RZ_DATA_SEND;
			x = RZ_X2 + RZ_GAB_MEDIUM_W + RZ_TITLEBOX_W - RZ_BUTTON_W_LARGE;	
			y = RZ_Y2 + 4 * RZ_BAR_H + 11 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 2 * RZ_BUTTON_H_LARGE;
			w = 17 * RZ_BUTTON_W_BASE;
			h = RZ_BAR_H;
			columns = 2;
			rows = 1;
			strings[] = {"Disabled","Enabled"};
			values[] = {0,1};
			colorText[] = {1,1,1,1};
			colorSelectedBg[] = COLOR_REV_TITLE;
			colorBackground[] = {0,0,0,1};
		};
		class Data_receive_title: Fuel_title
		{
			text = "Data Link Receive";	
			y = RZ_Y2 + 5 * RZ_BAR_H + 13 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 2 * RZ_BUTTON_H_LARGE;
		};
		class Data_receive_toolbox: Data_send_toolbox
		{
			idc = IDC_REV_RZ_DATA_RECEIVE;	
			y = RZ_Y2 + 5 * RZ_BAR_H + 13 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 2 * RZ_BUTTON_H_LARGE;
		};
		class Data_pos_title: Fuel_title
		{
			text = "Data Link Position";	
			y = RZ_Y2 + 6 * RZ_BAR_H + 15 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 2 * RZ_BUTTON_H_LARGE;
		};
		class Data_pos_toolbox: Data_send_toolbox
		{
			idc = IDC_REV_RZ_DATA_POS;	
			y = RZ_Y2 + 6 * RZ_BAR_H + 15 * RZ_GAB_SMALL_H + 1 * RZ_GAB_MEDIUM_H + 2 * RZ_BUTTON_H_LARGE;
		};
		class Button_Cancel: RscButtonMenuCancel
		{
			x = RZ_X2;
			y = RZ_Y2 + 7 * RZ_BAR_H + 16 * RZ_GAB_SMALL_H + 2 * RZ_GAB_MEDIUM_H + 2 * RZ_BUTTON_H_LARGE;
			w = 2 * RZ_BUTTON_W_LARGE;
			h = RZ_BAR_H;
		};
		class Button_Ok: Button_Cancel
		{
			idc = -1;
			Text = "OK";
			x = RZ_X2 + 1 * RZ_GAB_MEDIUM_W + RZ_TITLEBOX_W  + 3 * RZ_BUTTON_W_BASE;
			action = "call Rev_RZ_fnc_vehicle_ok";
		};
	};
};