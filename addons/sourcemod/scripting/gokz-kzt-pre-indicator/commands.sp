void RegisterCommands()
{
	RegConsoleCmd("sm_pre", CommandTogglePreIndicator, "[KZ] Toggle prestrafe indicator.");
}

public Action CommandTogglePreIndicator(int client, int args)
{
	if (GOKZ_PreIndicator_GetOption(client, PreIndicatorOption_PreIndicator) == PreIndicator_Disabled)
	{
		GOKZ_PreIndicator_SetOption(client, PreIndicatorOption_PreIndicator, PreIndicator_HealthAndArmor);
	}
	else if (GOKZ_PreIndicator_GetOption(client, PreIndicatorOption_PreIndicator) == PreIndicator_HealthAndArmor)
	{
		GOKZ_PreIndicator_SetOption(client, PreIndicatorOption_PreIndicator, PreIndicator_Bottom);
	}
	else
	{
		GOKZ_PreIndicator_SetOption(client, PreIndicatorOption_PreIndicator, PreIndicator_Disabled);
	}
	return Plugin_Handled;
}