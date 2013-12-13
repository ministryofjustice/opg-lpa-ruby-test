/*jslint browser: true, evil: false, plusplus: true, white: true, indent: 2 */
/*global html5_storage, PubSub, lpa, moj, $ */

// Form Popup module for LPA
// Dependencies: lpa, jQuery

(function (){
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
      loadingContent: '<div id="help-system"><header><p>A guide to making your lasting power of attorney</p></header><div class="help-sections"><article><p><img src="/assets/ajax-loader.gif"> Loading guidance</p></article></div></div>', // TODO: Use JS template rather than markup here...
      popupOnOpen: function () {
        this.source.spinner('off');
      }
    },

    init: function () {
      moj.log('lpa.Modules.FormPopup#init');
      this._cacheEls();
      this._bindEvents();
      localStorage.clear();
    },

    _cacheEls: function () {
      this.formContent = [];
      this.originalSource = false;
      this.source = false;
    },

    _bindEvents: function () {
      // form open
      $('body').on('click', this.settings.selector, $.proxy(this._btnClick, this));

      // submit form
      $('body').on('submit', '#popup.form-popup form', $.proxy(this._submitForm, this));

      // generic subscriptions to popup events
      PubSub.subscribe('popup.open', $.proxy(this.settings.popupOnOpen, this));
    },

    _btnClick: function (e) {
      var source = $(e.target),
          href = source.attr('href'),
          form = source.data('form');

      // set original source to be the original link clicked form the body to be able to return to it when the popup is closed
      // fixes when links inside a popup load another form. User should be focused back to original content button when closing
      if($('#popup').length === 0){
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


      moj.log('submitting form...');


      if($form.parsley('validate')){
        $form.find('input[type="submit"]').spinner();
        moj.log('validated');

        $.post(url, form.serialize(), function (response) {
          moj.log(response);

          if(response.success !== undefined) {
            // successful, so redirect
            window.location.reload();
          } else if (response.toLowerCase().indexOf("sign in") != -1) {
            // not logged in, redirect
            window.location.reload();
          } else {
            // handle error


            // has the login timed out?  if so, we must close the lightbox
            // if (resp.toLowerCase().indexOf("sign in") != -1) {
            //   window.location.reload();
            // } else {
            //   $lightbox = $('#form-lightbox').html(resp);

            //   // Mark as dirty
            //   $lightbox.find('form').data('dirty', true);

            //   OPGPopup.popup($lightbox, "form-popup", form);

            //   var donorCannotSign = $('#donor_cannot_sign').is(':checked');
            //   if (donorCannotSign) {
            //     $('#donorsignprompt').show();
            //   } else {
            //     $('#donorsignprompt').hide();
            //   }
            // }
          }
        });
      } else {
        moj.log('not validated');
      }

      return false;
    },

    _getCachedForm: function (url) {
      if(html5_storage() && typeof localStorage[url] !== 'undefined') {
        return localStorage[url];
      }
      // then try from this class
      else if(typeof this.formContent[url] !== 'undefined') {
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
      if(html !== false){
        lpa.Modules.Popup.open(html, {
          ident: this.settings.overlayIdent,
          source: this.originalSource,
          beforeOpen: function () {
            // set pcode lookup
            $('#popup').opgPostcodeLookup();
          }
        });
      }
      // otherwise, AJAX it in and then switch the content in the popup
      else {
        // load overlay
        lpa.Modules.Popup.open(this.settings.loadingContent, {
          ident: self.settings.overlayIdent,
          source: this.originalSource,
          beforeOpen: function () {
            $('#popup-content').load(href, function(html) {
              // cache content
              if (html5_storage()) {
                // save to html5 storage
                localStorage[form] = html;
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
    }
  };

  // Add module to MOJ namespace
  lpa.Modules.FormPopup = new FormPopup();
}());