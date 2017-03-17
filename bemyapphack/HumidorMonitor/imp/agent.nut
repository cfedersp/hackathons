///
Xively <- {
    FEED_ID = "1046002214"
    API_KEY = "ryWC91gsjdeOOvLl1F5xltqQZyMzNwBSKyOCdml9mnFUNbYv"
    triggers = []
}

const TWILIO_ACCOUNT_SID = "ACf90bb6b364e146a214dc70938adb9d63"
const TWILIO_AUTH_TOKEN = "f86c7f7817a8611098410c0f81d41a65"
const TWILIO_FROM_NUMBER = "+16502930023" // your phone no goes here
const TWILIO_TO_NUMBER = "+16507226399" // destination phone no

local GLOBAL_TEMP = 0;

function send_sms(number, message) {
    local twilio_url = format("https://api.twilio.com/2010-04-01/Accounts/%s/Messages.json", TWILIO_ACCOUNT_SID);
    local auth = "Basic " + http.base64encode(TWILIO_ACCOUNT_SID+":"+TWILIO_AUTH_TOKEN);
    local body = http.urlencode({From=TWILIO_FROM_NUMBER, To=number, Body=message});
    local req = http.post(twilio_url, {Authorization=auth}, body);
    local res = req.sendsync();
    if(res.statuscode != 201) {
        server.log("error sending message: "+res.body);
    }
}


/*****************************************
 * method: PUT
 * IN:
 *   feed: a XivelyFeed we are pushing to
 *   ApiKey: Your Xively API Key
 * OUT:
 *   HttpResponse object from Xively
 *   200 and no body is success
 *****************************************/
function Xively::Put(feed, ApiKey = Xively.API_KEY){
    if (ApiKey == null) ApiKey = Xively.API_KEY;
    local url = "https://api.xively.com/v2/feeds/" + feed.FeedID + ".json";
    local headers = { "X-ApiKey" : ApiKey, "Content-Type":"application/json", "User-Agent" : "Xively-Imp-Lib/1.0" };
    local request = http.put(url, headers, feed.ToJson());

    return request.sendsync();
}
    
/*****************************************
 * method: GET
 * IN:
 *   feed: a XivelyFeed we fulling from
 *   ApiKey: Your Xively API Key
 * OUT:
 *   An updated XivelyFeed object on success
 *   null on failure
 *****************************************/
function Xively::Get(feed, ApiKey = Xively.API_KEY){
    local url = "https://api.xively.com/v2/feeds/" + feed.FeedID + ".json";
    local headers = { "X-ApiKey" : ApiKey, "User-Agent" : "xively-Imp-Lib/1.0" };
    local request = http.get(url, headers);
    local response = request.sendsync();
    if(response.statuscode != 200) {
        server.log("error sending message: " + response.body);
        return null;
    }
    
    local channel = http.jsondecode(response.body);
    for (local i = 0; i < channel.datastreams.len(); i++)
    {
        for (local j = 0; j < feed.Channels.len(); j++)
        {
            if (channel.datastreams[i].id == feed.Channels[j].id)
            {
                feed.Channels[j].current_value = channel.datastreams[i].current_value;
                break;
            }
        }
    }
    
    return feed;
}

class Xively.Feed{
    FeedID = null;
    Channels = null;
    
    constructor(feedID, channels)
    {
        this.FeedID = feedID;
        this.Channels = channels;
    }
    
    function GetFeedID() { return FeedID; }

    function ToJson()
    {
        local json = "{ \"datastreams\": [";
        for (local i = 0; i < this.Channels.len(); i++)
        {
            json += this.Channels[i].ToJson();
            if (i < this.Channels.len() - 1) json += ",";
        }
        json += "] }";
        return json;
    }
}
class Xively.Channel{
    id = null;
    current_value = null;
    
    constructor(_id)
    {
        this.id = _id;
    }
    
    function Set(value) { this.current_value = value; }
    
    function Get() { return this.current_value; }
    
    function ToJson() { return "{ \"id\" : \"" + this.id + "\", \"current_value\" : \"" + this.current_value + "\" }"; }    
}

device.on("XivelyFeed", function(data) {
    local channels = [];
    for(local i = 0; i < data.Datastreams.len(); i++)
    {
        local channel = Xively.Channel(data.Datastreams[i].id);
        channel.Set(data.Datastreams[i].current_value);
        channels.push(channel);
    }
    local feed = Xively.Feed(data.FeedID, channels);
    local resp = Xively.Put(feed, Xively.API_KEY);
    server.log("Send data to Xively (FeedID: " + feed.FeedID + ") - " + resp.statuscode + " " + resp.body);
});
function Xively::On(feedID, streamID, callback) {
    if (Xively.triggers == null) Xively.triggers = [];
    // Make sure the trigger doesn't already exist
    for(local i = 0; i < triggers.len(); i++) {
        if (Xively.triggers.FeedID == feedID && Xively.triggers.StreamID = streamID)
        {
            server.log("ERROR: A trigger already exists for " + feedID + " : " + streamID);
            return;
        }
    }
    Xively.triggers.push({ FeedID = feedID, StreamID = streamID, Callback = callback });
}
function Xively::HttpHandler(request,res) {
    local responseTable = http.urldecode(request.body);
    local parsedTable = http.jsondecode(responseTable.body);
    res.send(200, "okay");    
    
    local trigger = { 
        FeedID = parsedTable.environment.id,
        FeedName = parsedTable.environment.title,
        StreamID = parsedTable.triggering_datastream.id,
        ThresholdValue = parsedTable.threshold_value,
        CurrentValue = parsedTable.triggering_datastream.value.value,
        TriggeredAt = parsedTable.timestamp,
        Debug = parsedTable.debug }
    if (trigger.Debug) {
        server.log(trigger.FeedID + "(" + trigger.StreamID + ") triggered at " + trigger.TriggeredAt + ": " + trigger.CurrentValue + " / " + trigger.ThresholdValue);
    }
    
    local callback = null;
    for (local i = 0; i < Xively.triggers.len(); i++)
    {
        if (Xively.triggers[i].FeedID = trigger.FeedID && Xively.triggers[i].StreamID == trigger.StreamID)
        {
            callback = Xively.triggers[i].Callback;
            break;
        }
    }
    if (callback == null){
        server.log("Unknown trigger from Xively - to create a callback for this trigger add the following line to your agent code:");
        server.log("Xively.On(\"" + trigger.FeedID + "\", \"" + trigger.StreamID + "\", triggerCallback);");
        return;
    }
    callback(trigger);
}
http.onrequest(function(req, resp) {
    if (req.path == "/xively") Xively.HttpHandler(req, resp);
});
/***************************************************** END OF API CODE *****************************************************/
device.on("SendToXively", function(data) {
    local channel = Xively.Channel(data.id);
    GLOBAL_TEMP = data.value - 19;
    channel.Set(GLOBAL_TEMP);
    local feed = Xively.Feed(Xively.FEED_ID, [channel]);
    local resp = Xively.Put(feed);
    //server.log(format("temperature agent %fC", data.value));
    
    // if(data.box){
    //     send_sms("+16507226399","WARNING: Box is Open");
    // }
    server.log(format("temperature %fC", GLOBAL_TEMP));
    
    if(GLOBAL_TEMP >= 68){
        //server.log(format("temperature test %fC", data.value));
        send_sms("+16507226399","WARNING: Temp level above optimal range");
    }

});

function requestHandler(request, response) {
  try {
    // check if the user sent led as a query parameter
    
    local json = http.jsonencode({"temp": GLOBAL_TEMP});
    response.send(200, json);
  } catch (ex) {
    response.send(500, "Internal Server Error: " + ex);
  }
}

// register the HTTP handler
http.onrequest(requestHandler);

