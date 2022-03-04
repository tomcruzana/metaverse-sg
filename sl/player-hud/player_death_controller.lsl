// the wearer's key
key gOwner; 

// listener
integer GAME_CHANNEL = -667;
integer listen_handle;

// set player death text properties
vector COLOR_RED = <1.000, 0.255, 0.212>;
float  OPAQUE      = 1.0;

/* runtime animation perm state
doc: http://wiki.secondlife.com/wiki/Run_time_permissions */
integer getRuntimePerm;

/*
rezBulletTracer()
{
    rotation rot = llGetRot();
    vector vel = llRot2Fwd(rot);           
    vector pos = llGetPos();               
    pos = pos + vel;               
    pos.z += 0.75;                 
    vel = vel * 100;
    llRezObject("bullet_tracer", pos, vel, rot, 0);
}
*/

// particle for directional blood Spray
sprayBlood()
{
    llParticleSystem([
    PSYS_PART_FLAGS,(0|256|1|2|16),
    PSYS_PART_START_COLOR,<0.50000, 0.20000, 0.20000>,
    PSYS_PART_END_COLOR,<0.62000, 0.25000, 0.20000>,
    PSYS_PART_START_ALPHA,0.800000,
    PSYS_PART_END_ALPHA,0.300000,
    PSYS_PART_START_GLOW,0.000000,
    PSYS_PART_END_GLOW,0.000000,
    PSYS_PART_START_SCALE,<0.07000, 0.07000, 0.00000>,
    PSYS_PART_END_SCALE,<0.60000, 0.60000, 0.00000>,
    PSYS_PART_MAX_AGE,0.800000,
    PSYS_SRC_ACCEL,<0.00000, 0.00000, -1.40000>,
    PSYS_SRC_PATTERN,4,
    PSYS_SRC_TEXTURE,"85ee6ede-13dc-36a0-f827-5af899e1e771",
    PSYS_SRC_BURST_RATE,0.020000,
    PSYS_SRC_BURST_PART_COUNT,1,
    PSYS_SRC_BURST_RADIUS,0.000000,
    PSYS_SRC_BURST_SPEED_MIN,1.200000,
    PSYS_SRC_BURST_SPEED_MAX,2.000000,
    PSYS_SRC_MAX_AGE,0.000000,
    PSYS_SRC_OMEGA,<0.00000, 0.00000, 0.00000>,
    PSYS_SRC_ANGLE_BEGIN,0.000000*PI,
    PSYS_SRC_ANGLE_END,0.010000*PI]);
    llSleep(5.0);
    llParticleSystem([]);
}

// move lock avatar
freezePlayerControls(integer perm)
{
    integer desired_controls = 
                CONTROL_FWD |
                CONTROL_BACK |
                CONTROL_LEFT |
                CONTROL_RIGHT |
                CONTROL_ROT_LEFT |
                CONTROL_ROT_RIGHT |
                CONTROL_UP |
                CONTROL_DOWN |
                CONTROL_LBUTTON |
                CONTROL_ML_LBUTTON; 

    if (perm & PERMISSION_TAKE_CONTROLS) 
    {
            llTakeControls(1, 1, 0); // glitch the rotation
            llTakeControls(desired_controls, 1, 0);
    } 
}

// plays the player death animation
die()
{
    llSetScriptState("player_controller",FALSE);
    freezePlayerControls(getRuntimePerm);
    
    // play the death sound from player_death_sound_controller
    llMessageLinked(LINK_THIS, 0, "MakeDeathSound", "");

    llStartAnimation("die_02");
    llSetText("Player eliminated\nYou are dead and can't move until the round ends", COLOR_RED, OPAQUE );
    
    // rez bullet tracer and blood effects
    // rezBulletTracer();
    sprayBlood();
}

Initialize(key id) {
    if (id == NULL_KEY) { // detaching
        llSetTimerEvent(0.0); // stop the timer
    }
    else { // attached, or reset while worn
        // request avatar control & animation
        llRequestPermissions(id, PERMISSION_TAKE_CONTROLS | PERMISSION_TRIGGER_ANIMATION);
    }
}

default
{
    state_entry()
    {   
        gOwner = llGetOwner();
        
        if (llGetAttached() != 0) {
            Initialize(gOwner);
        }
        
        llListenRemove(listen_handle);
        listen_handle = llListen(GAME_CHANNEL, "", "", "");
    }
    
    run_time_permissions(integer perm)
    {
        getRuntimePerm = perm;
    }   
    
    link_message(integer sender_num, integer num, string msg, key id)
    {
        if(msg == "die")
        {
            die();           
        }
    }
    
    listen( integer channel, string name, key id, string message )
    {
        if(message == "RESTART" || message == "END")
        {
            llMessageLinked(LINK_THIS, 0, "TELEPORT", "");
            llReleaseControls(); // release controls
            llResetOtherScript("player_game_controller");
            llSetScriptState("player_death_controller",FALSE);
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
