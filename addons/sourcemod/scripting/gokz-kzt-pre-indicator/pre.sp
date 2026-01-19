float gF_PreVelMod[MAXPLAYERS + 1];
float gF_PreVelModLastChange[MAXPLAYERS + 1];
int gI_PreTickCounter[MAXPLAYERS + 1];
bool gB_PreIndicatorShowed[MAXPLAYERS + 1];

int gI_BotButtonInput[MAXPLAYERS + 1];

// implement from gokz-mode-kztimer.sp
void CalcPrestrafeVelMod(KZPlayer player)
{
	if (!player.OnGround)
	{
		return;
	}

	int buttons = player.Buttons;
	if (player.Fake)
	{
		buttons = gI_BotButtonInput[player.ID];
	} 
	
	if (!player.Turning)
	{
		if (GetEngineTime() - gF_PreVelModLastChange[player.ID] > 0.2)
		{
			gF_PreVelMod[player.ID] = 1.0;
			gF_PreVelModLastChange[player.ID] = GetEngineTime();
		}
	}
	else if ((buttons & IN_MOVELEFT || buttons & IN_MOVERIGHT) && player.Speed > 248.9)
	{
		float increment = 0.0009;
		if (gF_PreVelMod[player.ID] > 1.04)
		{
			increment = 0.001;
		}
		
		bool forwards = GetClientMovingDirection(player.ID, false) > 0.0;
		
		if ((buttons & IN_MOVERIGHT && player.TurningRight || player.TurningLeft && !forwards)
			 || (buttons & IN_MOVELEFT && player.TurningLeft || player.TurningRight && !forwards))
		{
			gI_PreTickCounter[player.ID]++;
			
			if (gI_PreTickCounter[player.ID] < 75)
			{
				gF_PreVelMod[player.ID] += increment;
				if (gF_PreVelMod[player.ID] > PRE_VELMOD_MAX)
				{
					if (gF_PreVelMod[player.ID] > PRE_VELMOD_MAX + 0.007)
					{
						gF_PreVelMod[player.ID] = PRE_VELMOD_MAX - 0.001;
					}
					else
					{
						gF_PreVelMod[player.ID] -= 0.007;
					}
				}
				gF_PreVelMod[player.ID] += increment;
			}
			else
			{
				gF_PreVelMod[player.ID] -= 0.0045;
				gI_PreTickCounter[player.ID] -= 2;
				
				if (gF_PreVelMod[player.ID] < 1.0)
				{
					gF_PreVelMod[player.ID] = 1.0;
					gI_PreTickCounter[player.ID] = 0;
				}
			}
		}
		else
		{
			gF_PreVelMod[player.ID] -= 0.04;
			
			if (gF_PreVelMod[player.ID] < 1.0)
			{
				gF_PreVelMod[player.ID] = 1.0;
			}
		}
		
		gF_PreVelModLastChange[player.ID] = GetEngineTime();
	}
	else
	{
		gI_PreTickCounter[player.ID] = 0;
	}
}

void ResetPrestrafeVelMod(int client)
{
	gF_PreVelMod[client] = 1.0;
	gI_PreTickCounter[client] = 0;
}

stock float GetClientMovingDirection(int client, bool ladder)
{
	float fVelocity[3];
	GetEntPropVector(client, Prop_Data, "m_vecAbsVelocity", fVelocity);
	
	float fEyeAngles[3];
	GetClientEyeAngles(client, fEyeAngles);
	
	if (fEyeAngles[0] > 70.0)fEyeAngles[0] = 70.0;
	if (fEyeAngles[0] < -70.0)fEyeAngles[0] = -70.0;
	
	float fViewDirection[3];
	
	if (ladder)
	{
		GetEntPropVector(client, Prop_Send, "m_vecLadderNormal", fViewDirection);
	}
	else
	{
		GetAngleVectors(fEyeAngles, fViewDirection, NULL_VECTOR, NULL_VECTOR);
	}
	
	NormalizeVector(fVelocity, fVelocity);
	NormalizeVector(fViewDirection, fViewDirection);
	
	float direction = GetVectorDotProduct(fVelocity, fViewDirection);
	if (ladder)
	{
		direction = direction * -1;
	}
	return direction;
}