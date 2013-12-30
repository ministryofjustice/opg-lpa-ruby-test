module.exports = function (grunt) {
  'use strict';

  // Load all plugins
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

  // Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    handlebars: {
      compile: {
        options: {
          namespace: 'lpa.templates',
          prettify: false,
          amdWrapper: false,
          processName: function (filename) {
            // Shortens the file path for the template and removes file extension.
            return filename.slice(filename.indexOf('templates') + 10, filename.length).replace(/\.[^/.]+$/, '');
          }
        },
        src: ['app/assets/javascripts/templates/**/*.html'],
        dest: 'app/assets/javascripts/lpa.templates.js'
      }
    },
    jshint: {
      options: {
        jshintrc : '.jshintrc',
        ignores: [
          // ignore templates
          '<%= handlebars.compile.dest %>',
          // ignore rails manifest
          'app/assets/javascripts/application.js',
          // ignore legacy code for now
          'app/assets/javascripts/jquery-plugin/**/*',
          'app/assets/javascripts/date-picker.js',
          'app/assets/javascripts/application.js',
          'app/assets/javascripts/form.js',
          'app/assets/javascripts/help-popup.js',
          'app/assets/javascripts/pwstrength.js'
        ]
      },
      files: [
        'Gruntfile.js',
        'app/assets/javascripts/**/*.js',
        'app/views/**/*.js.erb'
      ]
    },
    imagemin: {
      dynamic: {
        options: {
          optimizationLevel: 5
        },
        files: [{
          expand: true,
          cwd: 'app/assets/images/',
          dest: 'app/assets/images/',
          src: ['**/*.{png,jpg,gif}']
        }]
      }
    },
    watch: {
      templates: {
        files: ['app/assets/javascripts/templates/**/*'],
        tasks: ['handlebars'],
      },
      jshint: {
        files: ['app/assets/javascripts/**/*.js', 'app/views/**/*.js.erb'],
        tasks: ['jshint'],
      }
    }
  });

  // task(s).
  grunt.registerTask('default', ['handlebars', 'jshint']);
};