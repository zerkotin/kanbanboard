{KanbanColumnView} = require './KanbanColumnView'
{KanbanFilterView} = require './KanbanFilterView'
{KanbanConfig} = require '../config/KanbanConfig'
{TicketCollection} = require '../model/TicketCollection'
{ColumnFilterView} = require './ColumnFilterView'

#TODO add drag and drop and sync the collection
exports.KanbanBoardView = class KanbanBoardView extends Backbone.View

  className: 'kanban-board-view'

  config: null

  ticketCollection: null

  columnViews: []
  filterView: null
  columnFilterView: null
  viewState: null

  initialize: (options) ->
    {@config} = options
    @viewState = new Backbone.Model
    @viewState.set('columns', @config.columns.map((column) -> return column.name))
    @ticketCollection = new TicketCollection(null, {url: @config.issuesUrl})

    @render()

  render: ->

    @filterView = new KanbanFilterView(ticketCollection: @ticketCollection, filters: @config.filters)
    @columnFilterView = new ColumnFilterView(config: @config, viewState: @viewState)

    @$el.append @filterView.el
    @$el.append @columnFilterView.el
    @$el.append wrapperTemplate()

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
    @columnFilterView.remove()

    super arguments...

wrapperTemplate = ->
  """
  <div class='kanban-columns-wrapper'></div>
  """
