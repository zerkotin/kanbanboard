exports.KanbanConfig = {
  redmineIssuesUrl: 'https://project.osthus.com/issues/',
  teamViewConfig:
    url: '/teamissues'
    filters: [
      {text: 'Key', name: 'key', type: 'password', description: 'Redmine API key'}
      {text: 'Team', name: 'team', type: 'text', description: 'Team name'}
      {text: 'Sprint', name: 'sprint', type: 'text', description: 'Sprint number'}
    ]
    columns: [
      {color: '#f37f7f', columnClass: 'first-column', columnTitle: 'TODO', statuses: ['New', 'Queued', 'Groomed', 'Committed']},
      {color: '#6c6cf5', columnTitle: 'In Progress...', statuses: ['In Progress']},
      {color: '#8ac383', columnClass: 'last-column', columnTitle: 'DONE', statuses: ['Resolved', 'Feedback', 'Closed', 'Rejected']}
    ]
  poViewConfig:
    url: '/createdbymeissues'
    filters: [
      {text: 'Key', name: 'key', type: 'password', description: 'Redmine API key'}
    ]
    columns: [
      {columnClass: 'first-column', columnTitle: 'TODO', statuses: ['New', 'Queued', 'Groomed', 'Committed']},
      {columnTitle: 'In Progress...', statuses: ['In Progress']},
      {columnTitle: 'Resolved', statuses: ['Resolved']},
      {columnTitle: 'Feedback', statuses: ['Feedback']},
      {columnTitle: 'Closed', statuses: ['Closed']},
      {columnClass: 'last-column', columnTitle: 'Rejected', statuses: ['Rejected']}
    ]
  developerViewConfig:
    url: '/assignedtomeissues'
    filters: [
      {text: 'Key', name: 'key', type: 'password', description: 'Redmine API key'}
    ]
    columns: [
      {color: '#f37f7f', columnClass: 'first-column', columnTitle: 'Backlog', statuses: ['New', 'Queued', 'Groomed', 'Committed']},
      {color: '#6c6cf5', columnTitle: 'In Progress...', statuses: ['In Progress']},
      {color: '#8ac383', columnClass: 'last-column', columnTitle: 'Resolved', statuses: ['Resolved']}
    ]
  navigationItems: [
    {path: 'team', template: '<i class="fa fa-users" aria-hidden="true"></i>Team'},
    {path: 'po', template: '<i class="fa fa-user-secret" aria-hidden="true"></i>PO'},
    {path: 'developer', template: '<i class="fa fa-laptop" aria-hidden="true"></i>Developer'}
  ]

}
