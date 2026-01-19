void RegisterOptions()
{
	for (PreIndicatorOption option; option < PREINDICATOROPTION_COUNT; option++)
	{
		GOKZ_RegisterOption(gC_PreIndicatorOptionNames[option], gC_PreIndicatorOptionDescriptions[option], OptionType_Int, gI_PreIndicatorOptionDefaults[option], 0, gI_PreIndicatorOptionCounts[option] - 1);
	}
}

void OnOptionChanged(int client, PreIndicatorOption option, int newValue)
{
	if (option == PreIndicatorOption_PreIndicator)
	{
		if (IsHealthBaseMap() && newValue == PreIndicator_HealthAndArmor)
		{
			GOKZ_PreIndicator_CycleOption(client, option);
			return;
		}
		else
		{
			SetEntityHealth(client, 100);
			SetEntProp(client, Prop_Data, "m_ArmorValue", 0);
		}
	}
	
	switch (option)
	{
		case PreIndicatorOption_PreIndicator:
		{
			switch (newValue)
			{
				case PreIndicator_Disabled:
				{
					GOKZ_PrintToChat(client, true, "%t", "Option - Prestrafe Indicator - Disable");
				}
				case PreIndicator_HealthAndArmor:
				{
					GOKZ_PrintToChat(client, true, "%t", "Option - Prestrafe Indicator - Health And Armor");
				}
				case PreIndicator_Bottom:
				{
					GOKZ_PrintToChat(client, true, "%t", "Option - Prestrafe Indicator - Bottom");
				}
			}
		}
	}
}