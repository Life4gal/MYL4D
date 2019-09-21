Msg("versus\n");

DirectorOptions <-
{
	cm_CommonLimit = 0
	ProhibitBosses = true

    	weaponsToConvert =
	{
		weapon_pumpshotgun		= "weapon_pumpshotgun_spawn"
		weapon_shotgun_chrome		= "weapon_shotgun_chrome_spawn"
		weapon_autoshotgun 		= "weapon_autoshotgun_spawn"
		weapon_shotgun_spas 		= "weapon_shotgun_spas_spawn"

		weapon_smg_silenced		= "weapon_smg_silenced_spawn"
		weapon_smg			= "weapon_smg_spawn"
		weapon_smg_mp5			= "weapon_smg_mp5_spawn"

		weapon_rifle 			= "weapon_pumpshotgun_spawn"
		weapon_rifle_desert 		= "weapon_shotgun_chrome_spawn"
		weapon_rifle_ak47 		= "weapon_autoshotgun_spawn"
		weapon_rifle_sg552 		= "weapon_shotgun_spas_spawn"

		weapon_sniper_awp		= "weapon_smg_silenced_spawn"
		weapon_sniper_scout		= "weapon_smg_spawn"
		weapon_sniper_military 		= "weapon_smg_mp5_spawn"
		weapon_hunting_rifle		= "weapon_pumpshotgun_spawn"

		weapon_first_aid_kit		= "weapon_pain_pills_spawn"
		weapon_pain_pills		= "weapon_pain_pills_spawn"
		weapon_adrenaline		= "weapon_pain_pills_spawn"
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
		//weapon_defibrillator 			= 0
		//upgrade_item 				= 0
		//weapon_pumpshotgun			= 0
		//weapon_shotgun_chrome			= 0
		//weapon_smg_silenced			= 0
		//weapon_smg				= 0
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
		weapon_hunting_rifle 		= true
		weapon_autoshotgun		= true
		weapon_rifle 			= true
		weapon_rifle_desert 		= true
		weapon_shotgun_spas 		= true
		weapon_rifle_ak47 		= true
		weapon_sniper_scout 		= true
		weapon_rifle_sg552		= true
		weapon_sniper_military 		= true
		weapon_weapon_pumpshotgun 	= true
		weapon_shotgun_chrome		= true
		weapon_smg_silenced		= true
		weapon_smg			= true
		weapon_pistol			= true
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
            "weapon_pistol",
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
