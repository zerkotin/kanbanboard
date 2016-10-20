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

  //Query functions
  function teamIssues (req, res) {
      if (isApiKeyMissing(req, res)) {
          return;
      }
      request({
              url: config.redmineRoot + 'issues.json?key=' + req.query.key,
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
    teamIssues: teamIssues
  }

  //thats redmineProxy object
  return {
    config: config,
    queries: queries,
    api: api
  };
})();
