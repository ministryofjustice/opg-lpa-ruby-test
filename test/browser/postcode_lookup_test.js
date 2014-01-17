var helper = require('./helper');

module.exports = {
  name: 'Postcode Lookup',

  'create account': helper.createAccount,
  'login to account': helper.login,
  'fill in details': helper.fillDetails,

  'create LPA': function (test) {
    'use strict';

    test
      .open(helper.url + 'lpas')
      .click('input[value="Create a new LPA"]', 'click create LPA button')
      .click('label[for="lpa_type_property_and_financial_affairs"]', 'select property and financial LPA')
      .click('input[value="Save and continue"]', 'continue to step 2')
      .done();
  },

  'empty postcode value should return error': function (test) {
    'use strict';

    test
      .click('.js-PostcodeLookup__search-btn', 'click postcode search button')
      // temp disable until bug with phantomjs is fixed
      // .assert.dialogText('Please enter a postcode', 'empty postcode validation message appears')
      .accept()
      .done();
  },

  'postcode search value should return results in select': function (test) {
    'use strict';

    test
      .type('.js-PostcodeLookup__query', 'SW1', 'enter value into postcode search query')
      .click('.js-PostcodeLookup__search-btn', 'click postcode search button')
      .waitForElement('.js-PostcodeLookup__search-results')
      .assert.visible('select.js-PostcodeLookup__search-results', 'search results have been display in select field')
      .end()
      .done();
  },

  'changing option in select should populate address': function (test) {
    'use strict';

    test
      .type('.js-PostcodeLookup__search-results', 'Flat', 'select address from results')
      .click('[for="donor_cannot_sign"]', 'click different element to trigger change')
      .assert.chain()
        .visible('.js-PostcodeLookup__postal-add', 'address fieldset is visible')
        .doesntExist('.js-PostcodeLookup__search-results', 'search results have been removed')
      .end()
      .done();
  },

  'selecting manual address shows address fields': function (test) {
    'use strict';

    test
      .reload()
      .click('.js-PostcodeLookup__toggle-address[data-address-type="postal"]', 'click manual address toggle')
      .assert.chain()
        .visible('.js-PostcodeLookup__postal-add', 'address fieldset is visible')
        .notVisible('.js-PostcodeLookup__dx-add', 'dx fieldset is not visible')
      .end()
      .done();
  },

  'selecting dx address shows dx fields': function (test) {
    'use strict';

    test
      .reload()
      .click('.js-PostcodeLookup__toggle-address[data-address-type="dx"]', 'click manual address toggle')
      .assert.chain()
        .visible('.js-PostcodeLookup__dx-add', 'dx fieldset is visible')
        .notVisible('.js-PostcodeLookup__postal-add', 'address fieldset is not visible')
      .end()
      .done();
  }
};