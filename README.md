# kanbanboard installation notes

this is a kanbanboard integrates with redmine API to provide a better view/dashboard.

clone the project, and change KanbanConfig.coffee to contain the correct URL.

to install, run the following commands in the reposiroty's base directory:
```
npm install -g bower
npm install -g grunt-cli
npm install
bower install
grunt
npm start
```

go to localhost:9090 in your browser

to get your api key:
login to redmine, go to my account,
and on the right panel, press show api key.
