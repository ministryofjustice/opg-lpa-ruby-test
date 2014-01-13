var url = 'http://0.0.0.0:3000/';

module.exports = {
  name : 'Guidance',

  'Open Guidance System (with JS)': function (test) {
    'use strict';

    test
      .open(url)
      .query('.page-intro')
        .assert.visible('Intro exists')
        .query('.js-guidance')
          .assert.chain()
            .visible('Link exists')
            .attr('href', url + 'help/#topic-lpa-basics', 'Link contains correct URL')
          .end()
          .click()
        .end()
        .wait(1000)
        .assert.chain()
          .url(url + '#/help/topic-lpa-basics', 'URL changed correctly')
          .visible('#topic-lpa-basics', 'Correct topic is visible')
        .end()
      .end()
      .done();
  },

  'Close Guidance on close click (with JS)': function (test) {
    'use strict';

    test
      .open(url)
      .click('.js-guidance')
      .wait(100)
      .assert.visible('#popup', 'Popup is visible')
      .click('.js-popup-close')
      .wait(800)
      .assert.doesntExist('#popup', 'Popup has been removed')
      .done();
  },

  'Close Guidance on escape press (with JS)': function (test) {
    'use strict';

    test
      .open(url)
      .click('.js-guidance')
      .wait(100)
      .assert.visible('#popup', 'Popup is visible')
      .sendKeys('body', '\uE00C')
      .wait(800)
      .assert.doesntExist('#popup', 'Popup has been removed')
      .done();
  },

  'Navigate Guidance System (with JS)': function (test) {
    'use strict';

    test
      .open(url)
      .query('.page-intro')
        .assert.visible('Intro exists')
        .query('.js-guidance')
          .assert.chain()
            .visible('First Link exists')
            .attr('href', url + 'help/#topic-lpa-basics', 'First Link is correct')
          .end()
          .click()
        .end()
        .wait(100)
        .assert.chain()
          .url(url + '#/help/topic-lpa-basics', 'First URL changed correctly')
          .visible('#topic-lpa-basics', 'First topic is visible')
        .end()
        .query('.help-navigation ul li:nth-child(2) a')
          .assert.chain()
            .visible('Nav link exists')
            .attr('href', url + 'help/#topic-about-this-tool', 'Second link contains correct URL')
          .end()
          .click()
        .end()
        .assert.chain()
          .url(url + '#/help/topic-about-this-tool', 'Second URL changed correctly')
          .visible('#topic-about-this-tool', 'Second topic is visible')
        .end()
        .back()
        .assert.chain()
          .url(url + '#/help/topic-lpa-basics', 'URL changed correctly after back click')
          .visible('#topic-lpa-basics', 'Correct topic visible after back click')
        .end()
        .forward()
        .assert.chain()
          .url(url + '#/help/topic-about-this-tool', 'URL changed correctly after forward')
          .visible('#topic-about-this-tool', 'Correct topic visible after forward click')
        .end()
        .back().back()
        .wait(800)
        .assert.chain()
          .doesntExist('#popup', 'Popup has been removed after back twice')
          .url(url + '', 'URL has been reset correctly after back twice')
        .end()
      .end()
      .done();
  }
};