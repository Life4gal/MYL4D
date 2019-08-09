#pragma semicolon 1
#include <sourcemod>
#include <sdktools>
#include <sdkhooks>

#define PLUGIN_VERSION "1.0"

new Handle: cPlayerBuuny = INVALID_HANDLE;
new OnBunnyHop[MAXPLAYERS+1] = 0;
new iDirectionCache[MAXPLAYERS+1] = 0;

public Plugin:myinfo=
{
	name = "easy bunnyhop",
	author = "NiceT",
	description = "bunnyhop",
	version = "1.0",
	url = ""
}

public OnPluginStart()
{
	cPlayerBuuny = CreateConVar("l4d_bunnyhop", "1", "0 = can't use bunny | 1 = can use", FCVAR_SPONLY|FCVAR_REPLICATED|FCVAR_NOTIFY);

	HookEvent("player_connect_full", ResetBunny);
	HookEvent("round_start", Event_RoundStart);
	HookEvent("player_jump_apex", Event_PlayerJumpApex);
	RegConsoleCmd("sm_hop", On_Autobhop);
	RegConsoleCmd("sm_bunny", On_Autobhop);
	RegConsoleCmd("sm_bunnyhop", On_Autobhop);

	AutoExecConfig(true, "bunnyhop");
}

public ResetBunny(Handle:event, const String:name[], bool:dontBroadcast)
{
	new client = GetClientOfUserId(GetEventInt(event, "userid"));
	OnBunnyHop[client] = 0;
}

public Action:Event_RoundStart(Handle:event, const String:name[], bool:dontBroadcast)
{
	for (new i=1; i<=MaxClients; i++)
	{
		if (IsClientInGame(i))
		{
            		OnBunnyHop[i] = 0;
		}
     }
}

public Action:On_Autobhop(client, args)
{
	if (GetConVarInt(cPlayerBuuny) == 1 && client > 0 && IsClientInGame(client) && IsPlayerAlive(client))
	{
		if (OnBunnyHop[client] == 0)
		{
			OnBunnyHop[client] = 1;
			PrintHintText(client, "bunnyhop开启");
		}
		else
		{
			OnBunnyHop[client] = 1;
			PrintHintText(client, "bunnyhop关闭");
		}
	}
	return Plugin_Handled;
}

public Action:OnPlayerRunCmd(client, &buttons)
{
	if(OnBunnyHop[client] && GetConVarInt(cPlayerBuuny) && IsClientInGame(client) && IsPlayerAlive(client))
	{
		if (buttons & IN_JUMP)
		{
			if (!(GetEntityFlags(client) & FL_ONGROUND) && !(GetEntityMoveType(client) & MOVETYPE_LADDER))
			{
				if (GetEntProp(client, Prop_Data, "m_nWaterLevel") < 2) buttons &= ~IN_JUMP;
			}
		}
	}
	return Plugin_Continue;
}

public Event_PlayerJumpApex(Handle:event, const String:name[], bool:dontBroadcast)
{
	new iMode = GetConVarInt(cPlayerBuuny);
	if(!iMode)
		return;
	new client = GetClientOfUserId(GetEventInt(event, "userid"));
	if(IsClientInGame(client) || GetClientTeam(client) != 2 || IsPlayerAlive(client) || OnBunnyHop[client])
		return;
	if ((GetClientButtons(client) & IN_MOVELEFT) || (GetClientButtons(client) & IN_MOVERIGHT))
	{
		if (GetClientButtons(client) & IN_MOVELEFT)
		{
			if (iDirectionCache[client] > -1)
			{
				iDirectionCache[client] = -1;
				return;
			}
			else iDirectionCache[client] = -1;
		}
		else if (GetClientButtons(client) & IN_MOVERIGHT)
		{
			if (iDirectionCache[client] < 1)
			{
				iDirectionCache[client] = 1;
				return;
			}
			else iDirectionCache[client] = 1;
		}
		new Float:fAngles[3];
		new Float:fLateralVector[3];
		new Float:fForwardVector[3];
		new Float:fNewVel[3];

		GetEntPropVector(client, Prop_Send, "m_angRotation", fAngles);
		GetAngleVectors(fAngles, NULL_VECTOR, fLateralVector, NULL_VECTOR);
		NormalizeVector(fLateralVector, fLateralVector);

		GetEntPropVector(client, Prop_Data, "m_vecVelocity", fForwardVector);
		if (RoundToNearest(GetVectorLength(fForwardVector)) > 300.0)
			return;
		else
			ScaleVector(fLateralVector, GetVectorLength(fLateralVector) * 50.0);
		GetEntPropVector(client, Prop_Data, "m_vecAbsVelocity", fNewVel);
		for(new i=0;i<3;i++) fNewVel[i] += fLateralVector[i];
		TeleportEntity(client, NULL_VECTOR, NULL_VECTOR,fNewVel);
	}
}
