//if you want a server, run 'npm install express' first
//i didnt want to include it in the package.json since it has nothing to do with it
var express = require('express');
var request = require("request");
var rmapi = require('./redmine_api.js')
var app = express();


//redmine API proxy
var rmconfig = {redmineRoot: 'http://project.osthus.com/'};
app.get('/issues', function (req, res) {
    if (rmapi.isApiKeyMissing(req, res)) {
        return;
    }
    request({
            url: rmconfig.redmineRoot + 'issues.json?key=' + req.query.key,
            json: true
        },
        function (error, response, body) {
            if (!error && response.statusCode === 200) {
                rmapi.makeCustomFields(body);
                res.json(rmapi.filterIssuesByTeam(body, req.query.team));
            }
            else {
                res.json({error: body});
            }
        }
    );
});

app.get('/', function(req, res) {
   res.sendFile(__dirname + '/index.html')
});

app.get(/^(.+)$/, function(req, res){
    res.sendFile(__dirname + req.params[0]);
});

app.listen(9090, function() {
  console.log('Server running on port 9090');
});
