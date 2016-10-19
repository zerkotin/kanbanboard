exports.KanbanConfig = {
  teamViewConfig: [
    {columnClass: 'first-column', columnTitle: 'TODO', statuses: ['New', 'Queued', 'Committed ']},
    {columnTitle: 'In Progress...', statuses: ['In Progress']},
    {columnClass: 'last-column', columnTitle: 'DONE', statuses: ['Resolved', 'Feedback', 'Closed', 'Rejected']}
  ]
}
