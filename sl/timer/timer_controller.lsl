integer CH = 3000;
integer palette = 555;

integer digits = 7; // number of digits in linkset (must be named in numerical order....1,2,3,4...


integer tempNum;

vector colorON = <1.0,0.42,1.0>;
vector colorOFF = <0.2,0.2,0.2>;

list one = [0,1];
list two = [2,0,3,6,4];
list three = [2,0,3,1,4];
list four = [5,0,3,1];
list five = [2,5,3,1,4];
list six = [2,5,3,6,1,4];
list seven = [2,0,1];
list eight = [2,5,0,3,6,1,4];
list nine = [2,5,0,3,1,4];
list zero = [2,5,0,6,1,4];

process(string num)
{
    integer x;
    integer length = llGetNumberOfPrims();
    integer len = llStringLength(num);
    tempNum = digits;
    @again;
    for(x = 1; x <= length; x++)
    {
        string compare = llGetLinkName(x);
        if(compare=="dots")
        {
            llSetLinkPrimitiveParamsFast(x,[ PRIM_COLOR, 0, colorON, 1.0, PRIM_FULLBRIGHT, 0, 1,PRIM_GLOW, 0, 0.1]);
        }
        if((string)tempNum==compare)
        {
            if(len<1)
            {
                off(x);
                jump out;
            }
            string digit = llGetSubString(num,len-1,len-1);
            list segments=[];
            
            if(digit=="1")
            {
                segments = one;
            }
            if(digit=="2")
            {
                segments = two;
            }
            if(digit=="3")
            {
                segments = three;
            }
            if(digit=="4")
            {
                segments = four;
            }
            if(digit=="5")
            {
                segments = five;
            }
            if(digit=="6")
            {
                segments = six;
            }
            if(digit=="7")
            {
                segments = seven;
            }
            if(digit=="8")
            {
                segments = eight;
            }
            if(digit=="9")
            {
                segments = nine;
            }
            if(digit=="0")
            {
                segments = zero;
            }
            len--;
            number(x,colorON,segments);
            @out;
            tempNum--;
            if(tempNum>0)
            {
                jump again;
            }
        }
    }
}
    
off(integer linkNum)
{
    list lst = [0,1,2,3,4,5,6];
    integer y;
    integer len=lst != [];
    for(y = 0; y < len; y++)
    {
         llSetLinkPrimitiveParamsFast(linkNum,[ PRIM_COLOR, llList2Integer(lst,y), colorOFF, 1.0, PRIM_FULLBRIGHT, llList2Integer(lst,y), 0,PRIM_GLOW, llList2Integer(lst,y), 0.0 ]);
    }
}

number(integer linkNum,vector color,list bits)
{
    list lst = [0,1,2,3,4,5,6];
    integer y;
    integer len=lst != [];
    for(y = 0; y < len; y++)
    {
        integer find = llListFindList(bits,[y]);
        if(find==-1)
        {
            llSetLinkPrimitiveParamsFast(linkNum,[ PRIM_COLOR, llList2Integer(lst,y), colorOFF, 1.0, PRIM_FULLBRIGHT, llList2Integer(lst,y), 0,PRIM_GLOW, llList2Integer(lst,y), 0.0 ]);
        }
    }
    integer x;
    integer length=bits != [];
    for(x = 0; x < length; x++)
    {
        llSetLinkPrimitiveParamsFast(linkNum,[ PRIM_COLOR, llList2Integer(bits,x), color, 1.0, PRIM_FULLBRIGHT, llList2Integer(bits,x), 1,PRIM_GLOW, llList2Integer(bits,x), 0.1]);
    }
}
//* This is just for example useage*//
integer numb;
integer STARTING = 30;
//--------//

integer listenHandle;
 
remove_listen_handle()
{
    llListenRemove(listenHandle);
}    

default
{
    state_entry()
    {
        numb = STARTING;
        listenHandle = llListen(-667, "", "", "");
    }
    
    listen(integer channel, string name, key id, string message)
    {
 
        if(message == "UNSAFE")
        {
            llSetTimerEvent(1.0);
        }
        else if(message == "END" || message == "RESTART")
        {
            numb = STARTING;
            llSetTimerEvent(0.0); 
        }
    }
     
    timer()
    {
        if(numb >= 1)
        {
            numb--;
            process((string)numb);
            //llShout(0, (string)numb); 
        }
        else if(numb == 0)
        {
            llRegionSay(-668, "MASSACRE");
            llSetTimerEvent(0.0); 
        }
    }
    
    link_message(integer sender_num, integer num, string str, key id)
    {
        if(num==CH)
        {
            process(str);
        }
        //if(num==palette)
        //{
        //    colorON = (vector)((string)id);
        //}
    }
}
