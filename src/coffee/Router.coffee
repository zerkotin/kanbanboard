{KanbanBoardView} = require './view/KanbanBoardView'
{KanbanConfig} = require './config/KanbanConfig'
{SideNavigationView} = require './view/SideNavigationView'
{DetailedView} = require './view/DetailedView'

exports.Router = class Router extends Backbone.Router

  currentView: null
  sideNavigationView: null

  routes:
    '': 'developer'
    'team': 'team'
    'po': 'po'
    'developer': 'developer'
    'tickets': 'tickets'
    'unassigned': 'unassigned'
    'detailed': 'detailed'

  team: ->
    @_browseToPage(KanbanBoardView, {model: KanbanConfig.teamViewConfig})

  po: ->
    @_browseToPage(KanbanBoardView, {model: KanbanConfig.poViewConfig})

  developer: ->
    @_browseToPage(KanbanBoardView, {model: KanbanConfig.developerViewConfig})

  tickets: ->
    @_browseToPage(KanbanBoardView, {model: KanbanConfig.ticketViewConfig})

  unassigned: ->
    @_browseToPage(KanbanBoardView, {model: KanbanConfig.unassignedViewConfig})

  detailed: ->
    @_browseToPage(DetailedView, {model: KanbanConfig.detailedViewConfig})


  _browseToPage: (viewConstructor, viewOptions) ->
    #adding navigation bar only on first load
    #TODO move it to initialize
    unless @sideNavigationView
          @sideNavigationView = new SideNavigationView(collection: KanbanConfig.navigationItems, initSelectedPath: viewOptions.model.path)
          $('body').append @sideNavigationView.$el

    #remove previous view and add the new one
    @currentView?.remove()
    @currentView = new viewConstructor(viewOptions)
    $('body').append @currentView.$el
