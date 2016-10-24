{KanbanBoardView} = require './view/KanbanBoardView'
{KanbanConfig} = require './config/KanbanConfig'

exports.Router = class Router extends Backbone.Router

  currentView: null

  routes:
    '': 'developer'
    'team': 'team'
    'po': 'po'
    'developer': 'developer'

  team: ->
    @_browseToPage(KanbanBoardView, {config: KanbanConfig.teamViewConfig})

  po: ->
    @_browseToPage(KanbanBoardView, {config: KanbanConfig.poViewConfig})

  developer: ->
    @_browseToPage(KanbanBoardView, {config: KanbanConfig.developerViewConfig})


  _browseToPage: (viewConstructor, viewOptions) ->
    @currentView?.remove()
    @currentView = new viewConstructor(viewOptions)
    $('body').append @currentView.$el
