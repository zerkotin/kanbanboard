{TicketView} = require './TicketView'

exports.KanbanColumnView = class KanbanColumnView extends Backbone.View

  className: 'kanban-column'


  ticketCollection: null
  columnConfig: null
  config: null

  ticketViews: []

  initialize: (options) ->
    {@columnConfig, @ticketCollection, @config} = options
    @listenTo @ticketCollection, 'sync', @_renderTickets

    @render()

  render: ->
    size = 100 / @config.columns.length
    @$el.css('width', size + '%')
    @$el.addClass @columnConfig.columnClass if @columnConfig.columnClass

    @$el.append(template(@columnConfig.columnTitle))

    @$('.kanban-column-title').css('background', "linear-gradient(to right, white, #{@columnConfig.color})");

  _renderTickets: ->
    $ticketsEl = @$('.kanban-column-content')
    $ticketsEl.empty()

    for ticket in @ticketCollection.models
      if ticket.get('status').name in @columnConfig.statuses
        view = new TicketView(ticketConfig: @config.ticketConfig, model: ticket)
        @ticketViews.push(view)
        $ticketsEl.append view.el

    return @

  remove: ->
    for view in @ticketViews
      view.remove();

    super arguments...

template = (columnTitle) ->
  """
  <div class="kanban-column-title">#{columnTitle}</div><div class="kanban-column-content"></div>
  """
