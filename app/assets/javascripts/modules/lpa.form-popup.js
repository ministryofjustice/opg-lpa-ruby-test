/*global html5_storage, lpa, moj */

// Form Popup module for LPA
// Dependencies: lpa, jQuery

(function () {
  'use strict';

  // Define the class
  var FormPopup = function (options) {
    this.settings = $.extend({}, this.defaults, options);
  };

  FormPopup.prototype = {
    defaults: {
      selector: '.js-form-popup',
      overlayIdent: 'form-popup',
      overlaySource: '#content',
      loadingTemplate: lpa.templates['shared.loading-popup'](),
      popupOnOpen: function () {
        this.source.spinner('off');
      }
    },

    init: function () {
      moj.log('lpa.Modules.FormPopup#init');
      this._cacheEls();
      this._bindEvents();
    },

    _cacheEls: function () {
      this.formContent = [];
      this.originalSource = false;
      this.source = false;
    },

    _bindEvents: function () {
      $('body')
        // form open
        .on('click', this.settings.selector, $.proxy(this._btnClick, this))
        // submit form
        .on('submit', '#popup.form-popup form', $.proxy(this._submitForm, this));
    },

    _btnClick: function (e) {
      var source = $(e.target),
          href = source.attr('href'),
          form = source.data('form');

      // set original source to be the original link clicked form the body to be able to return to it when the popup is closed
      // fixes when links inside a popup load another form. User should be focused back to original content button when closing
      if ($('#popup').length === 0) {
        this.originalSource = source;
      }
      // always set this source to be the clicked link
      this.source = source;

      // If this link is disabled then stop here
      if (!source.hasClass('disabled')) {
        // set loading spinner
        source.spinner();
        // show form
        this._showForm(href, form);
      }

      return false;
    },

    _submitForm: function (e) {
      var $form = $(e.target),
          $submitBtn = $form.find('input[type="submit"]'),
          url = $form.attr('action');

      if (!$form.parsley('validate')) {
        // show error summary
        this._invalidSummary($form, {});
      } else {
        // start spinner
        $submitBtn.spinner();

        $.ajax({
          url: url,
          type: 'post',
          dataType: 'json',
          data: $form.serialize(),
          context: this,
          success: function (response, textStatus, jqXHR) {
            if (jqXHR.status !== 200) {
              // if not a succesful request, reload page
              window.location.reload();
            } else if (response.success !== undefined && response.success) {
              // successful, so redirect
              window.location.reload();
            } else {
              var thing = this,
                  data;
              // if field errors, display them
              if (response.errors !== undefined) {
                data = {errors: []};
                $.each(response.errors, function (name, errors) {
                  data.errors.push({name: name, label: $('#' + name + '_label').text(), error: errors[0]});
                  thing._invalidField($form, name, errors);
                });
                // show error summary
                this._invalidSummary($form, data);
              } else {
                // show error summary
                this._invalidSummary($form, {});
              }
              // stop spinner
              $submitBtn.spinner('off');
            }
          },
          /*jshint unused: false */
          error: function (jqXHR, textStatus, errorThrown) {
            // an error occured, reload the page
            window.location.reload();
          }
        });
      }
      return false;
    },

    _getCachedForm: function (url) {
      if (html5_storage() && typeof sessionStorage[url] !== 'undefined') {
        return sessionStorage[url];
      }
      // then try from this class
      else if (typeof this.formContent[url] !== 'undefined') {
        return this.formContent[url];
      }
      // otherwise, return false
      else {
        return false;
      }
    },

    _showForm: function (href, form) {
      var self = this,
          html = this._getCachedForm(form);

      // if content has been cached, load it straight in
      if (html !== false) {
        lpa.Modules.Popup.open(html, {
          ident: this.settings.overlayIdent,
          source: this.originalSource,
          onOpen: this.settings.popupOnOpen,
          beforeOpen: function () {
            // set pcode lookup
            $('#popup').opgPostcodeLookup();
          }
        });
      }
      // otherwise, AJAX it in and then switch the content in the popup
      else {
        // load overlay
        lpa.Modules.Popup.open(this.settings.loadingTemplate, {
          ident: this.settings.overlayIdent,
          source: this.originalSource,
          onOpen: this.settings.popupOnOpen,
          beforeOpen: function () {
            $('#popup-content').load(href, function (html) {
              // cache content
              if (html5_storage()) {
                // save to html5 storage
                sessionStorage[form] = html;
              } else {
                // save to obj
                self.formContent[form] = html;
              }
              // set pcode lookup
              $('#popup').opgPostcodeLookup();
            });
          }
        });
      }
    },

    _invalidSummary: function (form, data) {
      var template = lpa.templates['shared.validation-summary'](data);
      if (form.find('.validation-summary').length === 0) {
        form.find('fieldset').filter(':first').prepend(template);
      } else {
        form.find('.validation-summary').replaceWith(template);
      }
    },

    _invalidField: function (form, name, errors) {
      var $field = form.find('[name*="' + name + '"]'),
          $label = $field.siblings('label'),
          template = lpa.templates['shared.validation-field-message']({error: errors[0]});

      // add validation class to parent
      $field.parent('.group').addClass('validation');
      // remove old errors
      $label.find('.validation-message').remove();
      // apply new template
      $label.append(template);
    }
  };

  // Add module to MOJ namespace
  lpa.Modules.FormPopup = new FormPopup();
}());