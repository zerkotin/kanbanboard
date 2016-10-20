module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    browserify:
      dev:
        src: '_temp/src/coffee/index.js'
        dest: 'build/index.js'
      dist:
        src: '_temp/src/coffee/index.js'
        dest: '_temp/index.js'

    watch:
      coffee:
        files: ['src/coffee/**/*.coffee']
        tasks: ['coffee-transpile']
      less:
        files: ['src/style/**/*.less']
        tasks: ['less-transpile']
      server:
        files: ['src/server/**/*.js']
        tasks: ['copy-server']

    less:
      distribution:
        files: {'build/index.css': 'src/style/index.less'}

    coffee:
      compile:
        expand: true
        flatten: false
        cwd: './'
        src: ['src/**/*.coffee']
        dest: '_temp/'
        ext: '.js'

    copy:
      favicon:
        files: [
          src: ['src/style/favicon.ico']
          dest: 'build/favicon.ico'
        ]
      fontawesome:
        files: [
          expand: true
          src: ['src/style/fontawesome/fonts/*']
          dest: 'build/fonts/'
          filter: 'isFile'
          flatten: true
        ]
      html:
        files: [
          src: ['src/index.html']
          dest: 'build/index.html'
        ]
      server:
        files: [
          expand: true
          src: ['src/server/*']
          dest: 'build/'
          filter: 'isFile'
          flatten: true
        ]

    concat:
      options:
        seperator: ';'
      devvendors:
        src: [
          'bower_components/jquery/dist/jquery.js',
          'bower_components/underscore/underscore.js',
          'bower_components/backbone/backbone.js'
        ],
        dest: 'build/vendors.js'
      distvendors:
        src: [
          'bower_components/jquery/dist/jquery.min.js',
          'bower_components/underscore/underscore-min.js',
          'bower_components/backbone/backbone-min.js'
        ],
        dest: '_temp/vendors.js'

    uglify:
      kanbanboard:
        files:
          'build/index.js': ['_temp/index.js']
      vendors:
        files:
          'build/vendors.js': ['_temp/vendors.js']

  #the tasks
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'

  #builds
  grunt.registerTask 'default', ['coffee', 'browserify:dev', 'less', 'copy', 'concat:devvendors']
  grunt.registerTask 'distribution', ['coffee', 'browserify:dist', 'less', 'copy', 'concat:distvendors', 'uglify']

  #for watchers
  grunt.registerTask 'coffee-transpile', ['coffee', 'browserify:dev']
  grunt.registerTask 'less-transpile', ['less']
  grunt.registerTask 'copy-server', ['copy:server']
