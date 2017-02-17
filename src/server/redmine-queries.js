/**
 * Created by itzhak.cohen-arazi on 25.10.2016.
 */
var redmine = require('./redmine-proxy.js');

module.exports = (function () {

    function developerIssues(req, res) {
        var params = {
            key: req.query.key,
            limit: 100,
            offset: 0,
            assigned_to_id: 'me',
            sort:'priority:desc,updated_on:desc'
        };
        redmine.query(req, res, params, true);
    }

    function specificIssues(req, res) {
        var params = {
            key: req.query.key
        };
        var tickets = req.query.tickets.split(',');
        redmine.multipleQueries(req, res, params, null, tickets, true);
    }

    function poIssues(req, res) {
        var params = {
            key: req.query.key,
            limit: 100,
            offset: 0,
            author_id: 'me',
            sort:'priority:desc,updated_on:desc'
        };
        redmine.query(req, res, params, true);
    }

    function teamIssues(req, res) {
        var remoteFilters = {
            key: req.query.key,
            limit: 100,
            offset: 0,
            sort:'priority:desc,updated_on:desc'
        };
        var localFilters = {
            cf_Team: req.query.team,
            cf_Sprint: req.query.sprint
        };
        redmine.query(req, res, remoteFilters, localFilters, true);
    }

    function unassignedIssues(req, res) {
      var remoteFilters = {
          key: req.query.key,
          limit: 100,
          offset: 0,
          sort:'priority:desc,updated_on:desc'
      };
      var localFilters = {
          cf_Team: '',
          cf_Sprint: '',
          assigned_to: null
      };
      redmine.query(req, res, remoteFilters, localFilters, false);
    }

    function setstatus(req, res) {
      var remoteFilters = {
          key: req.body.key,
      }
      redmine.setstatus(req, res, remoteFilters);
    }


    //this is what we expose to queries
    return queries = {
        teamIssues: teamIssues,
        developerIssues: developerIssues,
        poIssues: poIssues,
        specificIssues: specificIssues,
        unassignedIssues: unassignedIssues,
        setstatus: setstatus
    };

})();
