{KanbanColumnView} = require './KanbanColumnView'

exports.KanbanBoardView = class KanbanBoardView extends Backbone.View

  className: 'kanban-board-view'

  columns: [
    {columnClass: 'first-column', columnTitle: 'TODO'},
    {columnTitle: 'In Progress...'},
    {columnClass: 'last-column', columnTitle: 'Done.'}
  ]

  #TODO create a collection that takes all that fetches all the ticktes and renderes TicketViews

  initialize: ->
    @render()

  render: ->
    @$el.append template()

    $wrapper = @$('.kanban-columns-wrapper')

    for column in @columns
      column.el = $wrapper #providing element for the view
      new KanbanColumnView(column)

    return @$el #this is not necessary


template = ->
  """
  <div class='kanban-columns-wrapper'></div>
  """

