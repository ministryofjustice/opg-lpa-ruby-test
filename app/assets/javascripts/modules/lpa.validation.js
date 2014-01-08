(function () {
  'use strict';

  moj.Modules.Validation = {
    init: function () {
      this.cacheEls();
      this.bindEvents();
    },

    cacheEls: function () {
      this.$body = $('body');
    },

    bindEvents: function () {
      this.$body.on('click', '[role="alert"] a', this.focusError);
    },

    focusError: function (e) {
      var $target = $($(e.target).attr('href'));

      $('html, body')
        .animate({
          scrollTop: $target.offset().top
        }, 300)
        .promise()
        .done(function() {
          $target.closest('.group').find('input,select').first().focus();
        });
    }
  };

})();