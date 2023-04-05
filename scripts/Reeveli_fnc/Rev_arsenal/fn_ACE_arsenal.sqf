/*
 * Author: Reeveli
 * Client side function to create two additional ACE arsenal categories to reduce clutter in miscalleneous section.
 * Called as a postinit function.
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * call Rev_fnc_ACE_arsenal;
 *
 */

//Medical items
private _medical = [
	"ACE_fieldDressing",
	"ACE_elasticBandage",
	"ACE_packingBandage",
	"ACE_quikclot",
	
	"FirstAidKit",
	"ACE_adenosine",
	"ACE_epinephrine",
	"ACE_morphine",

	"ACE_bloodIV",
	"ACE_bloodIV_250",
	"ACE_bloodIV_500",
	"ACE_plasmaIV",
	"ACE_plasmaIV_250",
	"ACE_plasmaIV_500",
	"ACE_salineIV",
	"ACE_salineIV_250",
	"ACE_salineIV_500",
	
	"ACE_personalAidKit",
	"ACE_splint",
	"ACE_surgicalKit",
	"ACE_tourniquet",
	"Medikit",
	"ACE_bodyBag"
];

//Food items
private _foodWater = [
	"ACE_Banana",
	"ACE_Can_Franta",
	"ACE_Can_RedGull",
	"ACE_Can_Spirit",
	"ACE_Canteen",
	"ACE_Canteen_Empty",
	"ACE_Canteen_Half",
	"ACE_Humanitarian_Ration",
	"ACE_MRE_BeefStew",
	"ACE_MRE_ChickenTikkaMasala",
	"ACE_MRE_ChickenHerbDumplings",
	"ACE_MRE_CreamChickenSoup",
	"ACE_MRE_CreamTomatoSoup",
	"ACE_MRE_LambCurry",
	"ACE_MRE_MeatballsPasta",
	"ACE_MRE_SteakVegetables",
	"ACE_WaterBottle",
	"ACE_WaterBottle_Empty",
	"ACE_WaterBottle_Half"
];

//Add categories
[_medical, "Medical", "\z\ace\addons\medical_gui\ui\cross.paa", -1] call ace_arsenal_fnc_addRightPanelButton;
[_foodWater, "Food & Water", "\z\ace\addons\field_rations\ui\icon_hud_hungerstatus.paa", -1] call ace_arsenal_fnc_addRightPanelButton;