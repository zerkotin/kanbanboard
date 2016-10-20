exports.SideNavigationView = class SideNavigationView extends Backbone.View

  className: 'side-navigation-view'

  navigationItems: null

  events:
    'click .navigation-item': '_onNavigate'

  initialize: (options) ->
    {@navigationItems} = options
    @render()

  render: ->
    for item in @navigationItems
      @$el.append itemTemplate(item)

  _onNavigate: (event) ->
    navigationPath = event.target.id
    Backbone.history.navigate(navigationPath, {trigger: true})

itemTemplate = (config) ->
  """
  <div id="#{config.path}" class="navigation-item">#{config.template}</div>
  """
