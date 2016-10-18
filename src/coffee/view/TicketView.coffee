
exports.TicketView = class TicketView extends Backbone.View

  className: 'ticket-view'

  ticketData: null

  shouldShowDescription: false #by default false, this is why style is set to display: none

  events:
    'click .ticket-id': '_onTicketClick'
    'click .ticket-title': '_onTitleClick'

  initialize: (options) ->
    {@ticketData} = options
    @render()

  render: ->
    $component = $ template(@ticketData)
    @$el.append $component

  _onTicketClick: ->
    window.open('https://project.osthus.com/issues/' + @ticketData.get('id'))

  _onTitleClick: ->
    @shouldShowDescription = not @shouldShowDescription

    if @shouldShowDescription
      @$('.ticket-description').show()
    else
      @$('.ticket-description').hide()




template = (data) ->
  """
  <div class="ticket-header">
    <span class="ticket-id">#{data.get('id')}</span>
    <span class="ticket-owner">#{data.get('author').name}</span>
  </div>
  <div class="ticket-title">#{data.get('subject')}</div>
  <div class="ticket-description" style="display: none">#{data.get('description')}</div>
  <div class="ticket-status">#{data.get('status').name}</div>
  """

