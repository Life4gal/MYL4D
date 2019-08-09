#pragma semicolon 1

#include <sourcemod>
#include <sdkhooks>
#include <l4d2_damage_type>

#define PLUGIN_VERSION "1.0"
#define FCVAR_FLAG FCVAR_SPONLY|FCVAR_NOTIFY

public Plugin:myinfo = {
	name = "easy damage manager",
	author = "NiceT",
	description = "easy damage manager",
	version = PLUGIN_VERSION,
	url = "https://forums.alliedmods.net/showthread.php?t=317709"
};

/*Some people may not understand what I wrote below. I will explain it here first.*/
/*Since some guns damage types are exactly the same (such as smgs and pistols), in order to reduce the repetitive work, I used the guns' bullets caliber instead of their names.*/


new Handle:h_9mm = INVALID_HANDLE;
new Handle:h_9mm_ff = INVALID_HANDLE;   // pistol | smg

new Handle:h_9mm_headshot = INVALID_HANDLE;
new Handle:h_9mm_headshot_ff = INVALID_HANDLE;

new Handle:h_5_56mm = INVALID_HANDLE;   // rifle | sniper
new Handle:h_5_56mm_ff = INVALID_HANDLE;

new Handle:h_5_56mm_headshot = INVALID_HANDLE;
new Handle:h_5_56mm_headshot_ff = INVALID_HANDLE;

new Handle:h_18_4mm = INVALID_HANDLE;   // shotgun
new Handle:h_18_4mm_ff = INVALID_HANDLE;

new Handle:h_7_62mm = INVALID_HANDLE;   // m60 | minigun
new Handle:h_7_62mm_ff = INVALID_HANDLE;

new Handle:h_grenade_launcher = INVALID_HANDLE; //GRENADE_LAUNCHER
new Handle:h_grenade_launcher_ff = INVALID_HANDLE;
new Handle:h_grenade_launcher_self = INVALID_HANDLE;

new Handle:h_infected_claw = INVALID_HANDLE;    //include tank_claw, tank_stone, boomer_claw, hunter_claw, smoker_claw, spitter_claw, jockey_claw, charger_claw, common_infected_claw, hunter_punch, jockey_ride, charger_impact, charger_pummel

new Handle:h_witch = INVALID_HANDLE;        // I don't know why no use, I experimented many times, the damage type is correct, but the modification is invalid.

new Handle:h_smoker_choke = INVALID_HANDLE;
new Handle:h_spitter_spit = INVALID_HANDLE;

new Handle:h_melee = INVALID_HANDLE;
new Handle:h_melee_ff = INVALID_HANDLE;

new Handle:h_explosion = INVALID_HANDLE;
new Handle:h_explosion_ff = INVALID_HANDLE;
new Handle:h_explosion_self = INVALID_HANDLE;

new Handle:h_fall = INVALID_HANDLE;

new Handle:h_drown = INVALID_HANDLE;    // I don't know why no use, I experimented many times, the damage type is correct, but the modification is invalid.

new Handle:h_incapacitated = INVALID_HANDLE;    // I don't know why no use, I experimented many times, the damage type is correct, but the modification is invalid.

new Handle:h_fire = INVALID_HANDLE;
new Handle:h_fire_ff = INVALID_HANDLE;
new Handle:h_fire_self = INVALID_HANDLE;

public OnPluginStart()
{
	CreateConVar("l4d_Damage_Manager_Version", PLUGIN_VERSION, "The version of damage manager");

    h_9mm                   = CreateConVar("l4d_damage_9mm",                    "1.0", "damage coefficient of pistol|smg",                          FCVAR_FLAG);
    h_9mm_ff                = CreateConVar("l4d_damage_9mm_ff",                 "0.0", "damage coefficient of pistol|smg to survivor",              FCVAR_FLAG);
    h_9mm_headshot          = CreateConVar("l4d_damage_9mm_headshot",           "1.0", "damage coefficient of pistol|smg headshot",                 FCVAR_FLAG);
    h_9mm_headshot_ff       = CreateConVar("l4d_damage_9mm_headshot_ff",        "0.0", "damage coefficient of pistol|smg heashot to survivor",      FCVAR_FLAG);

    h_5_56mm                = CreateConVar("l4d_damage_5_56mm", 		"1.0", "damage coefficient of rifle|sniper",                        FCVAR_FLAG);
    h_5_56mm_ff             = CreateConVar("l4d_damage_5_56mm_ff", 		"0.0", "damage coefficient of rifle|sniper to survivor",            FCVAR_FLAG);
    h_5_56mm_headshot       = CreateConVar("l4d_damage_5_56mm_headshot", 	"1.0", "damage coefficient of rifle|sniper headshot",               FCVAR_FLAG);
    h_5_56mm_headshot_ff    = CreateConVar("l4d_damage_5_56mm_headshot_ff", 	"0.0", "damage coefficient of rifle|sniper headshot to survivor",   FCVAR_FLAG);

    h_7_62mm                = CreateConVar("l4d_damage_7_62mm", 		"1.0", "damage coefficient of m60|minigun",                         FCVAR_FLAG);
    h_7_62mm_ff             = CreateConVar("l4d_damage_7_62mm_ff", 		"0.0", "damage coefficient of m60|minigun to survivor",             FCVAR_FLAG);

    h_18_4mm                = CreateConVar("l4d_damage_18_4mm", 		"1.0", "damage coefficient of shotgun",                             FCVAR_FLAG);
    h_18_4mm_ff             = CreateConVar("l4d_damage_18_4mm_ff", 		"0.0", "damage coefficient of shutgun to survivor",                 FCVAR_FLAG);

    h_grenade_launcher      = CreateConVar("l4d_damage_grenade_launcher",       "1.0", "damage coefficient of grenade launcher",                    FCVAR_FLAG);
    h_grenade_launcher_ff   = CreateConVar("l4d_damage_grenade_launcher_ff",    "0.0", "damage coefficient of grenade launcher to survivor",        FCVAR_FLAG);
    h_grenade_launcher_self = CreateConVar("l4d_damage_grenade_launcher_self",  "5.0", "damage coefficient of grenade launcher to self",            FCVAR_FLAG);

    h_infected_claw         = CreateConVar("l4d_damage_infected_claw", 		"10.0", "damage coefficient of infected_claw",                      FCVAR_FLAG);

    h_witch                 = CreateConVar("l4d_damage_witch", 			"1.0", "damage coefficient of witch",                               FCVAR_FLAG);

    h_smoker_choke          = CreateConVar("l4d_damage_smoker_choke", 		"1.0", "damage coefficient of smoker_choke",                        FCVAR_FLAG);
    h_spitter_spit          = CreateConVar("l4d_damage_spitter_spit", 		"1.0", "damage coefficient of spitter_spit",                        FCVAR_FLAG);

    h_melee                 = CreateConVar("l4d_damage_melee", 			"1.0", "damage coefficient of melee",                               FCVAR_FLAG);
    h_melee_ff              = CreateConVar("l4d_damage_melee_ff", 		"0.0", "damage coefficient of melee to survivor",                   FCVAR_FLAG);

    h_explosion             = CreateConVar("l4d_damage_explosion", 		"1.0", "damage coefficient of explosion",                           FCVAR_FLAG);
    h_explosion_ff          = CreateConVar("l4d_damage_explosion_ff", 		"0.0", "damage coefficient of explosion to survivor",               FCVAR_FLAG);
    h_explosion_self        = CreateConVar("l4d_damage_explosion_self", 	"5.0", "damage coefficient of explosion to self",                   FCVAR_FLAG);

    h_fall                  = CreateConVar("l4d_damage_fall", 			"5.0", "damage coefficient of fall",                                FCVAR_FLAG);

    h_drown                 = CreateConVar("l4d_damage_drown", 			"10.0", "damage coefficient of drown",                               FCVAR_FLAG);

    h_incapacitated         = CreateConVar("l4d_damage_incapacitated", 		"10.0", "damage coefficient of bleed",                               FCVAR_FLAG);

    h_fire                  = CreateConVar("l4d_damage_fire", 			"1.0", "damage coefficient of fire",                                FCVAR_FLAG);
    h_fire_ff               = CreateConVar("l4d_damage_fire_ff", 		"0.0", "damage coefficient of fire to survivor",                    FCVAR_FLAG);
    h_fire_self             = CreateConVar("l4d_damage_fire_self", 		"5.0", "damage coefficient of fire to self",                        FCVAR_FLAG);

    AutoExecConfig(true, "l4d_DamageManager");
}

public OnClientPutInServer(client)
{
	if(IsValidClient(client))
	{
		SDKHook(client, SDKHook_OnTakeDamage, OnTakeDamage);
	}
}

public OnClientDisconnect(client)
{
	if (client > 0 && IsClientInGame(client))
	{
		SDKUnhook(client, SDKHook_OnTakeDamage, OnTakeDamage);
	}
}

stock bool:IsValidClient(client)
{
	if(client>0 && client<=MaxClients)
	{
		if(IsValidEntity(client) && IsClientInGame(client))
		{
			return true;
		}
	}
	return false;
}

stock bool:IsSameTeam(attacker, victim)
{
	if(GetClientTeam(attacker) == GetClientTeam(victim)){
		return true;
	}
	return false;
}

public Action:OnTakeDamage(victim, &attacker, &inflictor, &Float:damage, &damagetype)
{
    if(IsSameTeam(attacker, victim)){
        if(damagetype == TYPE_9MM){
            damage *= GetConVarFloat(h_9mm_ff);
            return Plugin_Changed;
        }
        else if(damagetype == TYPE_9MM_HEADSHOT){
            damage *= GetConVarFloat(h_9mm_headshot_ff);
            return Plugin_Changed;
        }
        else if(damagetype == TYPE_5_56MM){
            damage *= GetConVarFloat(h_5_56mm_ff);
            return Plugin_Changed;
        }
        else if(damagetype == TYPE_5_56MM_HEADSHOT){
            damage *= GetConVarFloat(h_5_56mm_headshot_ff);
            return Plugin_Changed;
        }
        else if(damagetype == TYPE_7_62MM){
            damage *= GetConVarFloat(h_7_62mm_ff);
            return Plugin_Changed;
        }
        else if(damagetype == TYPE_18_4MM){
            damage *= GetConVarFloat(h_18_4mm_ff);
            return Plugin_Changed;
        }
        else if(damagetype == TYPE_GRENADE_LAUNCHER){
            if(attacker != victim){
                damage *= GetConVarFloat(h_grenade_launcher_ff);
                return Plugin_Changed;
            }
            damage *= GetConVarFloat(h_grenade_launcher_self);
            return Plugin_Changed;
        }
        else if(damagetype == TYPE_MELEE_TO_SURVIVOR){
            damage *= GetConVarFloat(h_melee_ff);
            return Plugin_Changed;
        }
        else if(damagetype == TYPE_EXPLOSION){
            if(attacker != victim){
                damage *= GetConVarFloat(h_explosion_ff);
                return Plugin_Changed;
            }
            damage *= GetConVarFloat(h_explosion_self);
            return Plugin_Changed;
        }
        else if(damagetype == TYPE_FIRE){
            if(attacker != victim){
                damage *= GetConVarFloat(h_fire_ff);
                return Plugin_Changed;
            }
            damage *= GetConVarFloat(h_fire_self);
            return Plugin_Changed;
        }
    }
    else{
        if(damagetype == TYPE_9MM){
            damage *= GetConVarFloat(h_9mm);
            return Plugin_Changed;
        }
        else if(damagetype == TYPE_9MM_HEADSHOT){
            damage *= GetConVarFloat(h_9mm_headshot);
        }
        else if(damagetype == TYPE_5_56MM){
            damage *= GetConVarFloat(h_5_56mm);
            return Plugin_Changed;
        }
        else if(damagetype == TYPE_5_56MM_HEADSHOT){
            damage *= GetConVarFloat(h_5_56mm_headshot);
            return Plugin_Changed;
        }
        else if(damagetype == TYPE_7_62MM){
            damage *= GetConVarFloat(h_7_62mm);
            return Plugin_Changed;
        }
        else if(damagetype == TYPE_18_4MM){
            damage *= GetConVarFloat(h_18_4mm);
            return Plugin_Changed;
        }
        else if(damagetype == TYPE_GRENADE_LAUNCHER){
            damage *= GetConVarFloat(h_grenade_launcher);
            return Plugin_Changed;
        }
        else if(damagetype == TYPE_CLAW){
            damage *= GetConVarFloat(h_infected_claw);
            return Plugin_Changed;
        }
        else if(damagetype == TYPE_WITCH){
            damage *= GetConVarFloat(h_witch);
            return Plugin_Changed;
        }
        else if(damagetype == TYPE_SMOKER_CHOKE){
            damage *= GetConVarFloat(h_smoker_choke);
            return Plugin_Changed;
        }
        else if(damagetype == TYPE_SPITTER_SPIT){
            damage *= GetConVarFloat(h_spitter_spit);
            return Plugin_Changed;
        }
        else if(damagetype == TYPE_MELEE_TO_INFECTED){
            damage *= GetConVarFloat(h_melee);
            return Plugin_Changed;
        }
        else if(damagetype == TYPE_EXPLOSION){
            damage *= GetConVarFloat(h_explosion);
            return Plugin_Changed;
        }
        else if(damagetype == TYPE_FALL){
            damage *= GetConVarFloat(h_fall);
            return Plugin_Changed;
        }
        else if(damagetype == TYPE_DROWN){
            damage == GetConVarFloat(h_drown);
            return Plugin_Changed;
        }
        else if(damagetype == TYPE_INCAPACITATED){
            damage *= GetConVarFloat(h_incapacitated);
            return Plugin_Continue;
        }
        else if(damagetype == TYPE_FIRE){
            damage *= GetConVarFloat(h_fire);
        }
    }
    return Plugin_Continue;
}
