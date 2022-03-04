integer MASSACRE_CHANNEL = -668;
integer CHANNEL = -666;
integer killAllPlayerHandle;
/*
turnHead()
{
    llSetLocalRot( (g_rot_swing = ZERO_ROTATION / g_rot_swing) * llGetLocalRot() );
}
*/

default
{
    state_entry()
    {   
        llListenRemove(killAllPlayerHandle);
        killAllPlayerHandle = llListen(MASSACRE_CHANNEL, "", "", "MASSACRE");
    }

    listen(integer channel, string name, key id, string message)
    {
        // kill all listener
        if(channel == -668)
        {   
            llOwnerSay("MASSACRE TRIGERRED");
            
            llShout(0, "Time is up!");
            
            //turnHead();
            
            llPlaySound("fire_auto", 1.0);
            
            llRegionSay(CHANNEL, "KILLALL");
        
            llSetScriptState("doll_controller",FALSE);
        }
    }
}
