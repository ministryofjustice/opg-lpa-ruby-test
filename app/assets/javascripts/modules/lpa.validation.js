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
      var $target = $($(e.target).attr('href')),
          $scrollEl = $('#mask').length > 0 ? $('#mask') : $('html, body'),
          topPos = $('#mask').length > 0 ? $target.offset().top - $('#popup').offset().top + 55 : $target.offset().top;

      $scrollEl
        .animate({
          scrollTop: topPos
        }, 300)
        .promise()
        .done(function() {
          $target.closest('.group').find('input,select').first().focus();
        });
    }
  };

})();