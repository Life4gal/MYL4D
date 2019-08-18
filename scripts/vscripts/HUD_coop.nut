Msg("coop\n");
IncludeScript("vslib");

::survivors <-{
   Coach = "models/survivors/survivor_coach.mdl",
   Ellis = "models/survivors/survivor_mechanic.mdl",
   Nick = "models/survivors/survivor_gambler.mdl",
   Rochelle = "models/survivors/survivor_producer.mdl",
   Zoey = "models/survivors/survivor_teenangst.mdl",
   Francis = "models/survivors/survivor_biker.mdl",
   Louis = "models/survivors/survivor_manager.mdl",
   Bill = "models/survivors/survivor_namvet.mdl"
}

::_survivors <- 0;
::GetInfectedName <- {};
::ClientKillNum <-{};
::RoundStart_ShowInfo <- 0;
::TimerMax <- 0;
::AutoChange <- 0;
::EventPlayerSpawn_Off <- 1;
::GetUserId <- 0;
::_StrShow_ff <- "";
::_StrShow_pz <- "";
::_StrShow_hp <- "";
FF_damage <-{};
PZ_kill <-{};
HP_hard <-{};
HP_tmp <-{};
IsHanging <-{};		// 0 = false  1 = true

function OnGameEvent_round_start(params)
{
	for(local i=0;i<=32;i+=1)
	{
		FF_damage[i] <- 0;
		PZ_kill[i] <- 0;
		HP_hard[i] <- 0;
		HP_tmp[i] <- 0;
		IsHanging[i] <- 0;
	}
}


function OnGameEvent_player_team(params)
{
	local disconnect = false;
	local Player = GetPlayerFromUserID(params.userid);
	if(!Player.GetClassname() == "player" || !Player.IsSurvivor() || IsPlayerABot(Player)) return;
	disconnect = params["disconnect"];
	if(disconnect)
	{
		FF_damage[Player.GetEntityIndex()] = 0;
		PZ_kill[Player.GetEntityIndex()] = 0;
		HP_hard[Player.GetEntityIndex()] = 100;
		HP_tmp[Player.GetEntityIndex()] = 0;
		IsHanging[Player.GetEntityIndex()] = 0;
	}
}

function OnGameEvent_player_death(params)
{
	local attacker = GetPlayerFromUserID(params.attacker);
	local victim = GetPlayerFromUserID(params.userid);
	if(!IsPlayerABot(attacker) && victim.GetZombieType() <= 8)
	{
		PZ_kill[attacker.GetEntityIndex()]++;
	}
}

function OnGameEvent_player_hurt(params)
{
	local attacker = GetPlayerFromUserID(params.attacker);
	local victim = GetPlayerFromUserID(params.userid);
	local damage = 0;
	if(!victim.IsSurvivor() || !attacker.IsSurvivor())  return;
	damage = params["dmg_health"];
	if(damage > 0)
	{
		FF_damage[attacker.GetEntityIndex()] += damage;
	}
}

function OnGameEvent_player_ledge_grab(params)
{
	local victim = GetPlayerFromUserID(params.userid);
	if(victim.IsSurvivor())
	{
		IsHanging[victim.GetEntityIndex()] = 1;
	}
}

function OnGameEvent_player_ledge_release(params)
{
	local victim = GetPlayerFromUserID(params.userid);
	if(victim.IsSurvivor())
	{
		IsHanging[victim.GetEntityIndex()] = 0;
	}
}

function OnGameEvent_revive_success(params)
{
	local victim = GetPlayerFromUserID(params.subject);
	local ledge = false;
	ledge = params["ledge_hang"];
	if(victim.IsSurvivor() && ledge)
	{
		IsHanging[victim.GetEntityIndex()] = 0;
	}
}

function OnGameEvent_revive_end(params)
{
	local victim = GetPlayerFromUserID(params.subject);
	local ledge = false;
	ledge = params["ledge_hang"];
	if(victim.IsSurvivor() && ledge)
	{
		IsHanging[victim.GetEntityIndex()] = 0;
	}
}

last_set <- 0;

function Update()
{
	local _survivors = 0;
	::_StrShow_ff = "FF done";
	::_StrShow_pz = "SI kill";
	::_StrShow_hp = "HP remain";
	index <- {};
	counts <-{};
	foreach(surmodel in ::survivors)
	{
		playerindex <- null
		while ((playerindex = Entities.FindByModel(playerindex, surmodel)) != null)
		{
			if(!IsPlayerABot(playerindex))
			{
				index[_survivors] <- playerindex.GetEntityIndex();
				_survivors++;
			}
		}
	}

	if(Time() >= last_set + 1)
	{
		setSurvivorsHp(index);
		last_set = Time();
	}

	for(local i = 0; i < index.len(); i++)
	{
		if(PlayerInstanceFromIndex(index[i]).GetPlayerName().len()>12)
		{
			::_StrShow_ff += "\n" + PlayerInstanceFromIndex(index[i]).GetPlayerName().slice(0, 12) + " : " + FF_damage[index[i]];
			::_StrShow_pz += "\n" + PlayerInstanceFromIndex(index[i]).GetPlayerName().slice(0, 12) + " : " + PZ_kill[index[i]];
			if(PlayerInstanceFromIndex(index[i]).IsIncapacitated())
			{
				if(IsHanging[index[i]])
				{
					::_StrShow_hp += "\n" + PlayerInstanceFromIndex(index[i]).GetPlayerName().slice(0, 12) + " : Hanging HP: " + HP_hard[index[i]];
				}
				else
				{
					::_StrShow_hp += "\n" + PlayerInstanceFromIndex(index[i]).GetPlayerName().slice(0, 12) + " : DOWN HP: " + HP_hard[index[i]];
				}
			}
			else if(PlayerInstanceFromIndex(index[i]).IsDead())
			{
				::_StrShow_hp += "\n" + PlayerInstanceFromIndex(index[i]).GetPlayerName().slice(0, 12) + " : DEAD";
			}
			else
			{
				::_StrShow_hp += "\n" + PlayerInstanceFromIndex(index[i]).GetPlayerName().slice(0, 12) + " : " + "Hard: " + HP_hard[index[i]] + " Tmp: " + HP_tmp[index[i]].tointeger();
			}
		}
		else{
			::_StrShow_ff += "\n" + PlayerInstanceFromIndex(index[i]).GetPlayerName() + " : " + FF_damage[index[i]];
			::_StrShow_pz += "\n" + PlayerInstanceFromIndex(index[i]).GetPlayerName() + " : " + PZ_kill[index[i]];
			if(PlayerInstanceFromIndex(index[i]).IsIncapacitated())
			{
				if(IsHanging[index[i]])
				{
					::_StrShow_hp += "\n" + PlayerInstanceFromIndex(index[i]).GetPlayerName() + " : Hanging HP: " + HP_hard[index[i]];
				}
				else
				{
					::_StrShow_hp += "\n" + PlayerInstanceFromIndex(index[i]).GetPlayerName() + " : DOWN HP: " + HP_hard[index[i]];
				}
			}
			else if(PlayerInstanceFromIndex(index[i]).IsDead())
			{
				::_StrShow_hp += "\n" + PlayerInstanceFromIndex(index[i]).GetPlayerName() + " : DEAD";
			}
			else
			{
				::_StrShow_hp += "\n" + PlayerInstanceFromIndex(index[i]).GetPlayerName() + " : " + "Hard: " + HP_hard[index[i]] + " Tmp: " + HP_tmp[index[i]].tointeger();
			}
		}
	}
	::_survivors = _survivors;
	CustomHud();
}

function setSurvivorsHp(index){  //HP
	for(local i = 0; i < index.len(); i++)
	{
		HP_hard[index[i]] = PlayerInstanceFromIndex(index[i]).GetHealth();
		HP_tmp[index[i]] = PlayerInstanceFromIndex(index[i]).GetHealthBuffer();
	}
}

function CustomHud()
{

	HUDINFO <-
	{
		Fields =
		{
			KillIU01 = {slot = HUD_FAR_LEFT, dataval = ::_StrShow_pz,flags = HUD_FLAG_NOBG|HUD_FLAG_COUNTDOWN_WARN}
			KillIU02 = {slot = HUD_FAR_RIGHT, dataval = ::_StrShow_ff,flags = HUD_FLAG_NOBG|HUD_FLAG_COUNTDOWN_WARN}
			KillIU03 = {slot = HUD_MID_TOP, dataval = ::_StrShow_hp,flags = HUD_FLAG_NOBG|HUD_FLAG_COUNTDOWN_WARN}
		}
	}
	HUDSetLayout(HUDINFO);
	HUDPlace(HUD_FAR_LEFT,0.0,0.02,1.0,0.05);
	HUDPlace(HUD_FAR_RIGHT,0.5,0.02,0.4,0.05);
	HUDPlace(HUD_MID_TOP,0.25,0.02,0.4,0.05);
}
