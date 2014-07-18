opg-lpa
=======

Unmaintained
------------

**This project is not under active development**. It was an experiment as part of an cancelled re-write.

[![Build Status](https://travis-ci.org/ministryofjustice/opg-lpa.png?branch=master)](https://travis-ci.org/ministryofjustice/opg-lpa)
[![Code Climate](https://codeclimate.com/github/ministryofjustice/opg-lpa.png)](https://codeclimate.com/github/ministryofjustice/opg-lpa)
[![Coverage Status](https://coveralls.io/repos/ministryofjustice/opg-lpa/badge.png?branch=master)](https://coveralls.io/r/ministryofjustice/opg-lpa?branch=master)

About
-----

This is a test rails front end for the OPG LPA application website. It integrates with opg-lpa-api for the data storage layer.

Local installation
------------------

    git clone https://github.com/ministryofjustice/opg-lpa-api.git
    git clone https://github.com/ministryofjustice/opg-lpa.git

    cd opg-lpa
    bundle install

### PDFtk

On Mac OS X, download installer from here:
[http://www.pdflabs.com/tools/pdftk-server/#download](http://www.pdflabs.com/tools/pdftk-server/#download)

On Linux:

    sudo apt-get install pdftk

Tests
-----

Run `rake` to run unit tests.

If you want to use the api server running locally, then run `VCR=false rake` to run the integration tests.

To automatically run tests on file changes:

    bundle exec guard

Frontend Dev
------------

### Bower

Bower package manager is used for frontend package management. Bower relies in Node.js so if you don't already have it installed, you can install it via the [Node.js website](http://nodejs.org/).

Install Bower globally using:

    npm install -g bower

Then run the following command from the project directory to update packages:

    bower install

### Grunt

To watch directories for changes and to trigger relevant tasks run:

    grunt watch

#### JS Templating

[Grunt](http://gruntjs.com/) is being used to compile [Handlebars](http://handlebarsjs.com/) templates.

All JS template files currently live in `app/assets/javascripts/templates/`. To compile the templates run:

    grunt handlebars

#### JS Linting

[JSHint](http://www.jshint.com/docs/) is being run on JS files to detect errors and problems in JS code.

To manually check JS files run:

    grunt jshint

#### Automated Browser Tests

Browser tests are being run using a combination of [DalekJS](http://dalekjs.com/) and either [PhantomJS](http://phantomjs.org/) or a locally installed browser.

These are integration tests that are mainly used to test JavaScript specific functionality like an overlay correctly opening and closing with the right content.

To run tests silently in a PhantomJS:

    grunt dalek:headless

To run tests with local versions of Chrome, Firefox and in PhantomJS:

    grunt dalek:all

#### CI Tests

The CI server will run a grunt command to lint JS files and run the browser tests. To simulate this, run:

    grunt test

#### Image Optimisation

[grunt-contrib-imagemin](https://github.com/gruntjs/grunt-contrib-imagemin) is used to optimise images.

To optimise run:

    grunt imagemin

#### Watch during Dev

To watch files during development and run associated tasks, run:

    grunt watch

Subtasks of this are also available as:

    grunt watch:templates
    grunt watch:jshint
    grunt watch:dalek
