//credits: code@uvwxy.de

module.exports = (function () {
  var priv = {
    isApiKeyMissing: function (req, res) {
      //console.log(req.query);
      if (!req.query || !req.query.key) {
        res.json({error: 'ApiKey missing. Please provide "key" paramter.'});
        return true;
      }
    },
    issueHasTeam: function (customs, team) {
      var result = false;
      customs.forEach(function (c, i, a) {
        if (c.name == 'Team' && c.value == team) {
          result = true;
        }
      });

      return result;
    }
    ,
    filterIssuesByTeam: function (data, team) {
      var result = {issues: []};
      result.issues = data.issues.filter(function (c, i, a) {
        //console.log('found issue', c);
        return c.custom_fields && priv.issueHasTeam(c.custom_fields, team);
      });

      return result;
    },
    makeCustomFields: function (data) {
      data.issues.forEach(function (c, i, a) {
        //console.log("TODO: continue here", c);
        if (c.custom_fields) {
          c.custom_fields.forEach(function (c, i, a) {
            c["custom_" + c.id] = c.value;
          });
        }
      });

    }
  };
  return priv;
})();
