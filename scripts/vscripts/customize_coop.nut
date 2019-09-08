Msg("Script power by 無くなった雪\n");
IncludeScript("VSLib");

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

function Precache()
{
	Utils.PrecacheCSSWeapons();
	Utils.PrecacheSurvivors();
}

::g_GameInfo <- "";

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
!special all limit 8
!special hunter limit 4
!special all respawn 20
!special change respawn 3/-3
*/

function ChatTriggers::special(player, args, text){
    local arr = split(text, " ");
    if(arr.len() != 4){
        Utils.SayToAll("Format: '!special specialname agr1 arg2'\n" + "For example: input '!special hunter limit 2' to change hunter limit to 2\n" + "Or : input '!spcial all respawn 20' to change special respawn time to 20s");
        Utils.SayToAll("input '!special change respawn 3/-3' to make speical respawn time change 3/-3s per human survivor(not include bot, if only 1 human player we use base respawn time)");
        Utils.SayToAll("You can use 'all' replace 'specialname' so you change all special.\n" + "All special name: boomer,hunter,spitter,charger,jockey,smoker");
    }
    else{
        changeDirectorOptions(arr[1], arr[2], arr[3]);
        local _hud = HUD.Item("\n{playername}{action}{arg1}{arg2}\n");
        _hud.SetValue("playername", player.GetName());
        if(arr[2].tolower() == "limit"){
            if(arr[1].tolower() == "all"){
                _hud.SetValue("action", "\nchange");
                _hud.SetValue("arg1", "\nspecial limit to\n");
                _hud.SetValue("arg2", arr[3]);
            }
            else{
                _hud.SetValue("action", "\nchange\n");
                _hud.SetValue("arg1", arr[1] + " limit to\n");
                _hud.SetValue("arg2", arr[3]);
            }
        }
        else if(arr[2].tolower() == "respawn"){
            if(arr[1].tolower() == "all"){
                _hud.SetValue("action", "\nset");
                _hud.SetValue("arg1", " special respawn\n time to\n");
                _hud.SetValue("arg2", arr[3] + "s");
            }
            else if(arr[1].tolower() == "change"){
                _hud.SetValue("action", "\nset");
                _hud.SetValue("arg1", " respawn time change\n");
                _hud.SetValue("arg2", arr[3] + "s per hunman survivor");
            }
        }
        else{
            return;
        }
        _hud.AttachTo(HUD_MID_BOX);
        _hud.ChangeHUDNative(0, 225, 350, 150, 1366, 720);
        _hud.SetTextPosition(TextAlign.Left);
        _hud.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK);
        Timers.AddTimer(6.0, false, CloseHud, _hud);
    }
}

//================================= Common ================================
::g_CommonLimit <- 30;

function ChatTriggers::common(player, args, text){
    local arr = split(text, " ");
    if(arr.len() != 4){
        Utils.SayToAll("Format : '!common common limit arg'\n" + "For example : input '!common common limit 40' to change common limit to 40.(default 30)");
    }
    else{
        changeDirectorOptions(arr[1], arr[2], arr[3]);
        local _hud = HUD.Item("\n{playername}{action}{arg}\n");
        _hud.SetValue("playername", player.GetName());
        _hud.SetValue("action", "\nchange common limit to\n");
        _hud.SetValue("arg", arr[3]);
        _hud.AttachTo(HUD_MID_BOX);
        _hud.ChangeHUDNative(0, 225, 350, 150, 1366, 720);
        _hud.SetTextPosition(TextAlign.Left);
        _hud.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK);
        Timers.AddTimer(6.0, false, CloseHud, _hud);
    }
}

/*
When the function is called all the extra parameters will be accessible through the array called vargv, that is passed as implicit parameter.
vargv is a regular squirrel array and can be used accordingly.
*/
::changeDirectorOptions <- function(specialname, ...){
    if(vargv.len() != 2){
        Utils.SayToAll("Wrong format!");
        return;
    }
    vargv[1] = vargv[1].tointeger();
    if(vargv[1] < 0){
        Utils.SayToAll("Wrong number!");
        return;
    }
    if(vargv[0] == "limit"){
        switch(specialname.tolower()){
            case "all":
                if(vargv[1] == 0){
                    g_SpecialMax = 0;
                    g_BoomerLimit = 0;
                    g_HunterLimit = 0;
                    g_SpitterLimit = 0;
                    g_ChargerLimit = 0;
                    g_JockeyLimit = 0;
                    g_SmokerLimit = 0;
                }
                if(!g_SpecialMax && !g_BoomerLimit && !g_HunterLimit && !g_SpitterLimit && !g_ChargerLimit && !g_SmokerLimit){
                    local _max = 0;
                    _max = vargv[1];
                    while(_max > 0){
                        switch(RandomInt(0,5)){
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
                }
                g_SpecialMax = vargv[1];
                //Utils.SayToAll("Success change all special limit!");
                break;
            case "boomer":
                g_BoomerLimit = vargv[1];
                g_SpecialMax += (vargv[1] - 2);
                //Utils.SayToAll("Success change " + specialname + " limit!");
                break;
            case "hunter":
                g_HunterLimit = vargv[1];
                g_SpecialMax += (vargv[1] - 2);
                //Utils.SayToAll("Success change " + specialname + " limit!");
                break;
            case "spitter":
                g_SpitterLimit = vargv[1];
                g_SpecialMax += (vargv[1] - 2);
                //Utils.SayToAll("Success change " + specialname + " limit!");
                break;
            case "charger":
                g_ChargerLimit = vargv[1];
                g_SpecialMax += (vargv[1] - 2);
                //Utils.SayToAll("Success change " + specialname + " limit!");
                break;
            case "jockey":
                g_JockeyLimit = vargv[1];
                g_SpecialMax += (vargv[1] - 2);
                //Utils.SayToAll("Success change " + specialname + " limit!");
                break;
            case "smoker":
                g_SmokerLimit = vargv[1];
                g_SpecialMax += (vargv[1] - 2);
                //Utils.SayToAll("Success change " + specialname + " limit!");
                break;
            case "common":
                g_CommonLimit = vargv[1];
                break;
            default:
                Utils.SayToAll("Wrong format!");
        }
    }
    else if(vargv[0] == "respawn"){
        if(specialname == "change"){
            g_SpecialInitialChange = vargv[1];
        }
        else if(specialname == "all"){
            g_SpecialInitial = vargv[1];
        }
        else{
            Utils.SayToAll("Wrong format!");
            return;
        }
        //Utils.SayToAll("Success change special respawn time!");
    }
    else{
        Utils.SayToAll("Wrong format!");
        return;
    }
}

function Update(){
    local SurvivorsCount = 0;
    SurvivorsCount = getSurvivorCount();
    if(g_BoomerLimit >= 0){
        DirectorOptions.BoomerLimit = g_BoomerLimit;
    }
    if(g_HunterLimit >= 0){
        DirectorOptions.HunterLimit = g_HunterLimit;
    }
    if(g_SpitterLimit >= 0){
        DirectorOptions.SpitterLimit = g_SpitterLimit;
    }
    if(g_ChargerLimit >= 0){
        DirectorOptions.ChargerLimit = g_ChargerLimit;
    }
    if(g_JockeyLimit >= 0){
        DirectorOptions.JockeyLimit = g_JockeyLimit;
    }
    if(g_SmokerLimit >= 0){
        DirectorOptions.SmokerLimit = g_SmokerLimit;
    }
    if(g_SpecialMax >= 0){
        local _max = 0;
        _max = DirectorOptions.BoomerLimit + DirectorOptions.HunterLimit + DirectorOptions.SpitterLimit + DirectorOptions.ChargerLimit + DirectorOptions.JockeyLimit + DirectorOptions.SmokerLimit;
        if(g_SpecialMax < 4){
            g_SpecialMax = 4;
        }
        if(g_SpecialMax > 24){
            g_SpecialMax = 24;
        }
        if(g_SpecialMax > _max){
            g_SpecialMax = _max;
        }
        DirectorOptions.cm_MaxSpecials = g_SpecialMax;
        if(g_SpecialMax > 12){
            DirectorOptions.DominatorLimit = 12;
        }
        else{
            DirectorOptions.DominatorLimit = g_SpecialMax;
        }
    }
    local _change = (SurvivorsCount-1) * g_SpecialInitialChange;
    local _time = _change + g_SpecialInitial;
    if(_time >= 0 ){
        if(_time < 8){
            _time = 8;
        }
        DirectorOptions.cm_SpecialRespawnInterval = _time;
        DirectorOptions.SpecialInitialSpawnDelayMax = _time + 3;
        DirectorOptions.SpecialInitialSpawnDelayMin = _time;
    }
    if(g_CommonLimit >= 0){
        if(g_CommonLimit == 0){
            DirectorOptions.cm_CommonLimit = 0;
            DirectorOptions.MobMinSize = 0;
            DirectorOptions.MobMaxSize = 0;
        }
        else if(g_CommonLimit > 250){
            DirectorOptions.cm_CommonLimit = 250;
            DirectorOptions.MobMinSize = 120;
            DirectorOptions.MobMaxSize = 150;
        }
        else if(g_CommonLimit < 20 && g_CommonLimit > 0){
            DirectorOptions.cm_CommonLimit = 20;
            DirectorOptions.MobMinSize = 10;
            DirectorOptions.MobMaxSize = 20;
        }
        else if(g_CommonLimit >= 20 && g_CommonLimit < 80){
            DirectorOptions.cm_CommonLimit = g_CommonLimit;
            DirectorOptions.MobMinSize = g_CommonLimit / 2 + 5;
            DirectorOptions.MobMaxSize = g_CommonLimit / 2 + 10;
        }
        else if(g_CommonLimit >= 80 && g_CommonLimit < 150){
            DirectorOptions.cm_CommonLimit = g_CommonLimit;
            DirectorOptions.MobMinSize = g_CommonLimit / 2;
            DirectorOptions.MobMaxSize = g_CommonLimit / 2 + 10;
        }
        else if(g_CommonLimit >= 150 && g_CommonLimit <= 250){
            DirectorOptions.cm_CommonLimit = g_CommonLimit;
            DirectorOptions.MobMinSize = 90;
            DirectorOptions.MobMaxSize = 120;
        }
    }
    g_GameInfo = "INFO : " + "[(" + g_SpecialMax + ") SI (" + _time + ")s respawn]";
}

::getSurvivorCount <- function(){
    local SurvivorsCount = 0;
	ClientIndex <- {};
	foreach(surmodel in ::survivors)
	{
		playerindex <- null;
		while ((playerindex = Entities.FindByModel(playerindex, surmodel)) != null)
		{
			if(playerindex.IsValid() && playerindex.IsPlayer() && !IsPlayerABot(playerindex))
			{
				ClientIndex[SurvivorsCount] <- playerindex.GetEntityIndex();
				SurvivorsCount++;
			}
		}
	}
    return SurvivorsCount;
}

function ChatTriggers::give(player, args, text){
    local arr = split(text, " ");
    local _name = player.GetName();
    giveSurvivorItem(_name, arr[1]);
}

::giveSurvivorItem <- function(playername, itemname){
	foreach(surmodel in ::survivors)
	{
		player <- Entities.FindByModel(null, surmodel)
        if(player){
			if(player.IsSurvivor()){
                local _hud = HUD.Item("\n{msg1}{playername}{msg2}\n");
                _hud.SetValue("msg1", "give");
                _hud.SetValue("playername", playername);
                _hud.SetValue("msg2", itemname);
                _hud.AttachTo(HUD_MID_BOX);
                _hud.ChangeHUDNative(0, 120, 350, 150, 1366, 720);
                _hud.SetTextPosition(TextAlign.Left);
                _hud.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK);
                Timers.AddTimer(6.0, false, CloseHud, _hud);
                if(player.GetPlayerName() == playername){
                    player.GiveItem(itemname);
                }

            }
        }
	}
}

function ChatTriggers::rank(player, args, text){
    local _hud = HUD.Item("\n{info}\n");
    _hud.SetValue("info", g_GameInfo);
    _hud.AttachTo(HUD_MID_BOX);
	_hud.ChangeHUDNative(0, 0, 350, 150, 1366, 720);
	_hud.SetTextPosition(TextAlign.Left);
	_hud.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK);
    Timers.AddTimer(6.0, false, CloseHud, _hud);
}

::CloseHud <- function(hud)
{
	hud.Detach();
}
