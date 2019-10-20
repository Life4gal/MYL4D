/*
"自由控制"你的战役模式(也许也能支持其他模式)
*/
Msg("Script power by 無くなった雪\n");
IncludeScript("VSLib");

Utils.PrecacheCSSWeapons();
Utils.PrecacheSurvivors();

//pistol    pistol 15  magnum 7
//shotgun   autoshotgun 10/90  spas 10/90 pumpshotgun 8/56   chrome 8/56
//rifle rifle 50/360    desert 60/360   ak 40/360   sg552 50/360
//smg   smg 50/650  silenced 50/650 mp5 50/650
//sniper    hunting 15/150  military 30/180 awp 20/180  scout 15/180
//  grenade launcher/m60 要不要改？

//pistol
getroottable()["WEAPON_PISTOL"]             <- "weapon_pistol_spawn";
getroottable()["WEAPON_PISTOL_MAGNUM"]      <- "weapon_pistol_magnum_spawn";

getroottable()["AMMO_PISTOL"]               <- 15;
getroottable()["AMMO_PISTOL_MAGNUM"]        <- 7;

//smg
getroottable()["WEAPON_SMG"]                <- "weapon_smg_spawn";
getroottable()["WEAPON_SMG_SILENCED"]      <- "weapon_smg_silenced_spawn";
getroottable()["WEAPON_SMG_MP5"]            <- "weapon_mp5_spawn";

getroottable()["AMMO_SMG"]                  <- 50;
getroottable()["AMMO_SMG_SILENCED"]         <- 50;
getroottable()["AMMO_SMG_MP5"]              <- 50;

getroottable()["AMMO_SMG_BACKUP"]           <- 650;
getroottable()["AMMO_SMG_SILENCED_BACKUP"]  <- 650;
getroottable()["AMMO_SMG_MP5_BACKUP"]       <- 650;

//shotgun
getroottable()["WEAPON_PUMPSHOTGUN"]        <- "weapon_pumpshotgun_spawn";
getroottable()["WEAPON_SHOTGUN_CHROME"]     <- "weapon_shotgun_chrome_spawn";
getroottable()["WEAPON_AUTOSHOTGUN"]        <- "weapon_autoshotgun_spawn";
getroottable()["WEAPON_SHOTGUN_SPAS"]       <- "weapon_shotgun_spas_spawn";

getroottable()["AMMO_PUMPSHOTGUN"]        <- 8;
getroottable()["AMMO_SHOTGUN_CHROME"]     <- 8;
getroottable()["AMMO_AUTOSHOTGUN"]        <- 10;
getroottable()["AMMO_SHOTGUN_SPAS"]       <- 10;

getroottable()["AMMO_PUMPSHOTGUN_BACKUP"]        <- 56;
getroottable()["AMMO_SHOTGUN_CHROME_BACKUP"]     <- 56;
getroottable()["AMMO_AUTOSHOTGUN_BACKUP"]        <- 90;
getroottable()["AMMO_SHOTGUN_SPAS_BACKUP"]       <- 90;

//rifle
getroottable()["WEAPON_RIFLE"]              <- "weapon_rifle_spawn";
getroottable()["WEAPON_RIFLE_DESERT"]       <- "weapon_rifle_desert_spawn";
getroottable()["WEAPON_RIFLE_AK47"]         <- "weapon_rifle_ak47_spawn";
getroottable()["WEAPON_RIFLE_SG552"]        <- "weapon_rifle_sg552_spawn";

getroottable()["AMMO_RIFLE"]              <- 50;
getroottable()["AMMO_RIFLE_DESERT"]       <- 60;
getroottable()["AMMO_RIFLE_AK47"]         <- 40;
getroottable()["AMMO_RIFLE_SG552"]        <- 50;

getroottable()["AMMO_RIFLE_BACKUP"]              <- 360;
getroottable()["AMMO_RIFLE_DESERT_BACKUP"]       <- 360;
getroottable()["AMMO_RIFLE_AK47_BACKUP"]         <- 360;
getroottable()["AMMO_RIFLE_SG552_BACKUP"]        <- 360;

//sniper
getroottable()["WEAPON_HUNTING_RIFLE"]      <- "weapon_hunting_rifle_spawn";
getroottable()["WEAPON_SNIPER_MILITARY"]    <- "weapon_sniper_military_spawn";
getroottable()["WEAPON_SNIPER_AWP"]         <- "weapon_sniper_awp_spawn";
getroottable()["WEAPON_SNIPER_SCOUT"]       <- "weapon_sniper_scout_spawn";

getroottable()["AMMO_HUNTING_RIFLE"]      <- 15;
getroottable()["AMMO_SNIPER_MILITARY"]    <- 30;
getroottable()["AMMO_SNIPER_AWP"]         <- 20;
getroottable()["AMMO_SNIPER_SCOUT"]       <- 15;

getroottable()["AMMO_HUNTING_RIFLE_BACKUP"]      <- 150;
getroottable()["AMMO_SNIPER_MILITARY_BACKUP"]    <- 180;
getroottable()["AMMO_SNIPER_AWP_BACKUP"]         <- 180;
getroottable()["AMMO_SNIPER_SCOUT_BACKUP"]       <- 180;

//melee
getroottable()["WEAPON_MELEE"]              <- "weapon_melee_spawn";
//throw
getroottable()["WEAPON_MOLOTOV"]            <- "weapon_molotov_spawn";
getroottable()["WEAPON_PIPE_BOMB"]          <- "weapon_pipe_bomb_spawn";
getroottable()["WEAPON_VOMITJAR"]           <- "weapon_vomitjar_spawn";
//supply
getroottable()["WEAPON_PAIN_PILLS"]         <- "weapon_pain_pills_spawn";
getroottable()["WEAPON_ADRENALINE"]         <- "weapon_adrenaline_spawn";
getroottable()["WEAPON_DEFIBRILLATOR"]      <- "weapon_defibrillator_spawn";
getroottable()["WEAPON_FIRST_AID_KIT"]      <- "weapon_first_aid_kit_spawn";
//upgrade
getroottable()["UPGRADE"]                   <- "upgrade_spawn";
getroottable()["WEAPON_INCENDIARY"]         <- "weapon_upgrade_incendiary_spawn";
getroottable()["WEAPON_EXPLOSIVE"]          <- "weapon_upgrade_explosive_spawn";

getroottable()["CHANGE_SPECIAL_LIMIT"]      <- "change_special_limit";
getroottable()["CHANGE_SPECIAL_RESPAWN"]    <- "change_special_respawn";
getroottable()["CHANGE_SPECIAL_LIMIT_CHANGE"]       <- "change_special_limit_change";
getroottable()["CHANGE_SPECIAL_RESPAWN_CHANGE"]     <- "change_special_respawn_change";
getroottable()["CHANGE_COMMON_LIMIT"]               <- "change_common_limit";
getroottable()["CHANGE_COMMON_LIMIT_CHANGE"]        <- "change_common_limit_change"

::ItemInventory <- {
    Pistol = [
        WEAPON_PISTOL,
        WEAPON_PISTOL_MAGNUM
    ]
    Smg = [
        WEAPON_SMG,
        WEAPON_SMG_SILENCED,
        WEAPON_SMG_MP5
    ]
    Shotgun = [
        WEAPON_PUMPSHOTGUN,
        WEAPON_SHOTGUN_CHROME,
        WEAPON_AUTOSHOTGUN,
        WEAPON_SHOTGUN_SPAS
    ]
    Rifle = [
        WEAPON_RIFLE,
        WEAPON_RIFLE_DESERT,
        WEAPON_RIFLE_AK47,
        WEAPON_RIFLE_SG552
    ]
    Sniper = [
        WEAPON_HUNTING_RIFLE,
        WEAPON_SNIPER_MILITARY,
        WEAPON_SNIPER_AWP,
        WEAPON_SNIPER_SCOUT
    ]
    Melee = [
        WEAPON_MELEE
    ]
    Throw = [
        WEAPON_MOLOTOV,
        WEAPON_PIPE_BOMB,
        WEAPON_VOMITJAR
    ]
    Supply = [
        WEAPON_PAIN_PILLS,
        WEAPON_ADRENALINE,
        WEAPON_DEFIBRILLATOR,
        WEAPON_FIRST_AID_KIT
    ]
    Upgrade = [
        UPGRADE,
        WEAPON_INCENDIARY,
        WEAPON_EXPLOSIVE
    ]
}

DirectorOptions <- {
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

::CoreSystem <- {
    root_admin = "STEAM_1:1:98672042" //最高权限,填入steamid
    IsKickIdle = true  //是否踢出长时间空闲玩家
    KickIdleTime = 150   //空闲多久被提出
    FreezeDuration = 10 //冻结10秒
    VomitDuration = 5   //胆汁5秒
    Saved = {   //不会被重置的参数(过关会保留)
        Admins = {
            "STEAM_1:1:98672042":true
        } //管理员列表
        BannedPlayers = {

        }  //被禁玩家列表
        //本来管理员和封禁名单都应该从文件读取,不知道为什么读取不到,所以加入Saved表中
        IsAdminOnly = false    //指令是否仅限管理员使用
        IsBashDisable = {}  //不能用近战的玩家
        IsBashLimited = {}  //近战只能推
        IsNoclipEnable = {} //能使用穿墙的玩家
        IsGodEnable = {}    //无敌的玩家
        IsInfiniteAmmoEnable = {}   //无限前置子弹的玩家
        IsInfiniteBackupAmmoEnable = {}   //无限后备子弹的玩家
        IsInfiniteIncendiaryAmmoEnable = {} //无限燃烧子弹玩家
        IsInfiniteExplosiveAmmoEnable = {}  //无限高爆子弹玩家
        
        MultiAmmo = 1  //一倍前置子弹
        MultiBackupAmmo = 1 //一倍后备子弹
    }
    Info = {    //本关的全局信息
        CHumanCount = 0    //人类玩家数量
        CSurvivorCount = 0 //总幸存者数量
        CPlayerTable = {}  //储存人类玩家表

        CPZKill = {}
        CCZKill = {}
        CFFDmg = {}
        CShowInterval = 60.0 //60s显示一次数据
        CShowDuration = 6.0   //持续显示6秒
        CLastSet = 10

        //Smoker = 1
        //Boomer = 2
        //Hunter = 3
        //Spitter = 4
        //Jockey = 5
        //Charger = 6
        //Witch = 7
        //Tank = 8
        //Survivor = 9
        CSmokerKill = {}
        CBoomerKill = {}
        CHunterKill = {}
        CSpitterKill = {}
        CJockeyKill = {}
        CChargerKill = {}

        //WitchKill = {}
        CTankDmg = {}

        //特感/普感信息(包括数量和复活时间)
        CSpecialInfo = ""
        CCommonInfo = ""
        CGameMode = "" //游戏信息
        CGlobalPZKill = 0  //该回合死亡的普感/特感数量
        CGlobalCZKill = 0
    }
    Control = { //特感/普感调控信息
        //特感信息
        CBoomerLimit = 2
        CHunterLimit = 2
        CSpitterLimit = 2
        CChargerLimit = 2
        CJockeyLimit = 2
        CSmokerLimit = 2
        CSpecialMax = 4
        CSpecialMaxChange = 0 //每多一名玩家特感数量变化多少(未实际应用)

        CSpecialInitial = 25
        CSpecialInitialChange = 0 //每多一名玩家特感复活时间变化多少(未实际应用)
        //普感信息
        CCommonLimit = 30
        CCommonLimitChange = 0    //每多一名玩家普感数量变化多少(未实际应用)
    }
    Cvar = {    //convars信息
        //CMaxAmmo = 1  //一倍后备子弹(弃用该写法,使用NetProp)
        CMaxHealth = 100 //100最大生命值
        CLimpHealth = 40
        CReviveHealth = 30
        CFirstAidKitHealth = 100
        CPainPillsThreshold = 99
        CPainPillsHealth = 50
        CRespawnHealth = 50
        CAdrenalineHealth = 25
    }
}
/*
::CoreSystem.LoadAdmins <- function(){
    //载入管理员
    local fileContents = FileToString("admins.txt");
    local adminids = split(fileContents, "\r\n"); 
    //每行一个管理员的SteamID,以回车分隔

    foreach(adminid in adminids){
        //local player = GetPlayerFromUserID(adminid)
        //追求简便,直接使用steamid
        if(adminid.find("//") == null){
            ::CoreSystem.Admins[adminid] <- true;
        } 
    }
}

::CoreSystem.LoadBanned <- function(){
    local fileContents = FileToString("banneds.txt");
    local bannedids = split(fileContents, "\r\n");

    foreach(bannedid in bannedids){
        if(bannedid.find("//") == null){
            ::CoreSystem.BannedPlayers[bannedid] <- true;
        }  
    }
}

::CoreSystem.LoadCvars <- function(){
    //形式为    z_tank_health = 5000    不要分号结尾
    local fileContents = FileToString("convars.txt");
    local cvars = split(fileContents, "\r\n");

    foreach(cvar in cvars){
        if(cvar.find("//") == null){
            local arr = split(cvar, "=");
            Convars.SetValue(Utils.StringReplace(arr[0], " ", ""), Utils.StringReplace(arr[0], " ", ""));
            //去除空格
        }
    }
}
*/
::CoreSystem.IsPrivileged <- function(player){  //如果IsAdminOnly = false玩家也可以获得特权
    if(Director.IsSinglePlayerGame() || player.IsServerHost()){
        return true;
    }

    local steamid = player.GetSteamID();

    if(((steamid in ::CoreSystem.Saved.Admins) && (::CoreSystem.Saved.Admins[steamid])) || !(::CoreSystem.Saved.IsAdminOnly) || (CoreSystem.IsRoot(player))){
        return true;
    }
    return false;
}

::CoreSystem.IsAdmin <- function(player){   //管理员
    if(Director.IsSinglePlayerGame() || player.IsServerHost()){
        return true;
    }

    local steamid = player.GetSteamID();
    if(((steamid in ::CoreSystem.Saved.Admins) && (::CoreSystem.Saved.Admins[steamid])) || (CoreSystem.IsRoot(player))){
        return true;
    }
    return false;
}

::CoreSystem.IsRoot <- function(player){
    if(Director.IsSinglePlayerGame() || player.IsServerHost()){
        return true;
    }

    local steamid = player.GetSteamID();
    if(steamid == root_admin){
        return true;
    }
    return false;
}

::CoreSystem.GetID <- function(player){
    if(!player || !("IsPlayerEntityValid" in player) || !player.IsPlayerEntityValid()){
        return null;
    }

    local steamid = player.GetSteamID();
    if(steamid == "BOT"){
        if(player.IsSurvivor()){
            steamid = player.GetCharacterName();
        }
    }
    return steamid;
}

::CoreSystem.KickIdlePlayer <- function(player){
    local steamid = player.GetSteamID();
    Timers.RemoveTimerByName("KickTimer" + CoreSystem.GetID(player).tostring());

    foreach(survivor in ::VSLib.EasyLogic.Players.Survivors()){
        survivor.ShowHint(player.GetName() + "因闲置太长时间被踢出!", 3.0, "icon_alert", "", "200 50 50");
    }
    SendToServerConsole("kickid" + steamid + " 你因闲置太久被踢出!");
}

function EasyLogic::OnShutdown::SaveData(reason, nextmap){
    if(reason > 0 && reason < 4){
        //如果不是因为关闭服务器则保留之前对玩家的一些设置
        SaveTable("table_data", ::CoreSystem.Saved);
    }
}

function Notifications::OnRoundStart::LoadData(){

    for(local i = 0; i < 32; i++){
        ::CoreSystem.Info.CPZKill[i] <- 0;
        ::CoreSystem.Info.CCZKill[i] <- 0;
        ::CoreSystem.Info.CFFDmg[i] <- 0;
        ::CoreSystem.Info.CTankDmg[i] <- 0;
        ::CoreSystem.Info.CSmokerKill[i] <- 0;
        ::CoreSystem.Info.CBoomerKill[i] <- 0;
        ::CoreSystem.Info.CHunterKill[i] <- 0;
        ::CoreSystem.Info.CSpitterKill[i] <- 0;
        ::CoreSystem.Info.CJockeyKill[i] <- 0;
        ::CoreSystem.Info.CChargerKill[i] <- 0;
    }
    ::CoreSystem.Info.CGlobalPZKill <- 0;
    ::CoreSystem.Info.CGlobalCZKill <- 0;


    RestoreTable("table_data", ::CoreSystem.Saved);

    if(::CoreSystem.Saved == null){
        //没获取到直接初始化
        ::CoreSystem.Saved <-{
            Admins = {
                "STEAM_1:1:98672042":true
            } //管理员列表
            BannedPlayers = {

            }  //被禁玩家列表
            IsBashDisable = {}  //不能用近战的玩家
            IsBashLimited = {}  //到达使用限制的玩家
            IsNoclipEnable = {} //能使用穿墙的玩家
            IsGodEnable = {}    //无敌的玩家
            IsInfiniteAmmoEnable = {}   //无限前置子弹的玩家
            IsInfiniteAmmoEnable = {}   //无限后备子弹的玩家
            IsInfiniteIncendiaryAmmoEnable = {} //无限燃烧子弹玩家
            IsInfiniteExplosiveAmmoEnable = {}  //无限高爆子弹玩家
        }
    }
    /*
    //令人疑惑,squirrel到底有没有权限/能力创建/修改文件
    local admins = FileToString("admins.txt");
    local banneds = FileToString("banneds.txt");
    local convars = FileToString("convars.txt");
    local errorlog = "";

    if(admins != null){
        //printf("[admin] Loading success...");
        Utils.SayToAll("[admin] Loading success...");
        CoreSystem.LoadAdmins();
    }
    else{
        errorlog = Time().tostring() + "[admin] Loading fail...";
        StringToFile("log.txt", errorlog);  //todo 如何加上时间戳？如何获取当前时间,而不是服务器时间
    }
    if(banneds != null){
        //printf("[banned] Loading success...");
        Utils.SayToAll("[banned] Loading success...");
        CoreSystem.LoadBanned();
    }
    else{
        errorlog = Time().tostring() + "[banned] Loading fail...";
        StringToFile("log.txt", errorlog);
    }
    if(convars != null){
        //printf("[convars] Loading success...");
        Utils.SayToAll("[convars] Loading success...");
        CoreSystem.LoadCvars();
    }
    else{
        errorlog = Time().tostring() + "[convars] Loading fail...";
        StringToFile("log.txt", errorlog);
    }
    */
}

function Notifications::OnPlayerJoined::BanCheck(player, name, IPaddr, steamid, params){
    if(player){
        local steamid = player.GetSteamID();

        if(steamid in ::CoreSystem.Saved.BannedPlayers){
            SendToServerConsole("kick " + steamid + " 你已被封禁!");
        }
    }
}

function Notifications::OnWeaponFire::CoreSetInfiniteAmmo(player, weapon, params){
    local id = CoreSystem.GetID(player);
    local inventory = player.GetHeldItems();

    if((id in ::CoreSystem.Saved.IsInfiniteAmmoEnable) && (::CoreSystem.Saved.IsInfiniteAmmoEnable[id])){
        local wep = player.GetActiveWeapon();
        wep.SetNetProp("m_iClip1", wep.GetNetPropInt("m_iClip1") + 1);
    }
    if(((id in ::CoreSystem.Saved.IsInfiniteIncendiaryAmmoEnable) && (::CoreSystem.Saved.IsInfiniteIncendiaryAmmoEnable[id])) || ((id in ::CoreSystem.Saved.IsInfiniteExplosiveAmmoEnable) && (::CoreSystem.Saved.IsInfiniteExplosiveAmmoEnable[id]))){
        if("slot0" in inventory){
            local wep = inventory["slot0"];
            if(wep.GetClassname() == weapon){
                if(wep.GetNetPropInt("m_nUpgradedPrimaryAmmoLoaded") > 0){
                    wep.SetNetProp("m_nUpgradedPrimaryAmmoLoaded", wep.GetNetPropInt("m_nUpgradedPrimaryAmmoLoaded") + 1);
                }
            }
        }
    }
}

function Notifications::OnWeaponReload::CoreSetAmmo(player, manual, params){
    local id = CoreSystem.GetID(player);
    local inventory = player.GetHeldItems();

    if((id in ::CoreSystem.Saved.IsInfiniteAmmoEnable) && (::CoreSystem.Saved.IsInfiniteAmmoEnable[id])){
        player.GiveAmmo(999);
    }
    if(((id in ::CoreSystem.Saved.IsInfiniteIncendiaryAmmoEnable) && (::CoreSystem.Saved.IsInfiniteIncendiaryAmmoEnable[id])) || ((id in ::CoreSystem.Saved.IsInfiniteExplosiveAmmoEnable) && (::CoreSystem.Saved.IsInfiniteExplosiveAmmoEnable[id]))){
        if("slot0" in inventory){
            local wep = inventory["slot0"];

            if(wep.GetClassname() == player.GetActiveWeapon().GetClassname()){
                player.SetPrimaryAmmo(player.GetMaxPrimaryAmmo() + (wep.GetNetPropInt("m_nUpgradedPrimaryAmmoLoaded") * 2));
            }
        }
    }
    else{
        //不是无限升级子弹才修改前置子弹
        //这里有个问题,只能获取到当前的子弹量,而不是弹匣容量,只能记录正常情况下的弹匣容量作为依据
        //换子弹的顺序大致是 后备子弹加上前置子弹->清空前置子弹->前置子弹装上,后备子弹减少
        //由于是先清空前置子弹来加入后备,所以只需要在后备子弹中减去额外的前置子弹即可
        local wep = player.GetActiveWeapon();
        switch(wep.GetClassname()){
            //PISTOL
            case Utils.StringReplace(WEAPON_PISTOL, "_spawn", ""):{
                //去掉_spawn后和classname一致,没必要再写一遍
                wep.SetNetProp("m_iClip1", AMMO_PISTOL * ::CoreSystem.Saved.MultiAmmo);
                break;
            }
            case Utils.StringReplace(WEAPON_PISTOL_MAGNUM, "_spawn", ""):{
                //手枪不需要判断后备子弹数量
                wep.SetNetProp("m_iClip1", AMMO_PISTOL_MAGNUM * ::CoreSystem.Saved.MultiAmmo);
                break;
            }
            //SMG
            case Utils.StringReplace(WEAPON_SMG, "_spawn", ""):{
                if(wep.GetNetPropInt("m_iAmmo") > AMMO_SMG * ::CoreSystem.Saved.MultiAmmo){
                    wep.SetNetProp("m_iClip1", AMMO_SMG * ::CoreSystem.Saved.MultiAmmo);
                    wep.SetNetProp("m_iAmmo", wep.GetNetPropInt("m_iAmmo") - AMMO_SMG * (::CoreSystem.Saved.MultiAmmo - 1));
                }
                else{
                    wep.SetNetProp("m_iClip1", wep.GetNetPropInt("m_iClip1") + wep.GetNetPropInt("m_iAmmo"));
                    //子弹已经减少过一次,所以总的子弹量要补偿上减少的那次
                    wep.SetNetProp("m_iAmmo", 0);
                }
                break;
            }
            case Utils.StringReplace(WEAPON_SMG_SILENCED, "_spawn", ""):{
                if(wep.GetNetPropInt("m_iAmmo") > AMMO_SMG_SILENCED * ::CoreSystem.Saved.MultiAmmo){
                    wep.SetNetProp("m_iClip1", AMMO_SMG_SILENCED * ::CoreSystem.Saved.MultiAmmo);
                    wep.SetNetProp("m_iAmmo", wep.GetNetPropInt("m_iAmmo") - AMMO_SMG_SILENCED * (::CoreSystem.Saved.MultiAmmo - 1));
                }
                else{
                    wep.SetNetProp("m_iClip1", wep.GetNetPropInt("m_iClip1") + wep.GetNetPropInt("m_iAmmo"));
                    wep.SetNetProp("m_iAmmo", 0);
                }
                break;
            }
            case Utils.StringReplace(WEAPON_SMG_MP5, "_spawn", ""):{
                if(wep.GetNetPropInt("m_iAmmo") > AMMO_SMG_MP5 * ::CoreSystem.Saved.MultiAmmo){
                    wep.SetNetProp("m_iClip1", AMMO_SMG_MP5 * ::CoreSystem.Saved.MultiAmmo);
                    wep.SetNetProp("m_iAmmo", wep.GetNetPropInt("m_iAmmo") - AMMO_SMG_MP5 * (::CoreSystem.Saved.MultiAmmo - 1));
                }
                else{
                    wep.SetNetProp("m_iClip1", wep.GetNetPropInt("m_iClip1") + wep.GetNetPropInt("m_iAmmo"));
                    wep.SetNetProp("m_iAmmo", 0);
                }
                break;
            }
            //SHOTGUN
            case Utils.StringReplace(WEAPON_PUMPSHOTGUN, "_spawn", ""):{
                if(wep.GetNetPropInt("m_iAmmo") > AMMO_PUMPSHOTGUN * ::CoreSystem.Saved.MultiAmmo){
                    wep.SetNetProp("m_iClip1", AMMO_PUMPSHOTGUN * ::CoreSystem.Saved.MultiAmmo);
                    wep.SetNetProp("m_iAmmo", wep.GetNetPropInt("m_iAmmo") - AMMO_PUMPSHOTGUN * (::CoreSystem.Saved.MultiAmmo - 1));
                }
                else{
                    wep.SetNetProp("m_iClip1", wep.GetNetPropInt("m_iClip1") + wep.GetNetPropInt("m_iAmmo"));
                    wep.SetNetProp("m_iAmmo", 0);
                }
                break;
            }
            case Utils.StringReplace(WEAPON_SHOTGUN_CHROME, "_spawn", ""):{
                if(wep.GetNetPropInt("m_iAmmo") > AMMO_SHOTGUN_CHROME * ::CoreSystem.Saved.MultiAmmo){
                    wep.SetNetProp("m_iClip1", AMMO_SHOTGUN_CHROME * ::CoreSystem.Saved.MultiAmmo);
                    wep.SetNetProp("m_iAmmo", wep.GetNetPropInt("m_iAmmo") - AMMO_SHOTGUN_CHROME * (::CoreSystem.Saved.MultiAmmo - 1));
                }
                else{
                    wep.SetNetProp("m_iClip1", wep.GetNetPropInt("m_iClip1") + wep.GetNetPropInt("m_iAmmo"));
                    wep.SetNetProp("m_iAmmo", 0);
                }
                break;
            }
            case Utils.StringReplace(WEAPON_AUTOSHOTGUN, "_spawn", ""):{
                if(wep.GetNetPropInt("m_iAmmo") > AMMO_AUTOSHOTGUN * ::CoreSystem.Saved.MultiAmmo){
                    wep.SetNetProp("m_iClip1", AMMO_AUTOSHOTGUN * ::CoreSystem.Saved.MultiAmmo);
                    wep.SetNetProp("m_iAmmo", wep.GetNetPropInt("m_iAmmo") - AMMO_AUTOSHOTGUN * (::CoreSystem.Saved.MultiAmmo - 1));
                }
                else{
                    wep.SetNetProp("m_iClip1", wep.GetNetPropInt("m_iClip1") + wep.GetNetPropInt("m_iAmmo"));
                    wep.SetNetProp("m_iAmmo", 0);
                }
                break;
            }
            case Utils.StringReplace(WEAPON_SHOTGUN_SPAS, "_spawn", ""):{
                if(wep.GetNetPropInt("m_iAmmo") > AMMO_SHOTGUN_SPAS * ::CoreSystem.Saved.MultiAmmo){
                    wep.SetNetProp("m_iClip1", AMMO_SHOTGUN_SPAS * ::CoreSystem.Saved.MultiAmmo);
                    wep.SetNetProp("m_iAmmo", wep.GetNetPropInt("m_iAmmo") - AMMO_SHOTGUN_SPAS * (::CoreSystem.Saved.MultiAmmo - 1));
                }
                else{
                    wep.SetNetProp("m_iClip1", wep.GetNetPropInt("m_iClip1") + wep.GetNetPropInt("m_iAmmo"));
                    wep.SetNetProp("m_iAmmo", 0);
                }
                break;
            }
            //RIFLE
            case Utils.StringReplace(WEAPON_RIFLE, "_spawn", ""):{
                if(wep.GetNetPropInt("m_iAmmo") > AMMO_RIFLE * ::CoreSystem.Saved.MultiAmmo){
                    wep.SetNetProp("m_iClip1", AMMO_RIFLE * ::CoreSystem.Saved.MultiAmmo);
                    wep.SetNetProp("m_iAmmo", wep.GetNetPropInt("m_iAmmo") - AMMO_RIFLE * (::CoreSystem.Saved.MultiAmmo - 1));
                }
                else{
                    wep.SetNetProp("m_iClip1", wep.GetNetPropInt("m_iClip1") + wep.GetNetPropInt("m_iAmmo"));
                    wep.SetNetProp("m_iAmmo", 0);
                }
                break;
            }
            case Utils.StringReplace(WEAPON_RIFLE_DESERT, "_spawn", ""):{
                if(wep.GetNetPropInt("m_iAmmo") > AMMO_RIFLE_DESERT * ::CoreSystem.Saved.MultiAmmo){
                    wep.SetNetProp("m_iClip1", AMMO_RIFLE_DESERT * ::CoreSystem.Saved.MultiAmmo);
                    wep.SetNetProp("m_iAmmo", wep.GetNetPropInt("m_iAmmo") - AMMO_RIFLE_DESERT * (::CoreSystem.Saved.MultiAmmo - 1));
                }
                else{
                    wep.SetNetProp("m_iClip1", wep.GetNetPropInt("m_iClip1") + wep.GetNetPropInt("m_iAmmo"));
                    wep.SetNetProp("m_iAmmo", 0);
                }
                break;
            }
            case Utils.StringReplace(WEAPON_RIFLE_AK47, "_spawn", ""):{
                if(wep.GetNetPropInt("m_iAmmo") > AMMO_RIFLE_AK47 * ::CoreSystem.Saved.MultiAmmo){
                    wep.SetNetProp("m_iClip1", AMMO_RIFLE_AK47 * ::CoreSystem.Saved.MultiAmmo);
                    wep.SetNetProp("m_iAmmo", wep.GetNetPropInt("m_iAmmo") - AMMO_RIFLE_AK47 * (::CoreSystem.Saved.MultiAmmo - 1));
                }
                else{
                    wep.SetNetProp("m_iClip1", wep.GetNetPropInt("m_iClip1") + wep.GetNetPropInt("m_iAmmo"));
                    wep.SetNetProp("m_iAmmo", 0);
                }
                break;
            }
            case Utils.StringReplace(WEAPON_RIFLE_SG552, "_spawn", ""):{
                if(wep.GetNetPropInt("m_iAmmo") > AMMO_RIFLE_SG552 * ::CoreSystem.Saved.MultiAmmo){
                    wep.SetNetProp("m_iClip1", AMMO_RIFLE_SG552 * ::CoreSystem.Saved.MultiAmmo);
                    wep.SetNetProp("m_iAmmo", wep.GetNetPropInt("m_iAmmo") - AMMO_RIFLE_SG552 * (::CoreSystem.Saved.MultiAmmo - 1));
                }
                else{
                    wep.SetNetProp("m_iClip1", wep.GetNetPropInt("m_iClip1") + wep.GetNetPropInt("m_iAmmo"));
                    wep.SetNetProp("m_iAmmo", 0);
                }
                break;
            }
            //SNIPER
            case Utils.StringReplace(WEAPON_HUNTING_RIFLE, "_spawn", ""):{
                if(wep.GetNetPropInt("m_iAmmo") > AMMO_HUNTING_RIFLE * ::CoreSystem.Saved.MultiAmmo){
                    wep.SetNetProp("m_iClip1", AMMO_HUNTING_RIFLE * ::CoreSystem.Saved.MultiAmmo);
                    wep.SetNetProp("m_iAmmo", wep.GetNetPropInt("m_iAmmo") - AMMO_HUNTING_RIFLE * (::CoreSystem.Saved.MultiAmmo - 1));
                }
                else{
                    wep.SetNetProp("m_iClip1", wep.GetNetPropInt("m_iClip1") + wep.GetNetPropInt("m_iAmmo"));
                    wep.SetNetProp("m_iAmmo", 0);
                }
                break;
            }
            case Utils.StringReplace(WEAPON_SNIPER_MILITARY, "_spawn", ""):{
                if(wep.GetNetPropInt("m_iAmmo") > AMMO_SNIPER_MILITARY * ::CoreSystem.Saved.MultiAmmo){
                    wep.SetNetProp("m_iClip1", AMMO_SNIPER_MILITARY * ::CoreSystem.Saved.MultiAmmo);
                    wep.SetNetProp("m_iAmmo", wep.GetNetPropInt("m_iAmmo") - AMMO_SNIPER_MILITARY * (::CoreSystem.Saved.MultiAmmo - 1));
                }
                else{
                    wep.SetNetProp("m_iClip1", wep.GetNetPropInt("m_iClip1") + wep.GetNetPropInt("m_iAmmo"));
                    wep.SetNetProp("m_iAmmo", 0);
                }
                break;
            }
            case Utils.StringReplace(WEAPON_SNIPER_AWP, "_spawn", ""):{
                if(wep.GetNetPropInt("m_iAmmo") > AMMO_SNIPER_AWP * ::CoreSystem.Saved.MultiAmmo){
                    wep.SetNetProp("m_iClip1", AMMO_SNIPER_AWP * ::CoreSystem.Saved.MultiAmmo);
                    wep.SetNetProp("m_iAmmo", wep.GetNetPropInt("m_iAmmo") - AMMO_SNIPER_AWP * (::CoreSystem.Saved.MultiAmmo - 1));
                }
                else{
                    wep.SetNetProp("m_iClip1", wep.GetNetPropInt("m_iClip1") + wep.GetNetPropInt("m_iAmmo"));
                    wep.SetNetProp("m_iAmmo", 0);
                }
                break;
            }
            case Utils.StringReplace(WEAPON_SNIPER_SCOUT, "_spawn", ""):{
                if(wep.GetNetPropInt("m_iAmmo") > AMMO_SNIPER_SCOUT * ::CoreSystem.Saved.MultiAmmo){
                    wep.SetNetProp("m_iClip1", AMMO_SNIPER_SCOUT * ::CoreSystem.Saved.MultiAmmo);
                    wep.SetNetProp("m_iAmmo", wep.GetNetPropInt("m_iAmmo") - AMMO_SNIPER_SCOUT * (::CoreSystem.Saved.MultiAmmo - 1));
                }
                else{
                    wep.SetNetProp("m_iClip1", wep.GetNetPropInt("m_iClip1") + wep.GetNetPropInt("m_iAmmo"));
                    wep.SetNetProp("m_iAmmo", 0);
                }
                break;
            }
            // todo 这里有大量重复代码,这是可以避免的
            default:
                ;
        }
    }
}

function Notifications::OnItemPickup::CoreSetBackupAmmo(player, weapon, params){
    local id = CoreSystem.GetID(player);
    local inventory = player.GetHeldItems();

    if("slot0" in inventory){
        if(inventory["slot0"].GetClassname() == weapon){    //捡到的是主武器
            if((id in ::CoreSystem.Saved.IsInfiniteIncendiaryAmmoEnable) && (::CoreSystem.Saved.IsInfiniteIncendiaryAmmoEnable[id])){
                player.GiveUpgrade(UPGRADE_INCENDIAY_AMMO);
                player.input("CancelCurrentScene");
            }
            else if((id in ::CoreSystem.Saved.IsInfiniteExplosiveAmmoEnable) && (::CoreSystem.Saved.IsInfiniteExplosiveAmmoEnable[id])){
                player.GiveUpgrade(UPGARDE_EXPLOSIVE_AMMO);
                player.input("CancelCurrentScene");
            }
            else{
                local wep = inventory["slot0"];
                //因为副武器是不需要增加后备子弹的,所以在这里加入代码,如果不是无限升级子弹则执行
                //因为外围判断条件为捡到的是主武器,所以直接用给定参数weapon判断
                switch(weapon){
                    //这里有一个问题,每次捡起武器就会设置多倍后备子弹,那就会有一个刷子弹漏洞,需要杜绝
                    //SMG
                    case Utils.StringReplace(WEAPON_SMG, "_spawn", ""):{
                        if(wep.GetNetPropInt("m_iAmmo") == AMMO_SMG_BACKUP){
                            //只有在后备弹匣是满的情况下才加倍,防止刷子弹
                            wep.SetNetProp("m_iAmmo", AMMO_SMG * ::CoreSystem.Saved.MultiBackupAmmo);
                        }
                        break;
                    }
                    case Utils.StringReplace(WEAPON_SMG_SILENCED, "_spawn", ""):{
                        if(wep.GetNetPropInt("m_iAmmo") == AMMO_SMG_SILENCED_BACKUP){
                            wep.SetNetProp("m_iAmmo", AMMO_SMG_SILENCED_BACKUP * ::CoreSystem.Saved.MultiBackupAmmo);
                        }
                        break;
                    }
                    case Utils.StringReplace(WEAPON_SMG_MP5, "_spawn", ""):{
                        if(wep.GetNetPropInt("m_iAmmo") == AMMO_SMG_MP5_BACKUP){
                            wep.SetNetProp("m_iAmmo", AMMO_SMG_MP5_BACKUP * ::CoreSystem.Saved.MultiBackupAmmo);
                        }
                        break;
                    }
                    //SHOTGUN
                    case Utils.StringReplace(WEAPON_PUMPSHOTGUN, "_spawn", ""):{
                        if(wep.GetNetPropInt("m_iAmmo") == AMMO_PUMPSHOTGUN_BACKUP){
                            wep.SetNetProp("m_iAmmo", AMMO_PUMPSHOTGUN_BACKUP * ::CoreSystem.Saved.MultiBackupAmmo);
                        }
                        break;
                    }
                    case Utils.StringReplace(WEAPON_SHOTGUN_CHROME, "_spawn", ""):{
                        if(wep.GetNetPropInt("m_iAmmo") == AMMO_SHOTGUN_CHROME_BACKUP){
                            wep.SetNetProp("m_iAmmo", AMMO_SHOTGUN_CHROME_BACKUP * ::CoreSystem.Saved.MultiBackupAmmo);
                        }
                        break;
                    }
                    case Utils.StringReplace(WEAPON_AUTOSHOTGUN, "_spawn", ""):{
                        if(wep.GetNetPropInt("m_iAmmo") == AMMO_AUTOSHOTGUN_BACKUP){
                            wep.SetNetProp("m_iAmmo", AMMO_AUTOSHOTGUN_BACKUP * ::CoreSystem.Saved.MultiBackupAmmo);
                        }
                        break;
                    }
                    case Utils.StringReplace(WEAPON_SHOTGUN_SPAS, "_spawn", ""):{
                        if(wep.GetNetPropInt("m_iAmmo") == AMMO_SHOTGUN_SPAS_BACKUP){
                            wep.SetNetProp("m_iAmmo", AMMO_SHOTGUN_SPAS_BACKUP * ::CoreSystem.Saved.MultiBackupAmmo);
                        }
                        break;
                    }
                    //RIFLE
                    case Utils.StringReplace(WEAPON_RIFLE, "_spawn", ""):{
                        if(wep.GetNetPropInt("m_iAmmo") == AMMO_RIFLE_BACKUP){
                            wep.SetNetProp("m_iAmmo", AMMO_RIFLE_BACKUP * ::CoreSystem.Saved.MultiBackupAmmo);
                        }
                        break;
                    }
                    case Utils.StringReplace(WEAPON_RIFLE_DESERT, "_spawn", ""):{
                        if(wep.GetNetPropInt("m_iAmmo") == AMMO_RIFLE_DESERT_BACKUP){
                            wep.SetNetProp("m_iAmmo", AMMO_RIFLE_DESERT_BACKUP * ::CoreSystem.Saved.MultiBackupAmmo);
                        }
                        break;
                    }
                    case Utils.StringReplace(WEAPON_RIFLE_AK47, "_spawn", ""):{
                        if(wep.GetNetPropInt("m_iAmmo") == AMMO_RIFLE_AK47_BACKUP){
                            wep.SetNetProp("m_iAmmo", AMMO_RIFLE_AK47_BACKUP * ::CoreSystem.Saved.MultiBackupAmmo);
                        }
                        break;
                    }
                    case Utils.StringReplace(WEAPON_RIFLE_SG552, "_spawn", ""):{
                        if(wep.GetNetPropInt("m_iAmmo") == AMMO_RIFLE_SG552_BACKUP){
                            wep.SetNetProp("m_iAmmo", AMMO_RIFLE_SG552_BACKUP * ::CoreSystem.Saved.MultiBackupAmmo);
                        }
                        break;
                    }
                    //SNIPER
                    case Utils.StringReplace(WEAPON_HUNTING_RIFLE, "_spawn", ""):{
                        if(wep.GetNetPropInt("m_iAmmo") == AMMO_HUNTING_RIFLE_BACKUP){
                            wep.SetNetProp("m_iAmmo", AMMO_HUNTING_RIFLE_BACKUP * ::CoreSystem.Saved.MultiBackupAmmo);
                        }
                        break;
                    }
                    case Utils.StringReplace(WEAPON_SNIPER_MILITARY, "_spawn", ""):{
                        if(wep.GetNetPropInt("m_iAmmo") == AMMO_SNIPER_MILITARY_BACKUP){
                            wep.SetNetProp("m_iAmmo", AMMO_SNIPER_MILITARY_BACKUP * ::CoreSystem.Saved.MultiBackupAmmo);
                        }
                        break;
                    }
                    case Utils.StringReplace(WEAPON_SNIPER_AWP, "_spawn", ""):{
                        if(wep.GetNetPropInt("m_iAmmo") == AMMO_SNIPER_AWP_BACKUP){
                            wep.SetNetProp("m_iAmmo", AMMO_SNIPER_AWP_BACKUP * ::CoreSystem.Saved.MultiBackupAmmo);
                        }
                        break;
                    }
                    case Utils.StringReplace(WEAPON_SNIPER_SCOUT, "_spawn", ""):{
                        if(wep.GetNetPropInt("m_iAmmo") == AMMO_SNIPER_SCOUT_BACKUP){
                            wep.SetNetProp("m_iAmmo", AMMO_SNIPER_SCOUT_BACKUP * ::CoreSystem.Saved.MultiBackupAmmo);
                        }
                        break;
                    }
                    default:
                        ;
                }
            }
        }
    }
}

function Notifications::OnUse::CoreGiveUpgrade(player, target, params){
    local id = CoreSystem.GetID(player);
    local inventory = player.GetHeldItems();

    if("slot0" in inventory){
        if(inventory["slot0"].GetClassname() == target.GetClassname()){
            if((id in ::CoreSystem.Saved.IsInfiniteIncendiaryAmmoEnable) && (::CoreSystem.Saved.IsInfiniteIncendiaryAmmoEnable[id])){
                player.GiveUpgrade(UPGRADE_INCENDIAY_AMMO);
                player.input("CancelCurrentScene");
            }
            else if((id in ::CoreSystem.Saved.IsInfiniteExplosiveAmmoEnable) && (::CoreSystem.Saved.IsInfiniteExplosiveAmmoEnable[id])){
                player.GiveUpgrade(UPGARDE_EXPLOSIVE_AMMO);
                player.input("CancelCurrentScene");
            }
        }
    }
}

function Notifications::OnBotReplacedPlayer::CoreKickIdleTimerStart(player, bot, params){
    if(::CoreSystem.IsKickIdle && !IsAdmin(player)){
        Timers.AddTimerByName("KickTimer" + CoreSystem.GetID(player).tostring(), CoreSystem.KickIdleTime, false, CoreSystem.KickIdlePlayer, player);    
    }
}

function Notifications::OnPlayerReplacedBot::CoreKickIdleTimerStop(player, bot, params){
    Timers.RemoveTimerByName("KickTimer" + CoreSystem.GetID(player).tostring());
}

function EasyLogic::OnBash::CoreBash(attacker, victim){
    local id = CoreSystem.GetID(attacker);

    if((id in ::CoreSystem.Saved.IsBashDisable) && (::CoreSystem.Saved.IsBashDisable[id])){
        return ALLOW_BASH_NONE; //没反应,即不会砍出去
    }
    else if((id in :: CoreSystem.Saved.IsBashLimited) && (::CoreSystem.Saved.IsBashLimited[id])){
        return ALLOW_BASH_PUSHONLY; //推一下
    }
}

function EasyLogic::OnTakeDamage::CoreTakeDamage(damagetable){
    local attacker = Utils.GetEntityOrPlayer(damagetable.Attacker);
    local victim = Utils.GetEntityOrPlayer(damagetable.Victim);

    local id = CoreSystem.GetID(victim);
    
    if((id in ::CoreSystem.Saved.IsGodEnable) && (::CoreSystem.Saved.IsGodEnable[id])){
        return false;   //不造成伤害
    }
}

function Notifications::OnDeath::CorePlayerDeath(victim, attacker, params){
    if(!attacker || !victim || attacker.GetTeam() != 2){
        return;
    }

    switch(victim.GetClassname()){
        case "infected":{
            ::CoreSystem.Info.CCZKill[attacker.GetIndex()]++;
            ::CoreSystem.Info.CGlobalCZKill++;
            break;
        }
        case "player":{
            ::CoreSystem.Info.CPZKill[attacker.GetIndex()]++;
            ::CoreSystem.Info.CGlobalPZKill++;
            switch(victim.GetPlayerType()){
                case 1:{
                    ::CoreSystem.Info.CSmokerKill[attacker.GetIndex()]++;
                    break;
                }
                case 2:{
                    ::CoreSystem.Info.CBoomerKill[attacker.GetIndex()]++;
                    break;
                }
                case 3:{
                    ::CoreSystem.Info.CHunterKill[attacker.GetIndex()]++;
                    break;
                }
                case 4:{
                    ::CoreSystem.Info.CSpitterKill[attacker.GetIndex()]++;
                    break;
                }
                case 5:{
                    ::CoreSystem.Info.CJockeyKill[attacker.GetIndex()]++;
                    break;
                }
                case 6:{
                    ::CoreSystem.Info.CChargerKill[attacker.GetIndex()]++;
                    break;
                }
                default:
                    ;
            }
        }
        case "witch":{
            //也许有用
        }
    }
}

function Notifications::OnHurt::CorePlayerHurt(victim, attacker, params){
    if(!attacker || !victim || attacker.GetTeam() != 2){
        return;
    }

    switch(victim.GetClassname()){
        case "infected":{
            //显示一些东西
            return;
        }
        case "player":{
            if((attacker.GetTeam() == victim.GetTeam()) && (attacker.GetIndex() != victim.GetIndex())){
                ::CoreSystem.Info.CFFDmg[attacker.GetIndex()] += params["dmg_health"];
            }
            else if(victim.GetPlayerType() == 8 && !IsIncapatitated(victim)){   //倒地后的伤害不计算
                ::CoreSystem.Info.CTankDmg[attacker.GetIndex()] += params["dmg_health"];
            }
        }
    }
}

function EasyLogic::OnUserCommand::CoreCommands(player, args, text){
    //指令分核心指令于非核心指令,核心指令必须管理员才能够使用,非核心指令特权玩家能用(关掉了IsAdminOnly)
    local command = GetArgument(0);

    if(command == "kill"){  //自杀不需要权限
        //是管理员可以杀别人,不然全部视为自杀
        CoreSystem.KillCmd(player, args);
        return;
    }

    if(!(CoreSystem.IsPrivileged(player))){
        player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }

    switch(command){    //非核心指令
        case "give":{
            CoreSystem.GiveCmd(player, args);
            break;
        }
        case "special":{
            CoreSystem.SpecialCmd(player, args);
            break;
        }
        case "common":{
            CoreSystem.CommonCmd(player, args);
            break;
        }
        case "set":{
            CoreSystem.SetCmd(player, args);
            break;
        }
        case "mode":{
            CoreSystem.ModeCmd(player, args);
            break;
        }
        case "god":{
            CoreSystem.GodCmd(player, args);
            break;
        }
        case "noclip":{
            CoreSystem.NoclipCmd(player, args);
            break;
        }
        default:
            ;
    }

    if(!(CoreSystem.IsAdmin(player))){
        player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }

    switch(command){    //核心指令
        case "admin_mode":{
            CoreSystem.AdminModeCmd(player, args);
            break;
        }
        case "incap":{
            CoreSystem.IncapCmd(player, args);
            break;
        }
        case "revive":{ //和扶起来一样
            CoreSystem.ReviveCmd(player, args);
            break;
        }
        case "defib":{  //和电起来一样
            CoreSystem.DefibCmd(player, args);
            break;
        }
        case "respwan":{    //复活
            CoreSystem.RespawnCmd(player, args);
            break;
        }
        case "vomit":{
            CoreSystem.VomitCmd(player, args);
            break;
        }
        case "freeze":{
            CoreSystem.FreezeCmd(player, args);
            break;
        }
        case "kick":{
            CoreSystem.KickCmd(player, args);
            break;
        }
        case "ban":{
            CoreSystem.BanCmd(player, args);
            break;
        }
        default:
            ;
    }

    if(!(CoreSystem.IsRoot(player))){
        player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }

    switch(command){    //仅限root用户
        case "add_admin":{
            CoreSystem.AddAdminCmd(player, args);
            break;
        }
        case "remove_admin":{
            CoreSystem.RemoveAdminCmd(player, args);
            break;
        }
        default:
            ;
    }
}

function ChatTriggers::admin_mode(player, args, text){
    CoreSystem.AdminModeCmd(player, args);
}

function ChatTriggers::add_admin(player, args, text){
    CoreSystem.AddAdminCmd(player, args);
}

function ChatTriggers::remove_admin(player, args, text){
    CoreSystem.RemoveAdminCmd(player, args);
}

function ChatTriggers::give(player, args, text){
    CoreSystem.GiveCmd(player, args);
}

function ChatTriggers::special(player, args, text){
    CoreSystem.SpecialCmd(player, args);
}

function ChatTriggers::common(player, args, text){
    CoreSystem.CommonCmd(player, args);
}

function ChatTriggers::set(player, args, text){
    CoreSystem.SetCmd(player, args);
}

function ChatTriggers::mode(player, args, text){
    CoreSystem.ModeCmd(player, args);
}

function ChatTriggers::incap(player, args, text){
    CoreSystem.IncapCmd(player, args);
}

function ChatTriggers::revive(player, args, text){
    CoreSystem.ReviveCmd(player, args);
}

function ChatTriggers::defib(player, args, text){
    CoreSystem.DefibCmd(player, args);
}

function ChatTriggers::respawn(player, args, text){
    CoreSystem.RespawnCmd(player, args);
}

function ChatTriggers::vomit(player, args, text){
    CoreSystem.VomitCmd(player, args);
}

function ChatTriggers::god(player, args, text){
    CoreSystem.GodCmd(player, args);
}

function ChatTriggers::noclip(player, args, text){
    CoreSystem.NoclipCmd(player, args);
}

function ChatTriggers::freeze(player, args, text){
    CoreSystem.FreezeCmd(player, args);
}

function ChatTriggers::kick(player, args, text){
    CoreSystem.KickCmd(player, args);
}

function ChatTriggers::ban(player, args, text){
    CoreSystem.BanCmd(player, args);
}

function ChatTriggers::kill(player, args, text){
    CoreSystem.KillCmd(player, args);
}

::CoreSystem.AddAdminCmd <- function(player, args){
    //!add_admin name
    //该指令仅限root用户
    local target = Utils.GetPlayerFromName(GetArgument(1));

    if(!(CoreSystem.IsRoot(player))){
        player.ShowHint("[ROOT]只有root用户能够添加管理员!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }

    if(target == null){
        player.ShowHint("[ROOT]玩家不存在或名字出错!", 3.0, "icon_alert", "", "200 50 50");
    }

    if(target.IsBot() && target.IsHumanSpectating()){
        target = target.GetHumanSpectator();
    }

    //local admins = FileToString("admins.txt");

    local steamid = target.GetSteamID();
    if(steamid == "BOT"){
        player.ShowHint("[ROOT]无法设置BOT为管理员!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }

    if(((steamid in ::CoreSystem.Saved.Admins) && (::CoreSystem.Saved.Admins[steamid]))){
        player.ShowHint("[ROOT]该玩家已经是管理员了!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }
    /*
    if(admins == null){
        admins = steamid.tostring();
    }
    else{
        admins += "\r\n" + steamid.tostring();
    }*/
    player.ShowHint("[ROOT]管理员添加成功!", 3.0, "icon_tip", "", "200 50 50");
    /*
    StringToFile("admins.txt", admins);
    CoreSystem.LoadAdmins();
    */
    ::CoreSystem.Saved.Admins[steamid] <- true;
}

::CoreSystem.RemoveAdminCmd <- function(player, args){
    //!remove_admin name
    //该指令仅限root用户
    local target = Utils.GetPlayerFromName(GetArgument(1));

    if(!(CoreSystem.IsRoot(player))){
        player.ShowHint("[ROOT]只有root用户能够删除管理员!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }

    if(target == null){
        player.ShowHint("[ROOT]玩家不存在或名字出错!", 3.0, "icon_alert", "", "200 50 50");
    }

    if(target.IsBot() && target.IsHumanSpectating()){
        target = target.GetHumanSpectator();
    }

    //local admins = FileToString("admins.txt");

    local steamid = target.GetSteamID();
    /*
    if(admins == null){
        player.ShowHint("[ROOT]无管理员!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }
    */
    if(!(CoreSystem.IsAdmin(player))){
        player.ShowHint("[ROOT]玩家非管理员!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }
    /*
    admins = Utils.StringReplace(admins, steamid, "");
    ::CoreSystem.Saved.admins = {};
    */
    player.ShowHint("[ROOT]管理员删除成功!", 3.0, "icon_tip", "", "200 50 50");
    /*
    StringToFile("admins.txt", admins);
    CoreSystem.LoadAdmins();
    */
    CoreSystem.Saved.Admins[steamid] = false;
}

::CoreSystem.AdminModeCmd <- function(player, args){
    //!admin_mode true/enable/on
    //!admin_mode false/disable/off
    //该指令仅限管理员
    local isAdminOnly = GetArgument(1);

    if(!(CoreSystem.IsAdmin(player))){
        player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }

    if(isAdminOnly == "true" || isAdminOnly == "enable" || isAdminOnly == "on"){
        if(!(CoreSystem.Saved.IsAdminOnly)){
            ::CoreSystem.Saved.IsAdminOnly = true;
            player.ShowHint("仅管理员模式开启!", 3.0, "icon_tip", "", "200 50 50");
        }
        else{
            player.ShowHint("仅管理员模式已经开启了!", 3.0, "icon_alert", "", "200 50 50");
        }
    }
    else if(isAdminOnly == "false" || isAdminOnly == "disable" || isAdminOnly == "off"){
        if(CoreSystem.Saved.IsAdminOnly){
            ::CoreSystem.Saved.IsAdminOnly = false;
            player.ShowHint("仅管理员模式关闭!", 3.0, "icon_tip", "", "200 50 50");
        }
        else{
            player.ShowHint("仅管理员模式已经关闭了!", 3.0, "icon_alert", "", "200 50 50");
        }
    }
}

::CoreSystem.IncapCmd <- function(player, args){
    //!incap name
    //!incap all
    //!incap bot/bots
    //该指令仅限管理员,管理员可以无条件放到非管理员(即使是god模式)

    local arg = GetArgument(1);

    if(!(CoreSystem.IsAdmin(player))){
        player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }

    if(arg == "all"){
        Convars.SetValue("god", 0);
        if(CoreSystem.IsRoot(player)){
            foreach(survivor in ::VSLib.EasyLogic.Players.AliveSurvivors()){
                local id = CoreSystem.GetID(survivor);
                if((id in ::CoreSystem.Saved.IsGodEnable) && (::CoreSystem.Saved.IsGodEnable[id])){
                    ::CoreSystem.Saved.IsGodEnable[id] <- false;
                }
                survivor.Incapacitate();    //function VSLib::Player::Incapacitate( dmgtype = 0, attacker = null )
            }
            player.ShowHint("[ROOT]已放倒所有人!", 3.0, "icon_info", "", "200 50 50");
        }
        else if(CoreSystem.IsAdmin(player)){
            foreach(survivor in ::VSLib.EasyLogic.Players.AliveSurvivors()){
                if(!(CoreSystem.IsAdmin(survivor))){
                    local id = CoreSystem.GetID(survivor);
                    if((id in ::CoreSystem.Saved.IsGodEnable) && (::CoreSystem.Saved.IsGodEnable[id])){
                        ::CoreSystem.Saved.IsGodEnable[id] <- false;
                    }
                    survivor.Incapacitate();
                }
            }
            player.ShowHint("已放倒所有非管理员!", 3.0, "icon_info", "", "200 50 50");
        }
        else{
            player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
            return;
        }
    }
    else if(arg == "bot" || arg == "bots"){
        foreach(survivor in ::VSLib.EasyLogic.Players.AliveSurvivorBots()){
            if(!(CoreSystem.IsAdmin(survivor))){
                local id = CoreSystem.GetID(survivor);
                if((id in ::CoreSystem.Saved.IsGodEnable) && (::CoreSystem.Saved.IsGodEnable[id])){
                    ::CoreSystem.Saved.IsGodEnable[id] <- false;
                }
                survivor.Incapacitate(); 
            }
        }
        player.ShowHint("已放倒所有BOT!", 3.0, "icon_info", "", "200 50 50");
    }
    else{
        local target = Utils.GetPlayerFromName(GetArgument(1));

        if(target == null){
            player.ShowHint("[ROOT]玩家不存在或名字出错!", 3.0, "icon_alert", "", "200 50 50");
            return;
        }

        local id = CoreSystem.GetID(target);
        if(id){
            if(CoreSystem.IsRoot(player)){
                if((id in ::CoreSystem.Saved.IsGodEnable) && (::CoreSystem.Saved.IsGodEnable[id])){
                    ::CoreSystem.Saved.IsGodEnable[id] <- false;
                }
                target.Incapacitate(); 
                player.ShowHint("[ROOT]成功放倒目标!", 3.0, "icon_info", "", "200 50 50");
            }
            else if(CoreSystem.IsAdmin(target)){
                player.ShowHint("无法放倒其他管理员!", 3.0, "icon_alert", "", "200 50 50");
                return;
            }
            else{
                if((id in ::CoreSystem.Saved.IsGodEnable) && (::CoreSystem.Saved.IsGodEnable[id])){
                    ::CoreSystem.Saved.IsGodEnable[id] <- false;
                }
                target.Incapacitate(); 
                player.ShowHint("成功放倒目标!", 3.0, "icon_info", "", "200 50 50");
            } 
        }
    }
}

::CoreSystem.ReviveCmd <- function(player, args){
    //!revive name
    //!revive all
    //!revive bot/bots
    //该指令仅限管理员

    local arg = GetArgument(1);

    if(!(CoreSystem.IsAdmin(player))){
        player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }

    if(arg == "all"){
        foreach(survivor in ::VSLib.EasyLogic.Players.IncapacitatedSurvivors()){
            survivor.Revive();
        }
        player.ShowHint("成功救起所有玩家!", 3.0, "icon_tip", "", "200 50 50");
    }
    else if(arg == "bot" || bot == "bots"){
        foreach(survivor in ::VSLib.EasyLogic.Players.IncapacitatedSurvivorBots()){
            survivor.Revive();
        }
        player.ShowHint("成功救起所有BOT!", 3.0, "icon_tip", "", "200 50 50");
    }
    else{
        local target = Utils.GetPlayerFromName(GetArgument(1));

        if(target == null){
            player.ShowHint("玩家不存在或名字出错!", 3.0, "icon_alert", "", "200 50 50");
            return;
        }

        target.Revive();
        player.ShowHint("成功救起目标!", 3.0, "icon_tip", "", "200 50 50");
    }
}

::CoreSystem.DefibCmd <- function(player, args){
    //!defib name
    //!defib all
    //!defib bot/bots
    //该指令仅限管理员

    local arg = GetArgument(1);

    if(!(CoreSystem.IsAdmin(player))){
        player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }

    if(arg == "all"){
        foreach(survivor in ::VSLib.EasyLogic.Players.DeadSurvivors()){
            survivor.Defib();
        }
        player.ShowHint("成功电击救起所有玩家!", 3.0, "icon_tip", "", "200 50 50");
    }
    else if(arg == "bot" || bot == "bots"){
        foreach(survivor in ::VSLib.EasyLogic.Players.DeadSurvivorBots()){
            survivor.Defib();
        }
        player.ShowHint("成功电击救起所有BOT!", 3.0, "icon_tip", "", "200 50 50");
    }
    else{
        local target = Utils.GetPlayerFromName(GetArgument(1));

        if(target == null){
            player.ShowHint("玩家不存在或名字出错!", 3.0, "icon_alert", "", "200 50 50");
            return;
        }

        target.Defib();
        player.ShowHint("成功电击救起目标!", 3.0, "icon_tip", "", "200 50 50");
    }
}

::CoreSystem.RespawnCmd <- function(player, args){
    //!respwan name
    //!respawn all
    //!respawn bot/bots
    //该指令仅限管理员

    local arg = GetArgument(1);
    local location = player.GetLocation();
    //电击与复活没有血量区别,但是我们将复活的人传送到复活他们的人的身边

    if(!(CoreSystem.IsAdmin(player))){
        player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }

    if(arg == "all"){
        foreach(survivor in ::VSLib.EasyLogic.Players.DeadSurvivors()){
            local SpawnPos = survivor.GetSpawnLocation();

            survivor.Defib();
            if(player.IsAlive()){
                survivor.SetLocation(location);
            }
            else{
                survivor.SetLocation(SpawnPos);
            }
        }
        player.ShowHint("成功复活所有玩家!", 3.0, "icon_tip", "", "200 50 50");
    }
    else if(arg == "bot" || arg == "bots"){
        foreach(survivor in ::VSLib.EasyLogic.Players.DeadSurvivorBots()){
            local SpawnPos = survivor.GetSpawnLocation();

            survivor.Defib();
            if(player.IsAlive()){
                survivor.SetLocation(location);
            }
            else{
                survivor.SetLocation(SpawnPos);
            }
        }
        player.ShowHint("成功复活所有BOT!", 3.0, "icon_tip", "", "200 50 50");
    }
    else{
        local target = Utils.GetPlayerFromName(GetArgument(1));

        if(target == null){
            player.ShowHint("玩家不存在或名字出错!", 3.0, "icon_alert", "", "200 50 50");
            return;
        }

        local SpawnPos = target.GetSpawnLocation();

        target.Defib();
        if(player.IsAlive()){
            target.SetLocation(location);
        }
        else{
            target.SetLocation(SpawnPos);
        }

        player.ShowHint("成功复活目标!", 3.0, "icon_tip", "", "200 50 50");
    }
}

::CoreSystem.VomitCmd <- function(player, args){
    //!vomit name
    //!vomit all
    //!vomit bot/bots
    //该指令仅限管理员

    local arg = GetArgument(1);

    if(!(CoreSystem.IsAdmin(player))){
        player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }

    if(arg == "all"){
        if(CoreSystem.IsRoot(player)){
            foreach(survivor in ::VSLib.EasyLogic.Players.AliveSurvivors()){
                survivor.Vomit(VomitDuration);    //function VSLib::Player::Vomit( duration = null )
            }
            player.ShowHint("[ROOT]已对所有人使用胆汁!", 3.0, "icon_info", "", "200 50 50");
        }
        else if(CoreSystem.IsAdmin(player)){
            foreach(survivor in ::VSLib.EasyLogic.Players.AliveSurvivors()){
                if(!(CoreSystem.IsAdmin(survivor))){
                    survivor.Vomit(VomitDuration);
                }
            }
            player.ShowHint("已对所有非管理员使用胆汁!", 3.0, "icon_info", "", "200 50 50");
        }
        else{
            player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
            return;
        }
    }
    else if(arg == "bot" || arg == "bots"){
        foreach(survivor in ::VSLib.EasyLogic.Players.AliveSurvivorBots()){
            if(!(CoreSystem.IsAdmin(survivor))){
                survivor.Vomit(VomitDuration); 
            }
        }
        player.ShowHint("已对所有BOT使用胆汁!", 3.0, "icon_info", "", "200 50 50");
    }
    else{
        local target = Utils.GetPlayerFromName(GetArgument(1));

        if(target == null){
            player.ShowHint("[ROOT]玩家不存在或名字出错!", 3.0, "icon_alert", "", "200 50 50");
            return;
        }

        local id = CoreSystem.GetID(target);

        if(id){
            if(CoreSystem.IsRoot(player)){
                target.Vomit(VomitDuration); 
                player.ShowHint("[ROOT]成功对目标使用胆汁!", 3.0, "icon_info", "", "200 50 50");
            }
            else if(CoreSystem.IsAdmin(target)){
                player.ShowHint("无法对其他管理员使用胆汁!", 3.0, "icon_alert", "", "200 50 50");
                return;
            }
            else{
                target.Vomit(VomitDuration); 
                player.ShowHint("成功对目标使用胆汁!", 3.0, "icon_info", "", "200 50 50");
            } 
        }
    }
}

::CoreSystem.FreezeCmd <- function(player, args){
    //!freeze name
    //!freeze all
    //!freeze bot/bots
    //该指令仅限管理员

    local arg = GetArgument(1);

    if(!(CoreSystem.IsAdmin(player))){
        player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }

    if(arg == "all"){
        if(CoreSystem.IsRoot(player)){
            foreach(survivor in ::VSLib.EasyLogic.Players.AliveSurvivors()){

                survivor.AddFlag(FL_FROZEN);  //function VSLib::Entity::AddFlag( flag )
                //survivor.AddFlag(FL_FREEZING);    //不知道有啥差别
                survivor.ShowHint("你已被冻结!", 3.0, "icon_alert", "", "200 50 50");
                Timers.AddTimerByName("FreezeTimer" + CoreSystem.GetID(survivor).tostring(), ::CoreSystem.FreezeDuration, false, ThawedPlayer, survivor);
            }
            player.ShowHint("[ROOT]已冻结所有人!", 3.0, "icon_info", "", "200 50 50");
        }
        else if(CoreSystem.IsAdmin(player)){
            foreach(survivor in ::VSLib.EasyLogic.Players.AliveSurvivors()){
                if(!(CoreSystem.IsAdmin(survivor))){

                    survivor.AddFlag(FL_FROZEN);  //function VSLib::Entity::AddFlag( flag )
                    //survivor.AddFlag(FL_FREEZING);    //不知道有啥差别
                    survivor.ShowHint("你已被冻结!", 3.0, "icon_alert", "", "200 50 50");
                    Timers.AddTimerByName("FreezeTimer" + CoreSystem.GetID(survivor).tostring(), ::CoreSystem.FreezeDuration, false, ThawedPlayer, survivor);
                }
            }
            player.ShowHint("已冻结所有非管理员!", 3.0, "icon_info", "", "200 50 50");
        }
        else{
            player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
            return;
        }
    }
    else if(arg == "bot" || arg == "bots"){
        foreach(survivor in ::VSLib.EasyLogic.Players.AliveSurvivorBots()){
            if(!(CoreSystem.IsAdmin(survivor))){

                survivor.AddFlag(FL_FROZEN);
                Timers.AddTimerByName("FreezeTimer" + CoreSystem.GetID(survivor).tostring(), ::CoreSystem.FreezeDuration, false, ThawedPlayer, survivor);
            }
        }
        player.ShowHint("已冻结所有BOT!", 3.0, "icon_info", "", "200 50 50");
    }
    else{
        local target = Utils.GetPlayerFromName(GetArgument(1));

        if(target == null){
            player.ShowHint("玩家不存在或名字出错!", 3.0, "icon_alert", "", "200 50 50");
            return;
        }

        local id = CoreSystem.GetID(target);

        if(id){
            if(CoreSystem.IsRoot(player)){

                target.AddFlag(FL_FROZEN);  //function VSLib::Entity::AddFlag( flag )
                //target.AddFlag(FL_FREEZING);    //不知道有啥差别
                target.ShowHint("你已被冻结!", 3.0, "icon_alert", "", "200 50 50");
                Timers.AddTimerByName("FreezeTimer" + CoreSystem.GetID(survivor).tostring(), ::CoreSystem.FreezeDuration, false, ThawedPlayer, survivor);
                player.ShowHint("[ROOT]成功冻结目标!", 3.0, "icon_info", "", "200 50 50");
            }
            else if(CoreSystem.IsAdmin(target)){

                player.ShowHint("无法冻结其他管理员!", 3.0, "icon_alert", "", "200 50 50");
                return;
            }
            else{

                target.AddFlag(FL_FROZEN);  //function VSLib::Entity::AddFlag( flag )
                //target.AddFlag(FL_FREEZING);    //不知道有啥差别
                target.ShowHint("你已被冻结!", 3.0, "icon_alert", "", "200 50 50");
                Timers.AddTimerByName("FreezeTimer" + CoreSystem.GetID(survivor).tostring(), ::CoreSystem.FreezeDuration, false, ThawedPlayer, survivor);
                player.ShowHint("成功冻结目标!", 3.0, "icon_info", "", "200 50 50");
            } 
        }
    }
}

::ThawedPlayer <- function(player){
    player.RemoveFlag(FL_FROZEN);
    player.ShowHint("你已被解冻!", 3.0, "icon_info", "", "200 50 50");
    //player.RemoveFlag(FL_FREEZING);    //不知道有啥差别
}

::CoreSystem.KickCmd <- function(player, args){
    //!kick name [reason]
    //该指令仅限管理员使用

    local target = Utils.GetPlayerFromName(GetArgument(1));
    local reason = GetArgument(2);

    if(!(CoreSystem.IsAdmin(player))){
        player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }

    if(target == null){
        player.ShowHint("[ROOT]玩家不存在或名字出错!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }

    if(target.IsBot() && target.IsHumanSpectating()){
        target = target.GetHumanSpectator();
    }

    local steamid = target.GetSteamID();

    if(steamid != "BOT"){
        if(CoreSystem.IsRoot(player)){
            if(reason){ // todo 设置一些快捷理由
                foreach(survivor in ::VSLib.EasyLogic.Players.Survivors()){
                    survivor.ShowHint(target.GetName() + "因" + reason + "被root用户踢出!", 3.0, "icon_alert", "", "200 50 50");
                }
                SendToServerConsole("kick " + steamid + " 你因" + reason + "被root用户踢出!");
            }
            else{
                foreach(survivor in ::VSLib.EasyLogic.Players.Survivors()){
                    survivor.ShowHint(target.GetName() + "被root用户踢出!", 3.0, "icon_alert", "", "200 50 50");
                }
                SendToServerConsole("kick " + steamid + " 你被root用户踢出!");
            }
            player.ShowHint("[ROOT]成功踢出目标!", 3.0, "icon_info", "", "200 50 50");
        }
        else if(CoreSystem.IsAdmin(target)){
            player.ShowHint("无法踢出其他管理员!", 3.0, "icon_alert", "", "200 50 50");
            return;
        }
        else{
            if(reason){
                foreach(survivor in ::VSLib.EasyLogic.Players.Survivors()){
                    survivor.ShowHint(target.GetName() + "因" + reason + "被管理员踢出!", 3.0, "icon_alert", "", "200 50 50");
                }
                SendToServerConsole("kick " + steamid + " 你因" + reason + "被管理员踢出!");
            }
            else{
                foreach(survivor in ::VSLib.EasyLogic.Players.Survivors()){
                    survivor.ShowHint(target.GetName() + "被管理员踢出!", 3.0, "icon_alert", "", "200 50 50");
                }
                SendToServerConsole("kick " + steamid + " 你被管理员踢出!");
            }
            player.ShowHint("成功踢出目标!", 3.0, "icon_info", "", "200 50 50");
        } 
    }
    else{
        SendToServerConsole("kick " + target.GetName());
    }
}

::CoreSystem.BanCmd <- function(player, args){
    //!ban name [reason]
    //该指令仅限管理员使用

    local target = Utils.GetPlayerFromName(GetArgument(1));
    local reason = GetArgument(2);

    if(!(CoreSystem.IsAdmin(player))){
        player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }

    if(target == null){
        player.ShowHint("玩家不存在或名字出错!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }

    if(target.IsBot() && target.IsHumanSpectating()){
        target = target.GetHumanSpectator();
    }

    local steamid = target.GetSteamID();
    //local bannedPlayers = FileToString("banned.txt");

    if(steamid == "BOT" || !steamid){
        player.ShowHint("无法封禁BOT!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }

    if(CoreSystem.IsRoot(player)){
        if(reason){ // todo 设置一些快捷理由
            foreach(survivor in ::VSLib.EasyLogic.Players.Survivors()){
                survivor.ShowHint(target.GetName() + "因" + reason + "被root用户封禁!", 3.0, "icon_alert", "", "200 50 50");
            }
            SendToServerConsole("kick " + steamid + " 你因" + reason + "被root用户封禁!");
        }
        else{
            foreach(survivor in ::VSLib.EasyLogic.Players.Survivors()){
                survivor.ShowHint(target.GetName() + "被root用户封禁!", 3.0, "icon_alert", "", "200 50 50");
            }
            SendToServerConsole("kick " + steamid + " 你被root用户封禁!");
        }
        player.ShowHint("[ROOT]成功封禁目标!", 3.0, "icon_info", "", "200 50 50");
    }
    else if(CoreSystem.IsAdmin(target)){
        player.ShowHint("无法封禁其他管理员!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }
    else{
        if(reason){
            foreach(survivor in ::VSLib.EasyLogic.Players.Survivors()){
                survivor.ShowHint(target.GetName() + "因" + reason + "被管理员封禁!", 3.0, "icon_alert", "", "200 50 50");
            }
            SendToServerConsole("kick " + steamid + " 你因" + reason + "被管理员封禁!");
        }
        else{
            foreach(survivor in ::VSLib.EasyLogic.Players.Survivors()){
                survivor.ShowHint(target.GetName() + "被管理员封禁!", 3.0, "icon_alert", "", "200 50 50");
            }
            SendToServerConsole("kick " + steamid + " 你被管理员封禁!");
        }
        player.ShowHint("成功封禁目标!", 3.0, "icon_info", "", "200 50 50");
    } 
    /*
    if(bannedPlayers == null){
        bannedPlayers = steamid;
    }
    else{
        bannedPlayers += "\r\n" + steamid;
    }
    StringToFile("banned.txt", bannedPlayers);
    CoreSystem.LoadBanned();
    */
    CoreSystem.Saved.BannedPlayers[steamid] <- ture;
}

::CoreSystem.GiveCmd <- function(player, args){
    //!give itemname
    //!give itemname all
    //该指令仅限特权玩家使用

    if(!(CoreSystem.IsPrivileged(player))){
        player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }

    local itemname = GetArgument(1);
    local isAll = GetArgument(2);

    itemname = itemNameAssociation(itemname);
    if(isAll == "all"){
        foreach(survivor in ::VSLib.EasyLogic.Players.AliveSurvivors()){
            survivor.Give(itemname);
        }
    }
    else if(isAll == null){
        player.Give(itemname);
    }
    else{
        player.ShowHint("格式错误!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }
}

::CoreSystem.SpecialCmd <- function(player, args){
    //!special limit 12
    //!special limit hunter 0
    //!special limit change 2   //每多一位玩家多两只特感(默认为0)
    //!special respawn 15
    //!special respawn change 3 //每多一位玩家特感复活时间减少三秒(默认为0)

    if(!(CoreSystem.IsPrivileged(player))){
        player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }
    local command = GetArgument(1);
    local arg1 = GetArgument(2);
    local arg2 = GetArgument(3);

    if(!arg2){
        //两参数指令
        /*
        if(typeof arg1 != "integer" || typeof command != "string"){
            player.ShowHint("两参数特感命令格式输入错误!", 3.0, "icon_alert", "", "200 50 50");
            return;
        }
        */
        arg1 = arg1.tointeger();
        if(command == "limit"){
            //对于特感数量不做限制,因为引擎本身就有限制,只需要保证输入的值不小于0即可
            if(arg1 <= 0){
                ::CoreSystem.Control.CBoomerLimit = 0;
                ::CoreSystem.Control.CChargerLimit = 0;
                ::CoreSystem.Control.CHunterLimit = 0;
                ::CoreSystem.Control.CJockeyLimit = 0;
                ::CoreSystem.Control.CSmokerLimit = 0;
                ::CoreSystem.Control.CSpitterLimit = 0;

                ::CoreSystem.Control.CSpecialMax = 0;
                //设置一个HUD显示谁修改了
                BuildChangeHud(CHANGE_SPECIAL_LIMIT, player, 0);
                return;
            }
            else{
                if(arg1 > ::CoreSystem.Control.CSpecialMax){
                    local n = arg1 - ::CoreSystem.Control.CSpecialMax;
                    while(n-- > 0){
                        //给予减少补偿
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
                    BuildChangeHud(CHANGE_SPECIAL_LIMIT, player, arg1);
                    return;
                }
                else if(arg1 < ::CoreSystem.Control.CSpecialMax){
                    local n = ::CoreSystem.Control.CSpecialMax - arg1;
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
                    BuildChangeHud(CHANGE_SPECIAL_LIMIT, player, arg1);
                    return;
                }
            }
        }
        else if(command == "respawn"){
            if(arg1 <= 1){
                arg1 = 1;   //复活时间不要低于1秒,虽然由于引擎限制复活时间会长于实际
            }
            ::CoreSystem.Control.CSpecialInitial = arg1;
            BuildChangeHud(CHANGE_SPECIAL_RESPAWN, player, arg1);
            return;
        }
        else{
            player.ShowHint("未找到该两参数特感指令!", 3.0, "icon_alert", "", "200 50 50");
            return;
        } 
    }
    else{
        //三参数
        /*
        if(typeof arg2 != "integer" || typeof command != "string" || typeof arg1 != "string"){
            player.ShowHint("三参数特感命令格式输入错误!", 3.0, "icon_alert", "", "200 50 50");
            return;
        }
        */
        arg2 = arg2.tointeger();
        if(command == "limit"){
            if(arg1 == "change"){
                //如果是改变没增一个玩家特感数量的增减,不需要判断数值正负,在Update函数中再判断减少后的数量是否符合要求
                ::CoreSystem.Control.CSpecialMaxChange = arg2;
                BuildChangeHud(CHANGE_SPECIAL_LIMIT_CHANGE, player, arg2);
                return;
            }
            if(arg2 < 0){
                arg2 = 0;
            }
            switch(arg1){
                case "boomer":{
                    ::CoreSystem.Control.CSpecialMax += (arg2 - ::CoreSystem.Control.CBoomerLimit);
                    //先减去原来的量再加上调整的量
                    ::CoreSystem.Control.CBoomerLimit = arg2;
                    break;
                }
                case "hunter":{
                    ::CoreSystem.Control.CSpecialMax += (arg2 - ::CoreSystem.Control.CHunterLimit);
                    ::CoreSystem.Control.CHunterLimit = arg2;
                    break;
                }
                case "spitter":{
                    ::CoreSystem.Control.CSpecialMax += (arg2 - ::CoreSystem.Control.CSpitterLimit);
                    ::CoreSystem.Control.CSpitterLimit = arg2;
                    break;
                }
                case "charger":{
                    ::CoreSystem.Control.CSpecialMax += (arg2 - ::CoreSystem.Control.CChargerLimit);
                    ::CoreSystem.Control.CChargerLimit = arg2;
                    break;
                }
                case "jockey":{
                    ::CoreSystem.Control.CSpecialMax += (arg2 - ::CoreSystem.Control.CJockeyLimit);
                    ::CoreSystem.Control.CJockeyLimit = arg2;
                    break;
                }
                case "smoker":{
                    ::CoreSystem.Control.CSpecialMax += (arg2 - ::CoreSystem.Control.CSmokerLimit);
                    ::CoreSystem.Control.CSmokerLimit = arg2;
                    break;
                }
                default:{
                    player.ShowHint("特感名字输入错误!", 3.0, "icon_alert", "", "200 50 50");
                    return;
                }
            }
            BuildChangeHud(CHANGE_SPECIAL_LIMIT, player, arg2, arg1);
            return;
        }
        else if(command == "respawn" && arg1 == "change"){
            //数值可正可负,在Update函数中再判断减少后的时间是否符合要求
            ::CoreSystem.Control.CSpecialInitialChange = arg2;
            BuildChangeHud(CHANGE_SPECIAL_RESPAWN_CHANGE, player, arg2);
            return;
        }
        else{
            player.ShowHint("未找到该三参数特感指令!", 3.0, "icon_alert", "", "200 50 50");
            return;
        }
    }
}

::CoreSystem.CommonCmd <- function(player, args){
    //!common limit 20
    //!common limit change 10

    if(!(CoreSystem.IsPrivileged(player))){
        player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }

    local command = GetArgument(1);
    local arg1 = GetArgument(2);
    local arg2 = GetArgument(3);


    if(!arg2){
        //两参数
        /*
        if(typeof arg1 != "integer" || typeof command != "string"){
            player.ShowHint("两参数普感命令格式输入错误!", 3.0, "icon_alert", "", "200 50 50");
            return;
        }
        */
        arg1 = arg1.tointeger();
        if(command == "limit"){
            if(arg1 < 0){
                arg1 = 0;
            }
            ::CoreSystem.Control.CCommonLimit = arg1;
            BuildChangeHud(CHANGE_COMMON_LIMIT, player, arg1);
            return;
        }
        else{
            player.ShowHint("未找到该两参数普感指令!", 3.0, "icon_alert", "", "200 50 50");
            return;
        }
    }
    else{
        //三参数
        /*
        if(typeof arg1 != "string" || typeof command != "string" || typeof arg2 != "integer"){
            player.ShowHint("两参数普感命令格式输入错误!", 3.0, "icon_alert", "", "200 50 50");
            return;
        }
        */
        arg2 = arg2.tointeger();
        if(command == "limit"){
            if(arg1 == "change"){
                ::CoreSystem.Control.CCommonLimitChange = arg2;
                BuildChangeHud(CHANGE_COMMON_LIMIT_CHANGE, player, arg2);
                return;
            }
        }
        else{
            player.ShowHint("未找到该三参数普感指令!", 3.0, "icon_alert", "", "200 50 50");
            return;
        }
    }
}

::CoreSystem.SetCmd <- function(player, args){
    //!set smg 2    冲锋枪可以拿取两次
    //!set shotgun 2
    //!set rifle 2
    //!set sniper 2
    //!set gun 2    //所有枪都可以拿取两次
    //!set supply   //药可以拿取两次
    //!set ammobackup 2   //两倍后备子弹
    //!set ammo 2    //两倍前置子弹
    //!set health/hp 200    //设置200最大血量
    //......更多想法

    if(!(CoreSystem.IsPrivileged(player))){
        player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }

    local type = GetArgument(2);
    local value = GetArgument(3);

    /*
    if(typeof value != "integer" || typeof type != "string"){
        player.ShowHint("设置参数命令格式输入错误!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }
    */
    switch(type){
        case "pistol":{
            foreach(pistol in ::ItemInventory.Pistol){
                SetEntityGrabCount(pistol, value);
            }
            break;
        }
        case "smg":{
            foreach(smg in ::ItemInventory.Smg){
                SetEntityGrabCount(smg, value);
            }
            break;
        }
        case "shotgun":{
            foreach(shotgun in ::ItemInventory.Shotgun){
                SetEntityGrabCount(shotgun, value);
            }
            break;
        }
        case "rifle":{
            foreach(rifle in ::ItemInventory.Rifle){
                SetEntityGrabCount(rifle, value);
            }
            break;
        }
        case "sniper":{
            foreach(sniper in ::ItemInventory.Sniper){
                SetEntityGrabCount(sniper, value);
            }
            break;
        }
        case "gun":{
            foreach(inventory in ::ItemInventory){
                foreach(gun in inventory){  //大胆的尝试,很大几率不可用
                    SetEntityGrabCount(gun, value);
                }
            }
            break;
        }
        case "ammo":{
            //设置前置子弹量是一个麻烦事,如果使用NetProp会伴随很多新问题,如该方法只能修改玩家当前手中的武器,如果玩家换武器设置就失效了
            //除非在每次玩家捡起物品时判断捡起的是否是主武器/副武器,是的话就修改
            ::CoreSystem.Saved.MultiAmmo = value;
        }
        case "ammobackup":{
            //问题来了,是设置convar更快，更好还是使用NetProp？
            /*
            local assaultrifle = 360;   //记录下某把枪的备弹量作为依据,防止备弹量呈次数叠加
            local multi = (Convars.GetFloat("ammo_assaultrifle_max") / 360).tointeger();
            Convars.SetValue("ammo_assaultrifle_max", (Convars.GetFloat("ammo_assaultrifle_max") * value / multi);
            Convars.SetValue("ammo_autoshotgun_max", (Convars.GetFloat("ammo_autoshotgun_max") * value / multi));
            Convars.SetValue("ammo_grenadelauncher_max", (Convars.GetFloat("ammo_grenadelauncher_max") * value / multi));
            Convars.SetValue("ammo_huntingrifle_max", (Convars.GetFloat("ammo_huntingrifle_max") * value / multi));
            Convars.SetValue("ammo_minigun_max", (Convars.GetFloat("ammo_minigun_max") * value / multi));
            Convars.SetValue("ammo_shotgun_max", (Convars.GetFloat("ammo_shotgun_max") * value / multi));
            Convars.SetValue("ammo_smg_max", (Convars.GetFloat("ammo_smg_max") * value / multi));
            Convars.SetValue("ammo_sniperrifle_max", (Convars.GetFloat("ammo_sniperrifle_max") * value / multi));
            ::CoreSystem.Cvar.CMaxAmmo = value / multi;
            */
            //设置后备子弹量是一个麻烦事,如果使用NetProp会伴随很多新问题,如该方法只能修改玩家当前手中的武器,如果玩家换武器设置就失效了
            //除非在每次玩家捡起物品时判断捡起的是否是主武器/副武器,是的话就修改
            ::CoreSystem.Saved.MultiBackupAmmo = value;
        }
        case "hp":
        case "health":{
            if(value < 0){
                value = 0;
            }
            local _hp = 0;
            local _buffer = 0;
            foreach(survivor in ::VSLib.EasyLogic.Players.Survivors()){
                _hp = survivor.GetHealth();
                _buffer = survivor.GetHealthBuffer();
                if(_hp + _buffer > value){
                    if(_hp > value){
                        survivor.SetHealth(value);
                        survivor.SetHealthBuffer(0);
                    }
                    else{
                        survivor.SetHealthBuffer(value - _hp);
                    }
                }
                survivor.SetMaxHealth(value);
                ::CoreSystem.Cvar.CMaxHealth = value;
            }

            if(value * 0.4 > 1){
                Convars.SetValue("survivor_limp_health", (value * 0.4).tointeger());
                ::CoreSystem.Cvar.CLimpHealth = (value * 0.4).tointeger();
            }
            else{
                Convars.SetValue("survivor_limp_health", 1);
                ::CoreSystem.Cvar.CLimpHealth = 1;
            }

            if(value > 1){
                Convars.SetValue("first_aid_kit_max_heal", value.tointeger());
                ::CoreSystem.Cvar.CFirstAidKitHealth = value.tointeger();
                Convars.SetValue("pain_pills_health_threshold", (value - 1).tointeger()); 
                ::CoreSystem.Cvar.CPainPillsThreshold = (value - 1).tointeger();
            }
            else{
                Convars.SetValue("first_aid_kit_max_heal", 1);
                ::CoreSystem.Cvar.CFirstAidKitHealth = 1;
                Convars.SetValue("pain_pills_health_threshold", 1); 
                ::CoreSystem.Cvar.CPainPillsThreshold = 1;
            }

            if(value * 0.5 > 1){
                Convars.SetValue("pain_pills_health_value", (value * 0.5).tointeger());
                ::CoreSystem.Cvar.CPainPillsHealth = (value * 0.5).tointeger();
                Convars.SetValue("z_survivor_respawn_health", (value * 0.5).tointeger());
                ::CoreSystem.Cvar.CRespawnHealth = (value * 0.5).tointeger();
            }
            else{
                Convars.SetValue("pain_pills_health_value", 1);
                ::CoreSystem.Cvar.CPainPillsHealth = 1;
                Convars.SetValue("z_survivor_respawn_health", 1);
                ::CoreSystem.Cvar.CRespawnHealth = 1;
            }

            if(value * 0.3 > 1){
                Convars.SetValue("survivor_revive_health", (value * 0.3).tointeger());
                ::CoreSystem.Cvar.CReviveHealth = (value * 0.3).tointeger();
            }
            else{
                Convars.SetValue("survivor_revive_health", 1);
                ::CoreSystem.Cvar.CReviveHealth = 1;
            }

            if(value * 0.25 > 1){
                Convars.SetValue("adrenaline_health_buffer", (value * 0.25).tointeger());
                ::CoreSystem.Cvar.CAdrenalineHealth = (value * 0.25).tointeger();
            }
            else{
                Convars.SetValue("adrenaline_health_buffer", 1);
                ::CoreSystem.Cvar.CAdrenalineHealth = 1;
            }

            /*
            //不能这么写还是挺可惜的
            (value * 0.25).tointeger() > 1
            ? 
            (
            Convars.SetValue("survivor_limp_health", (value * 0.4).tointeger());
            ::CoreSystem.Cvar.CLimpHealth = (value * 0.4).tointeger();
            Convars.SetValue("first_aid_kit_max_heal", value.tointeger());
            ::CoreSystem.Cvar.CFirstAidKitHealth = value.tointeger();
            Convars.SetValue("pain_pills_health_threshold", (value - 1).tointeger()); 
            ::CoreSystem.Cvar.CPainPillsThreshold = (value - 1).tointeger();
            Convars.SetValue("pain_pills_health_value", (value * 0.5).tointeger());
            ::CoreSystem.Cvar.CPainPillsHealth = (value * 0.5).tointeger();
            Convars.SetValue("z_survivor_respawn_health", (value * 0.5).tointeger());
            ::CoreSystem.Cvar.CRespawnHealth = (value * 0.5).tointeger();
            Convars.SetValue("adrenaline_health_buffer", (value * 0.25).tointeger());
            ::CoreSystem.Cvar.CAdrenalineHealth = (value * 0.25).tointeger();
            ) 
            : 
            (
            Convars.SetValue("survivor_limp_health", 1);
            ::CoreSystem.Cvar.CLimpHealth = 1;
            Convars.SetValue("first_aid_kit_max_heal", 1);
            ::CoreSystem.Cvar.CFirstAidKitHealth = 1;
            Convars.SetValue("pain_pills_health_threshold", 1); 
            ::CoreSystem.Cvar.CPainPillsThreshold = 1;
            Convars.SetValue("pain_pills_health_value", 1);
            ::CoreSystem.Cvar.CPainPillsHealth = 1;
            Convars.SetValue("z_survivor_respawn_health", 1);
            ::CoreSystem.Cvar.CRespawnHealth = 1;
            Convars.SetValue("adrenaline_health_buffer", 1);
            ::CoreSystem.Cvar.CAdrenalineHealth = 1;    
            )
            */
        }
    }
}

::CoreSystem.ModeCmd <- function(player, args){





















}

::CoreSystem.GodCmd <- function(player, args){
    //!god
    //!god name
    //!god all

    if(!(CoreSystem.IsPrivileged(player))){
        player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }

    local target = GetArgument(1);
    /*
    if(typeof target != "string" || typeof target != null){
        player.ShowHint("GOD命令格式输入错误!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }
    */
    if(target == null){
        //仅对自己
        local id = CoreSystem.GetID(player);
        if((id in ::CoreSystem.Saved.IsGodEnable) && (::CoreSystem.Saved.IsGodEnable[id])){
            ::CoreSystem.Saved.IsGodEnable[id] <- false;
            player.ShowHint("GOD模式已关闭!", 3.0, "icon_alert", "", "200 50 50");
        }
        else{
            ::CoreSystem.Saved.IsGodEnable[id] <- true;
            player.ShowHint("GOD模式已开启!", 3.0, "icon_alert", "", "200 50 50");
        }
    }
    else{
        if(target == "all"){
            foreach(survivor in ::VSLib.EasyLogic.Players.AliveSurvivors()){
                local id = CoreSystem.GetID(survivor);
                if((id in ::CoreSystem.Saved.IsGodEnable) && (::CoreSystem.Saved.IsGodEnable[id])){
                    ::CoreSystem.Saved.IsGodEnable[id] <- false;
                    survivor.ShowHint("GOD模式已关闭!", 3.0, "icon_alert", "", "200 50 50");
                }
                else{
                    ::CoreSystem.Saved.IsGodEnable[id] <- true;
                    survivor.ShowHint("GOD模式已开启!", 3.0, "icon_alert", "", "200 50 50");
                }
            }
        }
        else{
            local _player = Utils.GetPlayerFromName(target);
            
            if(_player == null){
                player.ShowHint("玩家不存在或名字出错!", 3.0, "icon_alert", "", "200 50 50");
                return;
            }
            else{
                local id = CoreSystem.GetID(_player);

                if((id in ::CoreSystem.Saved.IsGodEnable) && (::CoreSystem.Saved.IsGodEnable[id])){
                    ::CoreSystem.Saved.IsGodEnable[id] <- false;
                    survivor.ShowHint("GOD模式已关闭!", 3.0, "icon_alert", "", "200 50 50");
                }
                else{
                    ::CoreSystem.Saved.IsGodEnable[id] <- true;
                    survivor.ShowHint("GOD模式已开启!", 3.0, "icon_alert", "", "200 50 50");
                }
            }
        }
    }
}

::CoreSystem.NoclipCmd <- function(player, args){
    //!noclip
    //!noclip name
    //!noclip all

    if(!(CoreSystem.IsPrivileged(player))){
        player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }

    local target = GetArgument(1);
    /*
    if(typeof target != "string" || typeof target != null){
        player.ShowHint("飞行命令格式输入错误!", 3.0, "icon_alert", "", "200 50 50");
        return;
    }
    */
    if(target == null){
        //仅对自己
        local id = CoreSystem.GetID(player);
        if((id in ::CoreSystem.Saved.IsNoclipEnable) && (::CoreSystem.Saved.IsNoclipEnable[id])){
            ::CoreSystem.Saved.IsNoclipEnable[id] <- false;
            player.SetNetProp("movetype", 2);
            player.ShowHint("飞行模式已关闭!", 3.0, "icon_alert", "", "200 50 50");
        }
        else{
            ::CoreSystem.Saved.IsNoclipEnable[id] <- true;
            player.SetNetProp("movetype", 8);
            player.ShowHint("飞行模式已开启!", 3.0, "icon_alert", "", "200 50 50");
        }
    }
    else{
        if(target == "all"){
            foreach(survivor in ::VSLib.EasyLogic.Players.AliveSurvivors()){
                local id = CoreSystem.GetID(survivor);
                if((id in ::CoreSystem.Saved.IsNoclipEnable) && (::CoreSystem.Saved.IsNoclipEnable[id])){
                    ::CoreSystem.Saved.IsNoclipEnable[id] <- false;
                    player.SetNetProp("movetype", 2);
                    survivor.ShowHint("飞行模式已关闭!", 3.0, "icon_alert", "", "200 50 50");
                }
                else{
                    ::CoreSystem.Saved.IsNoclipEnable[id] <- true;
                    player.SetNetProp("movetype", 8);
                    survivor.ShowHint("飞行模式已开启!", 3.0, "icon_alert", "", "200 50 50");
                }
            }
        }
        else{
            local _player = Utils.GetPlayerFromName(target);
            
            if(_player == null){
                player.ShowHint("玩家不存在或名字出错!", 3.0, "icon_alert", "", "200 50 50");
                return;
            }
            else{
                local id = CoreSystem.GetID(_player);

                if((id in ::CoreSystem.Saved.IsNoclipEnable) && (::CoreSystem.Saved.IsNoclipEnable[id])){
                    ::CoreSystem.Saved.IsNoclipEnable[id] <- false;
                    player.SetNetProp("movetype", 2);
                    survivor.ShowHint("飞行模式已关闭!", 3.0, "icon_alert", "", "200 50 50");
                }
                else{
                    ::CoreSystem.Saved.IsNoclipEnable[id] <- true;
                    player.SetNetProp("movetype", 8);
                    survivor.ShowHint("飞行模式已开启!", 3.0, "icon_alert", "", "200 50 50");
                }
            }
        }
    }
}

::CoreSystem.KillCmd <- function(player, args){
    //!kill 自杀
    //!kill name    非管理员一样自杀,管理员则杀死目标
    //!kill all
    //!kill bot/bots
    //该指令仅限管理员,管理员可以无条件杀死非管理员(即使是god模式)

    local arg = GetArgument(1);

    if(arg == null){
        player.ShowHint("自杀成功!", 3.0, "icon_tip", "", "200 50 50");
        player.Kill(); 
        return;
    }


    if(!(CoreSystem.IsAdmin(player))){
        player.ShowHint("自杀成功!", 3.0, "icon_tip", "", "200 50 50");
        player.Kill();
        return;
    }

    if(arg == "all"){
        Convars.SetValue("god", 0);
        if(CoreSystem.IsRoot(player)){
            foreach(survivor in ::VSLib.EasyLogic.Players.AliveSurvivors()){
                local id = CoreSystem.GetID(survivor);
                if((id in ::CoreSystem.Saved.IsGodEnable) && (::CoreSystem.Saved.IsGodEnable[id])){
                    ::CoreSystem.Saved.IsGodEnable[id] <- false;
                }
                survivor.Kill();    //function VSLib::Player::Kill()( dmgtype = 0, attacker = null )
            }
            player.ShowHint("[ROOT]已杀死所有人!", 3.0, "icon_info", "", "200 50 50");
        }
        else if(CoreSystem.IsAdmin(player)){
            foreach(survivor in ::VSLib.EasyLogic.Players.AliveSurvivors()){
                if(!(CoreSystem.IsAdmin(survivor))){
                    local id = CoreSystem.GetID(survivor);
                    if((id in ::CoreSystem.Saved.IsGodEnable) && (::CoreSystem.Saved.IsGodEnable[id])){
                        ::CoreSystem.Saved.IsGodEnable[id] <- false;
                    }
                    survivor.Kill()();
                }
            }
            player.ShowHint("已杀死所有非管理员!", 3.0, "icon_info", "", "200 50 50");
        }
        else{
            player.ShowHint("权限不足!", 3.0, "icon_alert", "", "200 50 50");
            return;
        }
    }
    else if(arg == "bot" || arg == "bots"){
        foreach(survivor in ::VSLib.EasyLogic.Players.AliveSurvivorBots()){
            if(!(CoreSystem.IsAdmin(survivor))){
                local id = CoreSystem.GetID(survivor);
                if((id in ::CoreSystem.Saved.IsGodEnable) && (::CoreSystem.Saved.IsGodEnable[id])){
                    ::CoreSystem.Saved.IsGodEnable[id] <- false;
                }
                survivor.Kill(); 
            }
        }
        player.ShowHint("已杀死所有BOT!", 3.0, "icon_info", "", "200 50 50");
    }
    else{
        local target = Utils.GetPlayerFromName(GetArgument(1));

        if(target == null){
            player.ShowHint("[ROOT]玩家不存在或名字出错!", 3.0, "icon_alert", "", "200 50 50");
            return;
        }

        local id = CoreSystem.GetID(target);
        if(id){
            if(CoreSystem.IsRoot(player)){
                if((id in ::CoreSystem.Saved.IsGodEnable) && (::CoreSystem.Saved.IsGodEnable[id])){
                    ::CoreSystem.Saved.IsGodEnable[id] <- false;
                }
                target.Kill(); 
                player.ShowHint("[ROOT]成功杀死目标!", 3.0, "icon_info", "", "200 50 50");
            }
            else if(CoreSystem.IsAdmin(target)){
                player.ShowHint("无法杀死其他管理员!", 3.0, "icon_alert", "", "200 50 50");
                return;
            }
            else{
                if((id in ::CoreSystem.Saved.IsGodEnable) && (::CoreSystem.Saved.IsGodEnable[id])){
                    ::CoreSystem.Saved.IsGodEnable[id] <- false;
                }
                target.Kill(); 
                player.ShowHint("成功杀死目标!", 3.0, "icon_info", "", "200 50 50");
            } 
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
        case "fire":
        case "火":
        case "火瓶":
            return "molotov";
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

::BuildChangeHud <- function(type, player, value, ...){
    //vargv[0]用来接收修改指定特感指令的特感名称

    if(!player){
        return;
    }

    local _hud_change = HUD.Item("\n{name}\n{act}\n{value}\n");
    _hud_change.SetValue("name", player.GetName());

    switch(type){
        case CHANGE_SPECIAL_LIMIT:{
            if(vargv.len() != 0){
                _hud_change.SetValue("act", "设置" + vargv[0] + "数量为");
            }
            else{
                _hud_change.SetValue("act", "设置特感数量为");
            }
            _hud_change.SetValue("value", value + "只");
            break;
        }
        case CHANGE_SPECIAL_LIMIT_CHANGE:{
            _hud_change.SetValue("act", "设置每增加一名玩家增加特感");
            _hud_change.SetValue("value", value + "只");
            break;
        }
        case CHANGE_SPECIAL_RESPAWN:{
            _hud_change.SetValue("act", "设置特感重生时间为");
            _hud_change.SetValue("value", value + "秒");
            break;
        }
        case CHANGE_SPECIAL_RESPAWN_CHANGE:{
            _hud_change.SetValue("act", "设置每增加一名玩家特感复活减少");
            _hud_change.SetValue("value", value + "秒");
            break;
        }
        case CHANGE_COMMON_LIMIT:{
            _hud_change.SetValue("act", "设置普感数量为");
            _hud_change.SetValue("value", value + "只");
            break;
        }
        case CHANGE_COMMON_LIMIT_CHANGE:{
            _hud_change.SetValue("act", "设置每增加一名玩家增加普感");
            _hud_change.SetValue("value", value + "只");
            break;
        }
        default:
            ;
    }

    _hud_change.AttachTo(HUD_FAR_LEFT);
    _hud_change.ChangeHUDNative(0, 0, 400, 300, 1920, 1080);
    _hud_change.SetTextPosition(TextAlign.Left);
    _hud_change.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
    Timers.AddTimer(::CoreSystem.Info.CShowDuration, false, CloseHud, _hud_change);
}

::BuildInfoHud <- function(){

    local _hud_global = HUD.Item("\n{gamemode}\n{special}\n{common}\n{special_kill}\n{common_kill}\n");
    _hud_global.SetValue("gamemode", ::CoreSystem.Info.CGameMode);
    _hud_global.SetValue("special", ::CoreSystem.Info.CSpecialInfo);
    _hud_global.SetValue("common", ::CoreSystem.Info.CCommonInfo);
    _hud_global.SetValue("special_kill", "阵亡特感: " + ::CoreSystem.Info.CGlobalPZKill + " 只");
    _hud_global.SetValue("common_kill", "阵亡普感: " + ::CoreSystem.Info.CGlobalCZKill + " 只");

    _hud_global.AttachTo(HUD_MID_BOX);
    _hud_global.SetTextPosition(TextAlign.Left);
    _hud_global.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
    Timers.AddTimer(::CoreSystem.Info.CShowDuration, false, CloseHud, _hud_global); 
    HUDPlace(HUD_MID_BOT, 0.8, 0.75, 0.6, 0.3); 

    local _hud_tittle = HUD.Item("\n{name}※{smoker}※{boomer}※{hunter}※{spitter}※{jockey}※{charger}※{total}※{common}※{ff}※{tank}\n");
    _hud_tittle.SetValue("name", "玩家");
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
    if(::CoreSystem.Info.CSurvivorCount > 4){ //超过四个人击杀榜显示两次,所以tittle显示双倍时间
        Timers.AddTimerByName("Timer_Tittle", 2 * ::CoreSystem.Info.CShowDuration, false, CloseHud, _hud_tittle);
    }
    else{
        Timers.AddTimerByName("Timer_Tittle", ::CoreSystem.Info.CShowDuration, false, CloseHud, _hud_tittle);
    }

    switch(::CoreSystem.Info.CSurvivorCount){
        //根据玩家数构建,由于玩家面板形式大同小异,所以应该只修改不同的部分,实现函数通用,减少冗余
        //从大到小判断,如果人数够大,那么前面的HUD肯定要显示,省去了break
            case 8:     //如果大于四个人分成两次显示
                Timers.AddTimer(::CoreSystem.Info.CShowDuration, false, BuildKillHud, {position = "SCORE_4", IsExtend = true});
            case 7:
                Timers.AddTimer(::CoreSystem.Info.CShowDuration, false, BuildKillHud, {position = "SCORE_3", IsExtend = true});
            case 6:
                Timers.AddTimer(::CoreSystem.Info.CShowDuration, false, BuildKillHud, {position = "SCORE_2", IsExtend = true});
            case 5:
                Timers.AddTimer(::CoreSystem.Info.CShowDuration, false, BuildKillHud, {position = "SCORE_1", IsExtend = true});
            case 4:
                BuildKillHud("SCORE_4", false);
            case 3:
                BuildKillHud("SCORE_3", false);
            case 2:
                BuildKillHud("SCORE_2", false);
            case 1:
                BuildKillHud("SCORE_1", false);
                break;
    }
}

::BuildKillHud <- function(position, IsExtend){

    local index = 0;
    local ypos = 10;
    if(IsExtend){
        index += 4; //超过了四个人
    }
    local _hud_info = HUD.Item("\n{name} {smoker} {boomer} {hunter} {spitter} {jockey} {charger} {total} {common} {ff} {tank}\n");

    switch(position){
        case "SCORE_1":
            index += 0;
            _hud_info.AttachTo(HUD_SCORE_1);
            ypos += 15;
            break;
        case "SCORE_2":
            index += 1;
            _hud_info.AttachTo(HUD_SCORE_2);
            ypos += 30;
            break;
        case "SCORE_3":
            index += 2;
            _hud_info.AttachTo(HUD_SCORE_3);
            ypos += 45;
            break;
        case "SCORE_4":
            index += 3;
            _hud_info.AttachTo(HUD_SCORE_4);
            ypos += 60;
            break;
        default:{
            /*
            local errorlog = "";
            errorlog = Time().tostring() + "[HUD] Build fail...";
            StringToFile("log.txt", errorlog);
            */
                ;
        }
    }

    local _name = PlayerInstanceFromIndex(::CoreSystem.Info.CPlayerTable[index]).GetPlayerName();
    _hud_info.SetValue("name", _name);
    _hud_info.SetValue("smoker", ExtendLength(::CoreSystem.Info.CSmokerKill[::CoreSystem.Info.CPlayerTable[index]], 6));
    _hud_info.SetValue("boomer", ExtendLength(::CoreSystem.Info.CBoomerKill[::CoreSystem.Info.CPlayerTable[index]], 6));
    _hud_info.SetValue("hunter", ExtendLength(::CoreSystem.Info.CHunterKill[::CoreSystem.Info.CPlayerTable[index]], 6));
    _hud_info.SetValue("spitter", ExtendLength(::CoreSystem.Info.CSpitterKill[::CoreSystem.Info.CPlayerTable[index]], 6));
    _hud_info.SetValue("jockey", ExtendLength(::CoreSystem.Info.CJockeyKill[::CoreSystem.Info.CPlayerTable[index]], 6));
    _hud_info.SetValue("charger", ExtendLength(::CoreSystem.Info.CChargerKill[::CoreSystem.Info.CPlayerTable[index]], 4));
    _hud_info.SetValue("total", ExtendLength(::CoreSystem.Info.CPZKill[::CoreSystem.Info.CPlayerTable[index]], 12));
    _hud_info.SetValue("common", ExtendLength(::CoreSystem.Info.CCZKill[::CoreSystem.Info.CPlayerTable[index]], 12));
    _hud_info.SetValue("ff", ExtendLength(::CoreSystem.Info.CFFDmg[::CoreSystem.Info.CPlayerTable[index]], 6));
    _hud_info.SetValue("tank", ExtendLength(::CoreSystem.Info.CTankDmg[::CoreSystem.Info.CPlayerTable[index]], 6));
    _hud_info.SetTextPosition(TextAlign.Right);
    _hud_info.ChangeHUDNative(0, 0, 1400, ypos, 1920, 1080);
    _hud_info.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); 
    Timers.AddTimer(::CoreSystem.Info.CShowDuration, false, CloseHud, _hud_info);

    HUDPlace(HUD_SCORE_TITLE, 0.1, 0.01, 0.755, 0.1);     //设置HUD位置
    HUDPlace(HUD_SCORE_1, 0.1, 0.04, 0.72, 0.1);
    HUDPlace(HUD_SCORE_2, 0.1, 0.07, 0.72, 0.1);
    HUDPlace(HUD_SCORE_3, 0.1, 0.10, 0.72, 0.1);
    HUDPlace(HUD_SCORE_4, 0.1, 0.13, 0.72, 0.1);
}

::ExtendLength <- function(value, tolen){
    //表格对齐可不是一件容易的事情,每个数据就算之偏一点点,整张表格就会显得不整齐
    //暂时想不到高效的对齐方法
    if(value >= 1000){
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

::BubbleSort <- function(_table){
    for(local i = 0; i < _table.len(); i++){
        for(local j = 0; j < _table.len() - 1; j++){
            if(::CoreSystem.Info.CPZKill[j] < ::CoreSystem.Info.CPZKill[j+1]){
                //使用特感击杀数排名
                local pz_tmp = _table[j+1];
                _table[j+1] = _table[j];
                _table[j] = pz_tmp;
            }
        }
    }
}

::CloseHud <- function(hud){
    hud.Detach();
}

function VSLib::EasyLogic::Update::DataUpdate(){

    DirectorOptions.BoomerLimit = ::CoreSystem.Control.CBoomerLimit;
    DirectorOptions.HunterLimit = ::CoreSystem.Control.CHunterLimit;
    DirectorOptions.SpitterLimit = ::CoreSystem.Control.CSpitterLimit;
    DirectorOptions.ChargerLimit = ::CoreSystem.Control.CChargerLimit;
    DirectorOptions.JockeyLimit = ::CoreSystem.Control.CJockeyLimit;
    DirectorOptions.SmokerLimit = ::CoreSystem.Control.CSmokerLimit;
    DirectorOptions.cm_MaxSpecials = ::CoreSystem.Control.CSpecialMax;
    DirectorOptions.DominatorLimit = ::CoreSystem.Control.CSpecialMax;
    DirectorOptions.cm_SpecialRespawnInterval = ::CoreSystem.Control.CSpecialInitial;
    DirectorOptions.SpecialInitialSpawnDelayMax = ::CoreSystem.Control.CSpecialInitial + 1;
	DirectorOptions.SpecialInitialSpawnDelayMin = ::CoreSystem.Control.CSpecialInitial;

    if(::CoreSystem.Control.CCommonLimit <= 60){
        DirectorOptions.cm_CommonLimit = ::CoreSystem.Control.CCommonLimit;
		DirectorOptions.MobMaxSize = ::CoreSystem.Control.CCommonLimit;
		DirectorOptions.MobMinSize = ::CoreSystem.Control.CCommonLimit;
    }
    else if(::CoreSystem.Control.CCommonLimit < 160){
        DirectorOptions.cm_CommonLimit = ::CoreSystem.Control.CCommonLimit;
		DirectorOptions.MobMaxSize = (::CoreSystem.Control.CCommonLimit > 100) ? ((::CoreSystem.Control.CCommonLimit / 2).tointeger() + 50) : CoreSystem.Control.CCommonLimit;
		DirectorOptions.MobMinSize = (::CoreSystem.Control.CCommonLimit > 100) ? ((::oreSystem.Control.CCommonLimit / 2).tointeger() + 30) : CoreSystem.Control.CCommonLimit - 20;
    }
    else if(::CoreSystem.Control.CCommonLimit < 250){
        DirectorOptions.cm_CommonLimit = ::CoreSystem.Control.CCommonLimit;
		DirectorOptions.MobMaxSize = (::CoreSystem.Control.CCommonLimit > 200) ? ((::CoreSystem.Control.CCommonLimit / 2).tointeger() + 70) : CoreSystem.Control.CCommonLimit - 30;
		DirectorOptions.MobMinSize = (::CoreSystem.Control.CCommonLimit > 200) ? ((::CoreSystem.Control.CCommonLimit / 2).tointeger() + 50) : CoreSystem.Control.CCommonLimit - 50;
    }

    local diff = ::VSLib.Utils.GetDifficulty();
    switch(diff){
        case "easy":{
            diff = "简单";
            break;
        }
        case "normal":{
            diff = "普通";
            break;
        }
        case "hard":{
            diff = "困难";
            break;
        }
        case "impossible":{
            diff = "专家";
            break;
        }
        default:{
            /*
            local errorlog = "";
            errorlog = Time().tostring() + "[INFO] Get difficulty fail...";
            StringToFile("log.txt", errorlog);
            */
                ;
        }    
    }

    ::CoreSystem.Info.CGameMode = "当前难度为： " + "[(" + diff + ")]";
    ::CoreSystem.Info.CCommonInfo = "普感： " + "[(" + DirectorOptions.cm_CommonLimit + ")]只";
    ::CoreSystem.Info.CSpecialInfo = "特感： " + "[(" + DirectorOptions.cm_MaxSpecials + ")只(" + DirectorOptions.cm_SpecialRespawnInterval + ")秒]";

    ::CoreSystem.Info.CSurvivorCount = ::VSLib.EasyLogic.Players.SurvivorsCount();

    local i = 0;
    local _player = null;

    while(_player = Entities.FindByClassname(_player, "player")){
        if(_player.IsValid()){
            ::CoreSystem.Info.CPlayerTable[i++] <- _player.GetEntityIndex();
        }
    }
    
    if(Time() > ::CoreSystem.Info.CShowInterval + ::CoreSystem.Info.CLastSet){
        BubbleSort(::CoreSystem.Info.CPlayerTable);
        BuildInfoHud();
        ::CoreSystem.Info.CLastSet = Time();
    }
}

function ChatTriggers::test(player, args, text){
    //player.ShowHint("INFO!", 3.0, "icon_info", "", "200 50 50");
    //player.ShowHint("ALERT!", 3.0, "icon_alert", "", "200 50 50");
    //player.ShowHint("TIP!", 3.0, "icon_tip", "", "200 50 50");
    //player.ShowHint("SHIELD!", 3.0, "icon_shield", "", "200 50 50");
    //player.ShowHint("ALERT_RED!", 3.0, "icon_alert_red", "", "200 50 50");
    //player.ShowHint("SKULL!", 3.0, "icon_skull", "", "200 50 50");
    //player.ShowHint("NO!", 3.0, "icon_no", "", "200 50 50");
    //player.ShowHint("INTERACT!", 3.0, "icon_interact", "", "200 50 50");
    //player.ShowHint("BUTTON!", 3.0, "icon_button", "", "200 50 50");
    //player.ShowHint("DOOR!", 3.0, "	icon_door", "", "200 50 50");   //没有图标
    //player.ShowHint("ARROW_PLAIN_RED!", 3.0, "icon_arrow_plain", "", "200 50 50");
    //player.ShowHint("PLAIN_DOWN_WHITE!", 3.0, "icon_arrow_plain_white_dn", "", "200 50 50");
    //player.ShowHint("PLAIN_UP_WHITE!", 3.0, "icon_arrow_plain_white_up", "", "200 50 50");
    //player.ShowHint("LONG_ARROW_UP_WHITE!", 3.0, "icon_arrow_up", "", "200 50 50");
    //player.ShowHint("LONG_ARROW_RIGHT_WHITE!", 3.0, "icon_arrow_right", "", "200 50 50");
}