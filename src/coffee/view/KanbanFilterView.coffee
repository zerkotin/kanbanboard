exports.KanbanFilterView = class KanbanFilterView extends Backbone.View

  className: 'kanban-filter-view'

  $component: null
  $team: null
  $key: null

  ticketCollection: null

  events:
    'click .kanban-button': '_onFilterClick'

  initialize: (options) ->
    {@ticketCollection} = options
    @render()

  render: ->
    @$component = $ template()
    @$el.append @$component

    @$team = @$('.team-input')
    @$key = @$('.key-input')

    @_loadFromLocalStorage()

  _onFilterClick: ->

    team = @$team.val()
    key = @$key.val()

    #fetch from the server om click
    @ticketCollection.fetch(data:{team: team, key: key})

    @_saveToLocalStorage(key, team)

  _saveToLocalStorage: (key, team) ->
    localStorage.setItem('key', key)
    localStorage.setItem('team', team)

  _loadFromLocalStorage: ->
    team = localStorage.getItem('team')
    key = localStorage.getItem('key')

    @$team.val(team)
    @$key.val(key)


template = ->
  """
  <span class="kanban-label key-label">Key:</span><input placeholder="paste your redmine api key" class="kanban-input key-input" type="password"></input>
  <span class="kanban-label team-label">Team:</span><input class="kanban-input team-input" type="text"></input>
  <span class="kanban-button filter-button">Filter</span>
  """