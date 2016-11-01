
{KanbanConfig} = require '../config/KanbanConfig'

exports.TicketView = class TicketView extends Backbone.View

  className: 'ticket-view'
  ticketConfig: null
  serverConfig: null
  viewState: null

  events:
    'click .ticket-id': '_onTicketClick'
    'click .ticket-title': '_onTitleClick'

  initialize: (options) ->
    {@ticketConfig, @viewState} = options

    @listenTo @viewState, 'change:assignees', @_stateChanged

    @render()

  render: ->
    @$el.append(template(@model, @ticketConfig))

  _onTicketClick: ->
    window.open(KanbanConfig.getRedmineIssueUrl(@model.get('id')))

  _stateChanged: ->
      data = @model.get('assigned_to') || {id: -1, name: 'unassigned'}

      if data.id in @viewState.get('assignees')
        @$el.show();
      else
        @$el.hide()

  _onTitleClick: ->

    if @$('.ticket-header').hasClass('expanded')
      @$('.ticket-description').slideUp()
      @$('.ticket-header').removeClass 'expanded'
    else
      @$('.ticket-description').slideDown()
      @$('.ticket-header').addClass 'expanded'


template = (data, config) ->
  """
  <div class="ticket-header">
    <span class="ticket-id">#{data.get('id')}</span>
    <span class="ticket-title">#{data.get('subject')}</span>
  </div>
  <div class="ticket-description" style="display: none">#{data.get('description')}</div>
  <div class="ticket-footer">
    <span class="ticket-owner">#{if data.get(config.nameField) then data.get(config.nameField).name else '---'}</span>
    <span class="ticket-status">#{data.get('status').name}</span>
  </div>

  """
