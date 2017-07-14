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
        //var newTweet = '@' + from + ' NOOOOO';
        reply(from, text, replyId);
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
function reply (from, userAnswer, replyId) {
    var botAnswer = readFile(userAnswer);
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
function readFile (userAnswer){
    var artist;
    var song;
    var botAnswer = "";
    var fs = require('fs')
    var filename = "out.txt"
    fs.readFile(filename, 'utf8', function(err, data) {
      if (err) {
          throw err;
          botAnswer = "There was an error =(";
      }
      //console.log('OK: ' + filename);
      //console.log(data);
      var res = data.split(/[\r\n]+/);
        console.log(res);
        //console.log(res);
        artist = res[0];
        song = res[1];
    
        //console.log("Artist > " + artist);
        //console.log("Song > " + song);
        compareAnswer(String(artist), String(song), userAnswer);
        
    });
    return botAnswer;
    
}
function compareAnswer(artist, song, userAnswer){
    //console.log(answer);
    var botAnswer = "";
    var rArtist = new RegExp(artist, "gi");
    var rSong = new RegExp(song, "gi");
    console.log("Artist > " + rArtist);
    if(userAnswer.match(rArtist) && userAnswer.match(rSong)){
        console.log("Correct!!");
        botAnswer = "Correct!!";
    }
    else if(userAnswer.match(rArtist)){
        console.log("What is the song name?");
        botAnswer = "What is the song name?";
    }
    else if(userAnswer.match(rSong)){
        console.log("Who is the artist?");
        botAnswer = "Who is the artist?";
    }
    else {
        console.log("Try again :):):)");
        botAnswer = "Try again :):):)";
    }
    return botAnswer;
}


