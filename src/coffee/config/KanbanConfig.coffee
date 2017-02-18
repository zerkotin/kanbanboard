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
      {title: 'Assignee', stateAttribute: 'assignees', ticketField: 'assigned_to', position: 'top'}
      {title: 'Project', stateAttribute: 'projects', ticketField: 'project', position: 'bottom'}
    ]
    columns: [
      {
        colorEnd: '#75a7f1'
        colorStart: '#d4e3fa'
        id: 'new'
        name: 'New'
        statusId: 7
        statusName: 'Queued '
        statuses: ['New', 'Queued ']
      }
      {
        colorEnd: '#7fe3f3'
        colorStart: '#e1fafe'
        id: 'todo'
        name: 'To Do'
        statusId: 8
        statusName: 'Groomed '
        statuses: ['Groomed ', 'Committed ']
      }
      {
        colorEnd: 'orange'
        colorStart: '#ffecc8'
        id: 'inprogress'
        name: 'In Progress...'
        statusId: 2
        statusName: 'In Progress'
        statuses: ['In Progress']
      }
      {
        colorEnd: '#8ac383'
        colorStart: '#daffd5'
        id: 'resolved'
        name: 'Resolved'
        statusId: 3
        statusName: 'Resolved'
        statuses: ['Resolved']
      }
      {
        colorEnd: '#f37f7f'
        colorStart: '#f6d2d2'
        id: 'removed'
        name: 'Feedback'
        statusId: 4
        statusName: 'Feedback'
        statuses: ['Feedback', 'Rejected', 'Blocked']
      }
    ]
    ticketConfig:
      nameField: 'assigned_to'

  unassignedViewConfig:
    path: 'unassigned'
    title: 'Unassigned'
    issuesUrl: '/unassignedissues'
    remoteFilters: [
      {text: 'Key', name: 'key', type: 'password', description: 'Redmine API key'}
    ]
    localFilters: [
      {title: 'Author', stateAttribute: 'authors', ticketField: 'author', position: 'top'}
      {title: 'Projects', stateAttribute: 'projects', ticketField: 'project', position: 'bottom'}
    ]
    columns: [
      {
        colorEnd: '#75a7f1'
        colorStart: '#d4e3fa'
        id: 'new'
        name: 'New'
        statusId: 7
        statusName: 'Queued '
        statuses: ['New', 'Queued ']
      }
      {
        colorEnd: '#7fe3f3'
        colorStart: '#e1fafe'
        id: 'todo'
        name: 'To Do'
        statusId: 8
        statusName: 'Groomed '
        statuses: ['Groomed ', 'Committed ']
      }
      {
        colorEnd: 'orange'
        colorStart: '#ffecc8'
        id: 'inprogress'
        name: 'In Progress...'
        statusId: 2
        statusName: 'In Progress'
        statuses: ['In Progress']
      }
      {
        colorEnd: '#8ac383'
        colorStart: '#daffd5'
        id: 'resolved'
        name: 'Resolved'
        statusId: 3
        statusName: 'Resolved'
        statuses: ['Resolved']
      }
      {
        colorEnd: '#f37f7f'
        colorStart: '#f6d2d2'
        id: 'removed'
        name: 'Feedback'
        statusId: 4
        statusName: 'Feedback'
        statuses: ['Feedback', 'Rejected', 'Blocked']
      }
    ]
    ticketConfig:
      nameField: 'author'

  poViewConfig:
    path: 'po'
    title: 'PO'
    issuesUrl: '/poissues'
    remoteFilters: [
      {text: 'Key', name: 'key', type: 'password', description: 'Redmine API key'}
    ]
    localFilters: [
      {title: 'Assignee', stateAttribute: 'assignees', ticketField: 'assigned_to', position: 'top'}
      {title: 'Project', stateAttribute: 'projects', ticketField: 'project', position: 'bottom'}
    ]
    columns: [
      {
        colorEnd: '#75a7f1'
        colorStart: '#d4e3fa'
        id: 'backlog'
        name: 'Backlog'
        statusId: 7
        statusName: 'Queued '
        statuses: ['New', 'Queued ', 'Groomed ', 'Committed ']
      }
      {
        colorEnd: 'orange'
        colorStart: '#ffecc8'
        id: 'inprogress'
        name: 'In Progress...'
        statusId: 2
        statusName: 'In Progress'
        statuses: ['In Progress']
      }
      {
        colorEnd: '#8ac383'
        colorStart: '#daffd5'
        id: 'resolved'
        name: 'Resolved'
        statusId: 3
        statusName: 'Resolved'
        statuses: ['Resolved']
      }
      {
        colorEnd: '#f37f7f'
        colorStart: '#f6d2d2'
        id: 'removed'
        name: 'Feedback'
        statusId: 4
        statusName: 'Feedback'
        statuses: ['Feedback', 'Rejected', 'Blocked']
      }
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
    localFilters: [
      {title: 'Author', stateAttribute: 'authors', ticketField: 'author', position: 'top'}
      {title: 'Project', stateAttribute: 'projects', ticketField: 'project', position: 'bottom'}
    ]
    columns: [
      {
        colorEnd: '#75a7f1'
        colorStart: '#d4e3fa'
        id: 'backlog'
        name: 'Backlog'
        statusId: 7
        statusName: 'Queued '
        statuses: ['New', 'Queued ', 'Groomed ', 'Committed ']
      }
      {
        colorEnd: 'orange'
        colorStart: '#ffecc8'
        id: 'inprogress'
        name: 'In Progress...'
        statusId: 2
        statusName: 'In Progress'
        statuses: ['In Progress']
      }
      {
        colorEnd: '#8ac383'
        colorStart: '#daffd5'
        id: 'resolved'
        name: 'Resolved'
        statusId: 3
        statusName: 'Resolved'
        statuses: ['Resolved']
      }
      {
        colorEnd: '#f37f7f'
        colorStart: '#f6d2d2'
        id: 'removed'
        name: 'Feedback'
        statusId: 4
        statusName: 'Feedback'
        statuses: ['Feedback', 'Rejected', 'Blocked']
      }
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
    columns: [
      {
        colorEnd: '#75a7f1'
        colorStart: '#d4e3fa'
        id: 'backlog'
        name: 'Backlog'
        statusId: 7
        statusName: 'Queued '
        statuses: ['New', 'Queued ', 'Groomed ', 'Committed ']
      }
      {
        colorEnd: 'orange'
        colorStart: '#ffecc8'
        id: 'inprogress'
        name: 'In Progress...'
        statusId: 2
        statusName: 'In Progress'
        statuses: ['In Progress']
      }
      {
        colorEnd: '#8ac383'
        colorStart: '#daffd5'
        id: 'resolved'
        name: 'Resolved'
        statusId: 3
        statusName: 'Resolved'
        statuses: ['Resolved']
      }
      {
        colorEnd: 'lightgrey'
        colorStart: '#efefef'
        id: 'closed'
        name: 'Closed'
        statusId: 5
        statusName: 'Closed'
        statuses: ['Closed']
      }
      {
        colorEnd: '#f37f7f'
        colorStart: '#f6d2d2'
        id: 'removed'
        name: 'Feedback'
        statusId: 4
        statusName: 'Feedback'
        statuses: ['Feedback', 'Rejected', 'Blocked']
      }
    ]
    ticketConfig:
      nameField: 'author'

  navigationItems: [
    {path: 'team', template: '<i class="fa fa-users" aria-hidden="true"></i>Team'}
    {path: 'po', template: '<i class="fa fa-user-secret" aria-hidden="true"></i>PO'}
    {path: 'developer', template: '<i class="fa fa-laptop" aria-hidden="true"></i>Developer'}
    {path: 'tickets', template: '<i class="fa fa-ticket" aria-hidden="true"></i>Tickets'}
    {path: 'unassigned', template: '<i class="fa fa-exclamation-circle" aria-hidden="true"></i>Unassigned'}
    {path: 'detailed', template: '<i class="fa fa-list-ol" aria-hidden="true"></i>Detailed'}
  ]

  detailedViewConfig:
    issuesUrl: '/specificissues'
    path: 'detailed'
    title: 'Detailed'
    remoteFilters: [
      {text: 'Key', name: 'key', type: 'password', description: 'Redmine API key'}
      {text: 'Tickets', name: 'tickets', type: 'text', description: 'Comma separated tickets'}
    ]
}
