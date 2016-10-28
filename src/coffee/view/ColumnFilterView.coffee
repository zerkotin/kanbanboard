exports.ColumnFilterView = class ColumnFilterView extends Backbone.View

  className: 'column-filter-view'

  config: null
  viewState: null
  animating: false

  events:
    'click .filter-item': '_onFilterClick'
    'mouseenter': '_onMouseOver'
    'mouseleave': '_onMouseOut'

  initialize: (options) ->
    {@config, @viewState} = options
    @render()

  render: () ->
    for item in @config.columns
      @$el.append itemTemplate(item)

    setTimeout(@_onMouseOut, 1000)

  _onFilterClick: (event) ->
    selectedFilter = @$('#'+event.target.id)
    if selectedFilter.hasClass 'selected'
      selectedFilter.removeClass 'selected'
      @viewState.set('columns', @viewState.get('columns').filter((column) -> return column.name isnt event.target.id))
    else
      selectedFilter.addClass 'selected'
      columns = @viewState.get('columns')
      columns.push event.target.id
      @viewState.set('columns', columns)

  _onMouseOver: ->
    return if @animating
    @animating = true
    @$el.animate({right: '-3px'}, 500, 'swing', => @animating = false)

  _onMouseOut: =>
    return if @animating
    @animating = true
    move = @$el.width() - 20
    @$el.animate({right: "-#{move}px"}, 500, 'swing', => @animating = false)

itemTemplate = (config) ->
  """
  <div id="#{config.name}" class="filter-item">#{config.columnTitle}</div>
  """
