#include<sourcemod>
#include<sdktools>


new Handle:l4d_recovery_hpH = 		INVALID_HANDLE;
new Handle:l4d_recovery_hpM = 		INVALID_HANDLE;
new Handle:l4d_recovery_hpL = 		INVALID_HANDLE;

new Handle:l4d_recovery_quantityH = 	INVALID_HANDLE;
new Handle:l4d_recovery_quantityM = 	INVALID_HANDLE;
new Handle:l4d_recovery_quantityL = 	INVALID_HANDLE;

new Handle:l4d_recovery_durationH = 	INVALID_HANDLE;
new Handle:l4d_recovery_durationM = 	INVALID_HANDLE;
new Handle:l4d_recovery_durationL = 	INVALID_HANDLE;

new Handle:l4d_recovery_limit = 	INVALID_HANDLE;
new Handle:l4d_recovery_enable = 	INVALID_HANDLE;

public Plugin:myinfo =
{
 name = "Health Recovery",
 author = "NiceT",
 description = "auto recover hp",
 version = "1.0",
 url = ""
}

public OnPluginStart(){
    l4d_recovery_enable     = CreateConVar("l4d_recovery_enable", 	"1", "0 = enable | 1 = disable");
    l4d_recovery_limit      = CreateConVar("l4d_recovery_limit", 	"100", "The maximum HP can recover");

    l4d_recovery_hpH        = CreateConVar("l4d_recovery_hpH", 		"60", "The minimum high level HP recover point");
    l4d_recovery_hpM        = CreateConVar("l4d_recovery_hpM", 		"20", "The minimum medium level HP recover point");
    l4d_recovery_hpL        = CreateConVar("l4d_recovery_hpL", 		"0", "The minimum low level HP recover point");

    l4d_recovery_durationH  = CreateConVar("l4d_recovery_durationH", 	"10.0", "The time of high level HP per recover need spend");
    l4d_recovery_durationM  = CreateConVar("l4d_recovery_durationM", 	"6.0", "The time of medium level HP per recover need spend");
    l4d_recovery_durationL  = CreateConVar("l4d_recovery_durationL", 	"3.0", "The time of low level HP per recover need spend");

    l4d_recovery_quantityH  = CreateConVar("l4d_recovery_quantityH", 	"1", "The quantity of high level HP per recover");
    l4d_recovery_quantityM  = CreateConVar("l4d_recovery_quantityM", 	"2", "The quantity of medium level HP per recover");
    l4d_recovery_quantityL  = CreateConVar("l4d_recovery_quantityL", 	"5", "the quantity of low level HP per recover");

    HookEvent("player_hurt", OnPlayerRecovery);
    AutoExecConfig(true, "l4d_recovery");
}

public Action:OnPlayerRecovery(Event event, const char[] name, bool dontBroadcast){
	new Client      = GetClientOfUserId(GetEventInt(event,"userid"));
	new iHealth     = GetEventInt(event, "health");
	new hp_enable   =   GetConVarInt(l4d_recovery_enable);
    	if(hp_enable){
        	if(IsClientInGame(Client) && (GetClientTeam(Client) == 2)){
            		if(iHealth > GetConVarInt(l4d_recovery_hpH)){
				CreateTimer(GetConVarFloat(l4d_recovery_durationH), h_HPTimer, Client, 0);
            		}
            	else if(iHealth > GetConVarInt(l4d_recovery_hpM)){
                	CreateTimer(GetConVarFloat(l4d_recovery_durationM), m_HPTimer, Client, 0);
            		}
            	else if(iHealth > GetConVarInt(l4d_recovery_hpL)){
                	CreateTimer(GetConVarFloat(l4d_recovery_durationL), l_HPTimer, Client, 0);
			}
		}
	}
	return Plugin_Continue;
}

public Action:h_HPTimer(Handle:timer, any:Client){
    new hp_add      =   GetConVarInt(l4d_recovery_quantityH);
    new now_hp      =   GetClientHealth(Client);
    new hp_limit    =   GetConVarInt(l4d_recovery_limit)

    if(hp_add <= 0) return;

    if(now_hp <= hp_limit){
        if(IsClientInGame(Client) && GetClientTeam(Client) == 2 && IsPlayerAlive(Client) && !IsPlayerIncapped(Client)){
            AddHealth(Client, hp_add, hp_limit, now_hp);
        }
        CreateTimer(GetConVarFloat(l4d_recovery_durationH), h_HPTimer, Client, 0);
    }
}

public Action:m_HPTimer(Handle:timer, any:Client){
    new hp_add      =   GetConVarInt(l4d_recovery_quantityM);
    new now_hp      =   GetClientHealth(Client);
    new hp_limit    =   GetConVarInt(l4d_recovery_hpH)

    if(hp_add <= 0) return;

    if(now_hp <= hp_limit){
        if(IsClientInGame(Client) && GetClientTeam(Client) == 2 && IsPlayerAlive(Client) && !IsPlayerIncapped(Client)){
            AddHealth(Client, hp_add, hp_limit, now_hp);
        }
        CreateTimer(GetConVarFloat(l4d_recovery_durationM), m_HPTimer, Client, TIMER_FLAG_NO_MAPCHANGE);
    }
}

public Action:l_HPTimer(Handle:timer, any:Client){
    new hp_add      =   GetConVarInt(l4d_recovery_quantityL);
    new now_hp      =   GetClientHealth(Client);
    new hp_limit    =   GetConVarInt(l4d_recovery_hpM)

    if(hp_add <= 0) return;

    if(now_hp <= hp_limit){
        if(IsClientInGame(Client) && GetClientTeam(Client) == 2 && IsPlayerAlive(Client) && !IsPlayerIncapped(Client)){
            AddHealth(Client, hp_add, hp_limit, now_hp);
        }
        CreateTimer(GetConVarFloat(l4d_recovery_durationL), l_HPTimer, Client, TIMER_FLAG_NO_MAPCHANGE);
    }
}

bool:IsPlayerIncapped(client)
{
	if (GetEntProp(client, Prop_Send, "m_isIncapacitated", 1)) return true;
	return false;
}

AddHealth(Client, hp_add, hp_limit, now_hp)
{
    new Max_hp = GetConVarInt(l4d_recovery_limit);
	if(now_hp + hp_add <= Max_hp && now_hp + hp_add <= hp_limit){
		SetEntityHealth(Client,  now_hp + hp_add);
	}
	return;
}
