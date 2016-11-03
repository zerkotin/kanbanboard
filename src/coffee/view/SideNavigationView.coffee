exports.SideNavigationView = class SideNavigationView extends Backbone.View

  className: 'side-navigation-view'

  animating: false

  events:
    'click .navigation-item': '_onNavigate'
    'mouseenter': '_onMouseOver'
    'mouseleave': '_onMouseOut'

  initialize: (options) ->
    @render(options.initSelectedPath)

  render: (initSelectedPath) ->
    for item in @collection
      @$el.append itemTemplate(item)

    @$('#'+initSelectedPath).addClass 'selected' # selecting the item after refresh screen

    #TODO fix this hack
    setTimeout(@_onMouseOut, 1000)

  _onNavigate: (event) ->
    navigationPath = event.target.id
    @$('.navigation-item').removeClass 'selected'
    @$('#'+navigationPath).addClass 'selected'
    Backbone.history.navigate(navigationPath, {trigger: true})

  _onMouseOver: ->
    return if @animating
    @animating = true
    @$el.animate({left: '-3px'}, 200, 'swing', => @animating = false)

  _onMouseOut: =>
    return if @animating
    @animating = true
    move = @$el.width() - 20
    @$el.animate({left: "-#{move}px"}, 200, 'swing', => @animating = false)

itemTemplate = (config) ->
  """
  <div id="#{config.path}" class="navigation-item">#{config.template}</div>
  """
