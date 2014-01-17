var helper = {
  url: 'http://0.0.0.0:3000/',
  username: 'john.stevens@digital.co.uk',
  password: 'tardis123',

  createAccount: function (test) {
    test
      .open(helper.url + 'users/sign_up')
      .type('[name="registration[email]"]', helper.username)
      .type('[name="registration[password]"]', helper.password)
      .click('[type="submit"]')
      .done();
  },

  login: function (test) {
    'use strict';

    test
      .open(helper.url + 'users/sign_in')
      .type('[name="session[email]"]', helper.username)
      .type('[name="session[password]"]', helper.password)
      .click('[type="submit"]')
      .done();
  },

  fillDetails: function (test) {
    'use strict';

    test
      .open(helper.url + 'applicants/new')
      .type('[name="applicant[first_name]"]', 'John')
      .type('[name="applicant[last_name]"]', 'Smith')
      .type('[name="applicant[date_of_birth(3i)]"]', '10')
      .click('h1', 'click different element')
      .type('[name="applicant[date_of_birth(2i)]"]', 'January')
      .click('h1', 'click different element')
      .type('[name="applicant[date_of_birth(1i)]"]', '1980')
      .click('h1', 'click different element')
      .click('input[value="Save and continue"]')
      .done();
  },

  killStorage: function (test) {
    'use strict';

    test
      .execute(function () {
        window.sessionstorage.clear();
        window.localstorage.clear();
      })
      .wait(500)
      .done();
  }
};
module.exports = helper;