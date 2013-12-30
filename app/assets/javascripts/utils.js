// Test for local storage
function html5_storage() {
  try {
    return 'sessionStorage' in window && window.sessionStorage !== null;
  } catch (e) {
    return false;
  }
}

// Update parsley defaults
window.ParsleyConfig = window.ParsleyConfig || {};

(function ($) {
  window.ParsleyConfig = $.extend( true, {}, window.ParsleyConfig, {
    messages: {
      defaultMessage: "in invalid",
      type: {
        email:      "must be a valid email address"
      },
      required:       "can't be blank",
      min:            "is too short (minimum is %s characters)",
      max:            "is too long (maximum is %s characters)"
    },
    trigger: 'change',
    animate: false,
    errorClass: 'validation',
    errors: {
      errorElem: '<span class="validation-message"></span>',
      errorsWrapper: '<span></span>',
      classHandler: function (elem, isRadioOrCheckbox) {
        return $(elem).parent();
      },
      container: function (elem, isRadioOrCheckbox) {
        return elem.parent().find("label");
      }
    }
  });
}(window.jQuery));