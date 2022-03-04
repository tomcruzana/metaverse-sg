// owner properties
key user;

// listener properties
integer game_settings_listen_handle;
integer GAME_CHANNEL = -667;

removeListenHandle()
{
    llListenRemove(game_settings_listen_handle);
}

// game state
integer isGameStarting = FALSE;

// doll controller script properties
integer dollControllerScriptState = FALSE;
string dollController = "doll_controller";

//user-defined function
counter(integer i)
{
    for(;i>0;i--)
    {
        llShout(0, (string)i);
        llSleep(5.0);
    }
    llShout(0,"Go!");
}

integer startGame(string gameStatus)
{
    llSetScriptState("doll_controller",FALSE);
    llShout(0, "The game will "+gameStatus+" in 3 seconds.\n Get to the safe zone and get ready!");
    counter(3);
    llSetScriptState("doll_controller",TRUE);
    llResetOtherScript("doll_controller");
    llResetOtherScript("doll_massacre_controller");
    llRegionSay(GAME_CHANNEL,"UNSAFE" );
    
    return TRUE;
}

string toggleStartOrRestartGame()
{
    /* enable if you want a restart feature 
    if(isGameStarting)
    {
        return "Restart";
    }
    else
    {
        return "Start";
    }
    */
    
    return "Start"; 
}

default
{
    state_entry()
    {
        removeListenHandle();
    
        // preload sounds
        llPreloadSound("fire_auto");
        llPreloadSound("easy_doll");
        llPreloadSound("medium_doll");
        llPreloadSound("hard_doll");
        llPreloadSound("evil_doll");
        
        // todo remove . this is temporary
        game_settings_listen_handle = llListen(GAME_CHANNEL, "", "", "");
    }

    touch_start(integer total_number)
    {
        // get the avatar key that touched the object 
        user = llDetectedKey(0);
        
        // clear exsisting listeners        
        removeListenHandle();
        
        // initialize listener
        game_settings_listen_handle = llListen(GAME_CHANNEL, "", user, "");
        // game_settings_listen_handle = llListen(GAME_CHANNEL, "", "", "");
        
        llDialog(user, "\nBETA version\nPlease select an option", [toggleStartOrRestartGame(), "End"] , GAME_CHANNEL);
        
        // time out listener for dialog
        llSetTimerEvent(60.0);
    }
    
    listen(integer channel, string name, key id, string message)
    {
        if (message == "Start")
        {
            if(isGameStarting == TRUE)
            {
                llInstantMessage(user,"Please end the current game.");
            }
            else
            {
                isGameStarting = startGame("start");
            }
        }
        else if (message == "Restart")
        {
            if(isGameStarting == TRUE)
            {
                llRegionSay(GAME_CHANNEL, "RESTART");
                isGameStarting = startGame("restart");
            }
            else
            {
                llInstantMessage(user,"Please start a new game.");
            } 
        }
        else if (message == "End")
        {
            if(isGameStarting == TRUE)
            {
                llResetOtherScript("doll_controller");
                llSetScriptState("doll_controller",FALSE);
                isGameStarting = FALSE;
                llRegionSay(GAME_CHANNEL,"END" );
                llInstantMessage(user, "Game Over!");
                removeListenHandle();
            }
            else
            {
                llInstantMessage(user,"Please start a new game.");
            }
        }
    }
    
    timer()
    {
        // stop listening. It's wise to do this to reduce lag
        removeListenHandle();
        llSetTimerEvent(0.0);
    }
    
    // execute on rez & change owner
    on_rez(integer start_param)
    {
        llResetScript();
    }
 
    changed(integer change)
    {
        if (change & CHANGED_OWNER)
        {
            llResetScript();
        }
    }
}
