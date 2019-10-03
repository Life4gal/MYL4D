Msg("HUD脚本加载成功\n");
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

g_PZKill <- 0;  //该回合死亡的普感/特感数量
g_CZKill <- 0;

PZKill <- {};
CZKill <- {};
FFDmg <- {};
ShowInterval <- 10.0; //30s显示一次数据
ShowDuration <- 6.0;    //持续显示6秒
LastSet <- 0;

//Smoker = 1
//Boomer = 2
//Hunter = 3
//Spitter = 4
//Jockey = 5
//Charger = 6
//Witch = 7
//Tank = 8
//Survivor = 9
SmokerKill <- {};
BoomerKill <- {};
HunterKill <- {};
SpitterKill <- {};
JockeyKill <- {};
ChargerKill <- {};

//WitchKill <- {};
TankDmg <- {};

function OnGameEvent_player_death(params){
    local victim = null;    //受害者
    local attacker = null;  //击杀者
    local victiment = null; //受害者实体
    local attackerent = null;   //击杀者实体
    //其实可以不判断击杀者或者受害者,直接使用实体,但是这样容易出错,而且杀死小僵尸会报异常
    if(params.rawin("attacker")){   //参数中含有攻击者id
        attacker = params["attacker"];
        attackerent = GetPlayerFromUserID(attacker);
        if(attackerent && attackerent.IsSurvivor()){
            if(params.rawin("userid")){
                victim = params["userid"];
                victiment = GetPlayerFromUserID(victim);              
                if(victiment && victiment.GetZombieType() <= 6){   //成功获取id是特感
                    g_PZKill++;
                    if(!IsPlayerABot(attackerent)){
                        switch(victiment.GetZombieType()){
                            case 1:
                                SmokerKill[attackerent.GetEntityIndex()]++;
                                break;
                            case 2:
                                BoomerKill[attackerent.GetEntityIndex()]++;
                                break;
                            case 3:
                                HunterKill[attackerent.GetEntityIndex()]++;
                                break;
                            case 4:
                                SpitterKill[attackerent.GetEntityIndex()]++;
                                break;
                            case 5:
                                JockeyKill[attackerent.GetEntityIndex()]++;
                                break;
                            case 6:
                                ChargerKill[attackerent.GetEntityIndex()]++;
                                break;
                            default:
                                ;
                        }
                        PZKill[attackerent.GetEntityIndex()]++;
                    }
                }
            }
            else{
                CZKill[attackerent.GetEntityIndex()]++;
            }
            g_CZKill++;
        }
    }
}

function OnGameEvent_player_hurt(params){
    local victim = null;    //受害者
    local attacker = null;  //击杀者
    local victiment = null; //受害者实体
    local attackerent = null;   //击杀者实体
    local dmg = null;
    if(params.rawin("userid") && params.rawin("attacker")){
        victim = params["userid"];
        attacker = params["attacker"];
        victiment = GetPlayerFromUserID(victim);
        attackerent = GetPlayerFromUserID(attacker);
        if(victiment && attackerent && victiment.IsSurvivor()  && attackerent.IsSurvivor()){    //都是幸存者
            dmg = params["dmg_health"];
            if(dmg){    //有伤害
                FFDmg[attackerent.GetEntityIndex()] += dmg;
            }
        }
        if(victiment && victiment.GetZombieType() == 8){
            dmg = params["dmg_health"];
            if(dmg){
                TankDmg[attackerent.GetEntityIndex()] += dmg;
            }
        }
    }
}

function OnGameEvent_round_start(params){
    for(local i = 0; i < 32; i++){  //初始化
        PZKill[i] <- 0;
        CZKill[i] <- 0;
        FFDmg[i] <- 0;
        SmokerKill[i] <- 0;
        BoomerKill[i] <- 0;
        HunterKill[i] <- 0;
        SpitterKill[i] <- 0;
        JockeyKill[i] <- 0;
        ChargerKill[i] <- 0;
        TankDmg[i] <- 0;
    }
    g_CZKill <- 0;
    g_PZKill <- 0;
}

function OnGameEvent_player_team(params){
    local user = null;
    local disconnect = false;
    local player = null;
    if(params.rawin("userid")){
        user = params["userid"];
        player = GetPlayerFromUserID(user);
        disconnect = params["disconnect"];
        if(player && player.IsSurvivor() && !IsPlayerABot(player) && disconnect){
            PZKill[Player.GetEntityIndex()] = 0;
            CZKill[Player.GetEntityIndex()] = 0;
            FFDmg[Player.GetEntityIndex()] = 0;
            SmokerKill[Player.GetEntityIndex()] = 0;
            BoomerKill[Player.GetEntityIndex()] = 0;
            HunterKill[Player.GetEntityIndex()] = 0;
            SpitterKill[Player.GetEntityIndex()] = 0;
            JockeyKill[Player.GetEntityIndex()] = 0;
            ChargerKill[Player.GetEntityIndex()] = 0;
            TankDmg[player.GetEntityIndex()] = 0;
        }
    }
}

function Update(){
    index <- {};
    local _surcount = 0;
    foreach(surmodel in survivors) {
        playerindex <- null;
        while((playerindex = Entities.FindByModel(playerindex, surmodel)) != null){
            if(!IsPlayerABot(playerindex)){
                index[_surcount] <- playerindex.GetEntityIndex();
                _surcount++;
            }
        }
    }

    bubbleSort(index);  //冒泡排序   以杀特感数为排序基准
    if(Time() >= ShowInterval + LastSet){
        buildHUD(index);
        LastSet = Time();
    }
}

function bubbleSort(arr){ 
    for(local i = 0; i < arr.len() - 1; i++){
        for(local j = 0; j < arr.len() - 1; j++){
            if(PZKill[arr[j]] < PZKill[arr[j+1]]){
                local pz_tmp = arr[j+1];
                arr[j+1] = arr[j];
                arr[j] = pz_tmp;
            }
        }
    }
}

function buildHUD(arr){
    local count = getHumanCount(); 
    //type = 1 显示特感   type = 2 显示普感   type = 3 显示黑枪   type = 4 显示该回合僵尸死亡数量
    //一个字符串长度最大为255字符,超过需要加
    //打算显示各种类型特感击杀数,所以只显示第一,函数传入了当前玩家数的参数count,想修改可以根据count修改

    //  name(20char) smoker boomer hunter spitter jockey charger total common
    //Utils.SayToAll("smoker -> " + "烟鬼".len() + " boomer -> " + "胖子".len() + " hunter -> " + "猎人".len() + " spitter -> " + "口水".len() + " jockey -> " + "猴子".len() + " charger -> " + "牛".len() + " total -> " + "总击杀数".len() + " common -> " + "普感击杀".len() + "ff -> " + "黑枪".len());
    //smoker -> 6 boomer -> 6 hunter -> 6 spitter -> 6 jockey -> 6 charger -> 3 total -> 12 common -> 12ff -> 6
    ConstructHUD(null, 0);
    for(local i = 1; i <= count; i++){
        ConstructHUD(arr[i-1], i);
    }
}

function ConstructHUD(player_index, index){
    switch(index){
        case 0: //tittle
            local _hud_tittle = HUD.Item("\n{name}※{smoker}※{boomer}※{hunter}※{spitter}※{jockey}※{charger}※{total}※{common}※{ff}※{tank}※\n");
            local _name = extendLen("玩家", 20, false);
            _hud_tittle.SetValue("name", _name);
            _hud_tittle.SetValue("smoker", "舌头");
            _hud_tittle.SetValue("boomer", "胖子");
            _hud_tittle.SetValue("hunter", "猎人");
            _hud_tittle.SetValue("spitter", "口水");
            _hud_tittle.SetValue("jockey", "猴子");
            _hud_tittle.SetValue("charger", "牛");
            _hud_tittle.SetValue("total", "总击杀数");
            _hud_tittle.SetValue("common", "普感击杀");
            _hud_tittle.SetValue("ff", "黑枪");
            _hud_tittle.SetValue("tank", "坦克伤害");
            _hud_tittle.AttachTo(HUD_SCORE_TITLE);
            _hud_tittle.ChangeHUDNative(0, 0, 1500, 20, 1920, 1080);
            _hud_tittle.SetTextPosition(TextAlign.Right);
            _hud_tittle.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
            Timers.AddTimer(ShowDuration, false, CloseHud, _hud_tittle);    //持续一定时间关闭HUD防止挡视野
            break;
        case 1: //player1
            local _hud_player1 = HUD.Item("\n{name} {smoker} {boomer} {hunter} {spitter} {jockey} {charger} {total} {common} {ff} {tank}         \t\t\t\t\n");
            local _name_player1 = extendLen(PlayerInstanceFromIndex(player_index).GetPlayerName(), 19, true, 1);
            _hud_player1.SetValue("name", _name_player1);
            _hud_player1.SetValue("smoker", extendLen(SmokerKill[player_index], 6, true));
            _hud_player1.SetValue("boomer", extendLen(BoomerKill[player_index], 6, true));
            _hud_player1.SetValue("hunter", extendLen(HunterKill[player_index], 6, true));
            _hud_player1.SetValue("spitter", extendLen(SpitterKill[player_index], 6, true));
            _hud_player1.SetValue("jockey", extendLen(JockeyKill[player_index], 6, true));
            _hud_player1.SetValue("charger", extendLen(ChargerKill[player_index], 3, true));
            _hud_player1.SetValue("total", extendLen(PZKill[player_index], 12, true));
            _hud_player1.SetValue("common", extendLen(CZKill[player_index], 12, true));
            _hud_player1.SetValue("ff", extendLen(FFDmg[player_index], 6, true));
            _hud_player1.SetValue("tank", extendLen(TankDmg[player_index], 6, true));
            _hud_player1.AttachTo(HUD_SCORE_1);
            _hud_player1.ChangeHUDNative(0, 0, 1400, 40, 1920, 1080);
            _hud_player1.SetTextPosition(TextAlign.Right);
            _hud_player1.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
            Timers.AddTimer(ShowDuration, false, CloseHud, _hud_player1);    //持续一定时间关闭HUD防止挡视野
            break;
        case 2:
            local _hud_player2 = HUD.Item("\n{name} {smoker} {boomer} {hunter} {spitter} {jockey} {charger} {total} {common} {ff} {tank}         \t\t\t\t\n");
            local _name_player2 = extendLen(PlayerInstanceFromIndex(player_index).GetPlayerName(), 19, true, 1);
            _hud_player2.SetValue("name", _name_player2);
            _hud_player2.SetValue("smoker", extendLen(SmokerKill[player_index], 6, true));
            _hud_player2.SetValue("boomer", extendLen(BoomerKill[player_index], 6, true));
            _hud_player2.SetValue("hunter", extendLen(HunterKill[player_index], 6, true));
            _hud_player2.SetValue("spitter", extendLen(SpitterKill[player_index], 6, true));
            _hud_player2.SetValue("jockey", extendLen(JockeyKill[player_index], 6, true));
            _hud_player2.SetValue("charger", extendLen(ChargerKill[player_index], 3, true));
            _hud_player2.SetValue("total", extendLen(PZKill[player_index], 12, true));
            _hud_player2.SetValue("common", extendLen(CZKill[player_index], 12, true));
            _hud_player2.SetValue("ff", extendLen(FFDmg[player_index], 6, true));
            _hud_player2.SetValue("tank", extendLen(TankDmg[player_index], 6, true));
            _hud_player2.AttachTo(HUD_SCORE_2);
            _hud_player2.ChangeHUDNative(0, 0, 1400, 60, 1920, 1080);
            _hud_player2.SetTextPosition(TextAlign.Right);
            _hud_player2.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
            Timers.AddTimer(ShowDuration, false, CloseHud, _hud_player2);    //持续一定时间关闭HUD防止挡视野
            break;
        case 3: 
            local _hud_player3 = HUD.Item("\n{name} {smoker} {boomer} {hunter} {spitter} {jockey} {charger} {total} {common} {ff} {tank}         \t\t\t\t\n");
            local _name_player3 = extendLen(PlayerInstanceFromIndex(player_index).GetPlayerName(), 19, true, 1);
            _hud_player3.SetValue("name", _name_player3);
            _hud_player3.SetValue("smoker", extendLen(SmokerKill[player_index], 6, true));
            _hud_player3.SetValue("boomer", extendLen(BoomerKill[player_index], 6, true));
            _hud_player3.SetValue("hunter", extendLen(HunterKill[player_index], 6, true));
            _hud_player3.SetValue("spitter", extendLen(SpitterKill[player_index], 6, true));
            _hud_player3.SetValue("jockey", extendLen(JockeyKill[player_index], 6, true));
            _hud_player3.SetValue("charger", extendLen(ChargerKill[player_index], 3, true));
            _hud_player3.SetValue("total", extendLen(PZKill[player_index], 12, true));
            _hud_player3.SetValue("common", extendLen(CZKill[player_index], 12, true));
            _hud_player3.SetValue("ff", extendLen(FFDmg[player_index], 6, true));
            _hud_player3.SetValue("tank", extendLen(TankDmg[player_index], 6, true));
            _hud_player3.AttachTo(HUD_SCORE_3);
            _hud_player3.ChangeHUDNative(0, 0, 1400, 80, 1920, 1080);
            _hud_player3.SetTextPosition(TextAlign.Right);
            _hud_player3.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
            Timers.AddTimer(ShowDuration, false, CloseHud, _hud_player3);    //持续一定时间关闭HUD防止挡视野
            break;
        case 4:
            local _hud_player4 = HUD.Item("\n{name} {smoker} {boomer} {hunter} {spitter} {jockey} {charger} {total} {common} {ff} {tank}         \t\t\t\t\n");
            local _name_player4 = extendLen(PlayerInstanceFromIndex(player_index).GetPlayerName(), 19, true, 1);
            _hud_player4.SetValue("name", _name_player4);
            _hud_player4.SetValue("smoker", extendLen(SmokerKill[player_index], 6, true));
            _hud_player4.SetValue("boomer", extendLen(BoomerKill[player_index], 6, true));
            _hud_player4.SetValue("hunter", extendLen(HunterKill[player_index], 6, true));
            _hud_player4.SetValue("spitter", extendLen(SpitterKill[player_index], 6, true));
            _hud_player4.SetValue("jockey", extendLen(JockeyKill[player_index], 6, true));
            _hud_player4.SetValue("charger", extendLen(ChargerKill[player_index], 3, true));
            _hud_player4.SetValue("total", extendLen(PZKill[player_index], 12, true));
            _hud_player4.SetValue("common", extendLen(CZKill[player_index], 12, true));
            _hud_player4.SetValue("ff", extendLen(FFDmg[player_index], 6, true));
            _hud_player4.SetValue("tank", extendLen(TankDmg[player_index], 6, true));
            _hud_player4.AttachTo(HUD_SCORE_4);
            _hud_player4.ChangeHUDNative(0, 0, 1400, 100, 1920, 1080);
            _hud_player4.SetTextPosition(TextAlign.Right);
            _hud_player4.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
            Timers.AddTimer(ShowDuration, false, CloseHud, _hud_player4);    //持续一定时间关闭HUD防止挡视野
            break;
        case 5:
            local _hud_player5 = HUD.Item("\n{name} {smoker} {boomer} {hunter} {spitter} {jockey} {charger} {total} {common} {ff} {tank}         \t\t\t\t\n");
            local _name_player5 = extendLen(PlayerInstanceFromIndex(player_index).GetPlayerName(), 19, true, 1);
            _hud_player5.SetValue("name", _name_player5);
            _hud_player5.SetValue("smoker", extendLen(SmokerKill[player_index], 6, true));
            _hud_player5.SetValue("boomer", extendLen(BoomerKill[player_index], 6, true));
            _hud_player5.SetValue("hunter", extendLen(HunterKill[player_index], 6, true));
            _hud_player5.SetValue("spitter", extendLen(SpitterKill[player_index], 6, true));
            _hud_player5.SetValue("jockey", extendLen(JockeyKill[player_index], 6, true));
            _hud_player5.SetValue("charger", extendLen(ChargerKill[player_index], 3, true));
            _hud_player5.SetValue("total", extendLen(PZKill[player_index], 12, true));
            _hud_player5.SetValue("common", extendLen(CZKill[player_index], 12, true));
            _hud_player5.SetValue("ff", extendLen(FFDmg[player_index], 6, true));
            _hud_player5.SetValue("tank", extendLen(TankDmg[player_index], 6, true));
            _hud_player5.AttachTo(HUD_FAR_LEFT);
            _hud_player5.ChangeHUDNative(0, 0, 1400, 120, 1920, 1080);
            _hud_player5.SetTextPosition(TextAlign.Right);
            _hud_player5.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
            Timers.AddTimer(ShowDuration, false, CloseHud, _hud_player5);    //持续一定时间关闭HUD防止挡视野
            break;
        case 6:
            local _hud_player6 = HUD.Item("\n{name} {smoker} {boomer} {hunter} {spitter} {jockey} {charger} {total} {common} {ff} {tank}         \t\t\t\t\n");
            local _name_player6 = extendLen(PlayerInstanceFromIndex(player_index).GetPlayerName(), 19, true, 1);
            _hud_player6.SetValue("name", _name_player6);
            _hud_player6.SetValue("smoker", extendLen(SmokerKill[player_index], 6, true));
            _hud_player6.SetValue("boomer", extendLen(BoomerKill[player_index], 6, true));
            _hud_player6.SetValue("hunter", extendLen(HunterKill[player_index], 6, true));
            _hud_player6.SetValue("spitter", extendLen(SpitterKill[player_index], 6, true));
            _hud_player6.SetValue("jockey", extendLen(JockeyKill[player_index], 6, true));
            _hud_player6.SetValue("charger", extendLen(ChargerKill[player_index], 3, true));
            _hud_player6.SetValue("total", extendLen(PZKill[player_index], 12, true));
            _hud_player6.SetValue("common", extendLen(CZKill[player_index], 12, true));
            _hud_player6.SetValue("ff", extendLen(FFDmg[player_index], 6, true));
            _hud_player6.SetValue("tank", extendLen(TankDmg[player_index], 6, true));
            _hud_player6.AttachTo(HUD_LEFT_TOP);
            _hud_player6.ChangeHUDNative(0, 0, 1400, 140, 1920, 1080);
            _hud_player6.SetTextPosition(TextAlign.Right);
            _hud_player6.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
            Timers.AddTimer(ShowDuration, false, CloseHud, _hud_player6);    //持续一定时间关闭HUD防止挡视野
            break;
        case 7:
            local _hud_player7 = HUD.Item("\n{name} {smoker} {boomer} {hunter} {spitter} {jockey} {charger} {total} {common} {ff} {tank}         \t\t\t\t\n");
            local _name_player7 = extendLen(PlayerInstanceFromIndex(player_index).GetPlayerName(), 19, true, 1);
            _hud_player7.SetValue("name", _name_player7);
            _hud_player7.SetValue("smoker", extendLen(SmokerKill[player_index], 6, true));
            _hud_player7.SetValue("boomer", extendLen(BoomerKill[player_index], 6, true));
            _hud_player7.SetValue("hunter", extendLen(HunterKill[player_index], 6, true));
            _hud_player7.SetValue("spitter", extendLen(SpitterKill[player_index], 6, true));
            _hud_player7.SetValue("jockey", extendLen(JockeyKill[player_index], 6, true));
            _hud_player7.SetValue("charger", extendLen(ChargerKill[player_index], 3, true));
            _hud_player7.SetValue("total", extendLen(PZKill[player_index], 12, true));
            _hud_player7.SetValue("common", extendLen(CZKill[player_index], 12, true));
            _hud_player7.SetValue("ff", extendLen(FFDmg[player_index], 6, true));
            _hud_player7.SetValue("tank", extendLen(TankDmg[player_index], 6, true));
            _hud_player7.AttachTo(HUD_LEFT_BOT);
            _hud_player7.ChangeHUDNative(0, 0, 1400, 160, 1920, 1080);
            _hud_player7.SetTextPosition(TextAlign.Right);
            _hud_player7.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
            Timers.AddTimer(ShowDuration, false, CloseHud, _hud_player7);    //持续一定时间关闭HUD防止挡视野
            break;
        case 8:
            local _hud_player8 = HUD.Item("\n{name} {smoker} {boomer} {hunter} {spitter} {jockey} {charger} {total} {common} {ff} {tank}         \t\t\t\t\n");
            local _name_player8 = extendLen(PlayerInstanceFromIndex(player_index).GetPlayerName(), 19, true, 1);
            _hud_player8.SetValue("name", _name_player8);
            _hud_player8.SetValue("smoker", extendLen(SmokerKill[player_index], 6, true));
            _hud_player8.SetValue("boomer", extendLen(BoomerKill[player_index], 6, true));
            _hud_player8.SetValue("hunter", extendLen(HunterKill[player_index], 6, true));
            _hud_player8.SetValue("spitter", extendLen(SpitterKill[player_index], 6, true));
            _hud_player8.SetValue("jockey", extendLen(JockeyKill[player_index], 6, true));
            _hud_player8.SetValue("charger", extendLen(ChargerKill[player_index], 3, true));
            _hud_player8.SetValue("total", extendLen(PZKill[player_index], 12, true));
            _hud_player8.SetValue("common", extendLen(CZKill[player_index], 12, true));
            _hud_player8.SetValue("ff", extendLen(FFDmg[player_index], 6, true));
            _hud_player8.SetValue("tank", extendLen(TankDmg[player_index], 6, true));
            _hud_player8.AttachTo(HUD_TICKER);
            _hud_player8.ChangeHUDNative(0, 0, 1400, 180, 1920, 1080);
            _hud_player8.SetTextPosition(TextAlign.Right);
            _hud_player8.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
            Timers.AddTimer(ShowDuration, false, CloseHud, _hud_player8);    //持续一定时间关闭HUD防止挡视野
            break;
        default:
            ;
    }
    local _hud_d = HUD.Item("\n{tittle}\n{pz}\n{cz}\n");
    _hud_d.SetValue("tittle", "本关阵亡的僵尸数(●ˇ∀ˇ●)");
    _hud_d.SetValue("pz", "特感死亡数:" + g_PZKill);
    _hud_d.SetValue("cz", "普感死亡数:" + g_CZKill);
    _hud_d.AttachTo(HUD_MID_BOT);
    _hud_d.ChangeHUDNative(800, 650, 350, 450, 1920, 1080);
    _hud_d.SetTextPosition(TextAlign.Center);
    _hud_d.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
    Timers.AddTimer(ShowDuration, false, CloseHud, _hud_d);    //持续一定时间关闭HUD防止挡视野

    HUDPlace(HUD_SCORE_TITLE, 0.1, 0.01, 0.7, 0.1);
    HUDPlace(HUD_SCORE_1, 0.1, 0.06, 0.7, 0.1);
    HUDPlace(HUD_SCORE_2, 0.1, 0.11, 0.7, 0.1);
    HUDPlace(HUD_SCORE_3, 0.1, 0.16, 0.7, 0.1);
    HUDPlace(HUD_SCORE_4, 0.1, 0.21, 0.7, 0.1);
    HUDPlace(HUD_FAR_LEFT, 0.1, 0.26, 0.7, 0.1);
    HUDPlace(HUD_LEFT_TOP, 0.1, 0.31, 0.7, 0.1);
    HUDPlace(HUD_LEFT_BOT, 0.1, 0.36, 0.7, 0.1);
    HUDPlace(HUD_TICKER, 0.1, 0.41, 0.7, 0.1);
    HUDPlace(HUD_MID_BOT, 0.6, 0.85, 0.4, 0.17);
}

function CloseHud(hud){
    hud.Detach();
}

function getHumanCount(){
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

function extendLen(_str, tolen, right, ...){
    local l = _str.tostring().len();
    if(right){
        if(l != tolen){
            if(vargv.len() > 0){
                if(l > tolen){
                    _str = _str.slice(0, tolen+1);
                }
                else{
                    for(local i = tolen - l; i >= 1; i--){
                        //_str = " " + _str;
                        _str += " ";
                    } 
                }
            }
            else{
                if(l > tolen){
                    _str = _str.slice(0, tolen+1);
                }
                else{
                    for(local i = tolen - l; i >= -1; i--){
                        _str = " " + _str;
                    } 
                }
            }
        }
    }
    else{
        if(l != tolen){
            if(l > tolen){
                _str = _str.slice(0, tolen+1);
            }
            else{
                for(local i = tolen - l; i >= 0; i--){
                    _str += " ";
                }              
            }
        }
    }
    return _str;
}