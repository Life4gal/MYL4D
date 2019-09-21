Msg("coop\n");
IncludeScript("vslib");
Convars.SetValue( "sv_cheats", "1" );
Convars.SetValue( "precache_all_survivors", "1" );
Convars.SetValue( "sv_consistency", "0" );
//Convars.SetValue( "z_difficulty", "Impossible" );
Convars.SetValue( "ammo_m60_max", "60000" );
Convars.SetValue( "ammo_grenadelauncher_max", "500" );
Convars.SetValue( "ammo_chainsaw_max", "100" );
Convars.SetValue( "sb_max_team_melee_weapons", "0" );
Convars.SetValue( "survivor_friendly_fire_factor_easy", "0.2" );
Convars.SetValue( "survivor_friendly_fire_factor_expert", "0.2" );
Convars.SetValue( "survivor_friendly_fire_factor_hard", "0.2" );
Convars.SetValue( "survivor_friendly_fire_factor_normal", "0.2" );
Convars.SetValue( "ammo_ammo_pack_max", "3" );
Convars.SetValue( "z_attack_incapacitated_damage", "5" );
Convars.SetValue( "z_hit_incap_factor_easy", "0.5" );
Convars.SetValue( "z_hit_incap_factor_normal", "0.5" );
Convars.SetValue( "z_hit_incap_factor_hard", "0.5" );
Convars.SetValue( "z_hit_incap_factor_expert", "0.5" );
Convars.SetValue( "sb_vomit_blind_time", "3" );
Convars.SetValue( "boomer_exposed_time_tolerance", "0.5" );
Convars.SetValue( "boomer_vomit_delay", "0.5" );
Convars.SetValue( "survivor_revive_health", "100" );
Convars.SetValue( "z_survivor_respawn_health", "100" );
Convars.SetValue( "rescue_distance", "1000" );
Convars.SetValue( "rescue_min_dead_time", "10" );

::survivors <-{
   Coach 	= "models/survivors/survivor_coach.mdl",
   Ellis 	= "models/survivors/survivor_mechanic.mdl",
   Nick 	= "models/survivors/survivor_gambler.mdl",
   Rochelle 	= "models/survivors/survivor_producer.mdl",
   Zoey 	= "models/survivors/survivor_teenangst.mdl",
   Francis 	= "models/survivors/survivor_biker.mdl",
   Louis 	= "models/survivors/survivor_manager.mdl",
   Bill 	= "models/survivors/survivor_namvet.mdl"
}

function Precache()
{
	Utils.PrecacheCSSWeapons();
	Utils.PrecacheSurvivors();
	Utils.PrecacheModel("models/w_models/weapons/w_m60.mdl");
	Utils.PrecacheModel("models/weapons/melee/v_chainsaw.mdl");
	Utils.PrecacheModel("models/weapons/melee/w_chainsaw.mdl");
}

DirectorOptions <-
{
	ActiveChallenge = 1
	DominatorLimit = 4
	cm_MaxSpecials = 8
	cm_AggressiveSpecials = 4
	cm_BaseSpecialLimit = 8
	cm_CommonLimit = 250
	cm_ProhibitBosses  =  true
	ProhibitBosses  =  true
	SpecialInfectedAssault = 4
  	SpecialRespawnInterval = 15
	SpecialInitialSpawnDelayMin = 15
	SpecialInitialSpawnDelayMax = 16
	PreferredSpecialDirection = SPAWN_SPECIALS_ANYWHERE
	BoomerLimit = 8
	SpitterLimit = 0
	HunterLimit = 0
	JockeyLimit = 0
	ChargerLimit = 0
	SmokerLimit = 0
	ZombieTankHealth = 1
	ShouldAllowSpecialsWithTank = true
	ShouldAllowMobsWithTank = false
	BehindSurvivorsSpawnDistance = 250
	SurvivorMaxIncapacitatedCount = 1
	FarAcquireRange = 5000
	FarAcquireTime = 1.0
	NearAcquireRange = 4000
	NearAcquireTime = 0.1
	IntensityRelaxThreshold = 1.0
	LockTempo = true
	MobRechargeRate = 1
	MobSpawnMaxTime = 10
	MobSpawnMinTime = 2
	RelaxMaxFlowTravel = 300
	MusicDynamicMobSpawnSize = 30
	MusicDynamicMobScanStopSize = 5
	MusicDynamicMobStopSize = 120

	weaponsToConvert =
	{
		weapon_pumpshotgun		    	= "weapon_rifle_m60_spawn"
		weapon_shotgun_chrome	    		= "weapon_upgradepack_explosive_spawn"
		weapon_autoshotgun 	    		= "weapon_pain_pills_spawn"
		weapon_shotgun_spas     		= "weapon_upgradepack_explosive_spawn"

		weapon_smg_silenced		    	= "weapon_pain_pills_spawn"
		weapon_smg				= "weapon_rifle_m60_spawn"
		weapon_smg_mp5			      	= "weapon_rifle_m60_spawn"

		weapon_rifle 			        = "weapon_pain_pills_spawn"
		weapon_rifle_desert 	    		= "weapon_grenade_launcher_spawn"
		weapon_rifle_ak47 		    	= "weapon_rifle_m60_spawn"
		weapon_rifle_sg552 		    	= "weapon_grenade_launcher_spawn"

		weapon_sniper_awp		      	= "weapon_rifle_m60_spawn"
		weapon_sniper_scout		    	= "weapon_upgradepack_explosive_spawn"
		weapon_sniper_military 	  		= "weapon_pain_pills_spawn"
		weapon_hunting_rifle	    		= "weapon_grenade_launcher_spawn"

		weapon_first_aid_kit	    		= "weapon_pain_pills_spawn"
		weapon_pain_pills		      	= "weapon_pain_pills_spawn"
		weapon_adrenaline		      	= "weapon_upgradepack_explosive_spawn"
		weapon_pistol			        = "weapon_upgradepack_explosive_spawn"
		weapon_pistol_magnum	    		= "weapon_upgradepack_explosive_spawn"

		weapon_melee			        = "weapon_pain_pills_spawn"
	}
	function ConvertWeaponSpawn( classname )
	{
		if ( classname in weaponsToConvert )
		{
			return weaponsToConvert[classname];
		}
		return 0;
	}

	weaponsToRemove =
	{
		//weapon_upgradepack_incendiary 	= 0
		//weapon_upgradepack_explosive 		= 0
		//weapon_rifle_m60			= 0
		//weapon_grenade_launcher 		= 0
		//weapon_chainsaw 			= 0
		weapon_defibrillator 			= 0
		//upgrade_item 				= 0
		weapon_pumpshotgun			= 0
		weapon_shotgun_chrome			= 0
		weapon_smg_silenced			= 0
		weapon_smg				= 0
	}

	function AllowWeaponSpawn( classname )
	{
		if ( classname in weaponsToRemove )
		{
			return false;
		}
		return true;
	}

	botAvoidItems =
	{
		weapon_hunting_rifle 		   	= true
		weapon_autoshotgun			= true
		weapon_rifle 				= true
		weapon_rifle_desert 		   	= true
		weapon_shotgun_spas 		   	= true
		weapon_rifle_ak47 			= true
		weapon_sniper_scout 		   	= true
		weapon_rifle_sg552			= true
		weapon_sniper_military 		 	= true
		weapon_weapon_pumpshotgun  		= true
		weapon_shotgun_chrome		   	= true
		weapon_smg_silenced			= true
		weapon_smg				= true
		weapon_pistol				= true
	}
	function ShouldAvoidItem( classname )
	{
		if ( classname in botAvoidItems )
		{
			return true;
		}
		return false;
	}
        DefaultItems =
        [
                "weapon_grenade_launcher",
                "weapon_rifle_m60",
                "weapon_pain_pills",
		"weapon_chainsaw",
		"weapon_upgradepack_explosive",
        ]
        function GetDefaultItem( idx )
        {
                if ( idx < DefaultItems.len() )
                {
                    return DefaultItems[idx];
                }
                return 0;
        }
}

function OnGameEvent_player_first_spawn( params)
{
	local player = GetPlayerFromUserID(params.userid);
	if ((player && player.IsSurvivor())) {
		player.SetHealth(100);
		player.SetHealthBuffer(1.0);
		player.SetReviveCount(0);
	}
}

function OnGameEvent_player_transitioned( params )
{
	local player = GetPlayerFromUserID(params.userid);
	if ((player && player.IsSurvivor())) {
		player.GiveItem("weapon_upgradepack_explosive");
		player.SetHealth(100);
		player.SetHealthBuffer(1.0);
		player.SetReviveCount(0);
	}
}

function OnGameEvent_survivor_rescued(params)
{
	local player = GetPlayerFromUserID(params.victim);
	local i = GetPlayerFromUserID(params.rescuer);
	if(player && player.IsSurvivor())
	{
		player.GiveItem("weapon_pain_pills");
		player.GiveItem("weapon_rifle_m60");
		player.SetHealth(100);
		player.SetHealthBuffer(1.0);
		player.SetReviveCount(0);
		i.SetHealth(100);
		i.SetHealthBuffer(1.0);
		i.SetReviveCount(0);
	}
}

function OnGameEvent_respawning(params)
{
	local player = GetPlayerFromUserID(params.userid);
	player.GiveItem("weapon_upgradepack_explosive");
	player.SetHealth(100);
	player.SetHealthBuffer(1.0);
	player.SetReviveCount(0);
}

function OnGameEvent_pills_used(params)
{
	local player = GetPlayerFromUserID(params.userid);
	player.SetHealth(100);
	player.SetHealthBuffer(1.0);
	player.SetReviveCount(0);
}

//god_time <- 3;

//function OnGameEvent_player_death(params)
//{
//	local player = GetPlayerFromUserID(params.userid);
//	if(player && player.IsSurvivor())
//	{
//		now_time <- Time();
//		Convars.SetValue( "god", "1" );
//	}
//	if(Time() > now_time + god_time)
//	{
//		Convars.SetValue( "god", "0" );
//	}
//}


::_survivors <- 0;
::_StrShow <- "";
::ClientKillNum <-{};
::RoundStart_ShowInfo <- 0;
::TimerMax <- 0;
::AutoChange <- 0;
::EventPlayerSpawn_Off <- 1;
::GetUserId <- 0;
CZKill <-{};
timecount <-0;
_timecount <-0;
_info <- "";	// maybe something will be write here

function OnGameEvent_round_start(params)
{
	for(local i=0;i<=32;i+=1)
	{
		CZKill[i] <- 0;
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
		CZKill[Player.GetEntityIndex()] = 0;
	}
}

function OnGameEvent_player_death(params)
{
	local attacker = GetPlayerFromUserID(params.attacker);
	CZKill[attacker.GetEntityIndex()]++;
}

function Update()
{
	local _survivors = 0;
	::_StrShow = "Zombies KILL";
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
	bubbleSort(index,::_StrShow);
	for(local i = 0; i < index.len(); i++)
	{
		local NO = i+1;
		if(PlayerInstanceFromIndex(index[i]).GetPlayerName().len()>12)
			::_StrShow += "\n"+NO+"."+PlayerInstanceFromIndex(index[i]).GetPlayerName().slice(0, 12)+" KILL:"+CZKill[index[i]];
		else
			::_StrShow += "\n"+NO+"."+PlayerInstanceFromIndex(index[i]).GetPlayerName()+" KILL:"+CZKill[index[i]];
	}
	::_survivors = _survivors;
	CustomHud();
}

function bubbleSort(arrindex,_StrShow)
{
    for (local i = 0; i < arrindex.len() - 1; i++)
    {
		for (local j = 0; j < arrindex.len() - 1 - i; j++)
		{
			if (CZKill[arrindex[j]] < CZKill[arrindex[j+1]])
			{
				local temp = arrindex[j + 1];
				arrindex[j + 1] = arrindex[j];
				arrindex[j] = temp;
			}
		}
	}
}

function CustomHud()
{
	timecount++;
	if(timecount >=20)
	{
		_info = "";
		timecount = 20;
	}


	HUDINFO <-
	{
		Fields =
		{
			KillIU01 = {slot = HUD_FAR_LEFT, dataval = ::_StrShow,flags = HUD_FLAG_NOBG|HUD_FLAG_COUNTDOWN_WARN}
			KillIU02 = {slot = HUD_FAR_RIGHT, dataval = _info,flags = HUD_FLAG_NOBG|HUD_FLAG_BLINK|HUD_FLAG_COUNTDOWN_WARN }
		}
	}
	HUDSetLayout( HUDINFO);
	HUDPlace( HUD_FAR_LEFT,0.0,0.0,0.4,0.6);
	HUDPlace( HUD_FAR_RIGHT,0.5,0.02,0.4,0.6);
}
