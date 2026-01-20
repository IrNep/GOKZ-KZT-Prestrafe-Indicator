#include <sourcemod>

#include <gokz/core>
#include <gokz/replays>
#include <gokz/kzplayer>
#include <gokz/kztpreindicator>

#pragma newdecls required
#pragma semicolon 1

bool gB_GOKZReplays;
bool gB_IsHealthBaseMap;
char gC_healthBaseMapPath[255];

#include "gokz-kzt-pre-indicator/options.sp"
#include "gokz-kzt-pre-indicator/pre.sp"
#include "gokz-kzt-pre-indicator/hud.sp"
#include "gokz-kzt-pre-indicator/commands.sp"

public Plugin myinfo = 
{
    name = "GOKZ KZTimer Prestrafe Indicator", 
    author = "FrozeEnd", 
    description = "Shows KZTimer players' PreVelMod & PreTickCounter.", 
    version = "1.2", 
    url = ""
};

public void OnPluginStart()
{
    LoadTranslations("gokz-kzt-pre-indicator.phrases");
    char gC_dirPath[255];
    BuildPath(Path_SM, gC_dirPath, sizeof(gC_dirPath), "configs/");
    Format(gC_healthBaseMapPath, sizeof(gC_healthBaseMapPath), "%sgokz_health_base_maps.txt", gC_dirPath);
    if (!DirExists(gC_dirPath))
    {
        CreateDirectory(gC_dirPath, 0, false, _);
    }
    if (!FileExists(gC_healthBaseMapPath))
    {
        CloseHandle(OpenFile(gC_healthBaseMapPath, "w"));
    }

    gB_GOKZReplays = LibraryExists("gokz-replays");
    PrepareHUD();
    RegisterCommands();
}

public void OnAllPluginsLoaded()
{
    gB_GOKZReplays = LibraryExists("gokz-replays");
    if (LibraryExists("gokz-core") && GOKZ_GetOptionsTopMenu() != null)
    {
        RegisterOptions();
    }
}

public void OnMapInit(const char[] mapName)
{
    char gC_HealthMapList[255];
    Handle h_healthBaseMapFile = OpenFile(gC_healthBaseMapPath, "r");
    gB_IsHealthBaseMap = false;
    while (!IsEndOfFile(h_healthBaseMapFile))
    {
        ReadFileLine(h_healthBaseMapFile, gC_HealthMapList, sizeof(gC_HealthMapList));
        TrimString(gC_HealthMapList);
        if (StrEqual(gC_HealthMapList, mapName, false))
        {
            gB_IsHealthBaseMap = true;
            break;
        }
    }
    CloseHandle(h_healthBaseMapFile);
}

public void GOKZ_OnOptionsMenuReady(TopMenu topMenu)
{
    RegisterOptions();
}

public void GOKZ_OnCountedTeleport_Post(int client)
{
    ResetPrestrafeVelMod(client);
}

public void GOKZ_OnOptionChanged(int client, const char[] option, any newValue)
{
    any pOption;
    if (GOKZ_PreIndicator_IsPreIndicatorOption(option, pOption))
    {
        OnOptionChanged(client, pOption, newValue);
    }
}

public void OnPlayerRunCmdPost(int client, int buttons, int impulse, const float vel[3], const float angles[3], int weapon, int subtype, int cmdnum, int tickcount, int seed, const int mouse[2])
{
    UpdatePreIndicator(client);
}

bool IsHealthBaseMap()
{
    return gB_IsHealthBaseMap;
}