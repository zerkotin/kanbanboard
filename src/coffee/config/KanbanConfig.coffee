exports.KanbanConfig = {
  redmineIssuesUrl: 'https://project.osthus.com/issues/',
  teamViewConfig:
    path: 'team'
    title: 'Team'
    url: '/teamissues'
    filters: [
      {text: 'Key', name: 'key', type: 'password', description: 'Redmine API key'}
      {text: 'Team', name: 'team', type: 'text', description: 'Team name'}
      {text: 'Sprint', name: 'sprint', type: 'text', description: 'Sprint number'}
    ]
    columns: [
      {color: '#f37f7f', columnClass: 'first-column', columnTitle: 'Backlog', statuses: ['New', 'Queued ', 'Groomed ', 'Committed ']}
      {color: '#6c6cf5', columnTitle: 'In Progress...', statuses: ['In Progress']}
      {color: '#8ac383', columnTitle: 'Resolved', statuses: ['Resolved']}
      {color: 'orange', columnClass: 'last-column', columnTitle: 'Other', statuses: ['Feedback', 'Rejected']}
    ]
    ticketConfig:
      nameField: 'assigned_to'

  poViewConfig:
    path: 'po'
    title: 'PO'
    url: '/poissues'
    filters: [
      {text: 'Key', name: 'key', type: 'password', description: 'Redmine API key'}
    ]
    columns: [
      {color: '#f37f7f', columnClass: 'first-column', columnTitle: 'Backlog', statuses: ['New', 'Queued ', 'Groomed ', 'Committed ']}
      {color: '#6c6cf5', columnTitle: 'In Progress...', statuses: ['In Progress']}
      {color: '#8ac383', columnTitle: 'Resolved', statuses: ['Resolved']}
      {color: 'orange', columnClass: 'last-column', columnTitle: 'Other', statuses: ['Feedback', 'Rejected']}
    ]
    ticketConfig:
      nameField: 'assigned_to'

  developerViewConfig:
    path: 'developer'
    title: 'Developer'
    url: '/developerissues'
    filters: [
      {text: 'Key', name: 'key', type: 'password', description: 'Redmine API key'}
    ]
    columns: [
      {color: '#f37f7f', columnClass: 'first-column', columnTitle: 'Backlog', statuses: ['New', 'Queued ', 'Groomed ', 'Committed ']}
      {color: '#6c6cf5', columnTitle: 'In Progress...', statuses: ['In Progress']}
      {color: '#8ac383', columnClass: 'last-column', columnTitle: 'Resolved', statuses: ['Resolved']}
    ]
    ticketConfig:
      nameField: 'author'

  ticketViewConfig:
    path: 'tickets'
    title: 'Tickets'
    url: '/specificissues'
    filters: [
      {text: 'Key', name: 'key', type: 'password', description: 'Redmine API key'}
      {text: 'Tickets', name: 'tickets', type: 'text', description: 'Comma separated tickets'}
    ]
    columns: [
      {color: '#f37f7f', columnClass: 'first-column', columnTitle: 'Backlog', statuses: ['New', 'Queued ', 'Groomed ', 'Committed ']}
      {color: '#6c6cf5', columnTitle: 'In Progress...', statuses: ['In Progress']}
      {color: '#8ac383', columnTitle: 'Resolved', statuses: ['Resolved']}
      {columnTitle: 'Closed', statuses: ['Closed']}
      {color: 'orange', columnClass: 'last-column', columnTitle: 'Other', statuses: ['Feedback', 'Rejected']}
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
