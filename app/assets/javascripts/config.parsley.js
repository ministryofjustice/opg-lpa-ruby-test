// Update parsley defaults
window.ParsleyConfig = window.ParsleyConfig || {};

(function ($) {
  'use strict';

  window.ParsleyConfig = $.extend(true, {}, window.ParsleyConfig, {
    messages: {
      defaultMessage: 'in invalid',
      type: {
        email:     'must be a valid email address'
      },
      required:    'can\'t be blank',
      minlength:   'is too short (minimum is %s characters)',
      maxlength:   'is too long (maximum is %s characters)'
    },
    trigger: 'change',
    scrollDuration: 0,
    animate: false,
    errorClass: 'validation',
    errors: {
      errorElem: '<span class="validation-message"></span>',
      errorsWrapper: '<span></span>',
      classHandler: function (elem) {
        return $(elem).parent();
      },
      container: function (elem) {
        return elem.parent().find('label');
      }
    }
  });
}(window.jQuery));
