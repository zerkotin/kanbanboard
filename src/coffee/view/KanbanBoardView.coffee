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
    @$el.append template()

    $wrapper = @$('.kanban-columns-wrapper')
    $header = @$('.kanban-filter-view')

    new KanbanFilterView(el: $header, ticketCollection: @ticketCollection)

    for column in @columns
      column.el = $wrapper #providing element for the view
      column.ticketCollection = @ticketCollection

      new KanbanColumnView(column)

    return $wrapper #not a must


template = ->
  """
  <div class="kanban-filter-view"></div>
  <div class='kanban-columns-wrapper'></div>
  """
