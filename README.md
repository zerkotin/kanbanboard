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

Before installation you must have nodejs installed, with bower and grunt-cli.

To install bower and grunt globally run the following commands:
```
npm install -g bower
npm install -g grunt-cli
```

To build the project the first time, run the following commands in the reposiroty's base directory:
```
npm install
bower install
grunt
```

Afterwards, building the project consists of running `grunt` or `grunt distribution`

dont forget to delete `build` and `_temp` directories before building a distribution version.


to run the project go to `build` directory and run `npm install` and then `npm start`

make sure you have a `kanbanboard.properties` file in build folder with a `redmine.api.url` property that points to your redmine host and a `kanbanboard.http.port` property with the http port for the web server.
for example:
```
redmine.api.url=my.redmine.host
kanbanboard.http.port=9090
```

Then go to `localhost:9090` in your browser.


When developing you can run `grunt watch` and it will automatically transpile the coffee and less files when you make changes to the project.


### To get your Redmine API Key:  
- Login to redmine
- Go to my account,  
- and on the right panel, press `Show API Key`
- Copy paste it to the key field in Kanbanboard
your'e all set, click `refresh` and you'll have your tickets.



