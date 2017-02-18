
{KanbanConfig} = require '../config/KanbanConfig'

exports.TicketView = class TicketView extends Backbone.View

  className: 'ticket-view draggable'
  ticketConfig: null
  serverConfig: null
  viewState: null
  config: null

  attributes:
    draggable: true

  events:
    'click .ticket-id': '_onTicketClick'
    'click .ticket-title': '_onTitleClick'
    'dragstart': '_handleDragStart'


  initialize: (options) ->
    {@ticketConfig, @viewState, @config} = options

    @render()

  render: ->
    @$el.append(template(@model, @ticketConfig))

  _onTicketClick: ->
    window.open(KanbanConfig.getRedmineIssueUrl(@model.get('id')))

  _onTitleClick: ->
    if @$('.expander').hasClass('expanded')
      @$('.ticket-description').slideUp()
      @$('.expander').removeClass 'expanded'
    else
      @$('.ticket-description').slideDown()
      @$('.expander').addClass 'expanded'

  _handleDragStart: (event) ->
    @viewState.set('dragTicketData', @model.attributes)
    event.originalEvent.dataTransfer.effectAllowed = 'move'


template = (data, config) ->
  """
  <div class="ticket-header">
    <span class="ticket-id">##{data.get('id')}</span>
    <span class="ticket-title"><span class="text">#{data.get('subject')}</span><span class="expander"></span></span>
  </div>
  <div class="ticket-description" style="display: none">#{data.get('description')}</div>
  <div class="ticket-footer">
    <span class="ticket-owner">#{if data.get(config.nameField) then data.get(config.nameField).name else '---'}</span>
    <span class="ticket-status">#{data.get('priority').name}</span>
  </div>

  """
