// player gender
integer isPlayerMale = TRUE;

default
{
    link_message(integer sender_num, integer num, string msg, key id)
    {   
        // gender options
        if(msg == "Male")
        {
            isPlayerMale = TRUE;
            llOwnerSay("Player gender set to male");
        }
        else if(msg == "Female")
        {
            isPlayerMale = FALSE;
            llOwnerSay("Player gender set to female");
        }  
        
        // death sound
        else if(msg == "MakeDeathSound")
        {
            if(!isPlayerMale)
            {
                llPlaySound("female_hit", 1.0);
                llPlaySound("female_death", 1.0);
            }
            else
            {
                llPlaySound("male_hit", 1.0);
                llPlaySound("male_death", 1.0);
            }          
        }
    }
}



    
