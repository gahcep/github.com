module.exports = (grunt) ->

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
        # Vendor source "app/vendor/js/..."
        vendor: []

        # Custom source "app/js/..."
        src: []

    ## Tasks
    concat:
      options:
        # Define a string to put between each file in the concatenated output
        separator: ';'

      js:
        src: ["<%= files.js.vendor %>", "<%= files.js.src %>"]
        dest: "dist/js/<%= pkg.name %>.js"

    newer:
      timestamps: "generated/compilation-timestamps"

    watch:
      options:
        livereload: true

      html:
        files: ["<%= files.html.src %>"]
        tasks: ["copy"]

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

  # Loading external tasks (plugins)
#  grunt.loadNpmTasks("grunt-contrib-concat")
#  grunt.loadNpmTasks("grunt-contrib-jshint")
#  grunt.loadNpmTasks("grunt-contrib-uglify")
#  grunt.loadNpmTasks("grunt-contrib-watch")
#  grunt.loadNpmTasks("grunt-contrib-less")
#  grunt.loadNpmTasks("grunt-contrib-copy")
#  grunt.loadNpmTasks("grunt-contrib-clean")
#  grunt.loadNpmTasks("grunt-open")
  require('matchdep').filterAll('grunt-*').forEach(grunt.loadNpmTasks)

  # Creating workflow
  grunt.registerTask("minify", ["newer:uglify"])
  grunt.registerTask("lint", ["newer:jshint"])

  grunt.registerTask("default", ["less:dev", "lint", "concat", "minify", "copy", "watch"])
  grunt.registerTask("build", ["clean", "less:prod", "concat", "minify", "copy"])
