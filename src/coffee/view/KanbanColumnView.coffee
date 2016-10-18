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
    @listenTo @ticketCollection, 'sync', @_renderTickets

    @render()

  render: ->
    @$component = $ template(@columnClass, @columnTitle)
    @$el.append @$component

    if @columnClass
      @$component.addClass @columnClass

  _renderTickets: ->
    $ticketsEl = @$component.find('.kanban-column-content')
    $ticketsEl.empty()

    for ticket in @ticketCollection.models
      if ticket.get('status').name in @statuses
        $ticketEl = $('<div class="ticket-view"></div>')
        $ticketsEl.append $ticketEl
        new TicketView(el: $ticketEl, ticketData: ticket)

    $ticketsEl #returning this, otherwise it creates array of results because of the for loop

template = (columnClass, columnTitle) ->
  """
  <div class="kanban-column"><div class="kanban-column-title">#{columnTitle}</div><div class="kanban-column-content"></div></div>
  """
