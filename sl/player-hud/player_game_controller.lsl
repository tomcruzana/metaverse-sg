key gOwner;
integer listenHandle;
integer GAME_CHANNEL = -667;
vector COLOR_WHITE = <1.0, 1.0, 1.0>;
float  OPAQUE      = 1.0;

// set player text & standing animation back to normal  
resurrect()
{
    llStopAnimation("die_02");       
    llSetText("Player", COLOR_WHITE, OPAQUE );
}

remove_listen_handle()
{
    llListenRemove(listenHandle);
}
 
default
{
    state_entry()
    {   
        // make sure to make this object transparent
        llSetAlpha(0.0, ALL_SIDES);
        
        // get owner UUID key
        gOwner = llGetOwner();
        
        // request avatar control & animation 
        llRequestPermissions(gOwner, PERMISSION_TAKE_CONTROLS | PERMISSION_TRIGGER_ANIMATION);
        
        // set player text & standing animation back to normal 
        resurrect();
        
        // clears any running particles, if any
        llParticleSystem([]);
        
        // set player default name text
        llSetText("Player", COLOR_WHITE, OPAQUE );

        // set player default name text
        llSetText("BETA HUD\nSquid Player v1.0.15", COLOR_WHITE, OPAQUE );
        listenHandle = llListen(GAME_CHANNEL, "", "", "");
        llSetScriptState("player_controller",FALSE);
        
        //set safe line collission filter
        llCollisionFilter("SAFE_LINE","",TRUE); 

    }
    
    collision_start(integer total_number)
    {
        // llShout(0, llKey2Name(gOwner) + " is safe.");
        llSetScriptState("player_death_controller",FALSE);
        llSetScriptState("player_controller",FALSE);
    }
 
    listen(integer channel, string name, key id, string message)
    {    
        if(message == "SAFE")
        {
            
            // if this wont work, attach and reattach using script
            llSetScriptState("player_controller", TRUE);
            llResetOtherScript("player_controller");
            llSetScriptState("player_controller", FALSE);
            
            llSetScriptState("player_death_controller", TRUE);
            llResetOtherScript("player_death_controller");
            llSetScriptState("player_death_controller", FALSE);
            
            //resurrect();
            
            llResetScript(); // reset this script
            
        }
        else if(message == "UNSAFE")
        {
            llSetScriptState("player_controller", TRUE);
            llResetOtherScript("player_controller");
            
            llSetScriptState("player_death_controller", TRUE);
            llResetOtherScript("player_death_controller");
        }
    }
 
    // triggered when object is rezzed
    on_rez(integer start_param)
    {
        llResetOtherScript("player_death_sound_controller");
        llResetOtherScript("player_gender_controller");
        llResetScript();
    }
 
    // triggered when object changes owner
    changed(integer change)
    {
        if (change & CHANGED_OWNER)
        {
            llResetOtherScript("player_death_sound_controller");
            llResetOtherScript("player_gender_controller");
            llResetScript();
        }
    }
    
    // triggered when this object attaches or detaches from the avatar
    attach(key id)
    {
        // id is a valid key and not NULL_KEY
        if (id)
        {
            llSetScriptState("player_controller",FALSE);
            llResetOtherScript("player_death_sound_controller");
            llResetOtherScript("player_gender_controller");
            llResetScript();
        }
        else
        {
            llSetScriptState("player_controller",FALSE);
        }
    }
}