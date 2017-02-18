//thats our server, it includes a simple file handler and proxy to our redmine queries
var express = require('express');
var bodyParser = require('body-parser');
var app = express();
app.use(bodyParser.json());

var PropertiesReader = require('properties-reader');
var properties = PropertiesReader('./kanbanboard.properties');

var queries = require('./redmine-queries.js');

mapRedmineQueries(); //maps redmine queries to http requests

configSimpleWebServer(); //should be called last

function mapRedmineQueries() {
  app.get('/teamissues', queries.teamIssues);
  app.get('/developerissues', queries.developerIssues);
  app.get('/poissues', queries.poIssues);
  app.get('/specificissues', queries.specificIssues);
  app.get('/unassignedissues', queries.unassignedIssues);
  app.get('/statuses', queries.statuses);
  app.put('/setstatus', queries.setstatus);
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
  var port = properties.get('kanbanboard.http.port');
  app.listen(port, function() {
    console.log('Server running on port '+port);
  });
}
