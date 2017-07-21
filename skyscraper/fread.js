
function readFile (filename){
   var content  = "";
     var fs = require("fs");
    content = fs.readFileSync(filename,'utf8');
    return content;
}

console.log(readFile("lyrics.txt"));