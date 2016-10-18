{KanbanColumnView} = require './KanbanColumnView'
{TicketCollection} = require '../model/TicketCollection'

exports.KanbanBoardView = class KanbanBoardView extends Backbone.View

  className: 'kanban-board-view'

  columns: [
    {columnClass: 'first-column', columnTitle: 'TODO', status: 'TODO'},
    {columnTitle: 'In Progress...', status: 'IN_PROGRESS'},
    {columnClass: 'last-column', columnTitle: 'Done.', status: 'RESOLVED'}
  ]

  ticketCollection: null

  initialize: ->
    @ticketCollection = new TicketCollection()
    @render()

  render: ->
    @$el.append template()

    $wrapper = @$('.kanban-columns-wrapper')

    for column in @columns
      column.el = $wrapper #providing element for the view
      column.ticketCollection = @ticketCollection

      new KanbanColumnView(column)

    @ticketCollection.fetch()


template = ->
  """
  <div class='kanban-columns-wrapper'></div>
  """

