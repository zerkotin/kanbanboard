exports.TicketCollection = class TicketCollection extends Backbone.Collection

  initialize: (models, options) ->
    @url = options.url

  parse: (data) ->
    return data.issues
