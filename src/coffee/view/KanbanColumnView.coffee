{TicketView} = require './TicketView'

exports.KanbanColumnView = class KanbanColumnView extends Backbone.View

  className: 'kanban-column'

  columnConfig: null
  ticketCollection: null
  config: null
  viewState: null
  ticketViews: []

  initialize: (options) ->
    {@columnConfig, @ticketCollection, @config, @viewState} = options
    @listenTo @ticketCollection, 'sync', @_renderTickets
    @listenTo @viewState, 'change:columns', @_columnsChanged

    @render()

  render: ->
    size = 100 / @viewState.get('columns').length
    @$el.css('width', size + '%')
    @$el.addClass @columnConfig.columnClass if @columnConfig.columnClass

    @$el.append(template(@columnConfig.columnTitle))

    @$('.kanban-column-title').css('background', "linear-gradient(to right, white, #{@columnConfig.color})");

  _renderTickets: ->
    $ticketsEl = @$('.kanban-column-content')
    $ticketsEl.empty()

    for ticket in @ticketCollection.models
      if ticket.get('status').name in @columnConfig.statuses
        view = new TicketView(ticketConfig: @config.ticketConfig, model: ticket, serverConfig: @ticketCollection.config)
        @ticketViews.push(view)
        $ticketsEl.append view.el

    return @

  _columnsChanged: ->
    if @columnConfig.name in @viewState.get('columns')
      @$el.show()
    else
      @$el.hide()

    size = 100 / @viewState.get('columns').length
    @$el.css('width', size + '%')

  remove: ->
    for view in @ticketViews
      view.remove();

    super arguments...

template = (columnTitle) ->
  """
  <div class="kanban-column-title">#{columnTitle}</div><div class="kanban-column-content"></div>
  """
