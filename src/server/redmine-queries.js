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
            //status_id: '1,7,8,9,2,3',
            set_filter: 1,
            sort:'priority:desc,updated_on:desc'
        };
        redmine.query(req, res, params);
    }

    function specificIssues(req, res) {
        var params = {
            key: req.query.key,
            limit: 100,
            offset: 0,
            set_filter: 1,
            sort:'priority:desc,updated_on:desc'
        };
        redmine.query(req, res, params);
    }

    function poIssues(req, res) {
        var params = {
            key: req.query.key,
            limit: 100,
            offset: 0,
            author_id: 'me'
        };
        redmine.query(req, res, params);
    }

    function teamIssues(req, res) {
        var remoteFilters = {
            key: req.query.key,
            limit: 100,
            offset: 0
        };
        var localFilters = {
            cf_Team: req.query.team,
            cf_Sprint: req.query.sprint
        };
        redmine.query(req, res, remoteFilters, localFilters);
    }

    //this is what we expose to queries
    return queries = {
        teamIssues: teamIssues,
        developerIssues: developerIssues,
        poIssues: poIssues,
        specificIssues: specificIssues
    };

})();

