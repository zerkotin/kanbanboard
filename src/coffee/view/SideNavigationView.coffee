exports.SideNavigationView = class SideNavigationView extends Backbone.View

  className: 'side-navigation-view'

  navigationItems: null
  animating: false

  events:
    'click .navigation-item': '_onNavigate'
    'mouseenter': '_onMouseOver'
    'mouseleave': '_onMouseOut'

  initialize: (options) ->
    {@navigationItems} = options
    @render()

  render: ->
    for item in @navigationItems
      @$el.append itemTemplate(item)

    #TODO fix this hack
    setTimeout(@_onMouseOut, 1000)

  _onNavigate: (event) ->
    navigationPath = event.target.id
    Backbone.history.navigate(navigationPath, {trigger: true})

  _onMouseOver: ->
    return if @animating
    @animating = true
    @$el.animate({left: '-3px'}, 500, 'swing', => @animating = false)

  _onMouseOut: =>
    return if @animating
    @animating = true
    move = @$el.width() - 20
    @$el.animate({left: "-#{move}px"}, 500, 'swing', => @animating = false)

itemTemplate = (config) ->
  """
  <div id="#{config.path}" class="navigation-item">#{config.template}</div>
  """
