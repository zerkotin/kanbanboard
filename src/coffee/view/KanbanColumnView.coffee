{TicketView} = require './TicketView'

exports.KanbanColumnView = class KanbanColumnView extends Backbone.View

  className: 'kanban-column'


  ticketCollection: null
  columnConfig: null
  config: null

  ticketViews: []

  initialize: (options) ->
    {@columnConfig, @ticketCollection, @config} = options
    #{@columnClass, @columnTitle, @statuses, @ticketCollection, @size, @color, @config} = options
    @listenTo @ticketCollection, 'sync', @_renderTickets

    @render()

  render: ->
    @$el.css('width', @columnConfig.size + '%') if @columnConfig.size
    @$el.addClass @columnConfig.columnClass if @columnConfig.columnClass
    @$el.css('box-shadow', "0px 20px 5px #{@columnConfig.color} inset") if @columnConfig.color

    @$el.append(template(@columnConfig.columnTitle))

  _renderTickets: ->
    $ticketsEl = @$('.kanban-column-content')
    $ticketsEl.empty()

    for ticket in @ticketCollection.models
      if ticket.get('status').name in @columnConfig.statuses
        view = new TicketView(ticketConfig: @config.ticketConfig, ticketData: ticket)
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
