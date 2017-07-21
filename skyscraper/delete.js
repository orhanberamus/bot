console.log("Deleting Tweets");
var Twit = require('twit');
var config = require('./config');
var T = new Twit(config);
//stream.on('tweet', tweetEvent);
T.get("statuses/user_timeline", {user_id: '3120225974'}, function(err, data, response) {
     for(var k = 0; k < Object.keys(data).length; k++){
            T.post('statuses/destroy/:id', { id: data[k].id_str }, function (err, data, response) {
            console.log("Deleted " + data.text);
            });
     }
});


 

