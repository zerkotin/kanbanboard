exports.StatusCollection = class StatusCollection extends Backbone.Collection

  url: 'statuses'

  parse: (data) ->
    return data.issue_statuses
