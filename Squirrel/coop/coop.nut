/*
到底是将脚本的结构按照功能划分呢,函数按照模块划分呢？
这个问题提我想了很久.
起初是像按照功能划分的,即表层函数与实际实现函数分开,但是这么做就会出现一个问题,如果你需要修改实现函数你需要慢慢往下翻找.
个人感觉非常麻烦,所以最后决定尽可能的按照模块划分,即按照功能将函数分区,通用的函数尽量放在最下方.
*/

Msg("Script power by 無くなった雪\n");
IncludeScript("VSLib");

function Precache() //缓存一二代人物模型以及CS武器模型,防止出错
{
	Utils.PrecacheCSSWeapons();
	Utils.PrecacheSurvivors();
}

//===========导演系统============
DirectorOptions <-  //导演系统选项,如果后需要修改某些内容则必须在修改之前定义
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
	MobMaxSize = 25
}

//==========有关管理员的功能===============================================================
//====================================================================================================================
//====================================================================================================================

::admin_canUseSpecial <- true;
::admin_canUseCommon <- true;
::admin_canUseSet <- true;
::admin_canUseGive <- true;
::admin_canUseChange <- true;

::admins <-{
    admin_root = "無くなった雪"
}
::adminIndex <- 1;

::isAdmin <- function(name){
    local f = false;
    foreach(key, val in admins){
        if(name == val){
            f = true;
        }
    }
    return f;
}

function ChatTriggers::adminset(player, args, text){
    if(isAdmin(player.GetName())){
        //管理员设置功能
        local arr = split(text, " ");
        if(arr.len() > 1){
            if(arr[1] == "special"){
                admin_canUseSpecial = !admin_canUseSpecial;
                ::VSLib.Utils.ShowHintSurvivors("管理员已调控特感控制功能", 3.0, "icon_alert", "", "150, 150, 150");
            }
            else if(arr[1] == "common"){
                admin_canUseCommon = !admin_canUseCommon;
                ::VSLib.Utils.ShowHintSurvivors("管理员已调控普感控制功能", 3.0, "icon_alert", "", "150, 150, 150");
            }
            else if(arr[1] == "set"){
                admin_canUseSet = !admin_canUseSet;
                ::VSLib.Utils.ShowHintSurvivors("管理员已调控参数控制功能", 3.0, "icon_alert", "", "150, 150, 150");
            }
            else if(arr[1] == "give"){
                admin_canUseGive = !admin_canUseGive;
                ::VSLib.Utils.ShowHintSurvivors("管理员已调控作弊功能", 3.0, "icon_alert", "", "150, 150, 150");
            }
            else if(arr[1] == "change"){
                admin_canUseChange = !admin_canUseChange;
                ::VSLib.Utils.ShowHintSurvivors("管理员已调控武器切换功能", 3.0, "icon_alert", "", "150, 150, 150");
            }
        }
        else{
            player.ShowHint("请输入需要改动的功能!", 3.0, "icon_tip", "", "200 50 50");
        }   
    }
    else{
        //提示权限不足
        player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
    }
}

function ChatTriggers::printadmin(player, args, text){
    RestoreTable("admins", admins);
    Utils.SayToAll("|正在载入管理员名单|");
    foreach(key, val in admins){
        Utils.SayToAll("|管理员 : " + val + "|");
    }
}

function ChatTriggers::regadmin(player, args, text){
    if(isAdmin(player.GetName())){
        local arr = split(text, " ");
        if(arr.len() > 1){
            local _name = arr[1];
            if(!isAdmin(_name)){
                player.ShowHint("管理员注册成功!", 3.0, "icon_tip", "", "200 50 50");
                admins[adminIndex++] <- _name;
                SaveTable("admins", admins);
            }
            else{
                player.ShowHint("已经是管理员了!", 3.0, "icon_alert", "", "200 50 50");
            }
        }
        else{
            player.ShowHint("请输入需注册的名称!", 3.0, "icon_alert", "", "200 50 50");
        }
    }
    else{
        player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
    }
}

//==========有关设置特感/普感数量以及设置特感复活时间的功能===============================================================
//====================================================================================================================
//====================================================================================================================
//============特感信息=============
::g_BoomerLimit <- 2;
::g_HunterLimit <- 2;
::g_SpitterLimit <- 2;
::g_ChargerLimit <- 2;
::g_JockeyLimit <- 2;
::g_SmokerLimit <- 2;
::g_SpecialMax <- 8;
::g_SpecialInitial <- 25;

//=============普感信息============
::g_CommonLimit <- 30;

//===============设置指令触发器==============

//这里传过来的text一般形式为    玩家姓名: 内容  注意:冒号的中英文不同,默认只有英文判断(英文冒号加空格),需要在easylogic中加入中文冒号的判断(防止出错),中文只有冒号,无空格

//特感
function ChatTriggers::special(player, args, text){
    if(!admin_canUseSpecial && !isAdmin(player.GetName())){
        player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }
    local arr = split(text, " ");   //以空格分隔指令,这样arr[0]即为需要舍去的玩家名+冒号部分,玩家名通过player获取
    /*
    特感的指令有三种,第一种为修改特感总量,第二种为修改某种特感量,第三种为修改特感复活时间
    !special limit 8    长度为3
    !special respawn 20 长度为3
    !special limit hunter 8 长度为4
    */
    if(arr.len() == 3){
        //如果为修改总量
        changeDirectorOptions("special", player.GetName(), arr[1].tolower(), arr[2].tointeger());
        //加入"special"标识是需要修改特感,如此函数便可与普感通用
    }
    else if(arr.len() == 4){
        //修改为某种
        changeDirectorOptions("special", player.GetName(), arr[1].tolower(), arr[2].tolower(), arr[3].tointeger());
    }
    else{
        //如果都不是则提示错误
        player.ShowHint("输入参数错误!", 3.0, "icon_alert", "", "200 50 50");
    }
}

//普感
function ChatTriggers::common(player, args, text){
    if(!admin_canUseCommon && !isAdmin(player.GetName())){
        player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }
    local arr = split(text, " ");
    /*
    普感的指令目前只有一种
    !common limit 30
    */
    if(arr.len() == 3){
        changeDirectorOptions("common", player.GetName(), arr[1].tolower(), arr[2].tointeger());
    }
    else{
        player.ShowHint("输入参数错误!", 3.0, "icon_alert", "", "200 50 50");
    }
}

//=============changeDirectorOptions================

//如果一个函数使用...作为参数表示该函数参数接收量是可变的,当有超过已命名参数的参数传入是,会调用隐式数组vargv来接收这些参数
//这种写法与function的写法作用相同,写法不同仅作区分功能
::changeDirectorOptions <- function(zombieType, playername, ...){
    if(zombieType == "special"){
        //如果是修改特感参数
        if(vargv.len() == 2){
            //修改全部特感,此时vargv[0]应该为 limit/respawn
            if(vargv[0] == "limit" || vargv[0] == "数量"){  //支持中文输入
                if(vargv[1] > (32 - g_SurvivorCount)){  
                    //最大插槽为32,特感插槽与幸存者插槽相加不应该超过32
                    vargv[1] = 32 - g_SurvivorCount;
                }
                else if(vargv[1] < 0){
                    //输入应合法
                    vargv[1] = 0;
                }
                if(vargv[1] == 0){
                    //设置为0即为无特感
                    g_BoomerLimit = 0;
                    g_ChargerLimit = 0;
                    g_HunterLimit = 0;
                    g_JockeyLimit = 0;
                    g_SmokerLimit = 0
                    g_SpitterLimit = 0;
                    g_SpecialMax = 0;
                    buildHUD("special_limit", playername, vargv[1]);  //显示有人修改了特感数量
                    return; //直接结束函数
                }
                if(g_SpecialMax < vargv[1]){    //如果设置的特感数量超过原来的量
                    //给予补偿
                    local n = vargv[1] - g_SpecialMax;  //获取差值
                    while(n-- > 0){
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
                    }
                    g_SpecialMax = vargv[1];
                    buildHUD("special_limit", playername, vargv[1]);
                    return;
                }
                if(g_SpecialMax > vargv[1]){    //如果设置的特感数量低于原来的量
                    local n = g_SpecialMax - vargv[1];
                    while(n > 0){
                        switch(RandomInt(0, 5)){
                            case 0:
								if(g_BoomerLimit >= 1){
									g_BoomerLimit--;
									n--;    //只有成功减少特感量才减小差值
								}
								break;
							case 1:
								if(g_ChargerLimit >= 1){
									g_ChargerLimit--;
									n--;
								}
								break;
							case 2:
								if(g_HunterLimit >= 1){
									g_HunterLimit--;
									n--;
								}
								break;
							case 3:
								if(g_JockeyLimit >= 1){
									g_JockeyLimit--;
									n--;
								}
								break;
							case 4:
								if(g_SmokerLimit >= 1){
									g_SmokerLimit--;
									n--;
								}
								break;
							case 5:
								if(g_SpitterLimit >= 1){
									g_SpitterLimit--;
									n--;
								}
								break;
							default:
								;
                        }
                    }
                    g_SpecialMax = vargv[1];
                    buildHUD("special_limit", playername, vargv[1]);
                    return;
                }
            }
            else if(vargv[0] == "respawn" || vargv[0] == "重生" || vargv[0] == "复活"){
                if(vargv[1] < 1){
                    vargv[1] = 1;
                    //不宜小于1秒
                }
                g_SpecialInitial = vargv[1];
                buildHUD("special_respawn", playername, vargv[1]);
                return;
            }
            else{
                buildHUD("special_arg_error", null);
                return;
            }
        }
        else if(vargv.len() == 3){
            //修改某种特感,此时vargv[0]应该为 limit 且vargv[1]为某种特感名字
            if(vargv[0] == "limit" || vargv[0] == "数量"){
                if(vargv[2] < 0){
                    vargv[2] = 0;
                }
                if(vargv[2] > (32 - g_SurvivorCount - g_SpecialMax)){   //如果数量超过剩余插槽数量
                    vargv[2] = 32 - g_SurvivorCount - g_SpecialMax;
                }
                switch(vargv[1]){
                    case "胖子":
					case "boomer":
                        g_SpecialMax += (vargv[2] - g_BoomerLimit); //先减去原来的量,这样数量不会出错
						g_BoomerLimit = vargv[2];
						break;
					case "猎人":
					case "hunter":
                    	g_SpecialMax += (vargv[2] - g_HunterLimit);
						g_HunterLimit = vargv[2];
						break;
					case "口水":
					case "spitter":
                        g_SpecialMax += (vargv[2] - g_SpitterLimit);
						g_SpitterLimit = vargv[2];
						break;
					case "牛":
					case "charger":
                        g_SpecialMax += (vargv[2] - g_ChargerLimit);
						g_ChargerLimit = vargv[2];
						break;
					case "猴子":
					case "jockey":
                        g_SpecialMax += (vargv[2] - g_JockeyLimit);
						g_JockeyLimit = vargv[2];
						break;
					case "烟鬼":
                    case "舌头":
					case "smoker":
                        g_SpecialMax += (vargv[2] - g_SmokerLimit);
						g_SmokerLimit = vargv[2];	
						break;
					default:
						//如果不是特感的名字应该直接输出错误信息
                        buildHUD("special_arg_error", null);
                        return;
                }
                buildHUD("special_limit_name", playername, vargv[1], vargv[2]);
                return;
            }
            buildHUD("special_arg_error");
            return;
        }
    }
    else if(zombieType == "common"){
        if(vargv.len() == 2){
            if(vargv[0] == "limit" || vargv[0] == "数量"){
                if(vargv[1] < 0){
                    vargv[1] = 0;
                }
                else if(vargv[1] > 250){    //普感数量不宜超过250只
                    vargv[1] = 250;
                }
                g_CommonLimit = vargv[1];
                buildHUD("common_limit", playername, vargv[1]);
                return;
            }
        }
        buildHUD("common_arg_error", null);
        return;
    }
}

//实际修改需要在Update中修改,因为只有在哪里才能实际访问到导演系统参数

//设置特感普感配置功能结束
//====================================================================================================================

//==========有关一些全局的信息以及一些幸存者的信息显示===============================================================
//====================================================================================================================
//====================================================================================================================

//=============有关幸存者的参数===============
::g_HumanCount <- 0;    //人类玩家数量
::g_SurvivorCount <- 0; //总幸存者数量
::playerTable <- {};  //储存人类玩家表

::PZKill <- {};
::CZKill <- {};
::FFDmg <- {};
::ShowInterval <- 60.0; //60s显示一次数据
::ShowDuration <- 6.0;    //持续显示6秒
::LastSet <- 0;

//Smoker = 1
//Boomer = 2
//Hunter = 3
//Spitter = 4
//Jockey = 5
//Charger = 6
//Witch = 7
//Tank = 8
//Survivor = 9
::SmokerKill <- {};
::BoomerKill <- {};
::HunterKill <- {};
::SpitterKill <- {};
::JockeyKill <- {};
::ChargerKill <- {};

//WitchKill <- {};
::TankDmg <- {};

//=============有关特感/普感的参数==============

//========特感/普感信息(包括数量和复活时间)===========
::g_SpecialInfo <- "";
::g_CommonInfo <- "";
::g_GameMode <- ""; //游戏信息

::g_PZKill <- 0;  //该回合死亡的普感/特感数量
::g_CZKill <- 0;

//==========游戏参数设置===============
::g_setSupply <- 1; //一倍补给
::g_setAmmo <- 1;   //一倍后备子弹
::g_setMaxHealth <- 100;    //最大100血

//击杀特感/普感
function Notifications::OnDeath::PlayerDeath(victim, attacker, params){ //获取的是实体而不是实例
    if(!victim || !attacker || attacker.GetTeam() != 2)    return;
    switch(victim.GetClassname()){
        case "infected":
            //普感
            CZKill[attacker.GetIndex()]++;
            ::g_CZKill++;   //使用这个函数有问题,需要申明这是全局变量,不然离开函数后该值的修改无效
            break;
        case "player":
            //特感
            PZKill[attacker.GetIndex()]++;
            ::g_PZKill++;
            switch(victim.GetPlayerType()){
                case 1:
                    SmokerKill[attacker.GetIndex()]++;
                    break;
                case 2:
                    BoomerKill[attacker.GetIndex()]++;
                    break;
                case 3:
                    HunterKill[attacker.GetIndex()]++;
                    break;
                case 4:
                    SpitterKill[attacker.GetIndex()]++;
                    break;
                case 5:
                    JockeyKill[attacker.GetIndex()]++;
                    break;
                case 6:
                    ChargerKill[attacker.GetIndex()]++;
                    break;
                default:
                    ;
            }
            break;
        case "witch":
            //以后也许有用
            break;
    }
}

::g_BoomerHealth <- Convars.GetFloat("z_exploding_health"); //50    
::g_SmokerHealth <- Convars.GetFloat("z_gas_health");       //250
::g_ChargerHealth <- Convars.GetFloat("z_charger_health");  //600
::g_HunterHealth <- Convars.GetFloat("z_hunter_health");    //250
::g_SpitterHealth <- Convars.GetFloat("z_spitter_health");  //100
::g_JockeyHealth <- Convars.GetFloat("z_jockey_health");    //325
::g_TankHealth <- Convars.GetFloat("z_tank_health");        
::g_WitchHealth <- Convars.GetFloat("z_witch_health");      

//造成伤害
function Notifications::OnHurt::PlayerHurt(victim, attacker, params){
    if(!attacker || !victim || attacker.GetTeam() != 2)    return;
    switch(victim.GetClassname()){
        case "infected":
            //普感不理会
            return;
        case "player":
            if(attacker.GetTeam() == victim.GetTeam() && victim.GetIndex() != attacker.GetIndex()){ // && attacker.IsHuman() && victim.IsHuman()
                FFDmg[attacker.GetIndex()] += params["dmg_health"];
            }
            else if(victim.GetPlayerType() == 8){
                TankDmg[attacker.GetIndex()] += params["dmg_health"];
            }
            //加入一个显示特感血量的标识条
            local _hp = victim.GetHealth() / 10;
            local _type = victim.GetPlayerType();
            if(_type <= 8){
                //本来是使用local bar = ::VSLib.Utils.BuildProgressBar(40, _hp, Convars.GetFloat("z_" + victim.GetZombieName().tolower() + "_health"), "#", "_");
                //但是有几个特感有差别,所以还不如switch
                local bar = ""
                switch(_type){
                    case 1:
                    bar = ::VSLib.Utils.BuildProgressBar(40, _hp, g_SmokerHealth / 10, "#", "_");
                    break;
                case 2:
                    bar = ::VSLib.Utils.BuildProgressBar(40, _hp, g_BoomerHealth / 10, "#", "_");
                    break;
                case 3:
                    bar = ::VSLib.Utils.BuildProgressBar(40, _hp, g_HunterHealth / 10, "#", "_");
                    break;
                case 4:
                    bar = ::VSLib.Utils.BuildProgressBar(40, _hp, g_SpitterHealth / 10, "#", "_");
                    break;
                case 5:
                    bar = ::VSLib.Utils.BuildProgressBar(40, _hp, g_JockeyHealth / 10, "#", "_");
                    break;
                case 6:
                    bar = ::VSLib.Utils.BuildProgressBar(40, _hp, g_ChargerHealth / 10, "#", "_");
                    break; 
                case 8:
                    bar = ::VSLib.Utils.BuildProgressBar(40, _hp, g_TankHealth / 10, "#", "_");
                    break;
                default:
                    ;
                }
                //问题来了,我把要他显示在哪里呢？
                //尝试着放在Hint里面,但是Hint有个问题,可能会一直叠加,因为不会挤占之前Hint的位置
                //弃用,会一直叠加,需要找个别的地方
                //attacker.ShowHint(bar, 2.0, "icon_info", "", "200 50 50");
                //::VSLib.Utils.SetEntityHint(victim, bar, "icon_alert", 0, false, 0.1);//难顶,暂时弃用
            }
            break;
        case "witch":
            local _hp = victim.GetHealth();
            local bar = ::VSLib.Utils.BuildProgressBar(40, _hp, g_WitchHealth / 10, "#", "_");
            //弃用,会一直叠加,需要找个别的地方
            //attacker.ShowHint(bar, 2.0, "icon_info", "", "200 50 50");
            //::VSLib.Utils.SetEntityHint(victim, bar, "icon_alert", 0, false, 0.1);
            break;
        default:
            ;
    }
}

//回合开始初始化数据
function Notifications::OnRoundStart::RoundStart(){
    for(local i = 0; i < 32; i++){  //初始化,其实不初始化也可以,因为每次过关脚本都会重载,不过好像团灭不会重载,所以加上
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
    ::g_CZKill <- 0;
    ::g_PZKill <- 0;
    //重置ConVars
    clearConVars();
}

//玩家加入
function Notifications::OnPlayerConnected::PlayerConnect(player, params){
    //显示玩家加入
    Utils.SayToAll("|玩家 " + player.GetName() + " 已连接|");
}

//玩家离开
function Notifications::OnPlayerLeft::PlayerLeft(player, name, steamid, params){
    //显示玩家离开 
    if(player.GetTeam() == 2 && player.GetClassname() == "player"){
        Utils.SayToAll("|玩家 " + name + " 已离开|");
    }  
}

function Notifications::OnTeamChanged::PlayerTeam(player, oldteam, newteam, params){
    if(oldteam == 1 && newteam == 2 && player.GetClassname() == "player"){
        //本来是在玩家离开后清空的,但是获取不到index,所以加入清空,效果一样
        Timers.AddTimer(1.0, false, clearPlyayerInfo, player);
        //不延时获取不到index
    }
}

::clearPlyayerInfo <- function(player){
    PZKill[Player.GetIndex()] = 0;
    CZKill[Player.GetIndex()] = 0;
    FFDmg[Player.GetIndex()] = 0;
    SmokerKill[Player.GetIndex()] = 0;
    BoomerKill[Player.GetIndex()] = 0;
    HunterKill[Player.GetIndex()] = 0;
    SpitterKill[Player.GetIndex()] = 0;
    JockeyKill[Player.GetIndex()] = 0;
    ChargerKill[Player.GetIndex()] = 0;
    TankDmg[player.GetIndex()] = 0;
}

//显示信息功能结束
//====================================================================================================================

//==========有关作弊指令===============================================================
//====================================================================================================================
//====================================================================================================================

//作弊指令
function ChatTriggers::give(player, args, text){
    if(!admin_canUseGive && !isAdmin(player.GetName())){
        player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }
    local arr = split(text, " ");
    /*
    作弊指令有两种
    !give item  给自己item
    !give item all  给所有人item
    */
    if(arr.len() == 2){
        giveSurvivorItem(player, itemNameAssociation(arr[1]), false);
        //给物品添加联想,使其更容易使用,false表示只给予自己
    }
    else if(arr.len() == 3){
        giveSurvivorItem(player, itemNameAssociation(arr[1]), true);
    }
    else{
        player.ShowHint("输入参数错误!", 3.0, "icon_alert", "", "200 50 50");
    }
}

//====================giveSurvivorItem============================

::giveSurvivorItem <- function(player, itemname, giveall){
    if(!giveall){
        //player.GetInstance().GiveItem(itemname);
        player.Give(itemname);
    }
    else{
        foreach(alive in ::VSLib.EasyLogic.Players.AliveSurvivors()){
            //alive.GetInstance().GiveItem(itemname);
            alive.Give(itemname);
        }
    }
}

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

//作弊功能结束
//====================================================================================================================

//==========有关设置参数指令===============================================================
//====================================================================================================================
//====================================================================================================================

::clearConVars <- function(){   //重置Convars,这个是回合重置自己调用的,但是按照功能应该放在这里
    Convars.SetValue("ammo_assaultrifle_max", "360");
    Convars.SetValue("ammo_autoshotgun_max", "90");
    Convars.SetValue("ammo_grenadelauncher_max", "30");
    Convars.SetValue("ammo_huntingrifle_max", "150");
    Convars.SetValue("ammo_minigun_max", "800");
    Convars.SetValue("ammo_shotgun_max", "56");
    Convars.SetValue("ammo_smg_max", "650");
    Convars.SetValue("ammo_sniperrifle_max", "180");
    Convars.SetValue("survivor_limp_health", "40");
    Convars.SetValue("survivor_revive_health", "1");
    Convars.SetValue("first_aid_kit_max_heal", "100");  //医疗包可以恢复的最大血量
    Convars.SetValue("pain_pills_health_threshold", "99");  //药丸可以使用的最小生命值
    Convars.SetValue("pain_pills_health_value", "50");  //药丸给予的临时血量
    Convars.SetValue("z_survivor_respawn_health", "50");  //复活的人的血量
    Convars.SetValue("adrenaline_health_buffer", "25"); 
    Convars.SetValue("sb_toughness_buffer", "15");
}

//游戏参数
function ChatTriggers::set(player, args, text){
    if(admin_canUseSet && !isAdmin(player.GetName())){
        player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }
    //待开发,参数改变是否需要投票？如何实现？
    //!set supply 2 设置两倍补给
    //!set ammo 2   设置两倍后备子弹
    //!set health 200   设置最大生命值
    local arr = split(text, " ");
    if(arr.len() == 3){
        if(arr[1] == "补给" || arr[1].tolower() == "supply"){
            setSupply(arr[2].tointeger());
        }
        else if(arr[1] == "子弹" || arr[1].tolower() == "ammo"){
            setAmmo(arr[2].tointeger());
        }
        else if(arr[1] == "血量" || arr[1].tolower() == "health" || arr[1].tolower() == "hp"){
            setHealth(arr[2].tointeger());
        }
    }
}

::setSupply <- function(count){ //TO-DO 应该要有对每种物品的单独设置
    if(count < 0){
        count = 0;
    }
    g_setSupply = count;
    //pistol
    UpdateEntCount("weapon_pistol_spawn", count);
    UpdateEntCount("weapon_pistol_magnum_spawn", count);
    //smg
    UpdateEntCount("weapon_smg_spawn", count);
    UpdateEntCount("weapon_smg_silenced_spawn", count);
    UpdateEntCount("weapon_smg_mp5_spawn", count);
    //shotgun
    UpdateEntCount("weapon_pumpshotgun_spawn", count);
    UpdateEntCount("weapon_shotgun_chrome_spawn", count);
    UpdateEntCount("weapon_autoshotgun_spawn", count);
    UpdateEntCount("weapon_shotgun_spas_spawn", count);
    //rifle
    UpdateEntCount("weapon_rifle_spawn", count);
    UpdateEntCount("weapon_rifle_desert_spawn", count);
    UpdateEntCount("weapon_rifle_ak47_spawn", count);
    UpdateEntCount("weapon_rifle_sg552_spawn", count);
    //sniper
    UpdateEntCount("weapon_hunting_rifle_spawn", count);
    UpdateEntCount("weapon_sniper_military_spawn", count);
    UpdateEntCount("weapon_sniper_awp_spawn", count);
    UpdateEntCount("weapon_sniper_scout_spawn", count);
    //melee
    UpdateEntCount("weapon_melee_spawn", count);
	//throw		
    UpdateEntCount("weapon_molotov_spawn", count);
    UpdateEntCount("weapon_pipe_bomb_spawn", count);
    UpdateEntCount("weapon_vomitjar_spawn", count);
    //supply
    UpdateEntCount("weapon_pain_pills_spawn", count);
    UpdateEntCount("weapon_adrenaline_spawn", count);
    UpdateEntCount("weapon_defibrillator_spawn", count);
    UpdateEntCount("weapon_first_aid_kit_spawn", count);	
}

::UpdateEntCount <- function(ClassName, count){
    weaponent <- null;
    while(weaponent = Entities.FindByClassname(weaponent, ClassName)){
        weaponent.__KeyValueFromInt("count", count);
        weaponent.__KeyValueFromInt("spawnflags", 0);
    }
}

::setAmmo <- function(count){
    if(count < 0){
        count = 0;
    }
    g_setAmmo = count;
    //是否有不使用修改convar的办法？
    Convars.SetValue("ammo_assaultrifle_max", (Convars.GetFloat("ammo_assaultrifle_max") * count).tostring());
    Convars.SetValue("ammo_autoshotgun_max", (Convars.GetFloat("ammo_autoshotgun_max") * count).tostring());
    Convars.SetValue("ammo_grenadelauncher_max", (Convars.GetFloat("ammo_grenadelauncher_max") * count).tostring());
    Convars.SetValue("ammo_huntingrifle_max", (Convars.GetFloat("ammo_huntingrifle_max") * count).tostring());
    Convars.SetValue("ammo_minigun_max", (Convars.GetFloat("ammo_minigun_max") * count).tostring());
    Convars.SetValue("ammo_shotgun_max", (Convars.GetFloat("ammo_shotgun_max") * count).tostring());
    Convars.SetValue("ammo_smg_max", (Convars.GetFloat("ammo_smg_max") * count).tostring());
    Convars.SetValue("ammo_sniperrifle_max", (Convars.GetFloat("ammo_sniperrifle_max") * count).tostring());
}

::setHealth <- function(value){
    if(value < 0){
        value = 0;
    }
    g_setMaxHealth = value;
    local _hp = 0;
    foreach(player in ::VSLib.EasyLogic.Players.All()){
        if(player.GetTeam() == 2){
            _hp = player.GetHealth();   //包括虚血
            if(_hp > value){
                player.SetHealth(value);
                player.SetHealthBuffer(1);
            }
            player.SetMaxHealth(value);
        }    
    }
    //是否有一种不使用convar修改的方法？
    if((_hp * 0.4).tointeger() > 1){
        Convars.SetValue("survivor_limp_health", (_hp * 0.4).tointeger().tostring());   //瘸腿的血量
    }
    else{
        Convars.SetValue("survivor_limp_health", "1");
    }
    if((_hp * 0.3).tointeger() > 1){
        Convars.SetValue("survivor_revive_health", (_hp * 0.3).tointeger().tostring()); //扶起来的血量
    }
    else{
        Convars.SetValue("survivor_revive_health", "1");
    }
    Convars.SetValue("first_aid_kit_max_heal", value.tostring());  //医疗包可以恢复的最大血量
    Convars.SetValue("pain_pills_health_threshold", (value-1).tostring());  //药丸可以使用的最小生命值
    Convars.SetValue("pain_pills_health_value", (value * 0.5).tointeger().tostring());  //药丸给予的临时血量
    Convars.SetValue("z_survivor_respawn_health", (value * 0.5).tostring());  //复活的人的血量
    Convars.SetValue("adrenaline_health_buffer", (value * 0.25).tostring());  //肾上腺给予血量
    Convars.SetValue("sb_toughness_buffer", (value * 0.15).tostring());  //BOT受到多少伤害才会考虑治疗
}

//设置功能结束
//====================================================================================================================

//==========有关模式切换指令===============================================================
//====================================================================================================================
//====================================================================================================================

//游戏模式
function ChatTriggers::mode(player, args, text){
    //待开发,模式改变是否需要投票？如何实现？

}

//模式切换功能结束
//====================================================================================================================

//==========有关武器切换指令===============================================================
//====================================================================================================================
//====================================================================================================================

//武器切换有个难点,那就是如何在玩家按下键盘后Call该函数？(sourcepawn中在sdktools_hooks.inc中有一个函数OnPlayerRunCmd会在玩家按下某个键后调用,底层如何实现？)
//问题暂时无法解决,如果使用循环的话开销是否太大？有没有开销更小的办法？该功能暂时搁置。

//武器切换
function ChatTriggers::change(player, args, text){
    if(!admin_canUseChange && !isAdmin(player.GetName())){
        player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }
    //单独为某人开启或者全部开启
    local arr = split(text, " ");
    if(arr.len() == 1){
        //给自己开
        onChangeWeapon(player);
    }
    else if(arr.len() == 2){
        onChangeWeapon(null);
    }
    else{
        player.ShowHint("输入参数错误!", 3.0, "icon_alert", "", "200 50 50");
    }
}
::changeInitial <- {};      //储存玩家切换武器的冷却时间
::onChangeWeapon <- function(player){
    if(player){
        //给自己

    }
}

//武器切换功能结束
//====================================================================================================================

//==========HUD显示===============================================================
//====================================================================================================================
//====================================================================================================================

//HUD显示有点特殊,很多功能都会调用,所以会写在最后面(update函数前)

//===================HUD=========================

/**
类型：
"special_chat_error"    //特感指令格式出错  长度不一致
"common_chat_error"     //普感指令格式出错  长度不一致
"give_chat_error"       //give指令格式出错
"special_limit"         //成功修改特感数量      传入修改的玩家名字以及修改的数量
"special_respawn"       //成功修改特感复活时间  传入修改的玩家名字以及修改的时间
"special_limit_name"    //成功修改特定特感数量  传入修改的玩家名字以及修改的特感种类及其数量
"special_arg_error"     //特感修改格式错误  参数内容不一致
"common_limit"          //成功修改普感数量      传入修改的玩家名字以及修改的数量
"common_arg_error"      //普感修改格式错误  参数内容不一致

"server_info"           //显示游戏信息
"survivor_info"         //显示玩家信息
*/
::buildHUD <- function(type, playername, ...){
    if(playername){ //玩家名不为空表示修改成功,非报错
        local _hud_trigger = HUD.Item("\n{name}\n{act}\n{num}\n");
        if(vargv.len() == 1){
            
            _hud_trigger.SetValue("name", playername);
            switch(type){
                case "special_limit":
                {
                    _hud_trigger.SetValue("act", "设置特感数量为");
                    _hud_trigger.SetValue("num", vargv[0] + " 只");
                    break;
                    
                }
                case "special_respawn":
                {
                    _hud_trigger.SetValue("act", "设置特感重生时间为");
                    _hud_trigger.SetValue("num", vargv[0] + " 秒");
                    break;
                }
                case "common_limit":
                {
                    _hud_trigger.SetValue("act", "设置普感数量为");
                    _hud_trigger.SetValue("num", vargv[0] + " 只");
                    break;
                }
            }
        }
        else{
            _hud_trigger.SetValue("act", "设置" + vargv[0] + "数量为");
            _hud_trigger.SetValue("num", vargv[1] + " 只");
        }
        _hud_trigger.AttachTo(HUD_MID_BOX);
        _hud_trigger.ChangeHUDNative(0, 0, 350, 250, 1920, 1080);
        _hud_trigger.SetTextPosition(TextAlign.Left);
        _hud_trigger.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
        Timers.AddTimer(ShowDuration, false, CloseHud, _hud_trigger);
    }
    else if(type == "server_info"){
        local _hud_info = HUD.Item("\n{gamemode}\n{special}\n{common}\n{special_kill}\n{common_kill}\n");
        _hud_info.SetValue("gamemode", g_GameMode);
        _hud_info.SetValue("special", g_SpecialInfo);
        _hud_info.SetValue("common", g_CommonInfo);
        _hud_info.SetValue("special_kill", "阵亡特感 : " + g_PZKill + " 只");
        _hud_info.SetValue("common_kill", "阵亡普感 : " + g_CZKill + " 只");
        _hud_info.AttachTo(HUD_MID_BOT);
        //_hud_info.ChangeHUDNative(800, 650, 350, 450, 1920, 1080);
        _hud_info.SetTextPosition(TextAlign.Left);
        _hud_info.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
        Timers.AddTimer(ShowDuration, false, CloseHud, _hud_info); 
        HUDPlace(HUD_MID_BOT, 0.8, 0.55, 0.6, 0.3); 

        local _hud_set = HUD.Item("\n{supply}\n{ammo}\n{health}\n");
        _hud_set.SetValue("supply", "当前补给倍数为 " + g_setSupply + " 倍");
        _hud_set.SetValue("ammo", "当前后备子弹倍数为 " + g_setAmmo + " 倍");
        _hud_set.SetValue("health", "当前最大生命值为 " + g_setMaxHealth + " 点");
        _hud_set.AttachTo(HUD_MID_BOX);
        _hud_set.ChangeHUDNative(0, 500, 350, 250, 1920, 1080);
        _hud_set.SetTextPosition(TextAlign.Left);
        _hud_set.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
        Timers.AddTimer(ShowDuration, false, CloseHud, _hud_set);
    }
    else if(type == "survivor_info"){   //玩家的信息
        //使用五个插槽,一个插槽两名玩家,最多支持8名玩家 HUD_SCORE_TITLE HUD_SCORE_1 HUD_SCORE_2 HUD_SCORE_3 HUD_SCORE_4
        //先构建标题
        local _hud_tittle = HUD.Item("\n{name}※{smoker}※{boomer}※{hunter}※{spitter}※{jockey}※{charger}※{total}※{common}※{ff}※{tank}※\n");
        local _name = "玩家";
        //extendLen("玩家", 19);
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
        _hud_tittle.ChangeHUDNative(0, 0, 1400, 10, 1920, 1080);
        _hud_tittle.SetTextPosition(TextAlign.Right);
        _hud_tittle.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
        Timers.AddTimer(ShowDuration, false, CloseHud, _hud_tittle);

        argtable <- {};
        switch(g_HumanCount){   //根据玩家数构建,由于玩家面板形式大同小异,所以应该只修改不同的部分,实现函数通用,减少冗余
            //从大到小判断,如果人数够大,那么前面的HUD肯定要显示,省去了break
            case 8:     //如果大于四个人分成两次显示
                argtable[0] = "SCORE_4";
                argtable[1] = true;
                Timers.AddTimer(ShowDuration, false, ShowHUD, argtable);
            case 7:
                argtable[0] = "SCORE_3";
                argtable[1] = true;
                Timers.AddTimer(ShowDuration, false, ShowHUD, argtable);
            case 6:
                argtable[0] = "SCORE_2";
                argtable[1] = true;
                Timers.AddTimer(ShowDuration, false, ShowHUD, argtable);
            case 5:
                argtable[0] = "SCORE_1";
                argtable[1] = true;
                Timers.AddTimer(ShowDuration, false, ShowHUD, argtable);
                argtable[0] = "server_info";
                argtable[1] = null;
                Timers.AddTimer(ShowDuration, false, ShowHUD, argtable);//再显示一遍
                argtable[0] = "survivor_info";
                argtable[1] = null;
                Timers.AddTimer(ShowDuration, false, ShowHUD, argtable);
            case 4:
                ShowHUD("SCORE_4", false);
            case 3:
                ShowHUD("SCORE_3", false);
            case 2:
                ShowHUD("SCORE_2", false);
            case 1:
                ShowHUD("SCORE_1", false);
                break;
        }
    }
    else{   //不然即为报错
        //出错警告
        local error_hud = HUD.Item("\n{msg}");
        error_hud.SetValue("msg", "格式错误,请重新输入");
        _hud.AttachTo(HUD_MID_BOX);
        _hud.ChangeHUDNative(0, 0, 100, 100, 1920, 1080);
        _hud.SetTextPosition(TextAlign.Left);
        _hud.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
        Timers.AddTimer(ShowDuration, false, CloseHud, _hud);
        // TODO 为每种报错分别设置提示
    }
}

::extendLen <- function(value, tolen){   //传入目标字符串,需要加长至多少
    if(value > 1000){
        tolen--;
    }
    value = value.tostring();
    local l = value.len();
    if(l != tolen){
        if(l > tolen){
            value = value.slice(0, tolen+1);
        }
        else{
            for(local i = tolen - l; i >= -1; i--){
                value = " " + value;
            } 
        }
    }
    return value;
}

::bubbleSort <- function(arr){
    for(local i = 0; i < arr.len() - 1; i++){       //以特感击杀为基准排序
        for(local j = 0; j < arr.len() - 1; j++){
            if(PZKill[arr[j]] < PZKill[arr[j+1]]){
                local pz_tmp = arr[j+1];
                arr[j+1] = arr[j];
                arr[j] = pz_tmp;
            }
        }
    }
}

::CloseHud <- function(hud){
	hud.Detach();
}

::ShowHUD <- function(positon, isExtend){
    //Utils.SayToAll("humancount -> " + g_HumanCount);
    local index = 0;
    local ypos = 10;
    if(isExtend){
        index += 4; //如果是超过四个人,则应该跳过已经显示的前四个人
    }
    local _hud = HUD.Item("\n{name} {smoker} {boomer} {hunter} {spitter} {jockey} {charger} {total} {common} {ff} {tank}\n");
    switch(positon){    //在构建hud之后判断,可以直接修改hud属性
        case "SCORE_1":
            index += 0;
            _hud.AttachTo(HUD_SCORE_1);
            ypos += 15;
            break;
        case "SCORE_2":
            index += 1;
            _hud.AttachTo(HUD_SCORE_2);
            ypos += 30;
            break;
        case "SCORE_3":
            index += 2;
            _hud.AttachTo(HUD_SCORE_3);
            ypos += 45;
            break;
        case "SCORE_4":
            index += 3;
            _hud.AttachTo(HUD_SCORE_4);
            ypos += 60;
            break;
        default:
            Utils.SayToAll("HUD build error!");
    }
    local _name_player = PlayerInstanceFromIndex(playerTable[index]).GetPlayerName();
    //extendLen(PlayerInstanceFromIndex(playerTable[index]).GetPlayerName(), 19);
    _hud.SetValue("name", _name_player);
    _hud.SetValue("smoker", extendLen(SmokerKill[playerTable[index]], 6));
    _hud.SetValue("boomer", extendLen(BoomerKill[playerTable[index]], 6));
    _hud.SetValue("hunter", extendLen(HunterKill[playerTable[index]], 6));
    _hud.SetValue("spitter", extendLen(SpitterKill[playerTable[index]], 6));
    _hud.SetValue("jockey", extendLen(JockeyKill[playerTable[index]], 6));
    _hud.SetValue("charger", extendLen(ChargerKill[playerTable[index]], 3));
    _hud.SetValue("total", extendLen(PZKill[playerTable[index]], 12));
    _hud.SetValue("common", extendLen(CZKill[playerTable[index]], 12));
    _hud.SetValue("ff", extendLen(FFDmg[playerTable[index]], 6));
    _hud.SetValue("tank", extendLen(TankDmg[playerTable[index]], 6));
    _hud.SetTextPosition(TextAlign.Right);
    _hud.ChangeHUDNative(0, 0, 1400, ypos, 1920, 1080);
    _hud.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
    Timers.AddTimer(ShowDuration, false, CloseHud, _hud);    //持续一定时间关闭HUD防止挡视野

    HUDPlace(HUD_SCORE_TITLE, 0.1, 0.01, 0.755, 0.1);     //设置HUD位置
    HUDPlace(HUD_SCORE_1, 0.1, 0.04, 0.7, 0.1);
    HUDPlace(HUD_SCORE_2, 0.1, 0.07, 0.7, 0.1);
    HUDPlace(HUD_SCORE_3, 0.1, 0.10, 0.7, 0.1);
    HUDPlace(HUD_SCORE_4, 0.1, 0.13, 0.7, 0.1);
}

//HUD功能结束
//====================================================================================================================

//==========投票功能===============================================================
//====================================================================================================================
//====================================================================================================================

//思路：为所有幸存者创建一个重复10次每次一秒的提示框(每一秒刷新一次),提示玩家按下某个键来投票
//难点：还是相同的问题,我要如何检测玩家按键？一直高频循环检测？开销太大了















//投票功能结束
//====================================================================================================================

//==========Update===============================================================
//====================================================================================================================
//====================================================================================================================

function VSLib::EasyLogic::Update::Update(){

    ///////////////////////////////////////////////////////////////////////////
    //////////////// Update -> 修改特感/普感参数
    //通过导演系统修改数量
    DirectorOptions.BoomerLimit = g_BoomerLimit;
	DirectorOptions.HunterLimit = g_HunterLimit;
	DirectorOptions.SpitterLimit = g_SpitterLimit;
	DirectorOptions.ChargerLimit = g_ChargerLimit;
	DirectorOptions.JockeyLimit = g_JockeyLimit;
	DirectorOptions.SmokerLimit = g_SmokerLimit;
	DirectorOptions.cm_MaxSpecials = g_SpecialMax;
    DirectorOptions.cm_SpecialRespawnInterval = g_SpecialInitial;
    DirectorOptions.SpecialInitialSpawnDelayMax = g_SpecialInitial + 3;
	DirectorOptions.SpecialInitialSpawnDelayMin = g_SpecialInitial;

    //special
    if(g_SpecialMax > 16){
        DirectorOptions.DominatorLimit = 16;    //同时出现的特感数量不宜超过16只
    }
    else{
        DirectorOptions.DominatorLimit = g_SpecialMax;
    }
    //common
    if(g_CommonLimit == 0){
        DirectorOptions.cm_CommonLimit = 0;
		DirectorOptions.MobMaxSize = 0;
		DirectorOptions.MobMinSize = 0;
    }
    else if(g_CommonLimit < 60){    // TODO 使用变量来定义阈值,而不是常量
        DirectorOptions.cm_CommonLimit = g_CommonLimit;
		DirectorOptions.MobMaxSize = g_CommonLimit;
		DirectorOptions.MobMinSize = g_CommonLimit;
    }
    else if(g_CommonLimit < 160){
        DirectorOptions.cm_CommonLimit = g_CommonLimit;
		DirectorOptions.MobMaxSize = (g_CommonLimit > 100) ? ((g_CommonLimit / 2).tointeger() + 50) : g_CommonLimit;
		DirectorOptions.MobMinSize = (g_CommonLimit > 100) ? ((g_CommonLimit / 2).tointeger() + 30) : g_CommonLimit - 20;
    }
    else if(g_CommonLimit < 250){
        DirectorOptions.cm_CommonLimit = g_CommonLimit;
		DirectorOptions.MobMaxSize = (g_CommonLimit > 200) ? ((g_CommonLimit / 2).tointeger() + 70) : g_CommonLimit - 30;
		DirectorOptions.MobMinSize = (g_CommonLimit > 200) ? ((g_CommonLimit / 2).tointeger() + 50) : g_CommonLimit - 50;
    }
    
    
    ///////////////////////////////////////////////////////////////////////////
    //////////////// Update -> 获取一些全局信息
    local diff = "";
    diff = ::VSLib.Utils.GetDifficulty();
    switch(diff){
        case "easy":
            diff = "简单";
            break;
        case "normal":
            diff = "普通";
            break;
        case "hard":
            diff = "困难";
            break;
        case "impossible":
            diff = "专家";
            break;
        default:
            ;
    }
    g_GameMode = "当前难度为 : " + "[(" + diff + ")]";
    g_CommonInfo = "普感 : " + "[(" + DirectorOptions.cm_CommonLimit + ")]只";
	g_SpecialInfo = "特感 : " + "[(" + DirectorOptions.cm_MaxSpecials + ") 只 (" + DirectorOptions.cm_SpecialRespawnInterval +")秒]";

    ///////////////////////////////////////////////////////////////////////////
    //////////////// Update -> 一段时间后显示榜单
    g_HumanCount = ::VSLib.EasyLogic.Players.SurvivorsCount();
    local _i = 0;
    local _player = null;
    while(_player = Entities.FindByClassname(_player, "player")){
		if(_player.IsValid()){
			playerTable[_i++] <- _player.GetEntityIndex();
		}
	}
    bubbleSort(playerTable);    //冒泡排序
    if(Time() > ShowInterval + LastSet){
        buildHUD("server_info", null);   //显示特感/普感信息
        buildHUD("survivor_info", null);  //显示玩家的信息
        LastSet = Time();
    }
}










