module.exports = function (grunt) {
  // Load all plugins
  require("matchdep").filterDev("grunt-*").forEach(grunt.loadNpmTasks);

  // Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    handlebars: {
      compile: {
        options: {
          namespace: "lpa.templates",
          prettify: false,
          amdWrapper: false,
          processName: function(filename) {
            // Shortens the file path for the template and removes file extension.
            return filename.slice(filename.indexOf("templates")+10, filename.length).replace(/\.[^/.]+$/, "");
          }
        },
        files: {
          "app/assets/javascripts/lpa.templates.js": ["app/assets/javascripts/templates/**/*.html"]
        }
      }
    },
    watch: {
      templates: {
        files: ['app/assets/javascripts/templates/**/*'],
        tasks: ['handlebars'],
      }
    }
  });

  // task(s).
  grunt.registerTask('default', ['handlebars']);
};