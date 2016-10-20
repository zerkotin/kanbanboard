exports.KanbanConfig = {
  redmineIssuesUrl: 'https://project.osthus.com/issues/',
  teamViewConfig: [
    {columnClass: 'first-column', columnTitle: 'TODO', statuses: ['New', 'Queued', 'Groomed', 'Committed ']},
    {columnTitle: 'In Progress...', statuses: ['In Progress']},
    {columnClass: 'last-column', columnTitle: 'DONE', statuses: ['Resolved', 'Feedback', 'Closed', 'Rejected']}
  ],
  poViewConfig: [
    {columnClass: 'first-column', columnTitle: 'TODO', statuses: ['New', 'Queued', 'Groomed', 'Committed ']},
    {columnTitle: 'In Progress...', statuses: ['In Progress']},
    {columnTitle: 'Resolved', statuses: ['Resolved']},
    {columnTitle: 'Feedback', statuses: ['Feedback']},
    {columnTitle: 'Closed', statuses: ['Closed']},
    {columnClass: 'last-column', columnTitle: 'Rejected', statuses: ['Rejected']}
  ],
  developerViewConfig: [
    {columnClass: 'first-column', columnTitle: 'Backlog', statuses: ['Groomed', 'Committed ']},
    {columnTitle: 'In Progress...', statuses: ['In Progress']},
    {columnClass: 'last-column', columnTitle: 'Resolved', statuses: ['Resolved']}
  ],
  navigationItems: [
    {path: 'team', template: 'team'},
    {path: 'po', template: 'po'},
    {path: 'developer', template: 'developer'}
  ]

}
