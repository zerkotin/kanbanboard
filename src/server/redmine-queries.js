/**
 * Created by itzhak.cohen-arazi on 25.10.2016.
 */
var redmine = require('./redmine-proxy.js');

module.exports = (function () {

    function assigendToMeIssues(req, res) {
        var params = {
            key: req.query.key,
            limit: 100,
            offset: 0,
            author_id: 'me'

        };
        redmine.query(req, res, params);
    }

    function createdByMeIssues(req, res) {
        var params = {
            key: req.query.key,
            limit: 100,
            offset: 0,
            assigned_to_id: 'me'

        };
        redmine.query(req, res, params);
    }

    function teamIssues(req, res) {
        var remoteFilters = {
            key: req.query.key,
            limit: 100,
            offset: 0,
            assigned_to_id: 'me'

        };
        var localFilters = {
            cf_Team: req.query.team,
            cf_Sprint: req.query.sprint
        };
        console.log('received: sprint: '+req.query.sprint+', team: '+req.query.team);
        redmine.query(req, res, remoteFilters, localFilters);
    }

    //this is what we expose to queries
    return queries = {
        teamIssues: teamIssues,
        assigendToMeIssues: assigendToMeIssues,
        createdByMeIssues: createdByMeIssues
    };

})();

