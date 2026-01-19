Handle gH_PreIndicatorSynchronizer;

void PrepareHUD()
{
	gH_PreIndicatorSynchronizer = CreateHudSynchronizer();
}

void UpdatePreIndicator(int client)
{
    KZPlayer player = KZPlayer(client);
    KZPlayer targetPlayer = KZPlayer(player.ObserverTarget);

    if (player.Alive)
	{
		if (player.Fake && gB_GOKZReplays)
		{
            HUDInfo info;
            GOKZ_RP_GetPlaybackInfo(player.ID, info);
            gI_BotButtonInput[player.ID] = info.Buttons;
            return;
		}
		CalcPrestrafeVelMod(player);
	}
	else if (targetPlayer.ID == -1)
	{
		return;
	}

    if (GOKZ_GetCoreOption(client, Option_Mode) != Mode_KZTimer || (targetPlayer.Valid && GOKZ_GetCoreOption(targetPlayer.ID, Option_Mode) != Mode_KZTimer))
    {
        if (gB_PreIndicatorShowed[client])
        {
            ClearPreIndicator(client);
        }
        return;
    }

    int targetClient = player.Alive ? player.ID : targetPlayer.ID;
    switch (GOKZ_PreIndicator_GetOption(client, PreIndicatorOption_PreIndicator))
	{
		case PreIndicator_Bottom:
		{
			if (gI_PreTickCounter[targetClient] < 73)
			{
				SetHudTextParams(-1.0, 0.9, 1.0, 255, 255, 255, 0, 0, 1.0, 0.0, 0.0);
			}
			else
			{
				SetHudTextParams(-1.0, 0.9, 1.0, 230, 20, 20, 0, 0, 1.0, 0.0, 0.0);
			}
			ShowSyncHudText(player.ID, gH_PreIndicatorSynchronizer, "%.0f\n(%d)", gF_PreVelMod[targetClient] * 250, gI_PreTickCounter[targetClient]);
		}
		case PreIndicator_HealthAndArmor:
		{
            if (IsHealthBaseMap())
            {
                return;
            }
            SetEntityHealth(player.ID, RoundToNearest(1 + 950 * (gF_PreVelMod[targetClient] - 1)));
            SetEntProp(player.ID, Prop_Data, "m_ArmorValue", gI_PreTickCounter[targetClient]);
		}
	}
    gB_PreIndicatorShowed[player.ID] = true;
}

static void ClearPreIndicator(int client)
{
    ClearSyncHud(client, gH_PreIndicatorSynchronizer);
    if (!IsHealthBaseMap())
    {
        SetEntityHealth(client, 100);
        SetEntProp(client, Prop_Data, "m_ArmorValue", 0);
    }
}