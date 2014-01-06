/*global lpa */

// Popup module for LPA
// Dependencies: lpa, jQuery

(function () {
  'use strict';

  // Define the class
  var UseDetails = function (el, options) {
    this.settings = $.extend({}, this.defaults, options);
    this._cacheEls(el);
    this._bindEvents();
  };

  UseDetails.prototype = {
    defaults: {
      property: null,
      message: 'This will replace the information which you have already entered, are you sure?'
    },

    _cacheEls: function (el) {
      this.$link = el;
      this.$form = this.$link.closest('form');
    },

    _bindEvents: function () {
      var self = this;
      this.$link.on('click', function (e) {
        e.preventDefault();

        if (self.settings.property !== undefined) {
          self._populateForm(self.$form, lpa[self.settings.property]);
        }
      });
    },

    _isFormClean: function (form) {
      var clean = true;
      $('input[type="text"], select, textarea', form).each(function() {
        if ($(this).val() !== '') {
          clean = false;
        }
      });
      return clean;
    },

    /*jshint onevar: false */
    _populateForm: function (form, data) {
      var proceed = this._isFormClean(form) ? true : confirm(this.settings.message);
      if (proceed) {
        for (var elmId in data) {
          var $field = $('[name*="' + elmId + '"]'),
              value = data[elmId];
          $field.val(value).change();
        }
      }
    }
  };

  // Add module to LPA namespace
  moj.Modules.UseDetails = {
    init: function () {
      $('.js-use-details').each(function () {
        $(this).data('moj.use-details', new UseDetails($(this), $(this).data()));
      });
    }
  };
}());