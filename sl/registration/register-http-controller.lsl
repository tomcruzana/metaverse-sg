// user data
key uuid;
string username;
string display_name;
integer wins;
string date_joined;
string region;
vector coordinates;

// http
key reqed;
string url = "https://jsonplaceholder.typicode.com/posts";
string body;

init()
{
    uuid = llDetectedKey(0);
    username = llGetUsername(llDetectedKey(0));
    display_name = llGetDisplayName(llDetectedKey(0));
    wins = 0;
    date_joined = llGetDate();
    region = llGetRegionName();
    coordinates = llGetPos();
}

default
{
    state_entry()
    {
    }

    touch_start(integer total_number)
    {
        init();
        
        body = "uuid="+(string)uuid+"&username="+username+"&displayname="+display_name+"&wins="+(string)wins+"&datejoined="+date_joined+"&region="+region+"&coordinates="+(string)coordinates;
        reqed = llHTTPRequest(url, [HTTP_METHOD, "POST", HTTP_MIMETYPE, "application/x-www-form-urlencoded"], body);

        llSay(0, ">>> Log: sent! <<<");
    }
    
    http_response(key request_id, integer status, list metadata, string body)
    {
        if(reqed==request_id)
        {
            llOwnerSay(body);      
        }
    }
}
