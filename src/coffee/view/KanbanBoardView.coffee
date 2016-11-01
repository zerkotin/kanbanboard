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
  localFilterViews: []
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

    for filter in @config.localFilters || []
        localFilterView = new TicketFilterView(ticketCollection: @ticketCollection, ticketField: filter.ticketField, viewState: @viewState, stateAttribute: filter.stateAttribute)
        @localFilterViews.push localFilterView
        @$el.append localFilterView.el

    @$el.append @filterView.el
    @$el.append @statusFilterView.el

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

    for localFilter in @localFilterViews
      localFilter.remove()

    super arguments...

wrapperTemplate = (boardName)->
  """
  <div class='kanban-board-title'>##{boardName}</div>
  <div class='kanban-columns-wrapper'></div>
  """
