/*
 * Author: Killet & Reeveli
 * Client side function to initialize post processing effects.
 * Called either from SPG settings or from curator module
 *
 * Arguments:
 * 0: Preset <Number> (default: 0)
 *
 * Return Value: BOOLEAN
 *
 * Example:
 * [0] call KLT_fnc_enviro
 *
 	0. 	Disabled
	1.	Realistic Color Correction theme
	2.	Post Apocalyptic theme
	3.	Nightstalkers theme
	4.	OFP Gamma theme
	5.	Golden autumn theme
	6.	Africa theme
	7.	Afghan theme
	8.	Middle East theme
	9.	Real Is Brown theme
	10. Gray Tone theme
	11.	Cold Tone theme
	12. Winter Blue theme
	13. Winter White theme
	14. Mediterranean theme

Changelog:
1.1
	Added proper function header
	Added default param
	Cleaned unnecessary _value definitions
	Added interface condition
	Added diag_log print

 */

if !(hasInterface) exitWith {false};

params ["_value"];
diag_log format ["KLT_fnc_enviro: Value changed to %1",_value];

switch (_value) do {

	case 0: {
		"ColorCorrections" ppEffectEnable false;
	};

	case 1: {
		//	Realistic Color Correction theme	
		"ColorCorrections" ppEffectEnable true; 
		"ColorCorrections" ppEffectAdjust [0.88, 0.88, 0, [0.2, 0.29, 0.4, -0.22], [1, 1, 1, 1.3], [0.15, 0.09, 0.09, 0.0]]; 
		"ColorCorrections" ppEffectCommit 0;
	};

	case 2: {
		//	Post Apocalyptic theme
		"colorCorrections" ppEffectEnable true;
		"colorCorrections" ppEffectAdjust [1, 0.9, -0.002, [0.0, 0.0, 0.0, 0.0], [1.0, 0.6, 0.4, 0.6],  [0.199, 0.587, 0.114, 0.0]];  
		"colorCorrections" ppEffectCommit 0;  
	};

	case 3: {
		//	Nightstalkers theme
		"colorCorrections" ppEffectEnable true;
		"colorCorrections" ppEffectAdjust [1, 1.1, 0.0, [0.0, 0.0, 0.0, 0.0], [1.0,0.7, 0.6, 0.60], [0.200, 0.600, 0.100, 0.0]];
		"colorCorrections" ppEffectCommit 0;
	};

	case 4: {
		//	OFP Gamma theme
		"colorCorrections" ppEffectEnable true;
		"colorCorrections" ppEffectAdjust [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.6, 1.4, 0.6, 0.7],  [0.199, 0.587, 0.114, 0.0]];  
		"colorCorrections" ppEffectCommit 1;  
	};

	case 5: {
		//	Golden autumn theme
		"colorCorrections" ppEffectEnable true;
		"colorCorrections" ppEffectAdjust [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [1.8, 1.8, 0.3, 0.7],  [0.199, 0.587, 0.114, 0.0]];  
		"colorCorrections" ppEffectCommit 0;  
	};

	case 6: {
		//	Africa theme
		"colorCorrections" ppEffectEnable true;
		"colorCorrections" ppEffectAdjust[ 1, 1.3, 0.001, [-0.11, -0.65, -0.76, 0.015],[-5, -1.74, 0.09, 0.86],[-1.14, -0.73, 1.14, -0.09]]; 
		"colorCorrections" ppEffectCommit 0; 
	};

	case 7: {
		//	Afghan theme
		"ColorCorrections" ppEffectEnable true; 
		"ColorCorrections" ppEffectAdjust [0.9, 0.9, 0, [0, 0.1, 0.25, -0.14], [1, 1, 1, 1.26], [0.15, 0.09, 0.09, 0.0]]; 
		"ColorCorrections" ppEffectCommit 0;
	};

	case 8: {
		//	Middle East theme
		"colorCorrections" ppEffectEnable true;
		"colorCorrections" ppEffectAdjust [0.9, 1, 0, [0.1, 0.1, 0.1, -0.1], [1, 1, 0.8, 0.528],  [1, 0.2, 0, 0]];
		"colorCorrections" ppEffectCommit 0;
	};

	case 9: {
		//	Real Is Brown theme
		"colorCorrections" ppEffectEnable true;
		"colorCorrections" ppEffectAdjust [1,1,0,[0.1,0.2,0.3,-0.3],[1,1,1,0.5],[0.5,0.2,0,1]];
		"colorCorrections" ppEffectCommit 0;
	};

	case 10: {
		//	Gray Tone theme
		"colorCorrections" ppEffectEnable true;
		"colorCorrections" ppEffectAdjust [1.0, 1.0, 0.0,[1.0, 1.0, 1.0, 0.0],[1.0, 1.0, 0.9, 0.35],[0.3,0.3,0.3,-0.1]];
		"colorCorrections" ppEffectCommit 0;
	};

	case 11: {
		//	Cold Tone theme
		"colorCorrections" ppEffectEnable true;
		"colorCorrections" ppEffectAdjust [1.0, 1.0, 0.0,[0.2, 0.2, 1.0, 0.0],[0.4, 0.75, 1.0, 0.60],[0.5,0.3,1.0,-0.1]];
		"colorCorrections" ppEffectCommit 0;
	};

	case 12: {
		//	Winter Blue theme
		"colorCorrections" ppEffectEnable true;
		"ColorCorrections" ppEffectAdjust [1.1, 1.3, 0.0, [0.5, 0.5, 0.1, -0.1], [0.4, 0.75, 1.0, 0.60], [0.5,0.3,1.0,-0.1]];
		"colorCorrections" ppEffectCommit 0;
	};

	case 13: {
		//	Winter White theme
		"colorCorrections" ppEffectEnable true;
		"colorCorrections" ppEffectAdjust [1, 1, 0, [0.31, 0.31, 1.0, 0.1], [0.85, 0.85, 0.92, 0.48], [1 , 1, 1, 0.03]];
		"colorCorrections" ppEffectCommit 0;
	};

	case 14: {
		//	Mediterranean theme
		"colorCorrections" ppEffectEnable true;
		"colorCorrections" ppEffectAdjust [1.01, 1.18, -0.04, [1.0, 1.4, 0.8, -0.04], [0.55, 0.55, 0.72, 1.35],  [0.699, 1.787, 0.314, 20.03]];   
		"colorCorrections" ppEffectCommit 1;       
	};
	
	case 15: {
		//	Cold Tone theme
		"colorCorrections" ppEffectEnable true;
		"colorCorrections" ppEffectAdjust [1.0, 1.0, 0.0,[0.2, 0.2, 1.0, 0.0],[0.4, 0.75, 1.0, 0.60],[0.5,0.3,1.0,-0.1]];
		"colorCorrections" ppEffectCommit 0;
	};

	case 16: {
		//	Cold Tone theme
		"colorCorrections" ppEffectEnable true;
		"colorCorrections" ppEffectAdjust [0.8, 1.0, 0.0,[0.2, 0.2, 1.0, 0.0],[0.7, 0.95, 1.0, 0.60],[0.5,0.3,1.0,-0.1]];
		"colorCorrections" ppEffectCommit 0;
	};

	case 17: {
		//	Cold Tone theme
		"colorCorrections" ppEffectEnable true;
		"colorCorrections" ppEffectAdjust [1.0, 1.0, 0.0,[0.2, 0.2, 1.0, 0.0],[0.5, 0.85, 1.0, 0.60],[0.5,0.3,1.0,-0.1]];
		"colorCorrections" ppEffectCommit 0;
	};


	case 18: {
		//	Cold Tone theme
		"colorCorrections" ppEffectEnable true;
		"colorCorrections" ppEffectAdjust [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.6, 0.6, 1.8, 0.7],  [0.199, 0.587, 0.114, 0.0]];
		"colorCorrections" ppEffectCommit 1;
	};

};

true;