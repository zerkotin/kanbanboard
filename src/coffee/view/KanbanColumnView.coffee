{TicketView} = require './TicketView'

exports.KanbanColumnView = class KanbanColumnView extends Backbone.View

  className: 'kanban-column'

  config: null
  viewState: null
  ticketViews: []

  events:
    'dragover .kanban-column-content': '_handleDrag'
    'dragend .kanban-column-content': '_handleDragEnd'
    'drop .kanban-column-content': '_handleDrop'
    'dragenter .kanban-column-content': '_handleDragEnter'
    'dragleave .kanban-column-content': '_handleDragLeave'

    #TODO drag enter and drag leave with classes

  initialize: (options) ->
    {@config, @viewState} = options
    @listenTo @collection, 'sync change', @_renderTickets
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
      @_createTicketView(ticket, $ticketsEl)

    @$('.counter').html('('+filteredTickets.length+')')

    return @

  _createTicketView: (ticketModel, $ticketsContainer)->
    view = new TicketView(
      ticketConfig: @config.ticketConfig
      model: ticketModel
      serverConfig: @collection.config
      viewState: @viewState
      config: @config
    )
    @ticketViews.push(view)
    $ticketsContainer.append view.el

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
    event.preventDefault()
    event.originalEvent.dataTransfer.dropEffect = 'move'
    return false

  _handleDragEnd: (event) ->
    event.stopPropagation()

  _handleDragEnter: ->
    $('.kanban-column-content').removeClass('dragover')
    @$('.kanban-column-content').addClass('dragover')

    event.stopPropagation();
    event.preventDefault();
    return false

  _handleDragLeave: ->
    event.stopPropagation();
    event.preventDefault();
    return false

  _handleDrop: (event) ->
    event.stopPropagation()

    $ticketsEl = @$('.kanban-column-content')
    $ticketsEl.removeClass('dragover')

    ticket = @viewState.get('dragTicketData')

    ticketStatus = new Backbone.Model(
      id: ticket.id
      statusId: @model.statusId
      key: @viewState.get 'key'
    )
    #TODO handle success and error
    ticketStatus.save({},{
      url: 'setstatus'
      success: ->
        #TODO stop a spinner
        return null
      error: ->
        #TODO show error message
        return null
    })

    originalTicket = @collection.findWhere({'id': ticket.id})
    originalTicket.set('status', {id: @model.statusId, name: @model.statusName})


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
