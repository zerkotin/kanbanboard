# Kanbanboard

Kanbanboard integrates with Redmine and provides a better View and better UI experience.

kanbanboard is based on:

* Backbone
* Underscode
* JQuery
* CoffeeScript
* NodeJS
* Express
* Grunt
* Browserify
* Less
* FontAwesome

take a look at the wonderful examples of CoffeesScript and Backbone with advanced stylesheets, responsive design without any framework interrupting, and a super lightweight and fast performing application.

kanbanboard is built with grunt and includes many grunt modules and features.
take a look at Gruntfile.coffee for interesting examples...

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


to run the project go to ```build``` directory and run ```npm install``` and then ```npm start```

make sure you have a ```kanbanboard.properties``` file in build folder with a ```redmine.api.url``` property that points to your redmine host and a ```kanbanboard.http.port``` property with the http port for the web server.
for example:
````
redmine.api.url=my.redmine.host
kanbanboard.http.port=9090
```

then go to localhost:9090 in your browser.


when developing you can run ```grunt watch``` and it will automatically transpile the coffee and less files when you make changes to the project.


to get your redmine api key:
login to redmine, go to my account,
and on the right panel, press show api key.

