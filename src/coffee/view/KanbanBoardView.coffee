{KanbanColumnView} = require './KanbanColumnView'
{KanbanFilterView} = require './KanbanFilterView'
{KanbanConfig} = require '../config/KanbanConfig'
{TicketCollection} = require '../model/TicketCollection'
{TicketFilterView} = require './TicketFilterView'

#TODO add drag and drop and sync the collection
exports.KanbanBoardView = class KanbanBoardView extends Backbone.View

  className: 'kanban-board-view'

  columnViews: []
  filterView: null
  statusFilterView: null
  localFilterViews: []
  viewState: null

  initialize: (options) ->
    #{} = options
    @viewState = new Backbone.Model
    @viewState.set('columns', @model.columns.map((column) -> return column.name))
    @collection = new TicketCollection(null, {url: @model.issuesUrl})

    @render()

  render: ->
    @filterView = new KanbanFilterView(ticketCollection: @collection, collection: @model.remoteFilters)

    #filter with static collection
    #TODO later add it to the localFilters config
    @statusFilterView = new TicketFilterView(
      collection: @model.columns
      ticketField: 'status'
      viewState: @viewState
      stateAttribute: 'columns'
      position: 'center'
      title: 'Status'
    )

    #adding localFilters
    for filter in @model.localFilters || []
        localFilterView = new TicketFilterView(
          collection: @collection
          ticketField: filter.ticketField
          viewState: @viewState
          stateAttribute: filter.stateAttribute
          position: filter.position
          title: filter.title
        )
        @localFilterViews.push localFilterView
        @$el.append localFilterView.el

    @$el.append @filterView.el
    @$el.append @statusFilterView.el

    @$el.append wrapperTemplate(@model.title)

    $wrapper = @$('.kanban-columns-wrapper')

    #adding columns
    for columnConfig in @model.columns
      kanbanColumnConfig = {
        model: columnConfig
        viewState: @viewState
        collection: @collection
        config: @model
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
