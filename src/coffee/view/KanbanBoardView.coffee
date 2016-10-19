{KanbanColumnView} = require './KanbanColumnView'
{KanbanFilterView} = require './KanbanFilterView'
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

    filterView = new KanbanFilterView(ticketCollection: @ticketCollection)

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
