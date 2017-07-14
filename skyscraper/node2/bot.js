console.log("The bot is starting");
var Twit = require('twit')

var config = require('./config');
var T = new Twit(config);
var newTweet = 'yeni tweet';
tweet(newTweet);
var stream = T.stream('user');
stream.on('tweet', tweetEvent);

var twitId;

function tweetEvent (eventMsg){
    
    var replyto = eventMsg.in_reply_to_screen_name;
    var text = eventMsg.text;
    var from = eventMsg.user.screen_name;
    var replyId = eventMsg.id_str;
    console.log(replyto + " " + from);
   
    if(eventMsg.in_reply_to_status_id_str === twitId){
        var newTweet = '@' + from + ' NOOOOO';
        reply(newTweet, replyId);
        console.log("reply to id = " + replyId);
    }
   /* var fs = require('fs');
    var json = JSON.stringify(eventMsg,null,2);
    fs.writeFile("tweet.json", json);*/
}
function tweet (text) {
    var content = {
        status: text
    }
    T.post('statuses/update', content, isTweet);
    function isTweet(err, data, response){
        if(err){
            console.log("Something went wrong");
        }
        else {
            console.log("Twetted");
            twitId = data.id_str;
            console.log("twit id = " + twitId);
             var fs = require('fs');
            var json = JSON.stringify(data,null,2);
            fs.writeFile("tweet.json", json);
        }
    }
   
}
function reply (text, replyId) {
    var content = {
        in_reply_to_status_id: replyId,
        status: text
        
    }
    T.post('statuses/update', content, isTweet);
    function isTweet(err, data, response){
        if(err){
            console.log("Something went wrong");
        }
        else {
            console.log("Replied");
             var fs = require('fs');
            var json = JSON.stringify(data,null,2);
            fs.writeFile("tweet.json", json);
        }
    }
   
}


