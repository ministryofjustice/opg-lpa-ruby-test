// Forms modules for LPA
// Dependencies: moj

(function () {
  'use strict';

  moj.Modules.ConditionalForms = {
    init: function () {
      moj.log('lpa.modules.ConditionalForms#init');
      _.bindAll(this, 'donorSign');
      this.cacheEls();
      this.bindEvents();

      // init conditional content plugins
      $('.js-conditional-content').conditionalContent();
    },

    cacheEls: function () {
      this.$body = $('body');
    },

    bindEvents: function () {
      this.$body.on('change', '#donor_cannot_sign', this.donorSign);
    },

    donorSign: function (e) {
      this.toggleEl($(e.target), $(e.target).is(':checked'));
    },

    toggleEl: function (el, bool) {
      if (bool) {
        el.show();
      } else {
        el.hide();
      }
    }
  };

}());