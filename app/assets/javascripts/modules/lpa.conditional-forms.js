// Forms modules for LPA
// Dependencies: moj

(function () {
  'use strict';

  moj.Modules.ConditionalForms = {
    init: function () {
      moj.log('lpa.modules.ConditionalForms#init');

      // init conditional content plugins
      $('.js-conditional-content').conditionalContent();
    }
  };

}());