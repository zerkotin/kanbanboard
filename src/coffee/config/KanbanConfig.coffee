exports.KanbanConfig = {
  redmineIssuesUrl: 'https://project.osthus.com/issues/',
  teamViewConfig:
    url: '/teamissues'
    filter:
      showTeamFilter: true
    columns: [
      {color: '#f37f7f', columnClass: 'first-column', columnTitle: 'TODO', statuses: ['New', 'Queued', 'Groomed', 'Committed']},
      {color: '#6c6cf5', columnTitle: 'In Progress...', statuses: ['In Progress']},
      {color: '#8ac383', columnClass: 'last-column', columnTitle: 'DONE', statuses: ['Resolved', 'Feedback', 'Closed', 'Rejected']}
    ]
  poViewConfig:
    url: '/createdbymeissues'
    filter:
      showTeamFilter: false
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
    filter:
      showTeamFilter: false
    columns: [
      {color: '#f37f7f', columnClass: 'first-column', columnTitle: 'Backlog', statuses: ['Groomed', 'Committed']},
      {color: '#6c6cf5', columnTitle: 'In Progress...', statuses: ['In Progress']},
      {color: '#8ac383', columnClass: 'last-column', columnTitle: 'Resolved', statuses: ['Resolved']}
    ]
  navigationItems: [
    {path: 'team', template: '<i class="fa fa-users" aria-hidden="true"></i>team'},
    {path: 'po', template: '<i class="fa fa-user-secret" aria-hidden="true"></i>po'},
    {path: 'developer', template: '<i class="fa fa-laptop" aria-hidden="true"></i>developer'}
  ]

}
