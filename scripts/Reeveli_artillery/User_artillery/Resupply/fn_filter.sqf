/*
 * Author: Reeveli, most of the code loaned from ACE arsenal framework.
 * Part of Reeveli's Artillery system, aerial resupply ordnance.
 * Function to handle filtering items by category in the supply dialog.
 *
 * Arguments:
 * 0: Value <NUMBER> (default: 0)
 *
 * Return Value: NONE
 *
 * Example:
 * [0] call Rev_arty_fnc_filter
 *
 */
 
params [
	["_types",1,[0]]
];

private _list = uiNamespace getVariable ["Rev_supply_list",[]];
private _items = [];

private ["_iteration"];
{
	_iteration = _x select 0;
	_items pushBackUnique (_x select 0);
} forEach _list;

//Taken from ACE arsenal addons and modified further by Reeveli
// weapon types
#define TYPE_WEAPON_PRIMARY 1
#define TYPE_WEAPON_HANDGUN 2
#define TYPE_WEAPON_SECONDARY 4
// magazine types
#define TYPE_MAGAZINE_HANDGUN_AND_GL 16 // mainly
#define TYPE_MAGAZINE_PRIMARY_AND_THROW 256
#define TYPE_MAGAZINE_SECONDARY_AND_PUT 512 // mainly
#define TYPE_MAGAZINE_MISSILE 768
// more types
#define TYPE_BINOCULAR_AND_NVG 4096
#define TYPE_WEAPON_VEHICLE 65536
#define TYPE_ITEM 131072
// item types
#define TYPE_DEFAULT 0
#define TYPE_MUZZLE 101
#define TYPE_OPTICS 201
#define TYPE_FLASHLIGHT 301
#define TYPE_BIPOD 302
#define TYPE_FIRST_AID_KIT 401
#define TYPE_FINS 501 // not implemented
#define TYPE_BREATHING_BOMB 601 // not implemented
#define TYPE_NVG 602
#define TYPE_GOGGLE 603
#define TYPE_SCUBA 604 // not implemented
#define TYPE_HEADGEAR 605
#define TYPE_FACTOR 607
#define TYPE_RADIO 611
#define TYPE_HMD 616
#define TYPE_BINOCULAR 617
#define TYPE_MEDIKIT 619
#define TYPE_TOOLKIT 620
#define TYPE_UAV_TERMINAL 621
#define TYPE_VEST 701
#define TYPE_UNIFORM 801
#define TYPE_BACKPACK 901


private _cargo =
[
    [ ], // Weapons primary 0,
    [ ], // Weapons secondary 1
    [ ], // Weapons handgun 2
    [ ], // WeaponAccessories optic 3
    [ ], // WeaponAccessories side 4
    [ ], // WeaponAccessories muzzle 5
    [ ], // WeaponAccessories bipod 6
    [ ], // Magazines 7
    [ ], // Headgear 8
    [ ], // Uniform 9
    [ ], // Vest 10
    [ ], // Backpacks 11
    [ ], // Goggles 12
    [ ], // NVGs 13
    [ ], // Binoculars 14
    [ ], // Map 15
    [ ], // Compass 16
    [ ], // Radio slot 17
    [ ], // Watch slot  18
    [ ], // Comms slot 19
    [ ], // WeaponThrow 20
    [ ], // WeaponPut 21
    [ ] // InventoryItems 22
];


private _configCfgWeapons = configFile >> "CfgWeapons"; //Save this lookup in variable for perf improvement


{
	private _configItemInfo = _configCfgWeapons >> _x >> "ItemInfo";
	private _simulationType = getText (_configCfgWeapons >> _x >> "simulation");
	switch true do {
		case (isClass (_configCfgWeapons >> _x)): {
			switch true do {
				/* Weapon acc */
				case (
						isClass (_configItemInfo) &&
						{(getNumber (_configItemInfo >> "type")) in [TYPE_MUZZLE, TYPE_OPTICS, TYPE_FLASHLIGHT, TYPE_BIPOD]} &&
						{!(_x isKindOf ["CBA_MiscItem", (_configCfgWeapons)])}
					): {
					switch (getNumber (_configItemInfo >> "type")) do {
						case TYPE_OPTICS: {
							_cargo select 3 pushBackUnique _x;
						};
						case TYPE_FLASHLIGHT: {
							_cargo select 4 pushBackUnique _x;
						};
						case TYPE_MUZZLE: {
							_cargo select 5 pushBackUnique _x;
						};
						case TYPE_BIPOD: {
							_cargo select 6 pushBackUnique _x;
						};
					};
				};
				/* Headgear */
				case (isClass (_configItemInfo) &&
					{getNumber (_configItemInfo >> "type") == TYPE_HEADGEAR}): {
					(_cargo select 8) pushBackUnique _x;
				};
				/* Uniform */
				case (isClass (_configItemInfo) &&
					{getNumber (_configItemInfo >> "type") == TYPE_UNIFORM}): {
					(_cargo select 9) pushBackUnique _x;
				};
				/* Vest */
				case (isClass (_configItemInfo) &&
					{getNumber (_configItemInfo >> "type") == TYPE_VEST}): {
					(_cargo select 10) pushBackUnique _x;
				};
				/* NVgs */
				case (_simulationType == "NVGoggles"): {
					(_cargo select 13) pushBackUnique _x;
				};
				/* Binos */
				case (_simulationType == "Binocular" ||
					{(_simulationType == 'Weapon') && {(getNumber (_configCfgWeapons >> _x >> 'type') == TYPE_BINOCULAR_AND_NVG)}}): {
					(_cargo select 14) pushBackUnique _x;
				};
				/* Map */
				case (_simulationType == "ItemMap"): {
					(_cargo select 15) pushBackUnique _x;
				};
				/* Compass */
				case (_simulationType == "ItemCompass"): {
					(_cargo select 16) pushBackUnique _x;
				};
				/* Radio */
				case (_simulationType == "ItemRadio"): {
					(_cargo select 17) pushBackUnique _x;
				};
				/* Watch */
				case (_simulationType == "ItemWatch"): {
					(_cargo select 18) pushBackUnique _x;
				};
				/* GPS */
				case (_simulationType == "ItemGPS"): {
					(_cargo select 19) pushBackUnique _x;
				};
				/* UAV terminals */
				case (isClass (_configItemInfo) &&
					{getNumber (_configItemInfo >> "type") == TYPE_UAV_TERMINAL}): {
					(_cargo select 19) pushBackUnique _x;
				};
				/* Weapon, at the bottom to avoid adding binos */
				case (isClass (_configCfgWeapons >> _x >> "WeaponSlotsInfo") &&
					{getNumber (_configCfgWeapons >> _x >> 'type') != TYPE_BINOCULAR_AND_NVG}): {
					switch (getNumber (_configCfgWeapons >> _x >> "type")) do {
						case TYPE_WEAPON_PRIMARY: {
							_cargo select 0 pushBackUnique  ([_x] call bis_fnc_baseWeapon);
						};
						case TYPE_WEAPON_HANDGUN: {
							_cargo select 2 pushBackUnique ([_x] call bis_fnc_baseWeapon);
						};
						case TYPE_WEAPON_SECONDARY: {
							_cargo select 1 pushBackUnique ([_x] call bis_fnc_baseWeapon);
						};
					};
				};
				/* Misc items */
				case (
						isClass (_configItemInfo) &&
						((getNumber (_configItemInfo >> "type")) in [TYPE_MUZZLE, TYPE_OPTICS, TYPE_FLASHLIGHT, TYPE_BIPOD] &&
						{(_x isKindOf ["CBA_MiscItem", (_configCfgWeapons)])}) ||
						{(getNumber (_configItemInfo >> "type")) in [TYPE_FIRST_AID_KIT, TYPE_MEDIKIT, TYPE_TOOLKIT]} ||
						{(getText (_configCfgWeapons >> _x >> "simulation")) == "ItemMineDetector"}
					): {
					(_cargo select 22) pushBackUnique _x;
				};
			};
		};
		case (isClass (configFile >> "CfgMagazines" >> _x)): {
			// Lists to check against
			private _grenadeList = [];
			{
				_grenadeList append getArray (_configCfgWeapons >> "Throw" >> _x >> "magazines");
				false
			} count getArray (_configCfgWeapons >> "Throw" >> "muzzles");

			private _putList = [];
			{
				_putList append getArray (_configCfgWeapons >> "Put" >> _x >> "magazines");
				false
			} count getArray (_configCfgWeapons >> "Put" >> "muzzles");

			// Check what the magazine actually is
			switch true do {
				// Rifle, handgun, secondary weapons mags
				case (
						((getNumber (configFile >> "CfgMagazines" >> _x >> "type") in [TYPE_MAGAZINE_PRIMARY_AND_THROW,TYPE_MAGAZINE_SECONDARY_AND_PUT,1536,TYPE_MAGAZINE_HANDGUN_AND_GL]) ||
						{(getNumber (configFile >> "CfgMagazines" >> _x >> "ace_arsenal_hide")) == -1}) &&
						{!(_x in _grenadeList)} &&
						{!(_x in _putList)}
					): {
					(_cargo select 7) pushBackUnique _x;
				};
				// Grenades
				case (_x in _grenadeList): {
					(_cargo select 20) pushBackUnique _x;
				};
				// Put
				case (_x in _putList): {
					(_cargo select 21) pushBackUnique _x;
				};
			};
		};
		case (isClass (configFile >> "CfgVehicles" >> _x)): {
			if (getNumber (configFile >> "CfgVehicles" >> _x >> "isBackpack") == 1) then {
				(_cargo select 11) pushBackUnique _x;
			};
		};
		case (isClass (configFile >> "CfgGlasses" >> _x)): {
			(_cargo select 12) pushBackUnique _x;
		};
	};

} foreach _items;

private _new_list = _cargo select _types;
[_new_list] call Rev_arty_fnc_supply_list;




