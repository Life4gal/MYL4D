#pragma semicolon 1
#include <sourcemod>
#include <sdktools>

#define PLUGIN_VERSION "1.0"
#define FCVAR_FLAG FCVAR_SPONLY|FCVAR_NOTIFY

new Handle:Enable;
new Handle:TeamRestrict;
new Handle:ZedSurvivorchance;
new Handle:ZedPipeChance;
new Handle:ZedChargerExplosionChance;
new Handle:ZedSmokerExplosionChance;
new Handle:ZedJockeyExplosionChance;
new Handle:ZedHunterExplosionChance;
new Handle:ZedBoomerExplosionChance;
new Handle:ZedModes;
new Handle:ZedTank;
new Handle:ZedWitch;
new Handle:ZedTimer;
new Handle:ZedAmazing;
new Handle:ZedCharger;
new Handle:ZedSmoker;
new Handle:ZedJockey;
new Handle:ZedHunter;
new Handle:ZedBoomer;
static const String:Sound1[] = "./ui/menu_countdown.wav";
new bool:ZedTimeGoing;

public Plugin:myinfo =
{
	name = "easy Zed Time",
	author = "NiceT",
	description = "easy Zed Time like Killing Floor.",
	version = PLUGIN_VERSION,
	url = ""
}

public OnPluginStart()
{
	decl String:game_name[64];
	GetGameFolderName(game_name, sizeof(game_name));
	if (!StrEqual(game_name, "left4dead2", false))
	{
		SetFailState("Plugin supports Left 4 Dead 2 only.");
	}
	CreateConVar("l4d2_zed_time_version", PLUGIN_VERSION, "plugin_version", FCVAR_FLAG);

	// the algorithm about the chance :  value == 1 means 100% triggers     value == 10 means 10% triggers   value == x means (1/x)% triggers

	ZedModes 				= CreateConVar("l4d2_zed_modes", "coop,versus,realism,teamversus", "which mode enable plugin", 							FCVAR_FLAG);
	Enable 					= CreateConVar("l4d2_zed_time_enable", 			"1", 	"enable plugin", 								FCVAR_FLAG);
	TeamRestrict 				= CreateConVar("l4d2_zed_restrict", 			"3", 	"1=survivor,2=Infected,3=all", 							FCVAR_FLAG);
	ZedAmazing 				= CreateConVar("l4d2_zed_extreme_shot", 		"150", 	"Triggers if the distance is greater than this value multiplicate 16", 		FCVAR_FLAG);
	ZedTimer				= CreateConVar("l4d2_zed_timer", 			"0.5", 	"Duration of the slow motion", 							FCVAR_FLAG);
	ZedCharger 				= CreateConVar("l4d2_zed_charger", 			"1", 	"charger Can trigger slow motion", 						FCVAR_FLAG);
	ZedSmoker 				= CreateConVar("l4d2_zed_smoker",			"1", 	"Smokers Can trigger slow motion", 						FCVAR_FLAG);
	ZedJockey 				= CreateConVar("l4d2_zed_jockey", 			"1", 	"Jockeys Can trigger slow motion", 						FCVAR_FLAG);
	ZedHunter 				= CreateConVar("l4d2_zed_hunter", 			"1", 	"Hunters Can trigger slow motion", 						FCVAR_FLAG);
	ZedBoomer 				= CreateConVar("l4d2_zed_boomer", 			"1", 	"Boomers Can trigger slow motion", 						FCVAR_FLAG);
	ZedSurvivorchance 			= CreateConVar("l4d2_zed_surv_chance", 			"20", 	"How many chances kill  the zombies  trigger the slow motion", 			FCVAR_FLAG);
	ZedPipeChance 				= CreateConVar("l4d2_zed_pipe_chance", 			"5", 	"How many chances throw the pipebomb trigger the slow motion", 			FCVAR_FLAG);
	ZedWitch 				= CreateConVar("l4d2_zed_witch", 			"10", 	"How many chances kill  the witch    trigger the slow motion", 			FCVAR_FLAG);
	ZedTank 				= CreateConVar("l4d2_zed_tank", 			"2",  	"How many chances kill  the tank     trigger the slow motion", 			FCVAR_FLAG);
	ZedChargerExplosionChance 		= CreateConVar("l4d2_zed_charger_explosion_chance", 	"10", 	"How many chances does the boomer    trigger the slow motion", 			FCVAR_FLAG);
	ZedSmokerExplosionChance 		= CreateConVar("l4d2_zed_smoker_explosion_chance", 	"10", 	"How many chances does the boomer    trigger the slow motion", 			FCVAR_FLAG);
	ZedJockeyExplosionChance 		= CreateConVar("l4d2_zed_jackey_explosion_chance", 	"10", 	"How many chances does the boomer    trigger the slow motion", 			FCVAR_FLAG);
	ZedHunterExplosionChance 		= CreateConVar("l4d2_zed_hunter_explosion_chance", 	"10", 	"How many chances does the boomer    trigger the slow motion", 			FCVAR_FLAG);
	ZedBoomerExplosionChance 		= CreateConVar("l4d2_zed_boomer_explosion_chance", 	"5",  	"How many chances does the boomer    trigger the slow motion", 			FCVAR_FLAG);
	HookEvent("player_death", Event_PlayerDeath);
	HookEvent("melee_kill", Event_Melee);
	HookEvent("tank_killed", Event_TankDeath);
	HookEvent("witch_killed", Event_WitchDeath);
	HookEvent("hegrenade_detonate", Event_PipeExplode);
	AutoExecConfig(true, "l4d2_zed_time");
}

stock bool:IsAllowedGameMode()
{
	decl String:gamemode[24], String:gamemodeactive[64];
	GetConVarString(FindConVar("mp_gamemode"), gamemode, sizeof(gamemode));
	GetConVarString(ZedModes, gamemodeactive, sizeof(gamemodeactive));

	return (StrContains(gamemodeactive, gamemode) != -1);
}

public OnMapStart()
{
	PrefetchSound(Sound1);
	PrecacheSound(Sound1);
	if(!IsAllowedGameMode()) return;
	if(GetConVarInt(Enable) == 0) return;
	if(GetConVarInt(TeamRestrict) > 1)
	{
		if(GetConVarInt(ZedHunter) == 1)
		{
			HookEvent("lunge_pounce", Event_Pounce);
			HookEvent("hunter_headshot", Event_Win);
		}
		else
		{
			UnhookEvent("lunge_pounce", Event_Pounce);
			UnhookEvent("hunter_headshot", Event_Win);
		}
		if(GetConVarInt(ZedJockey) == 1)
		{
			HookEvent("jockey_ride", Event_Ride);
		}
		else
		{
			UnhookEvent("jockey_ride", Event_Ride);
		}
		if(GetConVarInt(ZedSmoker) == 1)
		{
			HookEvent("toungue_grab", Event_Grab);
		}
		else
		{
			UnhookEvent("toungue_grab", Event_Grab);
		}
		if(GetConVarInt(ZedCharger) == 1)
		{
			HookEvent("charger_carry_start", Event_Charge);
			HookEvent("charger_impact", Event_Impact);
		}
		else
		{
			UnhookEvent("charger_carry_start", Event_Charge);
			UnhookEvent("charger_impact", Event_Impact);
		}
		if(GetConVarInt(ZedBoomer) == 1)
		{
			HookEvent("boomer_exploded", Event_Explosion);
			HookEvent("player_now_it", Event_Boomed);
		}
		else
		{
			UnhookEvent("boomer_exploded", Event_Explosion);
			UnhookEvent("player_now_it", Event_Boomed);
		}
	}
	if(GetConVarInt(TeamRestrict) == 2)
	{
		UnhookEvent("player_death", Event_PlayerDeath);
		UnhookEvent("melee_kill", Event_Melee);
		UnhookEvent("tank_killed", Event_TankDeath);
	}
	ZedTimeGoing = false;
}

public Action:Event_PlayerDeath(Handle:event, const String:name[], bool:dontBroadcast)
{
	if(!IsAllowedGameMode()) return;
	if(GetConVarInt(Enable) == 0) return;
	new attacker = GetClientOfUserId(GetEventInt(event, "attacker"));
	new victim = GetClientOfUserId(GetEventInt(event, "userid"));
	new bool:headshot = GetEventBool(event, "headshot");
	if(attacker && IsClientInGame(attacker) && GetClientTeam(attacker) == 2)
	{
		if(GetRandomInt(1, GetConVarInt(ZedSurvivorchance)) == 1)
		{
			if(victim && IsClientInGame(victim) && GetClientTeam(victim) == 2) return;
			if(GetConVarInt(Enable) == 0) return;
			if(IsFakeClient(attacker)) return;
			if(ZedTimeGoing == true) return;
			ZedTime1(attacker);
			FadeClientVolume(attacker, 90.0, 0.2, GetConVarFloat(ZedTimer)-0.2, 0.2);
			EmitSoundToAll(Sound1, attacker);
		}
		if(headshot)
		{
			if(GetRandomInt(1, GetConVarInt(ZedSurvivorchance)) == 1)
			{
				if(victim && IsClientInGame(victim) && GetClientTeam(victim) == 2) return;
				if(GetConVarInt(Enable) == 0) return;
				if(IsFakeClient(attacker)) return;
				if(ZedTimeGoing == true) return;
				ZedTime1(attacker);
				EmitSoundToAll(Sound1, attacker);
			}
		}
		decl Float:pos1[3], Float:pos2[3];
		if(victim == 0) return;
		if(attacker == 0) return;
		GetClientAbsOrigin(attacker, pos1);
		GetClientAbsOrigin(victim, pos2);
		if(GetVectorDistance(pos1, pos2, false) > GetConVarInt(ZedAmazing)*16)
		{
			if(GetRandomInt(1, GetConVarInt(ZedSurvivorchance)) == 1)
			{
				if(victim && IsClientInGame(victim) && GetClientTeam(victim) == 2) return;
				if(GetConVarInt(Enable) == 0) return;
				if(IsFakeClient(attacker)) return;
				if(ZedTimeGoing == true) return;
				ZedTime1(attacker);
				EmitSoundToAll(Sound1, attacker);
			}
		}
	}
}

public Action:Event_PipeExplode(Handle:event, const String:name[], bool:dontBroadcast)
{
	new client = GetClientOfUserId(GetEventInt(event, "userid"));
	if(client && IsClientInGame(client) && GetClientTeam(client) == 3) return;
	if(!IsAllowedGameMode()) return;
	if(GetRandomInt(1, GetConVarInt(ZedPipeChance)) == 1)
	{
		if(GetConVarInt(Enable) == 0) return;
		if(IsFakeClient(client)) return;
		if(ZedTimeGoing == true) return;
		ZedTime1(client);
		EmitSoundToAll(Sound1, client);
	}
}

public Action:Event_Explosion(Handle:event, const String:name[], bool:dontBroadcast)
{
	new client = GetClientOfUserId(GetEventInt(event, "userid"));
	if(client && IsClientInGame(client) && GetClientTeam(client) == 3) return;
	if(!IsAllowedGameMode()) return;
	if(GetRandomInt(1, GetConVarInt(ZedBoomerExplosionChance)) == 1)
	{
		if(GetConVarInt(Enable) == 0) return;
		if(IsFakeClient(client)) return;
		if(ZedTimeGoing == true) return;
		ZedTime1(client);
		EmitSoundToAll(Sound1, client);
	}
}

public Action:Event_Melee(Handle:event, const String:name[], bool:dontBroadcast)
{
	if(!IsAllowedGameMode()) return;
	new client = GetClientOfUserId(GetEventInt(event, "userid"));
	if(client && IsClientInGame(client) && GetClientTeam(client) == 3) return;
	if(GetRandomInt(1, GetConVarInt(ZedSurvivorchance)) == 1)
	{
		if(GetConVarInt(Enable) == 0) return;
		if(IsFakeClient(client)) return;
		if(ZedTimeGoing == true) return;
		ZedTime1(client);
		EmitSoundToAll(Sound1, client);
	}
}

public Action:Event_TankDeath(Handle:event, const String:name[], bool:dontBroadcast)
{
	if(!IsAllowedGameMode()) return;
	new attacker = GetClientOfUserId(GetEventInt(event, "attacker"));
	if(attacker && IsClientInGame(attacker) && GetClientTeam(attacker) == 2)
	{
		if(GetRandomInt(1, GetConVarInt(ZedTank)) == 1)
		{
			if(GetConVarInt(Enable) == 0) return;
			if(IsFakeClient(attacker)) return;
			if(ZedTimeGoing == true) return;
			ZedTime1(attacker);
			EmitSoundToAll(Sound1, attacker);
		}
	}
}

public Action:Event_Pounce(Handle:event, const String:name[], bool:dontBroadcast)
{
	if(!IsAllowedGameMode()) return;
	new client = GetClientOfUserId(GetEventInt(event, "userid"));
	if(client && IsClientInGame(client) && GetClientTeam(client) == 2) return;
	if(GetRandomInt(1, GetConVarInt(ZedHunterExplosionChance)) == 1)
	{
		if(GetConVarInt(Enable) == 0) return;
		if(IsFakeClient(client)) return;
		if(ZedTimeGoing == true) return;
		ZedTime1(client);
		EmitSoundToAll(Sound1, client);
	}
}

public Action:Event_Win(Handle:event, const String:name[], bool:dontBroadcast)
{
	if(!IsAllowedGameMode()) return;
	new client = GetClientOfUserId(GetEventBool(event, "userid"));
	new islunging = GetClientOfUserId(GetEventBool(event, "islunging"));
	if(client && IsClientInGame(client) && GetClientTeam(client) == 3) return;
	if(islunging)
	{
		if(GetConVarInt(Enable) == 0) return;
		if(IsFakeClient(client)) return;
		if(ZedTimeGoing == true) return;
		ZedTime1(client);
		EmitSoundToAll(Sound1, client);
	}
}

public Action:Event_Ride(Handle:event, const String:name[], bool:dontBroadcast)
{
	if(!IsAllowedGameMode()) return;
	new client = GetClientOfUserId(GetEventInt(event, "userid"));
	if(client && IsClientInGame(client) && GetClientTeam(client) == 2) return;
	if(GetRandomInt(1, GetConVarInt(ZedJockeyExplosionChance)) == 1)
	{
		if(GetConVarInt(Enable) == 0) return;
		if(IsFakeClient(client)) return;
		if(ZedTimeGoing == true) return;
		ZedTime1(client);
		EmitSoundToAll(Sound1, client);
	}
}

public Action:Event_Grab(Handle:event, const String:name[], bool:dontBroadcast)
{
	if(!IsAllowedGameMode()) return;
	new client = GetClientOfUserId(GetEventInt(event, "userid"));
	if(client && IsClientInGame(client) && GetClientTeam(client) == 2) return;
	if(GetRandomInt(1, GetConVarInt(ZedSmokerExplosionChance)) == 1)
	{
		if(GetConVarInt(Enable) == 0) return;
		if(IsFakeClient(client)) return;
		if(ZedTimeGoing == true) return;
		ZedTime1(client);
		EmitSoundToAll(Sound1, client);
	}
}

public Action:Event_Charge(Handle:event, const String:name[], bool:dontBroadcast)
{
	if(!IsAllowedGameMode()) return;
	new client = GetClientOfUserId(GetEventInt(event, "userid"));
	if(client && IsClientInGame(client) && GetClientTeam(client) == 2) return;
	if(GetRandomInt(1, GetConVarInt(ZedChargerExplosionChance)) == 1)
	{
		if(GetConVarInt(Enable) == 0) return;
		if(IsFakeClient(client)) return;
		if(ZedTimeGoing == true) return;
		ZedTime1(client);
		EmitSoundToAll(Sound1, client);
	}
}

public Action:Event_Impact(Handle:event, const String:name[], bool:dontBroadcast)
{
	if(!IsAllowedGameMode()) return;
	new client = GetClientOfUserId(GetEventInt(event, "userid"));
	if(client && IsClientInGame(client) && GetClientTeam(client) == 2) return;
	if(GetRandomInt(1, GetConVarInt(ZedChargerExplosionChance)) == 1)
	{
		if(GetConVarInt(Enable) == 0) return;
		if(IsFakeClient(client)) return;
		if(ZedTimeGoing == true) return;
		ZedTime1(client);
		EmitSoundToAll(Sound1, client);
	}
}

public Action:Event_Boomed(Handle:event, const String:name[], bool:dontBroadcast)
{
	if(!IsAllowedGameMode()) return;
	new attacker = GetClientOfUserId(GetEventInt(event, "attacker"));
	if(attacker && IsClientInGame(attacker) && GetClientTeam(attacker) == 2) return;
	if(GetRandomInt(1, GetConVarInt(ZedBoomerExplosionChance)) == 1)
	{
		if(GetConVarInt(Enable) == 0) return;
		if(IsFakeClient(attacker)) return;
		if(ZedTimeGoing == true) return;
		ZedTime1(attacker);
		EmitSoundToAll(Sound1, attacker);
	}
}

public Action:Event_WitchDeath(Handle:event, const String:name[], bool:dontBroadcast)
{
	new client = GetClientOfUserId(GetEventInt(event, "userid"));
	if(client && IsClientInGame(client) && GetClientTeam(client) == 3) return;
	if(!IsAllowedGameMode()) return;
	new headshot = GetEventBool(event, "oneshot");
	if(headshot)
	{
		if(GetRandomInt(1, GetConVarInt(ZedWitch)) == 1)
		{
			if(GetConVarInt(Enable) == 0) return;
			if(ZedTimeGoing == true) return;
			ZedTime1(client);
			EmitSoundToAll(Sound1, client);
		}
	}
	if(GetRandomInt(1, GetConVarInt(ZedWitch)) == 1)
	{
		if(GetConVarInt(Enable) == 0) return;
		if(ZedTimeGoing == true) return;
		ZedTime1(client);
		EmitSoundToAll(Sound1, client);
	}
}

public ZedTime1(client)
{
	ZedTimeGoing = true;
	decl i_Ent, Handle:h_pack;
	i_Ent = CreateEntityByName("func_timescale");
	DispatchKeyValue(i_Ent, "desiredTimescale", "0.2");
	DispatchKeyValue(i_Ent, "acceleration", "2.0");
	DispatchKeyValue(i_Ent, "minBlendRate", "1.0");
	DispatchKeyValue(i_Ent, "blendDeltaMultiplier", "2.0");
	DispatchSpawn(i_Ent);
	AcceptEntityInput(i_Ent, "Start");
	h_pack = CreateDataPack();
	WritePackCell(h_pack, i_Ent);
	CreateTimer(GetConVarFloat(ZedTimer), ZedBlendBack, h_pack);
	PrintHintTextToAll(" %N triggers the speed-breaker!", client);
}

public Action:ZedBlendBack(Handle:Timer, Handle:h_pack)
{
	decl i_Ent;
	ResetPack(h_pack, false);
	i_Ent = ReadPackCell(h_pack);
	CloseHandle(h_pack);
	if(IsValidEdict(i_Ent))
	{
		AcceptEntityInput(i_Ent, "Stop");
		ZedTimeGoing = false;
	}
	else
	{
		PrintToServer("[SM] i_Ent is not a valid edict!");
	}
}
