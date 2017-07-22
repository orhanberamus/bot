console.log("The bot is starting");
var Twit = require('twit')

var config = require('./config');
var T = new Twit(config);
tweet();
var stream = T.stream('user');
stream.on('tweet', tweetEvent);

var twitId;
function tweetEvent (eventMsg){
    
    var replyto = eventMsg.in_reply_to_screen_name;
    var userAnswer = eventMsg.text;
    var from = eventMsg.user.screen_name;
    var replyId = eventMsg.id_str;
    console.log(replyto + " " + from);
   
    if(eventMsg.in_reply_to_status_id_str === twitId){
        //var newTweet = '@' + from + ' NOOOOO';
        reply(from, userAnswer, replyId);
        console.log("reply to id = " + replyId);
    }
   /* var fs = require('fs');
    var json = JSON.stringify(eventMsg,null,2);
    fs.writeFile("tweet.json", json);*/
}
function tweet () {
    var txtData = readFile("lyrics.txt");
    txtData.toString();
    console.log(txtData);
   
    
    var content = {
        status: txtData
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
    var txtData = readFile("out.txt");
    var info = getArtistLyrics(txtData);
    var botAnswer = compareAnswer(String(info[0]), String(info[1]), userAnswer);
    var content = {
        in_reply_to_status_id: replyId,
        status: botAnswer
    }
    T.post('statuses/update', content, isTweet);
    function isTweet(err, data, response){
        if(err){
            console.log("Something went wrong");
        }
        else {
            console.log("Replied " + botAnswer);
             var fs = require('fs');
            var json = JSON.stringify(data,null,2);
            fs.writeFile("tweet.json", json);
        }
    }
   
}

function readFile (filename){
    var content  = "";
    var fs = require("fs");
    content = fs.readFileSync(filename,'utf8');
    return content;
}
function writeFile(filename){
    var fs = require('fs');
    fs.appendFile('posted.txt', "\n" + song, function(err) {
        if (err) throw err;
        console.log("Recorded -> " + song);
    });
}
function checkSong(song){
    var array = readFile('posted.txt').split("\n");
    for(i in array){
        if (array[i] === song){
            console.log("Error Already Posted"); 
            return false;
        }
    }
    console.log("Available Song");
    return true;
    //console.log(readFile('posted.txt'));
}
function getArtistLyrics(data){
    res = data.split(/[\r\n]+/);
    artist = res[0];
    song = res[1];
    return [artist, song];
        
}
function getLyrics(data){
    return data.split("");
}
function compareAnswer(artist, song, userAnswer){
    //console.log(answer);
    var botAnswer = "";
    var rArtist = convertToRegex(artist);
    var rSong  = convertToRegex(song);
    console.log("Artist > " + rArtist);
    console.log("Song > " + rSong);
    if(userAnswer.match(rArtist) && userAnswer.match(rSong)){
        console.log("Correct <3 <3");
        botAnswer = "Correct <3 <3";
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
   function convertToRegex(str){
       var array = [];
        for(var i = 0; i < str.length; i++){
        // 0-9 a-z A-Z
        if( (str.charCodeAt(i) >= 48 && str.charCodeAt(i) <= 57)||(str.charCodeAt(i) >= 65 && str.charCodeAt(i) <= 90) || (str.charCodeAt(i) >= 97 && str.charCodeAt(i) <= 122)
         ){
            array.push("[" + str.charAt(i) + "]");
        }
        else if(str.charCodeAt(i) == 32){//space
            array.push("\\s");
        }
        else{
           
            array.push("(\\" + str.charAt(i) + "?|\\w|\\s)");
        }
      }
        var sonuc = array.join("");
        //console.log(sonuc);
        return new RegExp(sonuc, "gi");
      
    }