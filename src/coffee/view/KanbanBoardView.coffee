{KanbanColumnView} = require './KanbanColumnView'
{KanbanFilterView} = require './KanbanFilterView'
{SideNavigationView} = require './SideNavigationView'
{KanbanConfig} = require '../config/KanbanConfig'
{TicketCollection} = require '../model/TicketCollection'

exports.KanbanBoardView = class KanbanBoardView extends Backbone.View

  className: 'kanban-board-view'

  columns: null

  ticketCollection: null

  initialize: (options) ->
    {@columns} = options
    @ticketCollection = new TicketCollection()

    @render()

  render: ->

    sideNavigationView = new SideNavigationView(navigationItems: KanbanConfig.navigationItems)
    filterView = new KanbanFilterView(ticketCollection: @ticketCollection)

    @$el.append sideNavigationView.el
    @$el.append filterView.el
    @$el.append wrapperTemplate()

    $wrapper = @$('.kanban-columns-wrapper')

    for columnConfig in @columns
      columnConfig.ticketCollection = @ticketCollection
      columnConfig.size = Math.floor(100 / @columns.length)

      view = new KanbanColumnView(columnConfig)
      $wrapper.append(view.el)

    return $wrapper #not a must


wrapperTemplate = ->
  """
  <div class='kanban-columns-wrapper'></div>
  """
