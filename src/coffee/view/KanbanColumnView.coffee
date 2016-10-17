
exports.KanbanColumnView = class KanbanColumnView extends Backbone.View

  className: 'kanban-column'

  columnClass: null
  columnTitle: null

  initialize: (options) ->
    {@columnClass, @columnTitle} = options
    @render()

  render: ->
    $component = $ template(@columnClass)
    @$el.append $component

    $component.find('.kanban-column-title').html(@columnTitle)

    if @columnClass
      $component.addClass @columnClass

template = (columnClass) ->
  """
  <div class="kanban-column"><div class="kanban-column-title"></div><div class="kanban-column-content"></div></div>
  """

