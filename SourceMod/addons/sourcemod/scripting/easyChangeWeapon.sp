#pragma semicolon 1
#include <sourcemod>
#include <sdktools>
#include <sdkhooks>

#define PLUGIN_VERSION "2.1"

new Handle:IntervalTimer[MAXPLAYERS+1] = {INVALID_HANDLE, ...};
new bool:TimerRunning[MAXPLAYERS+1] = false;
new Handle:DamageInterval = INVALID_HANDLE;
new Handle:SwitchInterval = INVALID_HANDLE;
new IntervalRemain[MAXPLAYERS+1] = 0;
new PlayerMeleeNum[MAXPLAYERS+1] = 0;  //We can't get player's melee script name, so we can only give player melee weapon in that order
/*
0 = baseball_bat
1 = cricket_bat
2 = crowbar
3 = electric_guitar
4 = fireaxe
5 = frying_pan
6 = golfclub
7 = katana
8 = knife
9 = machete
10 = tonfa
*/
new String:MeleeClass[11][32] = {"baseball_bat", "cricket_bat", "crowbar", "electric_guitar", "fireaxe", "frying_pan", "golfclub", "katana", "knife", "machete", "tonfa"};

public Plugin:myinfo = 
{
    name = "easyChangeWeapon",
    author = "NiceT",
    description = "Allow survivors change their weapon",
    version = PLUGIN_VERSION,
    url = "N/A"
}

public OnPluginStart()
{

    decl String:game[32];
    GetGameFolderName(game, sizeof(game));
    if (!StrEqual(game, "left4dead2", false))
    {
        SetFailState("Plugin supports Left 4 Dead 2 only.");
    }
    DamageInterval = CreateConVar("l4d2_damage_interval", "10", "Gun switching time interval if been attacked", FCVAR_NOTIFY);
    SwitchInterval = CreateConVar("l4d2_switch_interval", "5", "Gun switching time interval normal", FCVAR_NOTIFY);
    HookEvent("player_team", Event_PlayerChangeTeam);
    AutoExecConfig(true, "easyChangeWeapon");
}

public OnClientPutInServer(client)
{
	if(IsClientInGame(client))
	{
		SDKHook(client, SDKHook_OnTakeDamage, OnTakeDamage);
	}
}

public Action:Event_PlayerChangeTeam(Handle:event, const String:name[], bool:dontBroadcast)
{
    new bool:disconnect = GetEventBool(event, "disconnect");
    new client = GetClientOfUserId(GetEventInt(event, "userid"));
    if(disconnect)
    {
        SDKUnhook(client, SDKHook_OnTakeDamage, OnTakeDamage);
    }
}

public Action:OnPlayerRunCmd(client, &buttons, &impulse, Float:vel[3], Float:angles[3], &weapon)
{
    if(!IsClientInGame(client) || !IsPlayerAlive(client) || GetClientTeam(client) != 2) return Plugin_Continue;
    decl String:id[16];
    GetClientAuthId(client, AuthId_Steam2, id, sizeof(id));
    if(!StrEqual(id, "BOT", false))
    {
        int switch_interval = GetConVarInt(SwitchInterval);
        if(IntervalRemain[client] <= 0)//&& buttons & IN_ATTACK2
        {
            if(buttons & IN_SPEED)
            {
                decl String:weaponid[64];
                GetClientWeapon(client, weaponid, sizeof(weaponid));
                //=====THROW============
                if(StrEqual(weaponid, "weapon_molotov", false))
                {
                    new ent = GetPlayerWeaponSlot(client, 2);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_pipe_bomb");
                }
                else if(StrEqual(weaponid, "weapon_pipe_bomb", false))
                {
                    new ent = GetPlayerWeaponSlot(client, 2);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_vomitjar");
                }
                else if(StrEqual(weaponid, "weapon_vomitjar", false))
                {
                    new ent = GetPlayerWeaponSlot(client, 2);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_molotov");
                }
                //====MEDKIT==============
                else if(StrEqual(weaponid, "weapon_first_aid_kit", false))
                {
                    new ent = GetPlayerWeaponSlot(client, 3);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_defibrillator");
                }
                else if(StrEqual(weaponid, "weapon_defibrillator", false))
                {
                    new ent = GetPlayerWeaponSlot(client, 3);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_upgradepack_incendiary");
                }
                else if(StrEqual(weaponid, "weapon_upgradepack_incendiary", false))
                {
                    new ent = GetPlayerWeaponSlot(client, 3);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_upgradepack_explosive");
                }
                else if(StrEqual(weaponid, "weapon_upgradepack_explosive", false))
                {
                    new ent = GetPlayerWeaponSlot(client, 3);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_first_aid_kit");
                }
                //====PILLS================
                else if(StrEqual(weaponid, "weapon_pain_pills", false))
                {
                    new ent = GetPlayerWeaponSlot(client, 4);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_adrenaline");
                }
                else if(StrEqual(weaponid, "weapon_adrenaline", false))
                {
                    new ent = GetPlayerWeaponSlot(client, 4);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_pain_pills");
                }
                //====SECONDARY=============
                //====PISTOL================
                else if(StrEqual(weaponid, "weapon_pistol", false))
                {
                    new ent = GetPlayerWeaponSlot(client, 1);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_pistol_magnum");
                }
                else if(StrEqual(weaponid, "weapon_pistol_magnum", false))
                {
                    new ent = GetPlayerWeaponSlot(client, 1);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_pistol");
                }
                //====PRIMARY================
                //====SMG==================
                else if(StrEqual(weaponid, "weapon_smg", false))
                {
                    new ent = GetPlayerWeaponSlot(client, 0);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_smg_mp5");
                }
                else if(StrEqual(weaponid, "weapon_smg_mp5", false))
                {
                    new ent = GetPlayerWeaponSlot(client, 0);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_smg_silenced");
                }
                else if(StrEqual(weaponid, "weapon_smg_silenced", false))
                {
                    new ent = GetPlayerWeaponSlot(client, 0);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_smg");
                }
                //====SHOTGUN==============
                else if(StrEqual(weaponid, "weapon_autoshotgun", false))
                {
                    new ent = GetPlayerWeaponSlot(client, 0);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_pumpshotgun");
                }
                else if(StrEqual(weaponid, "weapon_pumpshotgun", false))
                {
                    new ent = GetPlayerWeaponSlot(client, 0);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_shotgun_chrome");
                }
                else if(StrEqual(weaponid, "weapon_shotgun_chrome", false))
                {
                    new ent = GetPlayerWeaponSlot(client, 0);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_shotgun_spas");
                }
                else if(StrEqual(weaponid, "weapon_shotgun_spas", false))
                {
                    new ent = GetPlayerWeaponSlot(client, 0);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_autoshotgun");
                }
                //====RIFLE===================
                else if(StrEqual(weaponid, "weapon_rifle", false))
                {
                    new ent = GetPlayerWeaponSlot(client, 0);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_rifle_ak47");
                }
                else if(StrEqual(weaponid, "weapon_rifle_ak47", false))
                {
                    new ent = GetPlayerWeaponSlot(client, 0);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_rifle_desert");
                }
                else if(StrEqual(weaponid, "weapon_rifle_desert", false))
                {
                    new ent = GetPlayerWeaponSlot(client, 0);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_rifle_sg552");
                }
                else if(StrEqual(weaponid, "weapon_rifle_sg552", false))
                {
                    new ent = GetPlayerWeaponSlot(client, 0);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_rifle_m60");
                }
                else if(StrEqual(weaponid, "weapon_rifle_m60", false))
                {
                    new ent = GetPlayerWeaponSlot(client, 0);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_grenade_launcher");
                }
                else if(StrEqual(weaponid, "weapon_grenade_launcher", false))
                {
                    new ent = GetPlayerWeaponSlot(client, 0);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_rifle");
                }
                //====SNIPER===================
                else if(StrEqual(weaponid, "weapon_hunting_rifle", false))
                {
                    new ent = GetPlayerWeaponSlot(client, 0);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_sniper_scout");
                }
                else if(StrEqual(weaponid, "weapon_sniper_scout"))
                {
                    new ent = GetPlayerWeaponSlot(client, 0);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_sniper_awp");
                }
                else if(StrEqual(weaponid, "weapon_sniper_awp", false))
                {
                    new ent = GetPlayerWeaponSlot(client, 0);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_sniper_military");
                }
                else if(StrEqual(weaponid, "weapon_sniper_military", false))
                {
                    new ent = GetPlayerWeaponSlot(client, 0);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    CheatCommand(client, "give", "weapon_hunting_rifle");
                }

                //====MELEE================
                else if(StrEqual(weaponid, "weapon_melee", false))
                {
                    if(++PlayerMeleeNum[client] > 10)
                    {
                        PlayerMeleeNum[client] = 0;
                    }
                    new ent = GetPlayerWeaponSlot(client, 1);
                    if(ent != -1)   RemovePlayerItem(client, ent);
                    GetClientPosition(client, MeleeClass[PlayerMeleeNum[client]]); //We can't give player melee weapon directly, but we can make items appear under their feet
                }
                IntervalRemain[client] = switch_interval;
                return Plugin_Handled;
            }
        }
        else if(!TimerRunning[client])
        {
            IntervalTimer[client] = CreateTimer(1.0, setInterval, client, TIMER_REPEAT);
            TimerRunning[client] = true;
            PrintHintText(client, "You need wait at least %d s for next change!", IntervalRemain[client]);
        }
    }
    return Plugin_Continue;
}

public Action:OnTakeDamage(victim, &attacker, &inflictor, &Float:damage, &damagetype) 
{
    int dmg_interval = GetConVarInt(DamageInterval);
    if(damage)
    {
        if(IsClientInGame(victim) && !IsFakeClient(victim))
        {
            if(GetClientTeam(victim) == 2)
            {
                IntervalRemain[victim] = dmg_interval;
            }
        }
        if(IsClientInGame(attacker) && !IsFakeClient(attacker))
        {
            if(GetClientTeam(attacker) == 2)
            {
                IntervalRemain[attacker] = dmg_interval;
            }
        }
    }
}

public Action:GetClientPosition(client, String:weaponid[32]){
    if(client != 0)
    {
        decl Float:SpawnPosition[3], Float:SpawnAngle[3];
        GetClientAbsOrigin(client, SpawnPosition);
        SpawnPosition[2] += 20; SpawnAngle[0] = 90.0;
        ChangeMelee(weaponid, SpawnPosition, SpawnAngle);
    }
}

public Action:setInterval(Handle:timer, any:client)
{
    if(IntervalRemain[client] < 0)
    {
        KillTimer(timer);
        TimerRunning[client] = false;
        PrintHintText(client, "Next change ready!");
    }
    else
    {
        PrintCenterText(client, "%d s remain for next change!", IntervalRemain[client]);
        IntervalRemain[client] -= 1;
    }
}

stock CheatCommand(Client, const String:command[], const String:arguments[])
{
    if (!Client) return;
    new admindata = GetUserFlagBits(Client);
    SetUserFlagBits(Client, ADMFLAG_ROOT);
    new flags = GetCommandFlags(command);
    SetCommandFlags(command, flags & ~FCVAR_CHEAT);
    FakeClientCommand(Client, "%s %s", command, arguments);
    SetCommandFlags(command, flags);
    SetUserFlagBits(Client, admindata);
}

stock ChangeMelee(const String:Weapon[32], Float:Position[3], Float:Angle[3])
{
    new MeleeSpawn = CreateEntityByName("weapon_melee");
    DispatchKeyValue(MeleeSpawn, "melee_script_name", Weapon);
    DispatchSpawn(MeleeSpawn);
    TeleportEntity(MeleeSpawn, Position, Angle, NULL_VECTOR);
}
