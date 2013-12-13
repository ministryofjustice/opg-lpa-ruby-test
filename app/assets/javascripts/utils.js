// Test for local storage
function html5_storage() {
  try {
    return 'sessionStorage' in window && window['sessionStorage'] !== null;
  } catch (e) {
    return false;
  }
}

// Update parsley defaults
window.ParsleyConfig = window.ParsleyConfig || {};

(function ($) {
  window.ParsleyConfig = $.extend( true, {}, window.ParsleyConfig, {
    messages: {
      // parsley //////////////////////////////////////
        defaultMessage: "This value seems to be invalid."
        , type: {
            email:      "must be a valid email address"
          , url:        "This value should be a valid url."
          , urlstrict:  "This value should be a valid url."
          , number:     "This value should be a valid number."
          , digits:     "This value should be digits."
          , dateIso:    "This value should be a valid date (YYYY-MM-DD)."
          , alphanum:   "This value should be alphanumeric."
          , phone:      "This value should be a valid phone number."
        }
      , notnull:        "This value should not be null."
      , notblank:       "This value should not be blank."
      , required:       "can't be blank"
      , regexp:         "This value seems to be invalid."
      , min:            "is too short (minimum is %s characters)"
      , max:            "is too long (maximum is %s characters)"
      , range:          "This value should be between %s and %s."
      , minlength:      "This value is too short. It should have %s characters or more."
      , maxlength:      "This value is too long. It should have %s characters or less."
      , rangelength:    "This value length is invalid. It should be between %s and %s characters long."
      , mincheck:       "You must select at least %s choices."
      , maxcheck:       "You must select %s choices or less."
      , rangecheck:     "You must select between %s and %s choices."
      , equalto:        "This value should be the same."
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