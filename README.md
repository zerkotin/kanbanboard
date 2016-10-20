# kanbanboard installation notes

this is a kanbanboard integrates with redmine API to provide a better view/dashboard.

clone the project, and change KanbanConfig.coffee to contain the correct URL.


before installation you must have nodejs installed, with bower and grunt-cli

to install bower and grunt globally run the following commands:
```
npm install -g bower
npm install -g grunt-cli
```

to build the project the first time, run the following commands in the reposiroty's base directory:
```
npm install
bower install
grunt
```

afterwards, building the project consists of running ```grunt``` or ```grunt distribution```

dont forget to delete ```build``` and ```_temp``` directories before building a distribution version.


to run the project go to ```build``` directory and run ```npm start```

then go to localhost:9090 in your browser.


when developing you can run ```grunt watch``` and it will automatically transpile the coffee and less files when you make changes to the project.


to get your redmine api key:
login to redmine, go to my account,
and on the right panel, press show api key.


Take a look at our wiki page...
