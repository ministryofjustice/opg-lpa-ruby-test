// Forms modules for LPA
// Dependencies: moj

(function () {
  'use strict';

  moj.Modules.ConditionalForms = {
    init: function () {
      moj.log('lpa.modules.ConditionalForms#init');
      this.cacheEls();
      this.bindEvents();
    },

    cacheEls: function () {
      this.$body = $('body');
    },

    bindEvents: function () {
      this.$body.on('change', '#donor_cannot_sign', this.donorSign);
      this.$body.on();
      this.$body.on();
      this.$body.on();
      this.$body.on();
    },

    donorSign: function (e) {
      this.toggleEl($(e.target), $(e.target).is(':checked'));
    }

    toggleEl: function (el, bool) {
      if (bool) {
        el.show();
      } else {
        el.hide();
      }
    }
  };

}());