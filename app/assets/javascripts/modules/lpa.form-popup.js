// Form Popup module for LPA
// Dependencies: moj, jQuery

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
      // bind 'this' as this in following methods
      _.bindAll(this, '_btnClick', '_submitForm');
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
        .on('click.moj.Modules.FormPopup', this.settings.selector, this._btnClick)
        // submit form
        .on('submit.moj.Modules.FormPopup', '#popup.form-popup form', this._submitForm);
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
          url = $form.attr('action');

      if ($form.parsley('isValid')) {
        $form.find('input[type="submit"]').spinner();

        $.ajax({
          url: url,
          type: 'post',
          dataType: 'json',
          data: $form.serialize(),
          context: $form,
          success: this.ajaxSuccess,
          error: this.ajaxError
        });
        return false;
      }
    },

    ajaxSuccess: function (response, textStatus, jqXHR) {
      var $form = $(this),
          data;

      if (jqXHR.status !== 200) {
        // if not a succesful request, reload page
        window.location.reload();
      } else if (response.success !== undefined && response.success) {
        // successful, so redirect
        window.location.reload();
      } else {
        // if field errors, display them
        if (response.errors !== undefined) {
          data = {errors: []};
          $.each(response.errors, function (name, errors) {
            data.errors.push({label_id: name + '_label', label: $('#' + name + '_label').text(), error: errors[0]});
            moj.Events.trigger('Validation.renderFieldSummary', {form: $form, name: name, errors: errors});
          });
          moj.Events.trigger('Validation.renderSummary', {form: $form, data: data});
          // show error summary
        } else {
          // show error summary
          moj.Events.trigger('Validation.renderSummary', {form: $form, data: {}});
        }
        // stop spinner
        $form.find('input[type="submit"]').spinner('off');
      }
    },

    ajaxError: function () {
      // an error occured, reload the page
      window.location.reload();
    },

    _getCachedForm: function (url) {
      if (moj.Helpers.hasHtml5Storage() && typeof sessionStorage[url] !== 'undefined') {
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
        moj.Modules.Popup.open(html, {
          ident: this.settings.overlayIdent,
          source: this.originalSource,
          onOpen: this.settings.popupOnOpen,
          beforeOpen: function () {
            // set pcode lookup
            $('#popup').opgPostcodeLookup();
            // trigger title replacement event
            moj.Events.trigger('TitleSwitch.render', {wrap: '#popup'});
          }
        });
      }
      // otherwise, AJAX it in and then switch the content in the popup
      else {
        // load overlay
        moj.Modules.Popup.open(this.settings.loadingTemplate, {
          ident: this.settings.overlayIdent,
          source: this.originalSource,
          onOpen: this.settings.popupOnOpen,
          beforeOpen: function () {
            $('#popup-content').load(href, function (html) {
              // cache content
              if (moj.Helpers.hasHtml5Storage()) {
                // save to html5 storage
                sessionStorage[form] = html;
              } else {
                // save to obj
                self.formContent[form] = html;
              }
              // set pcode lookup
              $('#popup').opgPostcodeLookup();
              // trigger title replacement event
              moj.Events.trigger('TitleSwitch.render', {wrap: '#popup'});
            });
          }
        });
      }
    }
  };

  // Add module to MOJ namespace
  moj.Modules.FormPopup = new FormPopup();
}());