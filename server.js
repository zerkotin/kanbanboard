//if you want a server, run 'npm install express' first
//i didnt want to include it in the package.json since it has nothing to do with it
var express = require('express');
var app = express();

app.get('/', function(req, res) {
   res.sendFile(__dirname + '/index.html')
});


app.get(/^(.+)$/, function(req, res){
    res.sendFile(__dirname + req.params[0]);
});

app.listen(9090, function() {
  console.log('Server running on port 9090');
});
