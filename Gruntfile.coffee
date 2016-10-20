module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    browserify:
      js:
        src: '_temp/src/coffee/index.js'
        dest: 'app/index.js'

    watch:
      coffee:
        files: ['src/coffee/**/*.coffee']
        tasks: ['coffee-transpile']
      less:
        files: ['src/style/**/*.less']
        tasks: ['less-transpile']

    less:
      development:
        files: {'app/index.css': 'src/style/index.less'}

    coffee:
      compile:
        expand: true
        flatten: false
        cwd: './'
        src: ['src/**/*.coffee']
        dest: '_temp/'
        ext: '.js'

    copy:
      fontawesome:
        files: [
          expand: true
          src: ['src/style/fontawesome/fonts/*']
          dest: 'app/fonts/'
          filter: 'isFile'
          flatten: true
        ]
      html:
        files: [
          src: ['src/index.html']
          dest: 'app/index.html'
        ]

    concat:
      options:
        seperator: ';'
      vendors:
        src: [
          'bower_components/jquery/dist/jquery.min.js',
          'bower_components/underscore/underscore-min.js',
          'bower_components/backbone/backbone-min.js'
        ],
        dest: 'app/vendors.js'

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-concat'

  grunt.registerTask 'default', ['coffee', 'browserify', 'less', 'copy:fontawesome', 'copy:html', 'concat:vendors']
  grunt.registerTask 'coffee-transpile', ['coffee', 'browserify']
  grunt.registerTask 'less-transpile', ['less']

  #TODO add a minifier and an uglifier
  #TODO add dev build and distribution build
  #TODO exclude the source maps from vendors
  #TODO pack a server folder including a package.json for node modules
