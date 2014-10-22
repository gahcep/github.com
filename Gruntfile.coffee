module.exports = (grunt) ->

  require('time-grunt')(grunt)

  # Initializing task configuration
  grunt.initConfig

    # Read package.json
    pkg: grunt.file.readJSON("package.json"),

    # Define the banner
    banner: "/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - " +
      "/<%= grunt.template.today(\"yyyy-mm-dd\") %>\n" +
      "<%= pkg.homepage ? \"* \" + pkg.homepage + \"\\n\" : \"\" %>" +
      "* Copyright (c) <%= grunt.template.today(\"yyyy\") %> <%= pkg.author %>" +
      "Licensed <%= _.pluck(pkg.licenses, \"type\").join(\", \") %> */\n"

    # Alias to our files that will be used by tasks
    files:
      html:
        src: "app/index.html"

      less:
        src: ["app/css/style.less"]

      js:
        # Vendor source "/bower_modules/..."
        vendor: []

        # Custom source "app/js/..."
        src: []

    ## Tasks
    concat:
      options:
        # Define a string to put between each file in the concatenated output
        separator: ';'

      js:
        src: [
          "<%= files.js.vendor %>",
          "<%= files.js.src %>"
        ]
        dest: "dist/js/<%= pkg.name %>.js"

#    concat-sourcemap:
#      options:
#        sourcesContent: true

#      js:
#        src: [
#          "<%= files.js.vendor %>",
#          "<%= files.js.src %>"
#        ]
#        dest: "dist/js/<%= pkg.name %>.js"

    newer:
      timestamps: "generated/compilation-timestamps"

    watch:
      options:
        livereload: true

      html:
        files: ["<%= files.html.src %>"]
        tasks: ["newer:copy"]

      js:
        files: ["<%= files.js.src %>"]
        tasks: ["jshint", "concat"]

      less:
        files: ["<%= files.less.src %>"]
        tasks: ["less:dev"]

    jshint:
      app:
        src: ["<%= files.js.src %>"]

    uglify:
      options:
        banner = "<%= banner %>"

      dist:
        src: "<%= concat.js.dest %>"
        dest: "dist/js/<%= pkg.name %>.min.js"

    less:
      # Task-level options
      options:
        paths: ["app/css"]
        ieCompat: false

      dev:
        src: "<%= files.less.src %>"
        dest: "generated/css/style.css"

      prod:
        # Target-level options
        options:
          cleancss: true
          compress: true
        src: "<%= files.less.src %>"
        dest: "dist/css/style.css"

    copy:
      html:
        files:
          "generated/index.html" : "<%= files.html.src %>"
          "dist/index.html"      : "<%= files.html.src %>"

    clean:
      workspace: ["dist", "generated"]

  # Loading local tasks
  grunt.loadTasks("tasks")

  # Loading Grunt tasks (plugins)
  require('load-grunt-tasks')(grunt)

  # Creating workflow
  grunt.registerTask("default", ["less:dev", "jshint", "concat", "uglify", "newer:copy", "watch"])
  grunt.registerTask("build", ["clean", "less:prod", "concat", "uglify", "newer:copy"])
