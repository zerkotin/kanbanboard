{TicketView} = require './TicketView'

exports.KanbanColumnView = class KanbanColumnView extends Backbone.View

  className: 'kanban-column'

  config: null
  viewState: null
  ticketViews: []

  events:
    'dragover .kanban-column-content': '_handleDrag'
    'drop .kanban-column-content': '_handleDrop'
    #TODO drag enter and drag leave with classes

  initialize: (options) ->
    {@config, @viewState} = options
    @listenTo @collection, 'sync', @_renderTickets
    @listenTo @viewState, 'change:columns', @_columnsChanged

    for filter in @config.localFilters || []
      @listenTo @viewState, "change:#{filter.stateAttribute}", @_renderTickets

    @render()

  render: ->
    size = 100 / @viewState.get('columns').length
    @$el.css('width', size + '%')
    @$el.addClass @model.columnClass if @model.columnClass

    @$el.append(template(@model.name))

    @$('.kanban-column-title').css('background', "linear-gradient(to right, #{@model.colorStart}, #{@model.colorEnd})");

  _renderTickets: ->
    $ticketsEl = @$('.kanban-column-content')
    @_removeTickets()
    $ticketsEl.empty()

    filteredTickets = @_getFilteredTickets()

    for ticket in filteredTickets
      view = new TicketView(
        ticketConfig: @config.ticketConfig
        model: ticket
        serverConfig: @collection.config
        viewState: @viewState
        config: @config
      )
      @ticketViews.push(view)
      $ticketsEl.append view.el

    @$('.counter').html('('+filteredTickets.length+')')

    return @

  _getFilteredTickets: ->
    filteredTickets = @collection.models.filter((ticket) =>
      return  ticket.get('status').name in @model.statuses
    )

    for filter in @config.localFilters || []
      filteredTickets = filteredTickets.filter((ticket) =>
        data = ticket.get(filter.ticketField) || {id: '-1', name: 'unassigned'}
        return data.id+'' in @viewState.get(filter.stateAttribute)
      )

    return filteredTickets

  _handleDrag: (event) ->
    if event.preventDefault
      event.preventDefault()

  _handleDrop: (event) ->
    if event.stopPropagation
      event.stopPropagation()

    ticket = JSON.parse event.originalEvent.dataTransfer.getData('application/json')

    ticketStatus = new Backbone.Model(
      id: ticket.id
      statusId: @model.statusId
      key: @viewState.get 'key'
    )
    ticketStatus.save({},{url: 'setstatus'})
    #TODO 1. update the ticket status and rerender all columns
    #TODO 2. add all drag and drop events to fix safari
    #TODO 3. make nice styling for drag
    #TODO 4. show error message if fail


  _columnsChanged: ->
    if @model.id in @viewState.get('columns')
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
