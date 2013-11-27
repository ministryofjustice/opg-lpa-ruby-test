opg-lpa
=======

[![Build Status](https://travis-ci.org/ministryofjustice/opg-lpa.png?branch=master)](https://travis-ci.org/ministryofjustice/opg-lpa)
[![Code Climate](https://codeclimate.com/github/ministryofjustice/opg-lpa.png)](https://codeclimate.com/github/ministryofjustice/opg-lpa)
[![Coverage Status](https://coveralls.io/repos/ministryofjustice/opg-lpa/badge.png?branch=master)](https://coveralls.io/r/ministryofjustice/opg-lpa?branch=master)

About
-----

This is a test rails front end for the OPG LPA application website. It integrates with opg-lpa-api for the data storage layer.

Installation
------------

    git clone https://github.com/ministryofjustice/opg-lpa-api.git
    git clone https://github.com/ministryofjustice/opg-lpa.git

    cd opg-lpa
    bundle install

### Frontend

#### Bower

Bower package manager is used for frontend package management. Bower relies in Node.js so if you don't already have it installed, you can install it via the [Node.js website](http://nodejs.org/).

Install Bower globally using:

```
npm install -g bower
```

Then run the following command from the project directory:

```
bower install
```

Tests
-----

Run `rake` to run unit tests. If you have the api server running locally, then run `INTEGRATION=true rake` to run the integration tests.
