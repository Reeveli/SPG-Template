/*
SPG squad checklist, run as a post init function
*/

if !(hasInterface) exitWith {};

player createDiarySubject ["SPG_SMP","SPG"];
player createDiaryRecord ["SPG_SMP", ["Squad Mission Preparation", 
"
<br/>
Mission and Execution<br/><br/>
Squad organisation and inheritance of command<br/><br/>
Radio network and comm checks<br/><br/>
Special equipment<br/><br/>
Suggestions and Questions<br/><br/>
Report that your squad is ready
"
]];

