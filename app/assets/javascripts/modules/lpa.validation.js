(function () {
  'use strict';

  moj.Modules.Validation = {
    errors: [],

    init: function () {
      _.bindAll(this, 'scrollTo', 'validateForm', 'onFieldError', 'onFormValidate', 'renderSummary');
      this.cacheEls();
      this.bindEvents();
    },

    cacheEls: function () {
      this.$body = $('body');
    },

    bindEvents: function () {
      this.$body
                .on('click.moj.Modules.Validation', '[role="alert"] a', this.scrollTo)
                .on('submit.moj.Modules.Validation', '.js-validate-form', this.validateForm);

      moj.Events.on('Validation.renderSummary', this.renderSummary);
      moj.Events.on('Validation.renderFieldSummary', this.renderFieldSummary);
    },

    scrollTo: function (e) {
      var $target = e.target !== undefined ? $($(e.target).attr('href')) : $(e),
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
      /*jshint laxbreak: true */
      return moj.Modules.Popup.isOpen()
              ? target.offset().top - $('#popup').offset().top + parseInt($('#popup').css('marginTop'))
              : target.offset().top;
    },

    validateForm: function (e) {
      var $form = $(e.target);

      // reset errors
      this.errors = [];
      // add event listeners to form
      $form.parsley('addListener', {
        onFormValidate: this.onFormValidate,
        onFieldError: this.onFieldError
      });
      // return false if invalid
      if (!$form.parsley('validate')) {
        return false;
      } else {
        moj.Events.trigger('Validation.isValid', $form);
      }
    },

    onFieldError: function (elem, constraints, ParsleyField) {
      var errorMsg = '',
          i = 0;

      // loop through constraints
      $.each(constraints, function (constraint, options) {
        i += 1;
        if (_.size(constraints) > 1 && i > 1) {
          errorMsg += ' and ';
        }
        errorMsg += ParsleyField.Validator.formatMesssage(ParsleyField.Validator.messages[constraint], options.requirements);
      });
      // push to error array to display in template
      this.errors.push({label_id: elem.siblings('label').attr('id'), label: elem.siblings('label').text(), error: errorMsg});
    },

    onFormValidate: function (isFormValid, event, ParsleyForm) {
      if (!isFormValid) {
        moj.Events.trigger('Validation.renderSummary', {form: ParsleyForm.$element, data: {errors: this.errors}});
      }
    },

    renderSummary: function (e, params) {
      var template = lpa.templates['shared.validation-summary'](params.data);

      if (params.form.find('.validation-summary').length === 0) {
        params.form.find('fieldset').filter(':first').prepend(template);
      } else {
        params.form.find('.validation-summary').replaceWith(template);
      }

      this.scrollTo('#error-heading');
    },

    renderFieldSummary: function (e, params) {
      var $field = params.form.find('[name*="' + params.name + '"]'),
          $label = $field.siblings('label'),
          template = lpa.templates['shared.validation-field-message']({error: params.errors[0]});

      // add validation class to parent
      $field.parent('.group').addClass('validation');
      // remove old errors
      $label.find('.validation-message').remove();
      // apply new template
      $label.append(template);
    }
  };

})();