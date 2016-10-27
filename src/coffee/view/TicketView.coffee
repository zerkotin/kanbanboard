
{KanbanConfig} = require '../config/KanbanConfig'

exports.TicketView = class TicketView extends Backbone.View

  className: 'ticket-view'

  ticketData: null
  ticketConfig: null

  shouldShowDescription: false

  events:
    'click .ticket-id': '_onTicketClick'
    'click .ticket-title': '_onTitleClick'

  initialize: (options) ->
    {@ticketData, @ticketConfig} = options
    @render()

  render: ->
    @$el.append(template(@ticketData, @ticketConfig))

  _onTicketClick: ->
    window.open(KanbanConfig.redmineIssuesUrl + @ticketData.get('id'))

  _onTitleClick: ->
    @shouldShowDescription = not @shouldShowDescription

    if @shouldShowDescription
      @$('.ticket-description').slideDown()
      @$('.ticket-header').addClass 'expanded'
    else
      @$('.ticket-description').slideUp()
      @$('.ticket-header').removeClass 'expanded'


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
