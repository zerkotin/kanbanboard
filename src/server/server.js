//thats our server, it includes a simple file handler and proxy to our redmine queries
var express = require('express');
var queries = require('./redmine-queries.js');

var app = express();

mapRedmineQueries(); //maps redmine queries to http requests

configSimpleWebServer(); //should be called last


function mapRedmineQueries() {
  app.get('/teamissues', queries.teamIssues);
  app.get('/developerissues', queries.developerIssues);
  app.get('/poissues', queries.poIssues);
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
