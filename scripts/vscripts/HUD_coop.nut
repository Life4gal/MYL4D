Msg("coop\n");

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
::_StrShow_ff <- "";
::_StrShow_pz <- "";
::_StrShow_hp <- "";
FF_damage <-{};
PZ_kill <-{};
HP_hard <-{};
HP_tmp <-{};


function OnGameEvent_round_start(params){
	for(local i = 0; i <= 32; i++)
	{
		FF_damage[i] <- 0;
    		PZ_kill[i] <- 0;
    		HP_hard[i] <- 0;
    		HP_tmp[i] <- 0;
	}
}

function OnGameEvent_player_team(params){
	local disconnect = false;
	local Player = GetPlayerFromUserID(params.userid);
	if(!Player.GetClassname() == "player" || !Player.IsSurvivor())  return;
	disconnect = params["disconnect"];
	if(disconnect)
	{
    		FF_damage[i] <- 0;
    		PZ_kill[i] <- 0;
    		HP_hard[i] <- 0;
    		HP_tmp[i] <- 0;
	}
}

function OnGameEvent_player_death(params){  //kill special infected
	local attacker = GetPlayerFromUserID(params.attacker);
	local victim = GetPlayerFromUserID(params.userid);
	if(victim > 0 && attacker > 0 &&  victim.GetZombieType <= 8){
		PZ_kill[attacker.GetEntityIndex()]++;
	}
}

function OnGameEvent_player_hurt(params){ //friendly fire damage
	local attacker = GetPlayerFromUserID(params.attacker);
	local victim = GetPlayerFromUserID(params.userid);
	local damage = 0;
	if(!attacker.IsSurvivor())  return;
	damage = params["dmg_healith"];
	if(damage > 0){
	FF_damage[attacker.GetEntityIndex()]++;
	}
}

function setSurvivorsHp(index){  //HP
	for(local i = 0; i < index.len(); i++){
	HP_hard[index[i]] = PlayerInstanceFromIndex(index[i]).GetHealth();
	HP_tmp[index[i]] = PlayerInstanceFromIndex(index[i]).GetHealthBuffer();
	}
}

last_set <- 0;

function Update(){
  local _survivors = 0;
  ::_StrShow_ff = "FF done";
  ::_StrShow_pz = "SI kill";
  ::_StrShow_hp = "HP remain";
  index <- {};
  counts <- {};
  foreach(surmodel in ::survivors){
    playerindex <- null;
    while((playerindex = Entities.FindByModel(playerindex, surmodel)) != null){
      index[_survivors] <- playerindex.GetEntityIndex();
      _survivors++;
    }
  }
  if(Time() >= last_set + 1){
    setSurvivorsHp(index);
    last_set = Time();
  }

  for(local i = 0; i < index.len(); i++){
    if(PlayerInstanceFromIndex(index[i]).GetPlayerName().len()>10){
      ::_StrShow_ff += "\n" + PlayerInstanceFromIndex(index[i]).GetPlayerName().slice(0, 10) + " : " + FF_damage[index[i]];
      ::_StrShow_pz += "\n" + PlayerInstanceFromIndex(index[i]).GetPlayerName().slice(0, 10) + " : " + PZ_kill[index[i]];
      if(HP_hard[index[i]] <= 0){
        ::_StrShow_hp += "\n" + PlayerInstanceFromIndex(index[i]).GetPlayerName().slce(0, 10) + " : Dead";
      }
      ::_StrShow_hp += "\n" + PlayerInstanceFromIndex(index[i]).GetPlayerName().slice(0, 10) + " : " + "Hard: " + HP_hard[index[i]] + " Tmp: " + HP_tmp[index[i]];
    }
    else{
      ::_StrShow_ff += "\n" + PlayerInstanceFromIndex(index[i]).GetPlayerName() + " : " + FF_damage[index[i]];
      ::_StrShow_pz += "\n" + PlayerInstanceFromIndex(index[i]).GetPlayerName() + " : " + PZ_kill[index[i]];
      if(HP_hard[index[i]] <= 0){
        ::_StrShow_hp += "\n" + PlayerInstanceFromIndex(index[i]).GetPlayerName() + " : Dead";
      }
      ::_StrShow_hp += "\n" + PlayerInstanceFromIndex(index[i]).GetPlayerName() + " : " + "Hard: " + HP_hard[index[i]] + " Tmp: " + HP_tmp[index[i]];
    }
  }
  ::_survivors = _survivors;
  CustomHud();
}

function CustomHud(){
  HUDINFO <-
  {
    Fileds =
    {
      PZ_kill_Hud = {slot = HUD_FAR_LEFT, dataval = ::_StrShow_pz, flags = HUD_FLAG_NOBG|HUD_FLAG_COUNTDOWN_WARN}
      FF_damage_Hud = {slot = HUD_FAR_RIGHT, dataval = ::_StrShow_ff, flags = HUD_FLAG_NOBG|HUD_FLAG_COUNTDOWN_WARN}
      HP_remain_Hud = {slot = HUD_MID_TOP, dataval = ::_StrShow_hp, flags = HUD_FLAG_NOBG|HUD_FLAG_COUNTDOWN_WARN}
    }
  }
	HUDSetLayout( HUDINFO);
	HUDPlace(HUD_FAR_LEFT, 0.0, 0.0, 0.4, 0.6);
	HUDPlace(HUD_FAR_RIGHT, 0.0, 0.0, 0.4, 0.6);
	HUDPlace(HUD_MID_TOP, 0.0, 0.0, 0.4, 0.6);
}
