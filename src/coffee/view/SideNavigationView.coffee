exports.SideNavigationView = class SideNavigationView extends Backbone.View

  className: 'side-navigation-view'

  navigationItems: null

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
    setTimeout(@_onMouseOut.bind(@), 1000)

  _onNavigate: (event) ->
    navigationPath = event.target.id
    Backbone.history.navigate(navigationPath, {trigger: true})

  _onMouseOver: ->
    @$el.animate({left: '-3px'})

  _onMouseOut: ->
    move = @$el.width() - 20
    @$el.animate({left: "-#{move}px"})

itemTemplate = (config) ->
  """
  <div id="#{config.path}" class="navigation-item">#{config.template}</div>
  """
