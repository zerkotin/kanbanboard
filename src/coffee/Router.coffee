{KanbanBoardView} = require './view/KanbanBoardView'
{KanbanConfig} = require './config/KanbanConfig'

exports.Router = class Router extends Backbone.Router

  currentView: null

  routes:
    '': 'team'
    'team': 'team'
    'po': 'po'
    'developer': 'developer'

  team: ->
    @_browseToPage(KanbanBoardView, {columns: KanbanConfig.teamViewConfig})

  po: ->
    @_browseToPage(KanbanBoardView, {columns: KanbanConfig.poViewConfig})

  developer: ->
    @_browseToPage(KanbanBoardView, {columns: KanbanConfig.developerViewConfig})


  _browseToPage: (viewConstructor, viewOptions) ->
    @currentView?.remove()
    @currentView = new viewConstructor(viewOptions)
    $('body').append @currentView.$el
