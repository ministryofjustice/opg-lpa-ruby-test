opg-lpa
=======

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

#### Error Checking

[JSHint](http://www.jshint.com/docs/) is being run on JS files to detect errors and problems in JS code.

To manually check JS files run:

    grunt jshint
