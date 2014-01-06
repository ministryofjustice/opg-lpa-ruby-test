// Popup module for LPA
// Dependencies: moj, jQuery

(function () {
  'use strict';

  // Define the class
  var Dialog = function (el, options) {
    this.settings = $.extend({}, this.defaults, options);
    this._cacheEls(el);
    this._bindEvents();
  };

  Dialog.prototype = {
    defaults: {
      type: 'confirm', // options - confirm, alert, prompt
      message: ''
    },

    _cacheEls: function (el) {
      this.$link = el;
    },

    _bindEvents: function () {
      var self = this;

      this.$link.on('click', function () {
        if (self.settings.type === 'confirm') {
          if (!confirm(self.settings.message)) {
            return false;
          }
        } else if (self.settings.type === 'prompt') {
          if (!prompt(self.settings.message)) {
            return false;
          }
        } else if (self.settings.type === 'alert') {
          alert(self.settings.message);
          return false;
        }
      });
    }
  };

  // Add module to MOJ namespace
  moj.Modules.dialog = {
    init: function () {
      $('.js-dialog').each(function () {
        $(this).data('moj.dialog', new Dialog($(this), $(this).data()));
      });
    }
  };
}());