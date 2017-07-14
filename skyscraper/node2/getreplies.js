console.log("Reply Deneme");
var Twit = require('twit')

var config = require('./config');
var T = new Twit(config);

reply();

function reply () {
    
T.get('statuses/show/885277501202857984', function (err, reply) {
  if (err) return console.log('error:', err)

  console.log(reply)
    })
    
    
    
    var content = {
        in_reply_to_status_id: 885277501202857984,
        status: '@orhanbot cevaaap'
        
    }
    T.post('statuses/update', content, isTweet);
    function isTweet(err, data, response){
        if(err){
            console.log("Something went wrong");
        }
        else {
            console.log("Replied");
            twitId = data.id;
             var fs = require('fs');
            var json = JSON.stringify(data,null,2);
            fs.writeFile("tweet.json", json);
        }
    }
   
}