
exports.TicketView = class TicketView extends Backbone.View

  className: 'ticket-view'

  ticketData: null

  initialize: (options) ->
    {@ticketData} = options
    @render()

  render: ->
    $component = $ template(@ticketData)
    @$el.append $component

template = (data) ->
  """
  <div class="ticket-view">
    <div class="ticket-id">#{data.get('id')}</div>
    <div class="ticket-owner">#{data.get('owner')}</div>
    <div class="ticket-title">#{data.get('title')}</div>
    <div class="ticket-description">#{data.get('description')}</div>
  </div>
  """

