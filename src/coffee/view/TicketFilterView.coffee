exports.TicketFilterView = class TicketFilterView extends Backbone.View

  className: 'ticket-filter-view'

  viewState: null
  stateAttribute: null
  animating: false
  ticketCollection: null
  ticketField: null

  events:
    'click .filter-item': '_onFilterClick'
    'mouseenter': '_onMouseOver'
    'mouseleave': '_onMouseOut'

  initialize: (options) ->
    {@ticketCollection, @ticketField, @viewState, @stateAttribute} = options
    @listenTo @ticketCollection, 'sync', @render

  render: () ->
    @$el.empty();
    properties = {}
    stateValue = []
    for ticket in @ticketCollection.models
      value = ticket.get(@ticketField) || {id: -1, name: 'unassigned'}
      unless properties[value.id]
        properties[value.id] = value.name
        stateValue.push +value.id

    data = {}
    data[@stateAttribute] = stateValue
    @viewState.set(data, {silent: true}) # silent only for startup

    for key of properties
      @$el.append itemTemplate({id: key, name: properties[key]})

    setTimeout(@_onMouseOut, 1000)

  _onFilterClick: (event) ->
    selectedFilter = @$('#'+event.target.id)
    if selectedFilter.hasClass 'selected'
      selectedFilter.removeClass 'selected'
      @viewState.set(@stateAttribute, @viewState.get(@stateAttribute).filter((column) => return column isnt +event.target.id))
    else
      selectedFilter.addClass 'selected'
      columns = @viewState.get(@stateAttribute)
      @viewState.set(@stateAttribute, columns.concat [+event.target.id])

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
  <div id="#{config.id}" class="filter-item selected">#{config.name}</div>
  """
