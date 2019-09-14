/*
	1.!special
	2.!common
	3.!give
	4.!rank
	5.!help
*/

Msg("Script power by 無くなった雪\n");
IncludeScript("VSLib");

::survivors <-{
   Coach        = "models/survivors/survivor_coach.mdl",
   Ellis        = "models/survivors/survivor_mechanic.mdl",
   Nick         = "models/survivors/survivor_gambler.mdl",
   Rochelle     = "models/survivors/survivor_producer.mdl",
   Zoey         = "models/survivors/survivor_teenangst.mdl",
   Francis      = "models/survivors/survivor_biker.mdl",
   Louis        = "models/survivors/survivor_manager.mdl",
   Bill         = "models/survivors/survivor_namvet.mdl"
}

function Precache()
{
	Utils.PrecacheCSSWeapons();
	Utils.PrecacheSurvivors();
}

::g_SpecialInfo <- "";
::g_CommonInfo <- "";
::g_SteamUrl <- "https://steamcommunity.com/sharedfiles/\nfiledetails/?id=1861743382";
::g_GitHubUrl <- "https://github.com/Life4gal/MYL4D/blob/master/\nscripts/vscripts/customize_coop_cn.nut";
//::GiveWithCoolDown <- false;

DirectorOptions <-
{
	ActiveChallenge = 1
	cm_SpecialRespawnInterval = 25
	cm_MaxSpecials = 8
	DominatorLimit = 8
	cm_CommonLimit = 30
	SmokerLimit = 2
	BoomerLimit = 2
	HunterLimit = 2
	SpitterLimit = 2
	JockeyLimit = 2
	ChargerLimit = 2
	SpecialInitialSpawnDelayMin = 0
	SpecialInitialSpawnDelayMax = 1
    MobMinSize = 20
	MobMaxSize = 30
}

//========================== Special ===========================
::g_BoomerLimit <- 2;
::g_HunterLimit <- 2;
::g_SpitterLimit <- 2;
::g_ChargerLimit <- 2;
::g_JockeyLimit <- 2;
::g_SmokerLimit <- 2;
::g_SpecialMax <- 8;
::g_SpecialInitial <- 25;
::g_SpecialInitialChange <- 0;

/*
!special limit 8
!special limit hunter 4
!special respawn 20
!special respawn change 3/-3
*/

function ChatTriggers::special(player, args, text){
	local arr = split(text, " ");
	if(arr.len() == 3){
		changeDirectorOptions(player.GetName(), "special", arr[1].tolower(), arr[2].tointeger());
	}
	else if(arr.len() == 4){
		changeDirectorOptions(player.GetName(), "special", arr[1].tolower(), arr[2].tolower(), arr[3].tointeger());
	}
	else{
		buildHUD(0);
	}
}

//================================= Common ================================
::g_CommonLimit <- 30;

/*
!common limit 50
!common(option)
*/

function ChatTriggers::common(player, args, text){
	local arr = split(text, " ");
	if(arr.len() == 3){
		changeDirectorOptions(player.GetName(), "common", arr[1].tolower(), arr[2].tointeger());
	}
	else{
		buildHUD(0);
	}
}

//================================= Give ================================

/*
!give pipe_bomb
!give pain_pills all
*/

function ChatTriggers::give(player, args, text){
	local arr = split(text, " ");
	arr[1] = itemNameAssociation(arr[1].tolower());
	if(arr.len() == 2){
		giveSurvivorItem(player.GetName(), arr[1], 0);
	}
	else if(arr.len() == 3){
		giveSurvivorItem(player.GetName(), arr[1], 1);
	}
	else{
		buildHUD(0);
	}
}

//================================= Rank ================================

/*
!rank
*/

function ChatTriggers::rank(player, args, text){
	buildHUD(4);
}

//================================= Help ================================

/*
!help
*/

function ChatTriggers::help(player, args, text){
	buildHUD(5);
}

//================================= Impl ================================
/*
When the function is called all the extra parameters will be accessible 
through the array called vargv, that is passed as implicit parameter.
vargv is a regular squirrel array and can be used accordingly.
*/
//================================= changeDirectorOptions ================================

::changeDirectorOptions <- function(playername, ...){
	if(vargv.len() == 3){
		if(vargv[1] == "limit" || vargv[1] == "数量"){
			if(vargv[0] == "special" || vargv[0] == "特感"){
				if(vargv[2] > 24){
					vargv[2] == 24;
				}
				if(vargv[2] < 0){
					vargv[2] = 0;
				}
				if(vargv[2] == 0){
					g_BoomerLimit = 0;
					g_HunterLimit = 0;
					g_SpitterLimit = 0;
					g_ChargerLimit = 0;
					g_JockeyLimit = 0;
					g_SmokerLimit = 0;
					g_SpecialMax = 0;
					buildHUD(1, playername, "设置特感数量为 ", vargv[2]);
					return;
				}
				local _max = 0;
				if(!g_SpecialMax && !g_BoomerLimit && !g_HunterLimit && !g_SpitterLimit && !g_ChargerLimit && !g_SmokerLimit){	
					_max = vargv[2];
					while(_max > 0){
						switch(RandomInt(0, 5)){
							case 0:
								g_BoomerLimit++;
								break;
							case 1:
								g_ChargerLimit++;
								break;
							case 2:
								g_HunterLimit++;
								break;
							case 3:
								g_JockeyLimit++;
								break;
							case 4:
								g_SmokerLimit++;
								break;
							case 5:
								g_SpitterLimit++;
								break;
							default:
								;
						}
						_max--;
					}
					g_SpecialMax = vargv[2];
					buildHUD(1, playername, "设置特感数量为 ", vargv[2]);
					return;
				}
				if((_max = g_BoomerLimit + g_ChargerLimit + g_HunterLimit + g_JockeyLimit + g_SmokerLimit + g_SpitterLimit) > vargv[2]){
					local i = 0;
					i = _max - vargv[2];
					while(i > 0){
						switch(RandomInt(0, 5)){
							case 0:
								if(g_BoomerLimit >= 1){
									g_BoomerLimit--;
									i--;
								}
								break;
							case 1:
								if(g_ChargerLimit >= 1){
									g_ChargerLimit--;
									i--;
								}
								break;
							case 2:
								if(g_HunterLimit >= 1){
									g_HunterLimit--;
									i--;
								}
								break;
							case 3:
								if(g_JockeyLimit >= 1){
									g_JockeyLimit--;
									i--;
								}
								break;
							case 4:
								if(g_SmokerLimit >= 1){
									g_SmokerLimit--;
									i--;
								}
								break;
							case 5:
								if(g_SpitterLimit >= 1){
									g_SpitterLimit--;
									i--;
								}
								break;
							default:
								;
						}
					}
					g_SpecialMax = vargv[2];
					buildHUD(1, playername, "设置特感数量为 ", vargv[2]);
					return;
				}
				g_SpecialMax = vargv[2];
			}
			else if(vargv[0] == "common" || vargv[0] == "普感"){
				if(vargv[2] > 250){
					vargv[2] = 250;
				}
				if(vargv[2] < 0){
					vargv[2] = 0;
				}
				g_CommonLimit = vargv[2];
				buildHUD(2, playername, "设置普感数量为 ", vargv[2]);
			}
			else{
				buildHUD(0);
			}
		}
		else if(vargv[1] == "respawn" || vargv[1] == "复活"){
			if(vargv[2] < 8){
				vargv[2] = 8;
			}
			buildHUD(1, playername, "设置特感复活时间为 ", vargv[2] + "秒");
			g_SpecialInitial = vargv[2];
		}
		else{
			buildHUD(0);
		}
	}
	else if(vargv.len() == 4){
		if(vargv[1] == "respawn" || vargv[1] == "复活"){
			if(vargv[2] == "change" || vargv[2] == "改变"){
				buildHUD(1, playername, "设置特感复活时间改变 ", vargv[2] + "秒每多一个人类玩家");
				g_SpecialInitialChange = vargv[3];
			}
			else{
				buildHUD(0);
			}
		}
		else if(vargv[1] == "limit" || vargv[1] == "数量"){
			if(vargv[3] < 0){
				vargv[3] = 0;
			}
			if(vargv[3] > 24){
				vargv[3] = 24;
			}
			if(g_SpecialMax + vargv[3] - 2 <= 24){
				if(g_SpecialMax == 0){
					g_SpecialMax = 2;
				}
				switch(vargv[2]){
					case "胖子":
					case "boomer":
						g_BoomerLimit = vargv[3];
						g_SpecialMax += (vargv[3] - 2);
						break;
					case "猎人":
					case "hunter":
						g_HunterLimit = vargv[3];
						g_SpecialMax += (vargv[3] - 2);
						break;
					case "口水":
					case "spitter":
						g_SpitterLimit = vargv[3];
						g_SpecialMax += (vargv[3] - 2);
						break;
					case "牛":
					case "charger":
						g_ChargerLimit = vargv[3];
						g_SpecialMax += (vargv[3] - 2);
						break;
					case "猴子":
					case "jockey":
						g_JockeyLimit = vargv[3];
						g_SpecialMax += (vargv[3] - 2);
						break;
					case "烟鬼":
					case "smoker":
						g_SmokerLimit = vargv[3];
						g_SpecialMax += (vargv[3] - 2);
						break;
					default:
						;
				}
				buildHUD(1, playername, "设置 " + vargv[2] + " 数量为", vargv[3]);
			}
		}
		else{
			buildHUD(0);
		}
	}
	else{
		buildHUD(0);
	}
}

//================================= giveSurvivorItem ================================

::giveSurvivorItem <- function(playername, itemname, giveall){
	//if(!GiveWithCoolDown){
		foreach(surmodel in survivors){
			player <- Entities.FindByModel(null, surmodel);
			if(player){
				if(player.IsSurvivor()){
					if(giveall){
						player.GiveItem(itemname);
						buildHUD(2, playername, "给了所有幸存者 ", itemname);
					}
					else{
						if(player.GetPlayerName() == playername){
							player.GiveItem(itemname);
							buildHUD(2, playername, "给了他自己 ", itemname);
						}
					}
				}
			}
//		}
//		GiveWithCoolDown = true;
		//Timers.AddTimer(5.0, false, unlockPlayerGive);
//		Timers.AddTimer(5.0, false, (function(){ GiveWithCoolDown = false;}));
/*
An Error in here:
	
AN ERROR HAS OCCURED [wrong number of parameters]
CALLSTACK
*FUNCTION [unknown()] f:/steam/steamapps/common/left 4 dead 2/left4dead2/scripts/vscripts/VSLib/Timer.nut line [190]
LOCALS
[params] TABLE
[deadFunc] CLOSURE
[id] "wrong number of parameters"
[timer] TABLE
[idx] 12
[curtime] 23.633335113525
[TIMER_FLAG_DURATION_VARIANT] 16
[TIMER_FLAG_COUNTDOWN] 4
[this] TABLE

But I don't know how to fix it......
*/
	}
}

::getHumanCount <- function(){
	local _count = 0;
	foreach(surmodel in survivors){
		player <- Entities.FindByModel(null, surmodel);
		if(player){
			if(player.IsPlayer() && !IsPlayerABot(player)){
				_count++;
			}
		}
	}
	return _count;
}

//================================= stock ================================

::itemNameAssociation <- function(itemname){
	switch(itemname){
		case "肾上腺":
		case "针":
		case "adren":
		case "adrenal":
			return "adrenaline";
		case "小连喷":
		case "auto":
			return "autoshotgun";
		case "可乐":
		case "cola":
			return "cola_bottles";
		case "电击器":
		case "defib":
			return "defibrillator";
		case "烟花":
		case "firework":
			return "fireworkcrate";
		case "医疗包":
		case "包":
		case "first":
		case "aid":
		case "kit":
			return "first_aid_kit";
		case "油桶":
		case "油箱":
		case "gas":
			return "gascan";
		case "榴弹":
		case "grenade":
			return "grenade_launcher";
		case "血":
		case "加血":
		case "hp":
			return "health";
		case "猎狙":
		case "hunting":
			return "hunting_rifle";
		case "棒球棒":
		case "baseball":
			return "baseball_bat";
		case "板球棒":
		case "cricket":
			return "cricket_bat";
		case "吉他":
		case "guitar":
			return "electric_guitar";
		case "斧子":
		case "斧头":
		case "axe":
			return "fireaxe";
		case "锅":
		case "平底锅":
		case "pan":
			return "frying_pan";
		case "氧气瓶":
		case "oxygen":
			return "oxygentank";
		case "药丸":
		case "药":
		case "pill":
		case "pills":
			return "pain_pills";
		case "土质":
		case "手雷":
		case "炸弹":
		case "pipe":
		case "bomb":
			return "pipe_bomb";
		case "马格南":
		case "沙鹰":
		case "magnum":
			return "pistol_magnum";
		case "丙烷":
		case "丙烷罐":
		case "propane":
			return "propanetank";
		case "木喷":
		case "pump":
			return "pumpshotun"
		case "m16":
			return "rifle";
		case "ak47":
		case "ak":
			return "rifle_ak47";
		case "scar":
			return "rifle_desert";
		case "sg552":
			return "rifle_sg552";
		case "铁喷":
		case "chrome":
			return "shotgun_chrome";
		case "大连喷":
		case "spas":
			return "spas";
		case "mac":
			return "smg";
		case "mp5":
			return "smg_mp5";
		case "uzi":
			return "smh_silenced";
		case "awp":
			return "sniper_awp";
		case "军用连狙":
		case "military":
			return "sniper_military";
		case "scout":
			return "sniper_scout";
		case "高爆":
		case "高爆弹":
		case "explosive":
			return "upgradepack_explosive";
		case "燃烧":
		case "燃烧弹":
		case "incendiary":
			return "upgradepack_incendiary";
		case "胆汁":
		case "vomit":
			return "vomitjar";
		default:
			return itemname;
	}
}

/*
HUD TYPE:
	0 : Wrong Format
	1 : special/common
	2 : give
	3 : give with cooldown
	4 : rank
	5 : help
*/

::buildHUD <- function(hudtype, ...){
	if(hudtype == 0){
		local _hud = HUD.Item("\n{msg}\n")
		_hud.SetValue("msg", "格式错误!输入'!help' 查看帮助");
		_hud.AttachTo(HUD_MID_BOX);
        _hud.ChangeHUDNative(0, 0, 350, 250, 1366, 720);
        _hud.SetTextPosition(TextAlign.Left);
        _hud.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
        Timers.AddTimer(6.0, false, CloseHud, _hud);
	}
	else if(hudtype == 1){
		local _hud = HUD.Item("\n{name}\n{msg1}\n{msg2}\n");
		_hud.SetValue("name", vargv[0]);
		_hud.SetValue("msg1", vargv[1]);
		_hud.SetValue("msg2", vargv[2]);
		_hud.AttachTo(HUD_MID_BOX);
        _hud.ChangeHUDNative(0, 0, 350, 250, 1366, 720);
        _hud.SetTextPosition(TextAlign.Left);
        _hud.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
        Timers.AddTimer(6.0, false, CloseHud, _hud);
	}
	else if(hudtype == 2){
		local _hud = HUD.Item("\n{name}\n{msg}\n{item}\n");
		_hud.SetValue("name", vargv[0]);
		_hud.SetValue("msg", vargv[1]);
		_hud.SetValue("item", vargv[2]);
		_hud.AttachTo(HUD_MID_BOX);
        _hud.ChangeHUDNative(0, 0, 350, 250, 1366, 720);
        _hud.SetTextPosition(TextAlign.Left);
        _hud.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
        Timers.AddTimer(6.0, false, CloseHud, _hud);
	}
	/*
	else if(hudtype == 3){
		local _hud = HUD.Item("\n{msg}\n");
		_hud.SetValue("msg", "The '!give' directive with a cooldown!");
		_hud.AttachTo(HUD_MID_BOX);
        _hud.ChangeHUDNative(0, 0, 250, 100, 1366, 720);
        _hud.SetTextPosition(TextAlign.Left);
        _hud.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
        Timers.AddTimer(6.0, false, CloseHud, _hud);
	}
	*/
	else if(hudtype == 4){
		local _hud = HUD.Item("\n{special_info}\n{common_info}\n");
		_hud.SetValue("special_info", g_SpecialInfo);
		_hud.SetValue("common_info", g_CommonInfo);
		_hud.AttachTo(HUD_MID_BOX);
		_hud.ChangeHUDNative(0, 0, 450, 250, 1366, 720);
		_hud.SetTextPosition(TextAlign.Left);
		_hud.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
		Timers.AddTimer(6.0, false, CloseHud, _hud);
	}
	else if(hudtype == 5){
		local _hud = HUD.Item("\n{t1}\n{t2}\n{t3}\n{t4}\\n");
		_hud.SetValue("t1", "'!special':'!special 数量 猎人 0'");
		_hud.SetValue("t2", "'!common':'!special 数量 50'");
		_hud.SetValue("t3", "'!give':'!give 土质'");
		_hud.SetValue("t4", "查看创意工坊以获得更多信息.");
		_hud.AttachTo(HUD_MID_BOX);
		_hud.ChangeHUDNative(0, 0, 500, 300, 1366, 720);
		_hud.SetTextPosition(TextAlign.Left);
		_hud.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
		Timers.AddTimer(6.0, false, CloseHud, _hud);

		local _Steam = HUD.Item("\n{steamUrl}\n");
		_Steam.SetValue("steamUrl", g_SteamUrl);
		_Steam.AttachTo(HUD_SCORE_2);
		_Steam.ChangeHUDNative(0, 120, 550, 200, 1366, 720);
		_Steam.SetTextPosition(TextAlign.Left);
		_Steam.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
		Timers.AddTimer(6.0, false, CloseHud, _Steam);

		local _GitHub = HUD.Item("\n{githubUrl}\n");
		_GitHub.SetValue("githubUrl", g_GitHubUrl);
		_GitHub.AttachTo(HUD_SCORE_3);
		_GitHub.ChangeHUDNative(0, 225, 600, 200, 1366, 720);
		_GitHub.SetTextPosition(TextAlign.Left);
		_GitHub.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
		Timers.AddTimer(6.0, false, CloseHud, _GitHub);
		Utils.SayToAll("Workshop:" + g_SteamUrl);
		Utils.SayToAll("GitHub:" + g_GitHubUrl);
	}
}

::CloseHud <- function(hud){
	hud.Detach();
}
/*
::unlockPlayerGive <- function(){
	GiveWithCoolDown = false;
}
*/
//================================= Update ================================


function Update(){
	
	local _HumanCount = 0;
	_HumanCount = getHumanCount();

	DirectorOptions.BoomerLimit = g_BoomerLimit;
	DirectorOptions.HunterLimit = g_HunterLimit;
	DirectorOptions.SpitterLimit = g_SpitterLimit;
	DirectorOptions.ChargerLimit = g_ChargerLimit;
	DirectorOptions.JockeyLimit = g_JockeyLimit;
	DirectorOptions.SmokerLimit = g_SmokerLimit;
	DirectorOptions.cm_MaxSpecials = g_SpecialMax;
	if(g_SpecialMax > 14){
		DirectorOptions.DominatorLimit = 14;
	}
	else{
		DirectorOptions.DominatorLimit = g_SpecialMax;
	}
	if(g_CommonLimit == 0){
		DirectorOptions.cm_CommonLimit = 0;
		DirectorOptions.MobMaxSize = 0;
		DirectorOptions.MobMinSize = 0;
	}
	else if(g_CommonLimit > 0 && g_CommonLimit < 20){
		DirectorOptions.cm_CommonLimit = 20;
		DirectorOptions.MobMaxSize = 20;
		DirectorOptions.MobMinSize = 10;
	}
	else if(g_CommonLimit >= 20 && g_CommonLimit < 100){
		DirectorOptions.cm_CommonLimit = g_CommonLimit;
		DirectorOptions.MobMaxSize = (g_CommonLimit > 40) ? ((g_CommonLimit / 2).tointeger() + 20) : (g_CommonLimit);
		DirectorOptions.MobMinSize = (g_CommonLimit > 40) ? ((g_CommonLimit / 2).tointeger() + 10) : (g_CommonLimit - 5);
	}
	else if(g_CommonLimit >= 100 && g_CommonLimit < 200){
		DirectorOptions.cm_CommonLimit = g_CommonLimit;
		DirectorOptions.MobMaxSize = (g_CommonLimit > 160) ? ((g_CommonLimit / 2).tointeger() + 50) : (g_CommonLimit - 30);
		DirectorOptions.MobMinSize = (g_CommonLimit > 160) ? ((g_CommonLimit / 2).tointeger() + 30) : (g_CommonLimit - 45);
	}
	else{
		DirectorOptions.cm_CommonLimit = g_CommonLimit;
		DirectorOptions.MobMaxSize = 180;
		DirectorOptions.MobMinSize = 150;
	}
	local _change = 0;
	local _time = 0;
	_change = (_HumanCount - 1) * g_SpecialInitialChange;
	_time = _change + g_SpecialInitial;
	if(_time < 8){
		_time = 8;
	}
	DirectorOptions.cm_SpecialRespawnInterval = _time;
	DirectorOptions.SpecialInitialSpawnDelayMax = _time + 3;
	DirectorOptions.SpecialInitialSpawnDelayMin = _time;
	g_CommonInfo = "普感 : " + "[(" + DirectorOptions.cm_CommonLimit + ")]只";
	g_SpecialInfo = "特感 : " + "[(" + DirectorOptions.cm_MaxSpecials + ") 只 (" + DirectorOptions.cm_SpecialRespawnInterval +")秒重生]";
}

