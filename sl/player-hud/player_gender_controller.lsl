integer genderListener;
integer GENDER_CHANNEL = -669;

default
{
    state_entry()
    {
        // set player gender listener and dialog popup box
        genderListener = llListen(GENDER_CHANNEL, "", "", "");
        llDialog(llGetOwner(), "\nChoose your gender", ["Male", "Female" ] , GENDER_CHANNEL);
        llSetTimerEvent(60.0);
    }

    listen(integer channel, string name, key id, string message)
    {      
        // send message to player_death_sound_controller  
        if (channel == GENDER_CHANNEL && message == "Male")
        {
            llMessageLinked(LINK_THIS, 0, "Male", "");
            llSetTimerEvent(0.0);
        }
        else if(channel == GENDER_CHANNEL && message == "Female")
        {
            llMessageLinked(LINK_THIS, 0, "Female", "");
            llSetTimerEvent(0.0);
        }
        
        // The user did not click "Yes" ...
        // Make the timer fire immediately, to do clean-up actions
        llSetTimerEvent(0.1);  
    }
        
    // clear gender listener if after 60 seconds
    timer()
    {
        llListenRemove(genderListener);
        llSetTimerEvent(0.0);
    }
}
