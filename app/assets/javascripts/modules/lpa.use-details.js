/*global lpa, moj */

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
      url: '/service/getdetails',
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

        // $.ajax({
        //   url: self.settings.url,
        //   dataType: 'json',
        //   success: function (response) {
            var proceed = self._isFormClean(self.$form) ? confirm(self.settings.message) : true;

            if(proceed){
              self._populateForm(self.$form, {});
            }
          // }
        // });
      });
    },

    _isFormClean: function (form) {
      moj.log('checking');
      var clean = true;

      $(':input', form).each(function() {
        if($(this).val() !== '') {
          clean = false;
        }
      });

      return clean;
    },

    _populateForm: function (form, data) {
      moj.log(form);
      moj.log(data);
    }
  };

  // Add module to LPA namespace
  lpa.Modules.reuseDetails = {
    init: function () {
      $('.js-use-details').each(function () {
        $(this).data('lpa.use-details', new UseDetails($(this), $(this).data()));
      });
    }
  };
}());