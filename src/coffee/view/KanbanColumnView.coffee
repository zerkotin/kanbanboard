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

    for filter in @config.localFilters || []
      @listenTo @viewState, "change:#{filter.stateAttribute}", @_renderTickets

    @render()

  render: ->
    size = 100 / @viewState.get('columns').length
    @$el.css('width', size + '%')
    @$el.addClass @columnConfig.columnClass if @columnConfig.columnClass

    @$el.append(template(@columnConfig.columnTitle))

    @$('.kanban-column-title').css('background', "linear-gradient(to right, white, #{@columnConfig.color})");

  _renderTickets: ->
    $ticketsEl = @$('.kanban-column-content')
    @_removeTickets()
    $ticketsEl.empty()

    filteredTickets = @_getFilteredTickets()

    for ticket in filteredTickets
      view = new TicketView(
        ticketConfig: @config.ticketConfig
        model: ticket
        serverConfig: @ticketCollection.config
        viewState: @viewState
        config: @config
      )
      @ticketViews.push(view)
      $ticketsEl.append view.el

    @$('.counter').html('('+filteredTickets.length+')')

    return @

  _getFilteredTickets: ->
    filteredTickets = @ticketCollection.models.filter((ticket) =>
      return  ticket.get('status').name in @columnConfig.statuses
    )

    for filter in @config.localFilters || []
      filteredTickets = filteredTickets.filter((ticket) =>
        data = ticket.get(filter.ticketField) || {id: -1, name: 'unassigned'}
        return data.id in @viewState.get(filter.stateAttribute)
      )

    return filteredTickets


  _columnsChanged: ->
    if @columnConfig.name in @viewState.get('columns')
      @$el.show()
    else
      @$el.hide()

    size = 100 / @viewState.get('columns').length
    @$el.css('width', size + '%')

  _removeTickets: ->
    for view in @ticketViews
      view.remove();
    @ticketViews = []

  remove: ->
    @_removeTickets()

    super arguments...

template = (columnTitle) ->
  """
  <div class="kanban-column-title">#{columnTitle}<span class="counter"></span></div><div class="kanban-column-content"></div>
  """
