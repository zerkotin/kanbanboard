
exports.TicketView = class TicketView extends Backbone.View

  className: 'ticket-view'

  ticketData: null

  initialize: (options) ->
    {@ticketData} = options
    @render()

  render: ->
    $component = $ template(@ticketData)
    @$el.append $component

template = (ticketData) ->
  """
  <div>#{ticketData}</div>
  """

