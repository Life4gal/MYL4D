#pragma semicolon 1

#include <sourcemod>
#include <sdktools>

#define VERSION "1.0"
#define FCVAR_FLAG FCVAR_SPONLY|FCVAR_NOTIFY

new Handle:Enabled;
new Handle:WeaponRandom;
new Handle:WeaponRandomAmount;
new Handle:WeaponBaseballBat;
new Handle:WeaponCricketBat;
new Handle:WeaponCrowbar;
new Handle:WeaponElecGuitar;
new Handle:WeaponFireAxe;
new Handle:WeaponFryingPan;
new Handle:WeaponGolfClub;
new Handle:WeaponKnife;
new Handle:WeaponKatana;
new Handle:WeaponMachete;
new Handle:WeaponRiotShield;
new Handle:WeaponTonfa;

new bool:SpawnedMelee;

new MeleeClassCount = 0;
new MeleeRandomSpawn[20];
new Round = 2;

new String:MeleeClass[16][32];

public Plugin:myinfo =
{
	name = "easy melee give",
	author = "NiceT",
	description = "at the start of each round spawn some melee",
	version = VERSION
};

public OnPluginStart()
{
	decl String:GameName[12];
	GetGameFolderName(GameName, sizeof(GameName));
	if( !StrEqual(GameName, "left4dead2") )
		SetFailState( "Melee In The Saferoom is only supported on left 4 dead 2." );

	CreateConVar( "l4d2_Melee_Give_Version",		VERSION, "The version of Melee In The Saferoom", 																						FCVAR_FLAG );
	Enabled				= CreateConVar( "l4d2_Melee_Enabled",			"1", "1 = plugin enable", 																				FCVAR_FLAG );
	WeaponRandom			= CreateConVar( "l4d2_Melee_Give_Random",		"0", "1 = random | 0 = customized", 					FCVAR_FLAG );
	WeaponRandomAmount		= CreateConVar( "l4d2_Melee_Give_Amount",		"0", "Number of weapons produced,if l4d2_Melee_Give_Random = 1", 	FCVAR_FLAG );
	WeaponBaseballBat 		= CreateConVar( "l4d2_Melee_Give_BaseballBat",		"0", "BaseballBat (l4d2_Melee_Give_Random must be 0)", 			FCVAR_FLAG );
	WeaponCricketBat 		= CreateConVar( "l4d2_Melee_Give_CricketBat", 		"0", "CricketBat (l4d2_Melee_Give_Random must be 0)", 			FCVAR_FLAG );
	WeaponCrowbar 			= CreateConVar( "l4d2_Melee_Give_Crowbar", 		"0", "Crowbar (l4d2_Melee_Give_Random must be 0)", 			FCVAR_FLAG );
	WeaponElecGuitar		= CreateConVar( "l4d2_Melee_Give_ElecGuitar",		"0", "ElecGuitar (l4d2_Melee_Give_Random must be 0)", 			FCVAR_FLAG );
	WeaponFireAxe			= CreateConVar( "l4d2_Melee_Give_FireAxe",		"2", "FireAxe (l4d2_Melee_Give_Random must be 0)", 			FCVAR_FLAG );
	WeaponFryingPan			= CreateConVar( "l4d2_Melee_Give_FryingPan",		"0", "FryingPan (l4d2_Melee_Give_Random must be 0)",			FCVAR_FLAG );
	WeaponGolfClub			= CreateConVar( "l4d2_Melee_Give_GolfClub",		"0", "GolfClub (l4d2_Melee_Give_Random must be 0)", 			FCVAR_FLAG );
	WeaponKnife			= CreateConVar( "l4d2_Melee_Give_Knife",		"0", "Knife (l4d2_Melee_Give_Random must be 0)", 			FCVAR_FLAG );
	WeaponKatana			= CreateConVar( "l4d2_Melee_Give_Katana",		"0", "Katana (l4d2_Melee_Give_Random must be 0)", 			FCVAR_FLAG );
	WeaponMachete			= CreateConVar( "l4d2_Melee_Give_Machete",		"0", "Machete (l4d2_Melee_Give_Random must be 0)", 			FCVAR_FLAG );
	WeaponRiotShield		= CreateConVar( "l4d2_Melee_Give_RiotShield",		"0", "RiotShield (l4d2_Melee_Give_Random must be 0)", 			FCVAR_FLAG );
	WeaponTonfa			= CreateConVar( "l4d2_Melee_Give_Tonfa",		"0", "Tonfa (l4d2_Melee_Give_Random must be 0)", 			FCVAR_FLAG );
	AutoExecConfig( true, "MeleeInTheSaferoom" );

	HookEvent( "round_start", Event_RoundStart );

	RegAdminCmd( "sm_melee", Command_SMMelee, ADMFLAG_KICK, "List all melee weapons produced in the current campaign" );
}

public Action:Command_SMMelee(client, args)
{
	for( new i = 0; i < MeleeClassCount; i++ )
	{
		PrintToChat( client, "%d : %s", i, MeleeClass[i] );
	}
}

public OnMapStart()
{
	PrecacheModel( "models/weapons/melee/v_bat.mdl", true );
	PrecacheModel( "models/weapons/melee/v_cricket_bat.mdl", true );
	PrecacheModel( "models/weapons/melee/v_crowbar.mdl", true );
	PrecacheModel( "models/weapons/melee/v_electric_guitar.mdl", true );
	PrecacheModel( "models/weapons/melee/v_fireaxe.mdl", true );
	PrecacheModel( "models/weapons/melee/v_frying_pan.mdl", true );
	PrecacheModel( "models/weapons/melee/v_golfclub.mdl", true );
	PrecacheModel( "models/weapons/melee/v_katana.mdl", true );
	PrecacheModel( "models/weapons/melee/v_machete.mdl", true );
	PrecacheModel( "models/weapons/melee/v_tonfa.mdl", true );

	PrecacheModel( "models/weapons/melee/w_bat.mdl", true );
	PrecacheModel( "models/weapons/melee/w_cricket_bat.mdl", true );
	PrecacheModel( "models/weapons/melee/w_crowbar.mdl", true );
	PrecacheModel( "models/weapons/melee/w_electric_guitar.mdl", true );
	PrecacheModel( "models/weapons/melee/w_fireaxe.mdl", true );
	PrecacheModel( "models/weapons/melee/w_frying_pan.mdl", true );
	PrecacheModel( "models/weapons/melee/w_golfclub.mdl", true );
	PrecacheModel( "models/weapons/melee/w_katana.mdl", true );
	PrecacheModel( "models/weapons/melee/w_machete.mdl", true );
	PrecacheModel( "models/weapons/melee/w_tonfa.mdl", true );

	PrecacheGeneric( "scripts/melee/baseball_bat.txt", true );
	PrecacheGeneric( "scripts/melee/cricket_bat.txt", true );
	PrecacheGeneric( "scripts/melee/crowbar.txt", true );
	PrecacheGeneric( "scripts/melee/electric_guitar.txt", true );
	PrecacheGeneric( "scripts/melee/fireaxe.txt", true );
	PrecacheGeneric( "scripts/melee/frying_pan.txt", true );
	PrecacheGeneric( "scripts/melee/golfclub.txt", true );
	PrecacheGeneric( "scripts/melee/katana.txt", true );
	PrecacheGeneric( "scripts/melee/machete.txt", true );
	PrecacheGeneric( "scripts/melee/tonfa.txt", true );
}

public Action:Event_RoundStart(Handle:event, const String:name[], bool:dontBroadcast)
{
	if( !GetConVarBool( Enabled ) ) return Plugin_Continue;

	SpawnedMelee = false;

	if( Round == 2 && IsVersus() ) Round = 1; else Round = 2;

	GetMeleeClasses();

	CreateTimer( 1.0, Timer_SpawnMelee );

	return Plugin_Continue;
}

public Action:Timer_SpawnMelee( Handle:timer )
{
	new client = GetInGameClient();

	if( client != 0 && !SpawnedMelee )
	{
		decl Float:SpawnPosition[3], Float:SpawnAngle[3];
		GetClientAbsOrigin( client, SpawnPosition );
		SpawnPosition[2] += 20; SpawnAngle[0] = 90.0;

		if( GetConVarBool( WeaponRandom ) )
		{
			new i = 0;
			while( i < GetConVarInt( WeaponRandomAmount ) )
			{
				new RandomMelee = GetRandomInt( 0, MeleeClassCount-1 );
				if( IsVersus() && Round == 2 ) RandomMelee = MeleeRandomSpawn[i];
				SpawnMelee( MeleeClass[RandomMelee], SpawnPosition, SpawnAngle );
				if( IsVersus() && Round == 1 ) MeleeRandomSpawn[i] = RandomMelee;
				i++;
			}
			SpawnedMelee = true;
		}
		else
		{
			SpawnCustomList( SpawnPosition, SpawnAngle );
			SpawnedMelee = true;
		}
	}
	else
	{
		if( !SpawnedMelee ) CreateTimer( 1.0, Timer_SpawnMelee );
	}
}

stock SpawnCustomList( Float:Position[3], Float:Angle[3] )
{
	decl String:ScriptName[32];

	//Spawn Basseball Bats
	if( GetConVarInt( WeaponBaseballBat ) > 0 )
	{
		for( new i = 0; i < GetConVarInt( WeaponBaseballBat ); i++ )
		{
			GetScriptName( "baseball_bat", ScriptName );
			SpawnMelee( ScriptName, Position, Angle );
		}
	}

	//Spawn Cricket Bats
	if( GetConVarInt( WeaponCricketBat ) > 0 )
	{
		for( new i = 0; i < GetConVarInt( WeaponCricketBat ); i++ )
		{
			GetScriptName( "cricket_bat", ScriptName );
			SpawnMelee( ScriptName, Position, Angle );
		}
	}

	//Spawn Crowbars
	if( GetConVarInt( WeaponCrowbar ) > 0 )
	{
		for( new i = 0; i < GetConVarInt( WeaponCrowbar ); i++ )
		{
			GetScriptName( "crowbar", ScriptName );
			SpawnMelee( ScriptName, Position, Angle );
		}
	}

	//Spawn Electric Guitars
	if( GetConVarInt( WeaponElecGuitar ) > 0 )
	{
		for( new i = 0; i < GetConVarInt( WeaponElecGuitar ); i++ )
		{
			GetScriptName( "electric_guitar", ScriptName );
			SpawnMelee( ScriptName, Position, Angle );
		}
	}

	//Spawn Fireaxes
	if( GetConVarInt( WeaponFireAxe ) > 0 )
	{
		for( new i = 0; i < GetConVarInt( WeaponFireAxe ); i++ )
		{
			GetScriptName( "fireaxe", ScriptName );
			SpawnMelee( ScriptName, Position, Angle );
		}
	}

	//Spawn Frying Pans
	if( GetConVarInt( WeaponFryingPan ) > 0 )
	{
		for( new i = 0; i < GetConVarInt( WeaponFryingPan ); i++ )
		{
			GetScriptName( "frying_pan", ScriptName );
			SpawnMelee( ScriptName, Position, Angle );
		}
	}

	//Spawn Golfclubs
	if( GetConVarInt( WeaponGolfClub ) > 0 )
	{
		for( new i = 0; i < GetConVarInt( WeaponGolfClub ); i++ )
		{
			GetScriptName( "golfclub", ScriptName );
			SpawnMelee( ScriptName, Position, Angle );
		}
	}

	//Spawn Knifes
	if( GetConVarInt( WeaponKnife ) > 0 )
	{
		for( new i = 0; i < GetConVarInt( WeaponKnife ); i++ )
		{
			GetScriptName( "hunting_knife", ScriptName );
			SpawnMelee( ScriptName, Position, Angle );
		}
	}

	//Spawn Katanas
	if( GetConVarInt( WeaponKatana ) > 0 )
	{
		for( new i = 0; i < GetConVarInt( WeaponKatana ); i++ )
		{
			GetScriptName( "katana", ScriptName );
			SpawnMelee( ScriptName, Position, Angle );
		}
	}

	//Spawn Machetes
	if( GetConVarInt( WeaponMachete ) > 0 )
	{
		for( new i = 0; i < GetConVarInt( WeaponMachete ); i++ )
		{
			GetScriptName( "machete", ScriptName );
			SpawnMelee( ScriptName, Position, Angle );
		}
	}

	//Spawn RiotShields
	if( GetConVarInt( WeaponRiotShield ) > 0 )
	{
		for( new i = 0; i < GetConVarInt( WeaponRiotShield ); i++ )
		{
			GetScriptName( "riotshield", ScriptName );
			SpawnMelee( ScriptName, Position, Angle );
		}
	}

	//Spawn Tonfas
	if( GetConVarInt( WeaponTonfa ) > 0 )
	{
		for( new i = 0; i < GetConVarInt( WeaponTonfa ); i++ )
		{
			GetScriptName( "tonfa", ScriptName );
			SpawnMelee( ScriptName, Position, Angle );
		}
	}
}

stock SpawnMelee( const String:Class[32], Float:Position[3], Float:Angle[3] )
{
	decl Float:SpawnPosition[3], Float:SpawnAngle[3];
	SpawnPosition = Position;
	SpawnAngle = Angle;

	SpawnPosition[0] += ( -10 + GetRandomInt( 0, 20 ) );
	SpawnPosition[1] += ( -10 + GetRandomInt( 0, 20 ) );
	SpawnPosition[2] += GetRandomInt( 0, 10 );
	SpawnAngle[1] = GetRandomFloat( 0.0, 360.0 );

	new MeleeSpawn = CreateEntityByName( "weapon_melee" );
	DispatchKeyValue( MeleeSpawn, "melee_script_name", Class );
	DispatchSpawn( MeleeSpawn );
	TeleportEntity(MeleeSpawn, SpawnPosition, SpawnAngle, NULL_VECTOR );
}

stock GetMeleeClasses()
{
	new MeleeStringTable = FindStringTable( "MeleeWeapons" );
	MeleeClassCount = GetStringTableNumStrings( MeleeStringTable );

	for( new i = 0; i < MeleeClassCount; i++ )
	{
		ReadStringTable( MeleeStringTable, i, MeleeClass[i], 32 );
	}
}

stock GetScriptName( const String:Class[32], String:ScriptName[32] )
{
	for( new i = 0; i < MeleeClassCount; i++ )
	{
		if( StrContains( MeleeClass[i], Class, false ) == 0 )
		{
			Format( ScriptName, 32, "%s", MeleeClass[i] );
			return;
		}
	}
	Format( ScriptName, 32, "%s", MeleeClass[0] );
}

stock GetInGameClient()
{
	for( new x = 1; x <= GetClientCount( true ); x++ )
	{
		if( IsClientInGame( x ) && GetClientTeam( x ) == 2 )
		{
			return x;
		}
	}
	return 0;
}

stock bool:IsVersus()
{
	new String:GameMode[32];
	GetConVarString( FindConVar( "mp_gamemode" ), GameMode, 32 );
	if( StrContains( GameMode, "versus", false ) != -1 ) return true;
	return false;
}
