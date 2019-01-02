/*  Jailbreak advanced features
*
*  Copyright (C) 2019 Arnaud 'Luckiris' MAMECIER
* 
* This program is free software: you can redistribute it and/or modify it
* under the terms of the GNU General Public License as published by the Free
* Software Foundation, either version 3 of the License, or (at your option) 
* any later version.
*
* This program is distributed in the hope that it will be useful, but WITHOUT 
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS 
* FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License along with 
* this program. If not, see http://www.gnu.org/licenses/.
*/

#pragma semicolon 1

#include <sourcemod>
#include <sdktools>
#include <multicolors>
#include <cstrike>

#pragma newdecls required

bool hasUsedE[MAXPLAYERS + 1];
bool hasUsedV[MAXPLAYERS + 1];
int hasUsedWDH[MAXPLAYERS + 1];
bool hasUsedHeal[MAXPLAYERS + 1];

Handle hasCooldown[MAXPLAYERS + 1];

ConVar cvTimer;
ConVar cvCooldown;

public Plugin myinfo = {
	name = "Ostblock-Gaming - Jailbreak advanced features",
	author = "Luckiris",
	description = "Plugin to add a few commands",
	version = "1.0",
	url = "https://ostblock-gaming.de"
};

public void OnPluginStart(){
    /**

        Load translations

    */
    LoadTranslations("jailbreak_advanced_features.phrases");   

	/**
	
		Registering the commands
		
	*/
    RegConsoleCmd("sm_e", CommandE);
    RegConsoleCmd("sm_v", CommandV);
    RegConsoleCmd("sm_wdh", CommandWDH);
    RegConsoleCmd("sm_heal", CommandHeal);

    /**

        Config

    */
    cvTimer = CreateConVar("sm_jailbreak_advanced_features_timer_color", "30.0", "Time to reset the colors");
    cvCooldown = CreateConVar("sm_jailbreak_advanced_features_timer_cooldown", "2.0", "Commands cooldown");
    AutoExecConfig(true, "jailbreak_advanced_features");

    /**

        Hook events

    */
    HookEvent("round_start", EventRoundStart);       
}

/**************************************************

	Event functions

**************************************************/
public Action EventRoundStart(Event event, const char[] name, bool dontBroadcast){	
    for (int i = 0; i < MaxClients; i++){
        hasUsedE[i] = false;
        hasUsedV[i] = false;      
        hasUsedWDH[i] = 0;
        hasUsedHeal[i] = false;
        hasCooldown[i] = INVALID_HANDLE;
    }
    return Plugin_Continue;
}

/**************************************************

	Command functions

**************************************************/
public Action CommandE(int client, int args){
    /**

        Check if client is a T

    */
    if (!IsT(client)){
        CPrintToChat(client, "%t", "Wrong team");
        return Plugin_Handled;        
    }

    /**

        Check if client has cooldown

    */
    if (hasCooldown[client] != INVALID_HANDLE){
        CPrintToChat(client, "%t", "Command cooldown");
        return Plugin_Handled;
    }

    /**

        Check if command already used

    */
    if (!hasUsedE[client] && IsPlayerAlive(client)){
        char name[MAX_NAME_LENGTH];
        hasUsedE[client] = !hasUsedE[client];
        SetEntityRenderColor(client, 0, 255, 0, 255);
        GetClientName(client, name, sizeof(name));
        CreateTimer(cvTimer.FloatValue, TimerReset, GetClientUserId(client));
        hasCooldown[client] = CreateTimer(cvCooldown.FloatValue, TimerCooldown, GetClientUserId(client));
        CPrintToChatAll("%t", "Command e used", name);
    } else  {
        CPrintToChat(client, "%t", "Command e already used");
    }
    return Plugin_Handled;
}

public Action CommandV(int client, int args){
    /**

        Check if client is a T

    */
    if (!IsT(client)){
        CPrintToChat(client, "%t", "Wrong team");
        return Plugin_Handled;        
    }

    /**

        Check if client has cooldown

    */
    if (hasCooldown[client] != INVALID_HANDLE){
        CPrintToChat(client, "%t", "Command cooldown");
        return Plugin_Handled;
    }

    /**

        Check if command already used

    */    
    if (!hasUsedV[client] && IsPlayerAlive(client)){
        char name[MAX_NAME_LENGTH];
        hasUsedV[client] = !hasUsedV[client];
        SetEntityRenderColor(client, 0, 0, 255, 255);
        GetClientName(client, name, sizeof(name));
        CreateTimer(cvTimer.FloatValue, TimerReset, GetClientUserId(client));
        hasCooldown[client] = CreateTimer(cvCooldown.FloatValue, TimerCooldown, GetClientUserId(client));       
        CPrintToChatAll("%t", "Command v used", name);
    } else  {
        CPrintToChat(client, "%t", "Command v already used");
    }
    return Plugin_Handled;
}

public Action CommandWDH(int client, int args){
    /**

        Check if client is a T

    */
    if (!IsT(client)){
        CPrintToChat(client, "%t", "Wrong team");
        return Plugin_Handled;        
    }

    /**

        Check if client has cooldown

    */
    if (hasCooldown[client] != INVALID_HANDLE){
        CPrintToChat(client, "%t", "Command cooldown");
        return Plugin_Handled;
    }

    /**

        Check if command already used

    */    
    if (hasUsedWDH[client] < 3 && IsPlayerAlive(client)){
        char name[MAX_NAME_LENGTH];
        hasUsedWDH[client]++;
        SetEntityRenderColor(client, 255, 255, 0, 255);
        GetClientName(client, name, sizeof(name));
        CreateTimer(cvTimer.FloatValue, TimerReset, GetClientUserId(client));
        hasCooldown[client] = CreateTimer(cvCooldown.FloatValue, TimerCooldown, GetClientUserId(client));
        CPrintToChatAll("%t", "Command wdh used", name);
    } else  {
        CPrintToChat(client, "%t", "Command wdh already used");
    }
    return Plugin_Handled;
}

public Action CommandHeal(int client, int args){
    /**

        Check if client is a T

    */
    if (!IsT(client)){
        CPrintToChat(client, "%t", "Wrong team");
        return Plugin_Handled;        
    }

    /**

        Check if client has cooldown

    */
    if (hasCooldown[client] != INVALID_HANDLE){
        CPrintToChat(client, "%t", "Command cooldown");
        return Plugin_Handled;
    }

    /**

        Check if command already used

    */    
    if (!hasUsedHeal[client] && IsPlayerAlive(client)){
        char name[MAX_NAME_LENGTH];
        hasUsedHeal[client] = !hasUsedHeal[client];
        SetEntityRenderColor(client, 255, 0, 0, 255);
        GetClientName(client, name, sizeof(name));
        CreateTimer(cvTimer.FloatValue, TimerReset, GetClientUserId(client));
        hasCooldown[client] = CreateTimer(cvCooldown.FloatValue, TimerCooldown, GetClientUserId(client));
        CPrintToChatAll("%t", "Command heal used", name);
    } else  {
        CPrintToChat(client, "%t", "Command heal already used");
    }
    return Plugin_Handled;
}

/**************************************************

	Timer functions

**************************************************/
public Action TimerReset(Handle timer, any data){
    int client = GetClientOfUserId(data);
    if (IsValid(client)){
        SetEntityRenderColor(client, 255, 255, 255, 255);
    }
    return Plugin_Handled;
}

public Action TimerCooldown(Handle timer, any data){
    int client = GetClientOfUserId(data);
    if (IsValid(client)){
        hasCooldown[client] = INVALID_HANDLE;
    }
    return Plugin_Handled;
}

/**************************************************

	Stock functions

**************************************************/
stock bool IsValid(int client){
	if (client <= 0 || client > MaxClients) return false;
	if (!IsClientConnected(client) || !IsClientInGame(client)) return false;
	if (IsClientSourceTV(client) || IsClientReplay(client)) return false;
	return true;
}

stock bool IsT(int client){
    if (IsValid(client) && GetClientTeam(client) == CS_TEAM_T) return true;
    else return false;
}