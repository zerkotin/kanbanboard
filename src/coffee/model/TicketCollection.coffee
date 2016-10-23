exports.TicketCollection = class TicketCollection extends Backbone.Collection

  parse: (data) ->
    return data.issues
