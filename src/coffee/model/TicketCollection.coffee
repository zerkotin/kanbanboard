{KanbanConfig} = require '../config/KanbanConfig'
exports.TicketCollection = class TicketCollection extends Backbone.Collection

  initialize: (models, options) ->
    @url = options.url

  parse: (data) ->
    KanbanConfig.serverConfig = data.config
    return data.issues
