
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
    <div class="ticket-header">
      <span class="ticket-id">#{data.get('id')}</span>
      <span class="ticket-owner">#{data.get('author').name}</span>
    </div>
    <div class="ticket-title">#{data.get('subject')}</div>
    <div class="ticket-description">#{data.get('description')}</div>
  </div>
  """

