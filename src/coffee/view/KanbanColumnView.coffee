{TicketView} = require './TicketView'

exports.KanbanColumnView = class KanbanColumnView extends Backbone.View

  className: 'kanban-column'

  $component: null

  columnClass: null
  columnTitle: null
  ticketCollection: null
  statuses: null

  initialize: (options) ->
    {@columnClass, @columnTitle, @statuses, @ticketCollection} = options
    @listenTo @ticketCollection, 'sync', @renderTickets

    @render()

  render: ->
    @$component = $ template(@columnClass)
    @$el.append @$component

    @$component.find('.kanban-column-title').html(@columnTitle)

    if @columnClass
      @$component.addClass @columnClass

  renderTickets: ->
    $ticketsEl = @$component.find('.kanban-column-content')

    for ticket in @ticketCollection.models
      if ticket.get('status').name in @statuses
        new TicketView(el: $ticketsEl, ticketData: ticket)

    $ticketsEl #returning this, otherwise it creates array of results because of the for loop


template = (columnClass) ->
  """
  <div class="kanban-column"><div class="kanban-column-title"></div><div class="kanban-column-content"></div></div>
  """

