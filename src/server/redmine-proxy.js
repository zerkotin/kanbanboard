//credits: code@uvwxy.de
var request = require('request');

module.exports = (function (){

  //Config constants
  var config = {redmineRoot: 'http://project.osthus.com/'};

  //API functions
  function isApiKeyMissing(req, res) {
    if (!req.query || !req.query.key) {
      res.json({error: 'ApiKey missing. Please provide "key" paramter.'});
      return true;
    }
  }

  function issueHasTeam(customs, team) {
    var result = false;
    customs.forEach(function (c, i, a) {
      if (c.name == 'Team' && c.value == team) {
        result = true;
      }
    });

    return result;
  }

  function filterIssuesByTeam(data, team) {
    var result = {issues: []};
    result.issues = data.issues.filter(function (c, i, a) {
      return c.custom_fields && issueHasTeam(c.custom_fields, team);
    });

    return result;
  }

  function makeCustomFields(data) {
    data.issues.forEach(function (c, i, a) {
      //TODO continue here
      if (c.custom_fields) {
        c.custom_fields.forEach(function (c, i, a) {
          c["custom_" + c.id] = c.value;
        });
      }
    });
  }

  #TODO add more filter options on the queries
  //Query functions
  function assigendToMeIssues(req, res) {
    if (isApiKeyMissing(req, res)) {
        return;
    }
    request({
            url: config.redmineRoot + 'issues.json?key=' + req.query.key+'&limit=100&offset=0&assigned_to_id=me',
            json: true
        },
        function (error, response, body) {
            if (!error && response.statusCode === 200) {
                //makeCustomFields(body);
                res.json(body);
            }
            else {
                res.json({error: body});
            }
        }
    );
  }

  function createdByMeIssues(req, res) {
    if (isApiKeyMissing(req, res)) {
        return;
    }
    request({
            url: config.redmineRoot + 'issues.json?key=' + req.query.key+'&limit=100&offset=0&author_id=me',
            json: true
        },
        function (error, response, body) {
            if (!error && response.statusCode === 200) {
                //makeCustomFields(body);
                res.json(body);
            }
            else {
                res.json({error: body});
            }
        }
    );
  }

  function teamIssues (req, res) {
      if (isApiKeyMissing(req, res)) {
          return;
      }
      request({
              url: config.redmineRoot + 'issues.json?key=' + req.query.key+'&limit=100&offset=0',
              json: true
          },
          function (error, response, body) {
              if (!error && response.statusCode === 200) {
                  makeCustomFields(body);
                  res.json(filterIssuesByTeam(body, req.query.team));
              }
              else {
                  res.json({error: body});
              }
          }
      );
  }

  //this is what we expose to the API
  var api = {
    isApiKeyMissing: isApiKeyMissing,
    issueHasTeam: issueHasTeam,
    filterIssuesByTeam: filterIssuesByTeam,
    makeCustomFields: makeCustomFields
  }

  //this is what we expose to queries
  var queries = {
    teamIssues: teamIssues,
    assigendToMeIssues: assigendToMeIssues,
    createdByMeIssues: createdByMeIssues
  }

  //thats redmineProxy object
  return {
    config: config,
    queries: queries,
    api: api
  };
})();
