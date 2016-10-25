{KanbanColumnView} = require './KanbanColumnView'
{KanbanFilterView} = require './KanbanFilterView'
{SideNavigationView} = require './SideNavigationView'
{KanbanConfig} = require '../config/KanbanConfig'
{TicketCollection} = require '../model/TicketCollection'

#TODO add drag and drop and sync the collection
exports.KanbanBoardView = class KanbanBoardView extends Backbone.View

  className: 'kanban-board-view'

  config: null

  ticketCollection: null

  columnViews: []
  sideNavigationView: null
  filterView: null

  initialize: (options) ->
    {@config} = options
    @ticketCollection = new TicketCollection()
    @ticketCollection.url = @config.url #running over the url for different screens

    @render()

  render: ->

    @sideNavigationView = new SideNavigationView(navigationItems: KanbanConfig.navigationItems)
    @filterView = new KanbanFilterView(ticketCollection: @ticketCollection, filters: @config.filters)

    @$el.append @sideNavigationView.el
    @$el.append @filterView.el
    @$el.append wrapperTemplate()

    $wrapper = @$('.kanban-columns-wrapper')

    for columnConfig in @config.columns
      columnConfig.ticketCollection = @ticketCollection
      columnConfig.size = Math.floor(100 / @config.columns.length)

      view = new KanbanColumnView(columnConfig)
      @columnViews.push(view)
      $wrapper.append(view.el)

    return $wrapper #not a must

  remove: ->
    for column in @columnViews
      column.remove();

    @sideNavigationView.remove();
    @filterView.remove();

    super arguments...


wrapperTemplate = ->
  """
  <div class='kanban-columns-wrapper'></div>
  """
