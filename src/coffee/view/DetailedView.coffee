{KanbanFilterView} = require './KanbanFilterView'
{TicketCollection} = require '../model/TicketCollection'

exports.DetailedView = class DetailedView extends Backbone.View

  className: 'detailed-view'

  filterView: null

  initialize: (options) ->
    #{} = options
    @collection = new TicketCollection(null, {url: @model.issuesUrl})

    @listenTo @collection, 'sync', @_renderTickets

    @render()

  render: ->
    @filterView = new KanbanFilterView(ticketCollection: @collection, collection: @model.remoteFilters)

    @$el.append @filterView.el
    @$el.append wrapperTemplate(@model.title)

  _renderTickets: ->
    $wrapper = @$('.kanban-detailed-wrapper')
    $wrapper.empty()

    return unless @collection.models?.length

    $wrapper.append(tableTemplate())

    $tableBody = @$('tbody')

    for data in @collection.models
      $tableBody.append(ticketTemplate(data))

  remove: ->
    @filterView.remove()

    super arguments...



wrapperTemplate = (boardName)->
  """
  <div class='kanban-board-title'>##{boardName}</div>
  <div class='kanban-detailed-wrapper'></div>
  """

tableTemplate = ->
  """
  <table><thead><th>Ticket</th><th>Team</th><th>Estimated Hours</th></thead><tbody></tbody></table>
  """

ticketTemplate = (data) ->
  """
  <tr class='ticket'><td class='ticket-num'>#{data.get('id')}</td><td class='team'>#{data.get('cf_Team') || ''}</td><td class='ticket-time'>#{data.get('estimated_hours') || '0'}</td></tr>
  """
