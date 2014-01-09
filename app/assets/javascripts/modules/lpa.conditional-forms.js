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
      $('[name="certificateProviderStatementType"], [name="lpa[how_attorneys_act]"], [name="lpa[how_replacement_attorneys_act]"]').conditionalContent();
    },

    cacheEls: function () {
      this.$body = $('body');
    },

    bindEvents: function () {
      this.$body.on('change', '#donor_cannot_sign', this.donorSign);
      this.$body.on('change', 'js-conditional-toggle', this.toggleConditionalEl);
      this.$body.on();
      this.$body.on();
      this.$body.on();
    },

    donorSign: function (e) {
      this.toggleEl($(e.target), $(e.target).is(':checked'));
    },

    toggleConditionalEl: function (e) {

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