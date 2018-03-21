/****Made by Escobar a.k.a Escobabe****/
/*************Version 1.0*************/
/****Advanced Bank Robbing System****/

#define FILTERSCRIPT

#include <a_samp>
#include <sscanf2>
#include <zcmd>

#if defined FILTERSCRIPT
#define COLOR_RED 0xFF0000FF
#define COLOR_GREEN 0x33AA33FF
#define BUY 69

new HackedSys[MAX_PLAYERS];
new Bribe[MAX_PLAYERS];
new Alarm;
new Bag[MAX_PLAYERS];
new MoneyRobbed[MAX_PLAYERS];
new Robbed[MAX_PLAYERS];

stock PlayerName(playerid)
{
  new name[MAX_PLAYER_NAME];
  GetPlayerName(playerid, name, MAX_PLAYER_NAME);
  return name;
}

forward Hacked(playerid);
public Hacked(playerid)
{
	TogglePlayerControllable(playerid,1);
	GameTextForPlayer(playerid,"Hacking completed.",2000,6);
	return 1;
}

forward RobbingTime(playerid);
public RobbingTime(playerid)
{
	if(GetPlayerInterior(playerid) == 0) return 0;
	SendClientMessage(playerid,COLOR_RED,"You weren't so fast, the alarm has been turned on.");
	SetPlayerWantedLevel(playerid,6);
	ApplyActorAnimation(1, "ped", "cower", 3.0, 1, 0, 0, 0, 0);
	ApplyActorAnimation(2, "ped", "cower", 3.0, 1, 0, 0, 0, 0);
	ApplyActorAnimation(3, "ped", "cower", 3.0, 1, 0, 0, 0, 0);
	ApplyActorAnimation(4, "ped", "cower", 3.0, 1, 0, 0, 0, 0);
	return 1;
}

forward RobbingSafe(playerid);
public RobbingSafe(playerid)
{
    new rand=400000 +(random(350000)), str[100];
	TogglePlayerControllable(playerid,1);
	GameTextForPlayer(playerid,"Robbing sucessfull",2000,6);
	SendClientMessage(playerid,COLOR_GREEN,"Quickly get outside so the alarm won't get turned on.");
	format(str,sizeof(str),"%s has robbed %d$ from the bank.",PlayerName(playerid),rand);
	SendClientMessageToAll(COLOR_GREEN,str);
	GivePlayerMoney(playerid, rand);
	MoneyRobbed[playerid] = rand;
	HackedSys[playerid] = 0;
	Bribe[playerid] = 0;
	Bag[playerid] = 0;
	Alarm = 1;
	SetTimer("Reset",120000,0);
	return 1;
}

forward Reset();
public Reset()
{
	ClearActorAnimations(1);
	ClearActorAnimations(2);
	ClearActorAnimations(3);
	ClearActorAnimations(4);
	Alarm = 0;
	return 1;
}

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("Advanced Bank Robbing System by Escobar");
	print("--------------------------------------\n");
	
	CreatePickup(1239,1,363.4240,210.2281,1008.3828); // Info point for /hacksystem
	CreatePickup(1239,1,345.3308,162.1849,1025.7964); // Info point for /robsafe
	CreatePickup(1239,1,-426.0232,2240.6008,42.4297); // Info point for /hidemoney
	CreatePickup(1239,1,370.1941,167.2163,1008.3828); // Info point for /bribe
	
	Create3DTextLabel("/hacksytem", 0xF70AF7, 363.4240,210.2281,1008.3828, 40.0, 0, 0); // Hacksystem
	Create3DTextLabel("/robsafe", 0xF70AF7, 345.3308,162.1849,1025.7964, 40.0, 0, 0); // Robsafe
	Create3DTextLabel("/hidemoney", 0xF70AF7, -426.0232,2240.6008,42.4297, 40.0, 0, 0); // Hidemoney
	Create3DTextLabel("/bribe", 0xF70AF7, 370.1941,167.2163,1008.3828, 40.0, 0, 0); // Bribe
	
	CreateActor(76,359.7125,173.5383,1008.3828,269.2284);
	CreateActor(71,370.1941,167.2163,1008.3828,359.5908);
	CreateActor(141,373.4727,182.8896,1008.8679,1.7843);
	CreateActor(147,372.0834,183.9877,1008.8679,276.3627);
	CreateObject(2919,2153.9731,1599.2941,1006.1754,0.0,0.0,0.0,0.0);
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}

#endif

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
	HackedSys[playerid] = 0;
	Bribe[playerid] = 0;
	Bag[playerid] = 0;
	Robbed[playerid] = 0;
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	HackedSys[playerid] = 0;
	Bribe[playerid] = 0;
	Bag[playerid] = 0;
	Robbed[playerid] = 0;
	for(new i=0; i<MAX_PLAYER_ATTACHED_OBJECTS; i++)
 	{
  		if(IsPlayerAttachedObjectSlotUsed(playerid, i)) RemovePlayerAttachedObject(playerid, i);
    }
    return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/mycommand", cmdtext, true, 10) == 0)
	{
		// Do something here
		return 1;
	}
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == BUY)
    {
        if(response)
        {
            if(Bag[playerid] == 1) return SendClientMessage(playerid,COLOR_RED,"You already have purchased one bag.");
            if(GetPlayerMoney(playerid) < 500) return SendClientMessage(playerid,COLOR_RED,"You don't have enough money.");
            Bag[playerid] = 1;
            SendClientMessage(playerid,COLOR_GREEN,"You've succesfully purchased the bag.");
            GivePlayerMoney(playerid,-500);
        }
        return 1;
    }
    return 0;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

//////////////////////////COMMANDS/////////////////////////////////////////////

CMD:hacksystem(playerid,params[])
{
	if(!IsPlayerInRangeOfPoint(playerid,3.0,363.4240,210.2281,1008.3828)) return SendClientMessage(playerid,COLOR_RED,"You need to be near the computers to hack the system.");
	if(Bribe[playerid] == 0) return SendClientMessage(playerid,COLOR_RED,"You must bribe the Security Guard first.");
	if(Alarm == 1) return SendClientMessage(playerid,COLOR_RED,"The bank has just been robbed, please wait 2 minutes.");
	GameTextForPlayer(playerid,"Hacking the system...",10000,6);
	TogglePlayerControllable(playerid,0);
	HackedSys[playerid] = 1;
	SetTimerEx("Hacked",10000,0,"i",playerid);
	return 1;
}

CMD:bribe(playerid,params[])
{
	if(!IsPlayerInRangeOfPoint(playerid,3.0,370.1941,167.2163,1008.3828)) return SendClientMessage(playerid,COLOR_RED,"You need to be near the Security Guard to bribe him.");
    if(Alarm == 1) return SendClientMessage(playerid,COLOR_RED,"The bank has just been robbed, please wait 2 minutes.");
	if(Bribe[playerid] == 1) return SendClientMessage(playerid,COLOR_RED,"You've already bribed the Security Guard, go hack the system now.");
	if(GetPlayerMoney(playerid) < 50000) return SendClientMessage(playerid,COLOR_GREEN,"Security Guard says: What? I'll not risk my job for this money.");
	GivePlayerMoney(playerid,-50000);
    SendClientMessage(playerid,COLOR_GREEN,"Security Guard says: Alright, i'll turn my head to the other side, you got 1 minute.");
    SetTimerEx("RobbingTime",60000,0,"i",playerid);
    Bribe[playerid] = 1;
    return 1;
}

CMD:buy(playerid,params[])
{
	if(GetPlayerInterior(playerid) != 6) return SendClientMessage(playerid,COLOR_RED,"You need to be inside the store to buy the bag.");
	ShowPlayerDialog(playerid, BUY, DIALOG_STYLE_TABLIST_HEADERS, "Store Products",
	"Peoduct\tUnit\tPrice\n\
	Bag\t1\t500",
	"Select", "Close");
	return 1;
}

CMD:robsafe(playerid,params[])
{
    if(Alarm == 1) return SendClientMessage(playerid,COLOR_RED,"The bank has just been robbed, please wait 2 minutes.");
	if(!IsPlayerInRangeOfPoint(playerid,3.0,345.3308,162.1849,1025.7964)) return SendClientMessage(playerid,COLOR_RED,"You're not at the banks safe.");
	if(Bag[playerid] == 0) return SendClientMessage(playerid,COLOR_RED,"You don't have a bag.");
	if(HackedSys[playerid] == 0) return SendClientMessage(playerid,COLOR_RED,"You didn't hack the system as of first.");
	if(Bribe[playerid] == 0) return SendClientMessage(playerid,COLOR_RED,"You didn't bribe the Security Guard.");
	SetTimerEx("RobbingSafe",10000,0,"i",playerid);
	TogglePlayerControllable(playerid,0);
	GameTextForPlayer(playerid,"Robbing the safe...",10000,6);
	Robbed[playerid] = 1;
	SetPlayerAttachedObject(playerid, 3, 1550, 6, 0.101, -0.0, 0.0, 5.50, 8.60, 3.7, 1, 1, 1, 0xFF00FF00);
	return 1;
}

CMD:hidemoney(playerid,params[])
{
	if(!IsPlayerInRangeOfPoint(playerid,3.0,-426.0232,2240.6008,42.4297)) return SendClientMessage(playerid,COLOR_RED,"You're not at the hideout.");
	SetPlayerWantedLevel(playerid,0);
	SendClientMessage(playerid,COLOR_GREEN,"You've succesfully evaded the cops, money is now safe.");
	for(new i=0; i<MAX_PLAYER_ATTACHED_OBJECTS; i++)
 	{
  		if(IsPlayerAttachedObjectSlotUsed(playerid, i)) RemovePlayerAttachedObject(playerid, i);
    }
	return 1;
}

CMD:steal(playerid,params[])
{
	new id, rand = MoneyRobbed[playerid];
	if(sscanf(params,"u",id)) return SendClientMessage(playerid,COLOR_RED,"USAGE: /steal [id]");
	GivePlayerMoney(playerid,MoneyRobbed[playerid] += rand);
	GivePlayerMoney(id,MoneyRobbed[playerid] -= rand);
	return 1;
}

CMD:money(playerid,params[])
{
	new str[75];
	format(str,sizeof(str),"Money: %d",GetPlayerMoney(playerid));
	SendClientMessage(playerid,COLOR_GREEN,str);
	return 1;
}
