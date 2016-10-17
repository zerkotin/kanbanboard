{KanbanBoardView} = require './view/KanbanBoardView'

exports.Router = class Router extends Backbone.Router

  currentView: null

  routes:
    '': 'default'

  default: ->
    @_openNewPage('kanban-board-view', KanbanBoardView, {})

  _openNewPage: (className, viewConstructor, options) ->
    @currentView?.remove()

    $el = $(containerTemplate className)
    $('body').append $el

    viewOptions = $.extend(true, {el: $el}, options)

    @currentView = new viewConstructor(viewOptions)

containerTemplate = (className) ->
  """
  <div class="#{className}"></div>
  """
