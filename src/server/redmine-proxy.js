//credits: code@uvwxy.de
var request = require('request');

module.exports = (function (){

    //TODO handle paging

    //Config constants
    var config = {redmineRoot: 'http://project.osthus.com/'};

    //API functions
    function removeEmptyFilters(filters){
        for(var prop in filters) {
            if(!filters[prop] || filters[prop].trim() =='') {
                delete filters[prop];
            }
        }
    }

    function filterIssues(issues, filters) {
        var filteredIssues = issues.filter(function(issue){
            for(var prop in filters) {
                if(issue[prop] != filters[prop])
                    return false;
            }
            return true;
        });
        return filteredIssues;
    }

    function mapCustomFields(issues) {
        issues.forEach(function (issue) {
            if (issue.custom_fields) {
                issue.custom_fields.forEach(function (field) {
                    issue['cf_' + field.name] = field.value;
                });
            }
        });
    }

    function buildUrl(parameters) {
        var url = config.redmineRoot + 'issues.json?';
        for(var prop in parameters) {
            url += prop+'='+parameters[prop]+'&';
        }
        return url.substring(0, url.length - 1); //removing the last character
    }

    function redmineQuery(req, res, remoteFilters, localFilters) {
      var url = null;
      if(req.query && req.query.key) {
          url = buildUrl(remoteFilters);
          request({url: url, json: true}, function(error, response, data){
              if (!error && response.statusCode === 200) {
                  removeEmptyFilters(localFilters);
                  if(localFilters) {
                      mapCustomFields(data.issues);
                      data.issues = filterIssues(data.issues, localFilters);
                      res.json(data);
                  }
                  else {
                      res.json(data);
                  }
              }
              else {
                  res.json({error: data || error});
              }
          });
      }
      else {
          res.json({error: 'API key is missing'});
      }
    }

    return {
        config: config,
        query: redmineQuery
    };

})();
