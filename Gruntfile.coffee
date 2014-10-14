module.exports = (grunt) ->

  # Initializing task configuration
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json"),
    concat:
      options:
        # Define a string to put between each file in the concatenated output
        separator: ';'

      app:
        # The location of the resulting JS file
        dest: "dist/<%= pkg.name %>.js",
        # The files to concatenate
        src: []

    # Loading local tasks
    grunt.loadTasks("tasks")

    # Loading external tasks (plugins)
    grunt.loadNpmTasks("grunt-contrib-concat")
    grunt.loadNpmTasks("grunt-contrib-jshint")
    grunt.loadNpmTasks("grunt-contrib-uglify")
    grunt.loadNpmTasks("grunt-contrib-watch")

    # Creating workflow
    grunt.registerTask('default', ['concat'])
