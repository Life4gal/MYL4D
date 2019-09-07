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
	//Utils.PrecacheCSSWeapons();
	Utils.PrecacheSurvivors();
}

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
}

/*
default:
    boomer = 2,
    hunter = 2,
    spitter = 2,
    charger = 2,
    jockey = 2,
    smoker = 2,
    specialmax = 8,
    specialinitial = 25,
    specialinitialchange = 0
*/

::g_BoomerLimit <- 2;
::g_HunterLimit <- 2;
::g_SpitterLimit <- 2;
::g_ChargerLimit <- 2;
::g_JockeyLimit <- 2;
::g_SmokerLimit <- 2;
::g_SpecialMax <- 8;
::g_SpecialInitial <- 25;
::g_SpecialInitialChange <- 0;

function ChatTriggers::special(player, args, text){
    local arr = split(text, " ");
    if(arr.len() != 4){
        Utils.SayToAll("Format: '!special specialname agr1 arg2'\n" + "For example: input '!special hunter limit 2' to change hunter limit to 2\n" + "Or : input '!spcial all respawn 20' to change special respawn time to 20s");
        Utils.SayToAll("input '!special change respawn 3/-3' to make speical respawn time change 3/-3s per human survivor(not include bot, if only 1 human player we use base respawn time)");
        Utils.SayToAll("You can use 'all' replace 'specialname' so you change all special.\n" + "All special name: boomer,hunter,spitter,charger,jockey,smoker");
    }
    else{
        changeDirectorOptions(arr[1], arr[2], arr[3]);
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
    if(g_SpecialInitial >= 0 ){
        local _change = (SurvivorsCount-1) * g_SpecialInitialChange;
        local _time = _change + g_SpecialInitial;
        if(_time < 8){
            _time = 8;
        }
        DirectorOptions.cm_SpecialRespawnInterval = _time;
        DirectorOptions.SpecialInitialSpawnDelayMax = _time + 3;
        DirectorOptions.SpecialInitialSpawnDelayMin = _time;
    }
}
