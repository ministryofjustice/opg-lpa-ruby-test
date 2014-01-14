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
        .wait(500)
        .assert.chain()
          .exists('#popup', 'Popup has been loaded')
          .visible('#topic-lpa-basics', 'Correct topic is visible')
          .notVisible('#topic-about-this-tool', 'Other topic is not visible')
          .url().to.contain('/#/help/topic-lpa-basics', 'URL has been changed correctly')
        .end()
      .end()
      .done();
  },

  'Close JS Guidance on link click': function (test) {
    'use strict';

    test
      .open(helper.url)
      .click('.js-guidance')
      .wait(100)
      .assert.visible('#popup', 'Popup is visible')
      .click('.js-popup-close')
      .wait(800)
      .assert.doesntExist('#popup', 'Popup has been removed')
      .done();
  },

  'Close JS Guidance on escape keypress': function (test) {
    'use strict';

    test
      .open(helper.url)
      .click('.js-guidance')
      .wait(100)
      .assert.visible('#popup', 'Popup is visible')
      .sendKeys('body', '\uE00C')
      .wait(800)
      .assert.doesntExist('#popup', 'Popup has been removed')
      .done();
  },

  'Navigate JS Guidance': function (test) {
    'use strict';

    test
      .open(helper.url)
      .query('.page-intro')
        .assert.visible('Intro exists')
        .query('.js-guidance')
          .assert.chain()
            .visible('First Link exists')
            .attr('href', helper.url + 'help/#topic-lpa-basics', 'First Link is correct')
          .end()
          .click()
        .end()
        .wait(100)
        .assert.chain()
          .url(helper.url + '#/help/topic-lpa-basics', 'First URL changed correctly')
          .visible('#topic-lpa-basics', 'First topic is visible')
        .end()
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