{KanbanColumnView} = require './KanbanColumnView'
{KanbanFilterView} = require './KanbanFilterView'
{KanbanConfig} = require '../config/KanbanConfig'
{TicketCollection} = require '../model/TicketCollection'
{ColumnFilterView} = require './ColumnFilterView'
{TicketFilterView} = require './TicketFilterView'

#TODO add drag and drop and sync the collection
exports.KanbanBoardView = class KanbanBoardView extends Backbone.View

  className: 'kanban-board-view'

  config: null

  ticketCollection: null

  columnViews: []
  filterView: null
  statusFilterView: null
  assigneeFilterView: null
  viewState: null

  initialize: (options) ->
    {@config} = options
    @viewState = new Backbone.Model
    @viewState.set('columns', @config.columns.map((column) -> return column.name))
    @ticketCollection = new TicketCollection(null, {url: @config.issuesUrl})

    @render()

  render: ->

    @filterView = new KanbanFilterView(ticketCollection: @ticketCollection, filters: @config.remoteFilters)
    @statusFilterView = new ColumnFilterView(collection: @config.columns, viewState: @viewState, stateAttribute: 'columns')

    @assigneeFilterView = new TicketFilterView(ticketCollection: @ticketCollection, ticketField: 'assigned_to', viewState: @viewState, stateAttribute: 'assignees')

    @$el.append @filterView.el
    @$el.append @statusFilterView.el
    @$el.append @assigneeFilterView.el

    @$el.append wrapperTemplate(@config.title)

    $wrapper = @$('.kanban-columns-wrapper')

    for columnConfig in @config.columns
      kanbanColumnConfig = {
        columnConfig: columnConfig
        viewState: @viewState
        ticketCollection: @ticketCollection
        config: @config
      }

      view = new KanbanColumnView(kanbanColumnConfig)
      @columnViews.push(view)
      $wrapper.append(view.el)

    return $wrapper #not a must

  remove: ->
    for column in @columnViews
      column.remove();

    @filterView.remove();
    @statusFilterView.remove()
    @assigneeFilterView.remove()

    super arguments...

wrapperTemplate = (boardName)->
  """
  <div class='kanban-board-title'>##{boardName}</div>
  <div class='kanban-columns-wrapper'></div>
  """
