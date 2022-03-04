//UUID of the robot doll
//key robotDoll = "f3e38acb-6010-c66b-520a-f2a9513f0cf7s";

//listeners
integer listenHandle;
integer listenKillAllHandle;
integer CHANNEL = -666; 

// player name text
vector COLOR_WHITE = <1.000, 1.000, 1.000>;
vector COLOR_RED = <1.000, 0.255, 0.212>;
float  OPAQUE      = 1.0;

// player state
key gOwner; // the wearer's key
string currentAnimation = "Standing"; // default animation state
string gLastAnimation; // last llGetAnimation value seen

                
// User-defined functions
Initialize(key id) {
    if (id == NULL_KEY) { // detaching
        llSetTimerEvent(0.0); // stop the timer
    }
    else { // attached, or reset while worn
        // request avatar control & animation
        llRequestPermissions(id, PERMISSION_TRIGGER_ANIMATION);
    }
}

default
{
    state_entry() 
    {   
        // disable currently running particles, if any
        llParticleSystem([]);
    
        // get owner key & in case the script was reset while already attached
        gOwner = llGetOwner();
        
        if (llGetAttached() != 0) {
            Initialize(gOwner);
        }
        
        //listen handler
        listenHandle = llListen(CHANNEL, "", "", "KILL");
        listenKillAllHandle = llListen(CHANNEL, "", "", "KILLALL");
        
    }
    
    run_time_permissions(integer perm)
    {
        // for broadcasting animation state
        if (perm & PERMISSION_TRIGGER_ANIMATION) {
            llSetTimerEvent(0.25); // start polling
        }
        
    }    
    
    listen(integer channel, string name, key id, string message)
    {         
        if(channel == -666 && currentAnimation != "Standing")
        {
            // die
            // llSetScriptState("player_death_controller", TRUE);
            llMessageLinked(LINK_THIS, 0, "die", "");
        }
        
        if(channel = -668 && message == "KILLALL")
        {
            llMessageLinked(LINK_THIS, 0, "die", "");
        }
    }
 
    timer() {
            currentAnimation = llGetAnimation(gOwner);
        
            if(currentAnimation != "Standing")
            {
                // Any animation but NOT Standing
                llRegionSay(CHANNEL, currentAnimation);  
            }
            else
            {
                // Only Standing standing 
                llRegionSay(CHANNEL, "Standing");
            } 
    }
    
    attach(key id) {
        Initialize(id);
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
