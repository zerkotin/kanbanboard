{KanbanFilterView} = require './KanbanFilterView'
{TicketCollection} = require '../model/TicketCollection'

exports.DetailedView = class DetailedView extends Backbone.View

  className: 'detailed-view'

  filterView: null
  viewState: null

  initialize: (options) ->
    #{} = options
    @collection = new TicketCollection(null, {url: @model.issuesUrl})
    @viewState = new Backbone.Model
    @listenTo @collection, 'sync', @_renderTickets

    @render()

  render: ->
    @filterView = new KanbanFilterView(ticketCollection: @collection, collection: @model.remoteFilters, viewState: @viewState)

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
  <table><thead><th>Ticket</th><th>Team</th><th>Subject</th><th>Status</th><th>Story Points</th><th>Estimated Hours</th></thead><tbody></tbody></table>
  """

ticketTemplate = (data) ->
  """
  <tr class='ticket'><td>#{data.get('id')}</td><td>#{data.get('cf_Team') || ''}</td><td>#{data.get('subject')}</td><td>#{data.get('status').name}</td><td class="ctxt">#{data.get('cf_story points') || ''}</td><td class="ctxt">#{data.get('estimated_hours') || '0'}</td></tr>
  """
