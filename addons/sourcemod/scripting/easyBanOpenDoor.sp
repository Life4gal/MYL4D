#include <sourcemod>
#include <sdktools>

new CanOpenT[MAXPLAYERS+1];


public Plugin:myinfo=
{
	name = "easy ban open door too frequent",
	author = "NiceT",
	description = "ban open door too frequent",
	version = "1.0",
	url = ""
}

public OnPluginStart()
{
    HookEvent("player_use", Player_Open);
    HookEvent("round_start", Event_RoundStart);
}

public Action:Event_RoundStart( Handle:event, const String:name[], bool:dontBroadcast )
{
	for (new i=1; i<=MaxClients; i++)
	{
		if (IsClientInGame(i))
		{
               	 	CanOpenT[i] = 0;
		}
     }
}

public Action Player_Open(Handle:event, const String:name[], bool:dontBroadcast)
{
    new client = GetClientOfUserId(GetEventInt(event, "userid"));
    new targetid = GetEventInt(event, "targetid");
    if(client>0)
    {
	new String:entname[64];
	if(GetEdictClassname(targetid, entname, sizeof(entname)))
	{
		if(StrEqual(entname, "prop_door_rotating_checkpoint") && IsLeftStartAreaArea())
		{
                	CanOpenT[client]++;
                if (CanOpenT[client] > 5)
                {
                    AcceptEntityInput(targetid, "Lock");
                    CreateTimer(5.0, Allow, client);
                    PrintHintText(client, "\x03 You use the door too frequent, lock 5s!");
                }
		else
		{
                    AcceptEntityInput(targetid, "Unlock");
                }
		}
        }
    }
    return Plugin_Continue;
}

public Action:Allow(Handle:Timer, any:client)
{
    CanOpenT[client] = 0;
}

bool:IsLeftStartAreaArea()
{
	new ent = -1, maxents = GetMaxEntities();
	for (new i = MaxClients+1; i <= maxents; i++)
	{
		if (IsValidEntity(i))
		{
			decl String:netclass[64];
			GetEntityNetClass(i, netclass, sizeof(netclass));

			if (StrEqual(netclass, "CTerrorPlayerResource"))
			{
				ent = i;
				break;
			}
		}
	}
	if (ent > -1)
	{
		new offset = FindSendPropInfo("CTerrorPlayerResource", "m_hasAnySurvivorLeftSafeArea");
		if (offset > 0)
		{
			if (GetEntData(ent, offset))
			{
				if (GetEntData(ent, offset) == 1) return true;
			}
		}
	}
	return false;
}
