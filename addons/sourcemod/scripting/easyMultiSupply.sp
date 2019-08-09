#pragma semicolon 1
#include <sourcemod>
#include <sdktools>
#include <sdkhooks>

#define PLUGIN_VERSION "1.0"
#define FCVAR_FLAG FCVAR_SPONLY|FCVAR_NOTIFY

public Plugin:myinfo =
{
	name = "easy multi-supply",
	author = "NiceT",
	description = "easy multi-supply",
	version = PLUGIN_VERSION,
	url = ""
};

public OnPluginStart()
{
    HookEvent("round_start", Event_RoundStart);
}

public Action:Event_RoundStart(Handle:event, const String:name[], bool:dontBroadcast)
{
	CreateTimer(3.0, UpdateCounts);
	return Plugin_Continue;
}

public Action:UpdateCounts(Handle:timer)
{
	UpdateEntCount("weapon_autoshotgun_spawn","4"); 	// autoshotgun
	UpdateEntCount("weapon_hunting_rifle_spawn","4"); 	// hunting
	UpdateEntCount("weapon_pistol_spawn","4"); 		// pistol
	UpdateEntCount("weapon_pistol_magnum_spawn","4"); 	// magnum
	UpdateEntCount("weapon_pumpshotgun_spawn","4"); 	// pumpshotgun
	UpdateEntCount("weapon_rifle_spawn","4"); 		// rifle
	UpdateEntCount("weapon_rifle_ak47_spawn","4"); 		// ak47
	UpdateEntCount("weapon_rifle_desert_spawn","4"); 	// desert
	UpdateEntCount("weapon_rifle_sg552_spawn","4"); 	// sg552
	UpdateEntCount("weapon_shotgun_chrome_spawn","4"); 	// shotgun_chrome
	UpdateEntCount("weapon_shotgun_spas_spawn","4"); 	// shotgun_spas
	UpdateEntCount("weapon_smg_spawn","4"); 		// smg
	UpdateEntCount("weapon_smg_mp5_spawn","4"); 		// mp5
	UpdateEntCount("weapon_smg_silenced_spawn","4"); 	// smg_silenced
	UpdateEntCount("weapon_sniper_awp_spawn","4"); 		// awp
	UpdateEntCount("weapon_sniper_military_spawn","4"); 	// sniper_military
	UpdateEntCount("weapon_sniper_scout_spawn","4"); 	// scout
	UpdateEntCount("weapon_grenade_launcher_spawn", "2"); 	// grenade_launcher
	UpdateEntCount("weapon_spawn", "10");    		//random new l4d2 weapon
	UpdateEntCount("weapon_chainsaw_spawn", "2"); 		// chainsaw
	UpdateEntCount("weapon_defibrillator_spawn", "2"); 	// defibrillator
	UpdateEntCount("weapon_first_aid_kit_spawn", "2"); 	// first_aid_kit
	UpdateEntCount("weapon_pain_pills_spawn", "3"); 	// pills
	UpdateEntCount("weapon_adrenaline_spawn", "3"); 	// adrenaline
	UpdateEntCount("weapon_melee_spawn", "2"); 		// melee
}

public UpdateEntCount(const String:entname[], const String:count[])
{
	new edict_index = FindEntityByClassname(-1, entname);

	while(edict_index != -1)
	{
		DispatchKeyValue(edict_index, "count", count);
		edict_index = FindEntityByClassname(edict_index, entname);
	}
}
