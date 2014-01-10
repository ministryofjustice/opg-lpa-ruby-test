(function () {
  'use strict';

  moj.Modules.Validation = {
    init: function () {
      _.bindAll(this, 'focusError');
      this.cacheEls();
      this.bindEvents();
    },

    cacheEls: function () {
      this.$body = $('body');
    },

    bindEvents: function () {
      this.$body.on('click.moj.Modules.Validation', '[role="alert"] a', this.focusError);
    },

    focusError: function (e) {
      var $target = $($(e.target).attr('href')),
          $scrollEl = moj.Modules.Popup.isOpen() ? $('#mask') : $('html, body'),
          topPos = this.calculateScrollPos($target);

      $scrollEl
        .animate({
          scrollTop: topPos
        }, 300)
        .promise()
        .done(function() {
          $target.closest('.group').find('input, select, textarea').first().focus();
        });
    },

    calculateScrollPos: function (target) {
      return moj.Modules.Popup.isOpen()
              ? target.offset().top - $('#popup').offset().top + parseInt($('#popup').css('marginTop'))
              : target.offset().top;
    }
  };

})();