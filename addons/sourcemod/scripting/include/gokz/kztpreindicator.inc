#define PRE_VELMOD_MAX 1.104

enum PreIndicatorOption:
{
	PREINDICATOROPTION_INVALID = -1, 
	PreIndicatorOption_PreIndicator, 
	PREINDICATOROPTION_COUNT
};

enum
{
	PreIndicator_Disabled = 0, 
	PreIndicator_HealthAndArmor, 
	PreIndicator_Bottom, 
	PREINDICATOR_COUNT,
};

stock char gC_PreIndicatorOptionNames[PREINDICATOROPTION_COUNT][] = 
{
	"GOKZ Pre - Pre Indicator"
};

stock any gI_PreIndicatorOptionDefaults[PREINDICATOROPTION_COUNT] = 
{
	PreIndicator_Disabled
};

stock char gC_PreIndicatorOptionDescriptions[PREINDICATOROPTION_COUNT][] = 
{
	"Visble Prestafe - 0 = Disabled, 1 = Health And Armor, 2 = Bottom"
};

stock char gC_PreIndicatorOptionPhrases[PREINDICATOROPTION_COUNT][] = 
{
	"Options Menu - Pre Indicator"
};

stock int gI_PreIndicatorOptionCounts[PREINDICATOROPTION_COUNT] = 
{
	PREINDICATOR_COUNT
};

stock char gC_PreIndicatorPhrases[PREINDICATOR_COUNT][] = 
{
	"Options Menu - Disabled",
	"Options Menu - Health And Armor",
	"Options Menu - Bottom"
};

enum struct HUDInfo
{
	bool TimerRunning;
	int TimeType;
	float Time;
	bool Paused;
	bool OnGround;
	bool OnLadder;
	bool Noclipping;
	bool Ducking;
	bool HitBhop;
	bool IsTakeoff;
	float Speed;
	int ID;
	bool Jumped;
	bool HitPerf;
	float TakeoffSpeed;
	int Buttons;
}

/**
 * Returns whether an option is a gokz-pre-indicator option.
 *
 * @param option		Option name.
 * @param optionEnum	Variable to store enumerated gokz-pre-indicator option (if it is one).
 * @return				Whether option is a gokz-pre-indicator option.
 */
stock bool GOKZ_PreIndicator_IsPreIndicatorOption(const char[] option, PreIndicatorOption &optionEnum = PREINDICATOROPTION_INVALID)
{
	for (PreIndicatorOption i; i < PREINDICATOROPTION_COUNT; i++)
	{
		if (StrEqual(option, gC_PreIndicatorOptionNames[i]))
		{
			optionEnum = i;
			return true;
		}
	}
	return false;
}

/**
 * Gets the current value of a player's gokz-pre-indicator option.
 *
 * @param client		Client index.
 * @param option		gokz-pre-indicator option.
 * @return				Current value of option.
 */
stock any GOKZ_PreIndicator_GetOption(int client, PreIndicatorOption option)
{
	return GOKZ_GetOption(client, gC_PreIndicatorOptionNames[option]);
}

/**
 * Sets a player's gokz-pre-indicator option's value.
 *
 * @param client		Client index.
 * @param option		gokz-pre-indicator option.
 * @param value			New option value.
 * @return				Whether option was successfully set.
 */
stock bool GOKZ_PreIndicator_SetOption(int client, PreIndicatorOption option, any value)
{
	return GOKZ_SetOption(client, gC_PreIndicatorOptionNames[option], value);
}

/**
 * Increment an integer-type gokz-pre-indicator option's value.
 * Loops back to '0' if max value is exceeded.
 *
 * @param client		Client index.
 * @param option		gokz-pre-indicator option.
 * @return				Whether option was successfully set.
 */
stock bool GOKZ_PreIndicator_CycleOption(int client, PreIndicatorOption option)
{
	return GOKZ_CycleOption(client, gC_PreIndicatorOptionNames[option]);
}