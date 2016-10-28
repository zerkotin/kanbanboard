{KanbanColumnView} = require './KanbanColumnView'
{KanbanFilterView} = require './KanbanFilterView'
{KanbanConfig} = require '../config/KanbanConfig'
{TicketCollection} = require '../model/TicketCollection'

#TODO add drag and drop and sync the collection
exports.KanbanBoardView = class KanbanBoardView extends Backbone.View

  className: 'kanban-board-view'

  config: null

  ticketCollection: null

  columnViews: []
  filterView: null

  initialize: (options) ->
    {@config} = options
    @ticketCollection = new TicketCollection(null, {url: @config.issuesUrl})
    #@ticketCollection.url = @config.issuesUrl #running over the url for different screens

    @render()

  render: ->

    @filterView = new KanbanFilterView(ticketCollection: @ticketCollection, filters: @config.filters)

    @$el.append @filterView.el
    @$el.append wrapperTemplate()

    $wrapper = @$('.kanban-columns-wrapper')

    for columnConfig in @config.columns
      kanbanColumnConfig = {
        columnConfig: columnConfig
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

    super arguments...


wrapperTemplate = ->
  """
  <div class='kanban-columns-wrapper'></div>
  """
