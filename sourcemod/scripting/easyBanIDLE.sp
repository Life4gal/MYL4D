#include <sourcemod>
#include <sdktools>

public Plugin:myinfo=
{
	name = "easy ban open door too frequent",
	author = "NiceT",
	description = "easy ban open door too frequent",
	version = "1.0",
	url = ""
}

public OnPluginStart()
{
     AddCommandListener(BanIDLE, "go_away_from_keyboard");
     AddCommandListener(BanIDLE, "sm_away");
}

public Action:BanIDLE(int Client, const char[] sCommand, int iArg)
{
	if (PlayerBeenControled(Client))
	{
          if(GetClientTeam(Client) == 2)
          {
                PrintHintText(Client, "\x03 You were been controled, you can't idle now!");
		return Plugin_Stop;
          }
	}
	return Plugin_Continue;
}

bool PlayerBeenControled(Client)
{
       if(GetEntPropEnt(Client, Prop_Send, "m_pummelAttacker") > 0)
		  return true;
       if(GetEntPropEnt(Client, Prop_Send, "m_carryAttacker") > 0)
		  return true;
       if(GetEntPropEnt(Client, Prop_Send, "m_pounceAttacker") > 0)
		  return true;
       if(GetEntPropEnt(Client, Prop_Send, "m_jockeyAttacker") > 0)
		  return true;
       if(GetEntPropEnt(Client, Prop_Send, "m_tongueOwner") > 0)
		  return true;
       return false;
}
