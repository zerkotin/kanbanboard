exports.TicketCollection = class TicketCollection extends Backbone.Collection

  url: '/issues'

  parse: (data) ->
    return data.issues