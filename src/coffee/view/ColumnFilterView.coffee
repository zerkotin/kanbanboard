exports.ColumnFilterView = class ColumnFilterView extends Backbone.View

  className: 'column-filter-view'

  viewState: null
  stateAttribute: null
  animating: false

  events:
    'click .filter-item': '_onFilterClick'
    'mouseenter': '_onMouseOver'
    'mouseleave': '_onMouseOut'

  initialize: (options) ->
    {@viewState, @stateAttribute} = options
    @render()

  render: () ->
    @$el.empty();
    for item in @collection
      @$el.append itemTemplate(item)

    setTimeout(@_onMouseOut, 1000)

  _onFilterClick: (event) ->
    selectedFilter = @$('#'+event.target.id)
    if selectedFilter.hasClass 'selected'
      selectedFilter.removeClass 'selected'
      @viewState.set(@stateAttribute, @viewState.get(@stateAttribute).filter((column) => return column isnt event.target.id))
    else
      selectedFilter.addClass 'selected'
      columns = @viewState.get(@stateAttribute)
      @viewState.set(@stateAttribute, columns.concat [event.target.id])

  _onMouseOver: ->
    return if @animating
    @animating = true
    @$el.animate({right: '-3px'}, 200, 'swing', => @animating = false)

  _onMouseOut: =>
    return if @animating
    @animating = true
    move = @$el.width() - 20
    @$el.animate({right: "-#{move}px"}, 200, 'swing', => @animating = false)

itemTemplate = (config) ->
  """
  <div id="#{config.name}" class="filter-item selected">#{config.columnTitle}</div>
  """
