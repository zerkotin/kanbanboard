{KanbanBoardView} = require './view/KanbanBoardView'
{KanbanConfig} = require './config/KanbanConfig'
{SideNavigationView} = require './view/SideNavigationView'

exports.Router = class Router extends Backbone.Router

  currentView: null
  sideNavigationView: null

  routes:
    '': 'developer'
    'team': 'team'
    'po': 'po'
    'developer': 'developer'
    'tickets': 'tickets'

  team: ->
    @_browseToPage(KanbanBoardView, {config: KanbanConfig.teamViewConfig})

  po: ->
    @_browseToPage(KanbanBoardView, {config: KanbanConfig.poViewConfig})

  developer: ->
    @_browseToPage(KanbanBoardView, {config: KanbanConfig.developerViewConfig})

  tickets: ->
    @_browseToPage(KanbanBoardView, {config: KanbanConfig.ticketViewConfig})


  _browseToPage: (viewConstructor, viewOptions) ->
    unless @sideNavigationView
          @sideNavigationView = new SideNavigationView(navigationItems: KanbanConfig.navigationItems, initSelectedPath: viewOptions.config.path)
          $('body').append @sideNavigationView.$el

    @currentView?.remove()
    @currentView = new viewConstructor(viewOptions)
    $('body').append @currentView.$el
