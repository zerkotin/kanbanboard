exports.KanbanConfig = {
  serverConfig: null #will be updated from TicketCollection
  getRedmineIssueUrl: (redmineId) -> return "https://#{@serverConfig.redmineHost}/issues/#{redmineId}"
  teamViewConfig:
    path: 'team'
    title: 'Team'
    issuesUrl: '/teamissues'
    remoteFilters: [
      {text: 'Key', name: 'key', type: 'password', description: 'Redmine API key'}
      {text: 'Team', name: 'team', type: 'text', description: 'Team name'}
      {text: 'Sprint', name: 'sprint', type: 'text', description: 'Sprint number'}
    ]
    localFilters: [
      {title: 'Status', name: 'status', field: 'status'}
      {title: 'Assignee', name: 'assignee', field: 'assigned_to'}
    ]
    columns: [
      {color: '#75a7f1', name: 'new', columnTitle: 'New', statuses: ['New', 'Queued ']}
      {color: '#7fe3f3', name: 'todo', columnTitle: 'To Do', statuses: ['Groomed ', 'Committed ']}
      {color: 'orange', name: 'inprogress', columnTitle: 'In Progress...', statuses: ['In Progress']}
      {color: '#8ac383', name: 'resolved' ,columnTitle: 'Resolved', statuses: ['Resolved']}
      {color: '#f37f7f', name: 'removed', columnTitle: 'Removed', statuses: ['Feedback', 'Rejected']}
    ]
    ticketConfig:
      nameField: 'assigned_to'

  poViewConfig:
    path: 'po'
    title: 'PO'
    issuesUrl: '/poissues'
    remoteFilters: [
      {text: 'Key', name: 'key', type: 'password', description: 'Redmine API key'}
    ]
    localFilters: [
      {title: 'Status', name: 'status', field: 'status'}
    ]
    columns: [
      {color: '#75a7f1', name: 'backlog', columnTitle: 'Backlog', statuses: ['New', 'Queued ', 'Groomed ', 'Committed ']}
      {color: 'orange', name: 'inprogress', columnTitle: 'In Progress...', statuses: ['In Progress']}
      {color: '#8ac383', name: 'resolved', columnTitle: 'Resolved', statuses: ['Resolved']}
      {color: '#f37f7f', name: 'removed', columnTitle: 'Removed', statuses: ['Feedback', 'Rejected']}
    ]
    ticketConfig:
      nameField: 'assigned_to'

  developerViewConfig:
    path: 'developer'
    title: 'Developer'
    issuesUrl: '/developerissues'
    remoteFilters: [
      {text: 'Key', name: 'key', type: 'password', description: 'Redmine API key'}
    ]
    columns: [
      {color: '#75a7f1', name: 'backlog', columnTitle: 'Backlog', statuses: ['New', 'Queued ', 'Groomed ', 'Committed ']}
      {color: 'orange', name: 'inprogress', columnTitle: 'In Progress...', statuses: ['In Progress']}
      {color: '#8ac383', name: 'resolved', columnTitle: 'Resolved', statuses: ['Resolved']}
    ]
    ticketConfig:
      nameField: 'author'

  ticketViewConfig:
    path: 'tickets'
    title: 'Tickets'
    issuesUrl: '/specificissues'
    remoteFilters: [
      {text: 'Key', name: 'key', type: 'password', description: 'Redmine API key'}
      {text: 'Tickets', name: 'tickets', type: 'text', description: 'Comma separated tickets'}
    ]
    localFilters: [
      {title: 'Status', name: 'status', field: 'status'}
    ]
    columns: [
      {color: '#75a7f1', name: 'backlog', columnTitle: 'Backlog', statuses: ['New', 'Queued ', 'Groomed ', 'Committed ']}
      {color: 'orange', name: 'inprogress', columnTitle: 'In Progress...', statuses: ['In Progress']}
      {color: '#8ac383',name: 'resolved',  columnTitle: 'Resolved', statuses: ['Resolved']}
      {color: 'lightgrey', name: 'closed', columnTitle: 'Closed', statuses: ['Closed']}
      {color: '#f37f7f', name: 'removed', columnTitle: 'Removed', statuses: ['Feedback', 'Rejected']}
    ]
    ticketConfig:
      nameField: 'author'

  navigationItems: [
    {path: 'team', template: '<i class="fa fa-users" aria-hidden="true"></i>Team'}
    {path: 'po', template: '<i class="fa fa-user-secret" aria-hidden="true"></i>PO'}
    {path: 'developer', template: '<i class="fa fa-laptop" aria-hidden="true"></i>Developer'}
    {path: 'tickets', template: '<i class="fa fa-ticket" aria-hidden="true"></i>Tickets'}
  ]

}
