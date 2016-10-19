{KanbanBoardView} = require './view/KanbanBoardView'
{KanbanConfig} = require './config/KanbanConfig'

exports.Router = class Router extends Backbone.Router

  currentView: null

  routes:
    '': 'default'
    'normal': 'normal'

  default: ->
    @_browseToPage(KanbanBoardView, {columns: KanbanConfig.teamViewConfig})

  normal: ->
    @_browseToPage(KanbanBoardView, {columns: KanbanConfig.normalViewConfig})


  _browseToPage: (viewConstructor, viewOptions) ->
    @currentView?.remove()
    @currentView = new viewConstructor(viewOptions)
    $('body').append @currentView.$el
