var helper = require('./helper');

module.exports = {
  name: 'Check Guidance System',

  'Open JS Guidance System to correct topic': function (test) {
    'use strict';

    test
      .open(helper.url)
      .query('.js-guidance')
        .assert.chain()
          .exists('Guidance link exists')
          .attr('href').to.contain('/help/#topic-lpa-basics', 'Guidance link contains correct url')
        .end()
        .click()
        .waitForElement('#popup')
        .assert.chain()
          .exists('#popup', 'Popup has been loaded')
          .visible('#topic-lpa-basics', 'Correct topic is visible')
          // .notVisible('#topic-glossary', 'Other topic is not visible') // doesn't seem to work
        .end()
        .wait(100)
        .assert.url().to.contain('/#/help/topic-lpa-basics', 'URL has been changed correctly')
      .end()
      .done();
  },

  'Close JS Guidance on link click': function (test) {
    'use strict';

    test
      .open(helper.url)
      .click('.js-guidance')
      .waitForElement('#popup')
      .wait(750)
      .assert.visible('#popup', 'Popup has been opened')
      .click('.js-popup-close')
      .wait(750)
      .assert.doesntExist('#popup', 'Popup has been removed')
      .done();
  },

  'Close JS Guidance on escape keypress': function (test) {
    'use strict';

    test
      .open(helper.url)
      .click('.js-guidance')
      .waitForElement('#popup')
      .wait(750)
      .assert.visible('#popup', 'Popup has been opened')
      .sendKeys('body', '\uE00C')
      .wait(750)
      .assert.doesntExist('#popup', 'Popup has been removed')
      .done();
  },

  'Change JS Guidance section with navigation': function (test) {
    'use strict';

    test
      .open(helper.url)
      .query('.js-guidance')
        .assert.chain()
          .exists('Guidance link exists')
          .attr('href').to.contain('/help/#topic-lpa-basics', 'Guidance link contains correct url')
        .end()
        .click()
        .waitForElement('#popup')
        .assert.chain()
          .exists('#popup', 'Popup has been loaded')
          .visible('#topic-lpa-basics', 'Correct topic is visible')
        .end()
        .wait(100)
        .assert.url().to.contain('/#/help/topic-lpa-basics', 'URL has been changed correctly')
        .query('.help-navigation ul li:nth-child(2) a')
          .assert.chain()
            .visible('Nav link exists')
            .attr('href', helper.url + 'help/#topic-about-this-tool', 'Second link contains correct URL')
          .end()
          .click()
        .end()
        .assert.chain()
          .url(helper.url + '#/help/topic-about-this-tool', 'Second URL changed correctly')
          .visible('#topic-about-this-tool', 'Second topic is visible')
        .end()
      .end()
      .done();
  },

  'Navigate JS Guidance with back/foward buttons': function (test) {
    'use strict';

    test
      .open(helper.url)
      .query('.js-guidance')
        .assert.chain()
          .exists('Guidance link exists')
          .attr('href').to.contain('/help/#topic-lpa-basics', 'Guidance link contains correct url')
        .end()
        .click()
        .waitForElement('#popup')
        .assert.chain()
          .exists('#popup', 'Popup has been loaded')
          .visible('#topic-lpa-basics', 'Correct topic is visible')
        .end()
        .wait(100)
        .assert.url().to.contain('/#/help/topic-lpa-basics', 'URL has been changed correctly')
        .query('.help-navigation ul li:nth-child(2) a')
          .assert.chain()
            .visible('Nav link exists')
            .attr('href', helper.url + 'help/#topic-about-this-tool', 'Second link contains correct URL')
          .end()
          .click()
        .end()
        .assert.chain()
          .url(helper.url + '#/help/topic-about-this-tool', 'Second URL changed correctly')
          .visible('#topic-about-this-tool', 'Second topic is visible')
        .end()
        .back()
        .assert.chain()
          .url(helper.url + '#/help/topic-lpa-basics', 'URL changed correctly after back click')
          .visible('#topic-lpa-basics', 'Correct topic visible after back click')
        .end()
        .forward()
        .assert.chain()
          .url(helper.url + '#/help/topic-about-this-tool', 'URL changed correctly after forward')
          .visible('#topic-about-this-tool', 'Correct topic visible after forward click')
        .end()
        .back().back()
        .wait(800)
        .assert.chain()
          .doesntExist('#popup', 'Popup has been removed after back twice')
          .url(helper.url, 'URL has been reset correctly after back twice')
        .end()
      .end()
      .done();
  }
};