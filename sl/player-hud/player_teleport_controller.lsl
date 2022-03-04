/* optional feature: tp back to starting zone */
integer getRuntimePerm;
key gOwner;

// teleport to safe zone
teleportToSafeZone(integer perm)
{
    llRequestPermissions(gOwner, PERMISSION_TELEPORT);
}

default
{
    state_entry()
    {
        gOwner = llGetOwner();
    }
    
    link_message(integer source, integer num, string str, key id)
    {
        if(str == "TELEPORT")
        {
             
             teleportToSafeZone(getRuntimePerm); 
        } 
    }
    
    run_time_permissions(integer perm)
    {
        getRuntimePerm = perm;
        
        if(PERMISSION_TELEPORT & perm)
        {
            llTeleportAgent(gOwner, "START", <0.0, 0.0, 0.0>, <0.0, 0.0, 0.0>);
        }
    } 
    
    attach(key id) {
        llResetScript();
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
