//thats our server, it includes a simple file handler and proxy to our redmine queries
var express = require('express');
var redmine = require('./redmine-proxy.js');

var app = express();

mapRedmineQueries(); //maps redmine queries to http requests

configSimpleWebServer(); //should be called last


function mapRedmineQueries() {
  app.get('/issues', redmine.queries.teamIssues);
}

function configSimpleWebServer() {

  //handles get to localhost
  app.get('/', function(req, res) {
     res.sendFile(__dirname + '/index.html')
  });

  //handles requests for files
  app.get(/^(.+)$/, function(req, res){
      res.sendFile(__dirname + req.params[0]);
  });

  //runs the web server
  app.listen(9090, function() {
    console.log('Server running on port 9090');
  });
}
