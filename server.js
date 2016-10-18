//if you want a server, run 'npm install express' first
//i didnt want to include it in the package.json since it has nothing to do with it
var express = require('express');
var app = express();

//mock data
app.get('/tickets', function(req, res) {
    res.send([
        {
            title: 'Ticket 1',
            description: 'im a ticket',
            id: '1234234678',
            status: 'TODO',
            owner: 'moshe'
        },
        {
            title: 'Ticket 11',
            description: 'what? you want a big description?! there you go, have a long ass description just for testing',
            id: '1234089723',
            status: 'TODO',
            owner: 'moshe'
        },
        {
            title: 'Ticket 12',
            description: 'im a ticket',
            id: '1234447908',
            status: 'TODO',
            owner: 'moshe'
        },
        {
            title: 'Ticket 13',
            description: 'im a ticket',
            id: '123409823',
            status: 'TODO',
            owner: 'moshe'
        },
        {
            title: 'Ticket 14',
            description: 'im a ticket',
            id: '12340893',
            status: 'TODO',
            owner: 'moshe'
        },
        {
            title: 'Ticket 15',
            description: 'im a ticket',
            id: '12342679',
            status: 'TODO',
            owner: 'moshe'
        },
        {
            title: 'Ticket 16',
            description: 'im a ticket',
            id: '12348855',
            status: 'TODO',
            owner: 'moshe'
        },
        {
            title: 'Ticket 17',
            description: 'im a ticket',
            id: '12346443',
            status: 'TODO',
            owner: 'moshe'
        },
        {
            title: 'Ticket 18',
            description: 'im a ticket',
            id: '123467',
            status: 'TODO',
            owner: 'moshe'
        },
        {
            title: 'Ticket 19',
            description: 'im a ticket',
            id: '1234123',
            status: 'TODO',
            owner: 'moshe'
        },
        {
            title: 'Ticket 2',
            description: 'see, its also really easy to make simple scrolling wherever you want...',
            id: '12345',
            status: 'TODO',
            owner: 'shimon'
        },
        {
            title: 'Ticket 3',
            description: 'im a 3rd ticket',
            id: '123456',
            status: 'IN_PROGRESS',
            owner: 'baruch'
        },
        {
            title: 'Ticket 4',
            description: 'im a 4th ticket',
            id: '1234567',
            status: 'RESOLVED',
            owner: 'arie'
        }
    ]);
});

app.get('/', function(req, res) {
   res.sendFile(__dirname + '/index.html')
});

app.get(/^(.+)$/, function(req, res){
    res.sendFile(__dirname + req.params[0]);
});

app.listen(9090, function() {
  console.log('Server running on port 9090');
});
