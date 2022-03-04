/* NOTE: when doll is singing, it needs to be looking away from the players */

// game settings
integer isGameStart = FALSE;

// listener
integer listenHandle;
integer CHANNEL = -666;
integer DOLL_SING_CHANNEL = -669;

// use - to reverse the direction of swing, eg. -90;
integer rotation_angle = -180;
rotation g_rot_swing;

// sound volume 
float volume = 1.0;
string doll_song = "Mugunghwa Kkoci Pieot Seumnida";
integer is_singing = FALSE;

// user-defined functions
string sing()
{
    // randomize selection of the song (1 - 4)
    integer convertedInt = (integer)(llFrand (4.0) + 1.0);
    return (string) convertedInt;
}

turnHead(float interval, integer singing_val)
{
    is_singing = singing_val;
    //llShout(0, " doll singing? " + (string)is_singing);
    llSetLocalRot( (g_rot_swing = ZERO_ROTATION / g_rot_swing) * llGetLocalRot() );
    llSleep(interval);
}

removeListenHandle()
{
    llListenRemove(listenHandle);
    //llListenRemove(killAllPlayerHandle);
}

playSongSpeed(string msg)
{
        if (msg == "1")
        {
            // llShout(0, doll_song); optional shout of doll song lyrics
            
            llRegionSay(DOLL_SING_CHANNEL, "EASY_DOLL");
            llLoopSoundMaster("easy_doll", volume);
            
            llListenControl(listenHandle, FALSE);
            turnHead(5.0, TRUE);
            llListenControl(listenHandle, TRUE);
            
            llRegionSay(DOLL_SING_CHANNEL, "STOP_DOLL");
            llStopSound();

            turnHead(0.0, FALSE);
        }    
        else if (msg == "2")
        {
            llRegionSay(DOLL_SING_CHANNEL, "MEDIUM_DOLL");
            llLoopSoundMaster("medium_doll", volume);
            
            llListenControl(listenHandle, FALSE);
            turnHead(3.0, TRUE);
            llListenControl(listenHandle, TRUE);
            
            llRegionSay(DOLL_SING_CHANNEL, "STOP_DOLL");
            llStopSound();

            turnHead(0.0, FALSE);
        }  
        else if (msg == "3")
        {
            llRegionSay(DOLL_SING_CHANNEL, "HARD_DOLL");
            llLoopSoundMaster("hard_doll", volume);
            
            llListenControl(listenHandle, FALSE);
            turnHead(2.0, TRUE);
            llListenControl(listenHandle, TRUE);
            
            llRegionSay(DOLL_SING_CHANNEL, "STOP_DOLL");
            llStopSound();

            turnHead(0.0, FALSE);
        }  
        else if (msg == "4")
        {
            llRegionSay(DOLL_SING_CHANNEL, "EVIL_DOLL");
            llLoopSoundMaster("evil_doll", volume);
            
            llListenControl(listenHandle, FALSE);
            turnHead(1.0, TRUE);
            llListenControl(listenHandle, TRUE);
            
            llRegionSay(DOLL_SING_CHANNEL, "STOP_DOLL");
            llStopSound();

            turnHead(0.0, FALSE);
        } 
}

default
{
    
    state_entry()
    {   
        // clear exisiting listeners
        removeListenHandle();

        // reinitialize listener
        listenHandle = llListen(CHANNEL, "", "", "");
        
        // initialized doll rotation angle
        g_rot_swing = llEuler2Rot( <0.0, rotation_angle * DEG_TO_RAD, 0.0> );
        
        // play doll song with the specified interval value
        playSongSpeed("1"); // guaratees to start the slow doll song at the beginning of the game
        llSetTimerEvent(10.0);
    }

    listen(integer channel, string name, key id, string message)
    {
        // shoot player if not in standing state and if doll isn't singing
        if (channel == -666 && message != "Standing")
        {
            llPlaySound("fire_auto", volume);
            llRegionSay(CHANNEL, "KILL");
        }
        
        /* kill all listener
        if(channel == -668)
        {   
            // force doll turn animation
            turnHead(1.0, TRUE);
            llListenControl(listenHandle, TRUE);
            turnHead(0.0, FALSE);
            
            
            llPlaySound("fire_auto", volume);
            llRegionSay(CHANNEL, "KILLALL");
            
            llShout(0, "Time is up!");
            llPlaySound("time_is_up_alarm", TRUE);
            
            llSetScriptState("doll_controller",FALSE);
        }*/
    }
    
    timer()
    {
        playSongSpeed(sing());
    }

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