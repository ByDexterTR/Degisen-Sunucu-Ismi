#include <sourcemod>

ConVar g_sure = null, 
g_s1 = null, 
g_s2 = null, 
g_s3 = null;

Handle h_timer = null;
int Global = 0;

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo = 
{
	name = "Değişen Sunucu İsmi", 
	author = "ByDexter", 
	description = "Belirleyeceğiniz dakika da bir CFG üzerinde belirlediğiniz 3 adet sunucu ismi sırasıyla değişir , bu eklentiyi toplantı , adminlik duyuru vs olduğunda kullanmanız işinize yarayacaktır", 
	version = "1.0", 
	url = "https://steamcommunity.com/id/ByDexterTR - ByDexter#5494"
};

public void OnPluginStart()
{
	g_sure = CreateConVar("sm_timer_degisensunucuismi", "180", "Kaç saniye arayla sunucu ismi değişsin", 0, true, 1.0, false);
	g_s1 = CreateConVar("sm_1_sunucuismi", "ByDexter#5494", "1. Sunucu ismi");
	g_s2 = CreateConVar("sm_2_sunucuismi", "github.com/ByDexterTR", "2. Sunucu ismi");
	g_s3 = CreateConVar("sm_3_sunucuismi", "steamcommunity.com/id/ByDexterTR", "3. Sunucu ismi");
	g_sure.AddChangeHook(ConVarChanged);
	h_timer = CreateTimer(g_sure.FloatValue, Kontrolet, _, TIMER_REPEAT);
}

public void ConVarChanged(ConVar cvar, const char[] oldVal, const char[] newVal)
{
	if (cvar == g_sure)
	{
		if (h_timer != null)
			delete h_timer;
		h_timer = CreateTimer(g_sure.FloatValue, Kontrolet, _, TIMER_REPEAT);
	}
}

public Action Kontrolet(Handle timer, any data)
{
	if (Global >= 0)
	{
		Global++;
		char HostNames[512];
		if (Global == 1)
		{
			g_s1.GetString(HostNames, sizeof(HostNames));
			ServerCommand("hostname %s", HostNames);
		}
		else if (Global == 2)
		{
			g_s2.GetString(HostNames, sizeof(HostNames));
			ServerCommand("hostname %s", HostNames);
		}
		else if (Global == 3)
		{
			g_s3.GetString(HostNames, sizeof(HostNames));
			ServerCommand("hostname %s", HostNames);
			Global = 0;
		}
	}
	else
	{
		Global = 0;
	}
} 