
klt_throwRock = 
{
	private _thrower = _this select 0;
	//Find the closest player from the thrower
	 _target = [_thrower] call KLT_fnc_findNearest;


	if (_target distance _thrower < 10) then
	{
		_say = selectrandom ["SomalianAngry2", "SomalianAngry"];
		//_thrower say3d [_say,50]; 

		[_thrower, [_say,50]] remoteExec ["say3D"];

		_thrower addEventHandler ["Fired",
		{ 
			if (_this select 2 == "Rock_Muzzle") then 
			{
				[ _this select 0] spawn
				{
					params ["_thrower"]; 

					 _target = [_thrower] call KLT_fnc_findNearest;
					private _sounds = ["a3\sounds_f\characters\human-sfx\Person3\P3_breath_damage_low_01.wss","a3\sounds_f\characters\human-sfx\Person3\P3_breath_damage_low_02.wss","a3\sounds_f\characters\human-sfx\Person3\P3_breath_damage_low_03.wss","a3\sounds_f\characters\human-sfx\Person3\P3_breath_damage_low_04.wss","a3\sounds_f\characters\human-sfx\Person3\P3_breath_damage_low_05.wss","a3\sounds_f\characters\human-sfx\Person3\P3_breath_damage_low_06.wss","a3\sounds_f\characters\human-sfx\Person3\P3_breath_damage_low_07.wss","a3\sounds_f\characters\human-sfx\Person3\P3_breath_damage_low_08.wss","a3\sounds_f\characters\human-sfx\Person3\P3_breath_damage_low_09.wss","a3\sounds_f\characters\human-sfx\Person3\P3_breath_damage_low_10.wss","a3\sounds_f\characters\human-sfx\Person3\P3_breath_damage_low_11.wss"] call BIS_fnc_selectRandom;
					sleep 0.8;
					playsound3d [_sounds, _target]; 
					[] remoteexec ["klt_fnc_shake",_target];
					_thrower doWatch objNull;
					_thrower playAction "PlayerStand"; 
					_thrower removeEventHandler ["Fired", 0];
					
				};
			};
		}];



		private _group = group _thrower;
		_group setCombatMode "BLUE";
		_group setBehaviour "SAFE";

		_thrower playAction "PlayerCrouch";  
		sleep 1;

		if (stance _thrower == "CROUCH") then 
		{


			
			if (vehicle _target != _target) then {_thrower doTarget vehicle _target;} else {_thrower doTarget _target};
			_thrower addItemToUniform "ROCK_MAG";
			[_thrower, "Rock_Muzzle"] call BIS_fnc_fire;
		};
		
	};
};


klt_fnc_shake = 
{
 addCamShake [10, 1, 25];
};











