/*jslint browser: true, evil: false, plusplus: true, white: true, indent: 2 */
/*global moj, lpa, $ */

// Popup module for LPA
// Dependencies: lpa, moj, jQuery

(function (){
  "use strict";

  // Define the class
  var Popup = function (options) {
    this.settings = $.extend({}, this.defaults, options);
    this._cacheEls();
    this._bindEvents();
  };

  Popup.prototype = {
    defaults: {
      source: $("#content"),
      placement: "body",
      popupId: "popup",
      maskHTML: '<div id="mask" class="popover-mask" />',
      popupHTML: '<div id="popup" role="dialog" />',
      closeHTML: '<p class="close"><a id="lightboxclose" href="#" title="Click or press escape to close this window">Close</a></p>',
      contentHTML: '<div id="popup-content" />',
      beforeOpen: null,
      onOpen: null,
      onClose: null
    },

    init: function (){
      moj.log("lpa.modules.popup#init");
    },

    _cacheEls: function () {
      this.$win = $(window);
      this.$html = $('html');
      this.$body = $('body');
      this.$mask = $(this.settings.maskHTML);
      this.$popup = $(this.settings.popupHTML);
      this.$close = $(this.settings.closeHTML);
      this.$content = $(this.settings.contentHTML);
    },

    _bindEvents: function () {
      var self = this;

      this.$body
        .on('keydown', function (e) {
          if (e.which == 27) {
            self.close();
          }
        })
        .on('click', '#popup .close, #popup .close-help', function (e) {
          e.preventDefault();
          self.close();
        });
    },

    open: function (html, opts) {
      var self = this,
          opts = $.extend({}, this.settings, opts);

      // Stop rest of page from scrolling when scrolling the popup
      if ($(document).height() > $(window).height()) {
        // Works for Chrome, Firefox, IE...
        var scrollTop = ($('html').scrollTop()) ? $('html').scrollTop() : $('body').scrollTop();
        moj.log(scrollTop);
        $('html').addClass('noscroll').css('top', -scrollTop);
      }

      // Join it all together
      this.$popup.data('settings', opts).addClass(opts.ident).append(this.$close).append(this.$content.html(html)).appendTo(this.$mask);

      // Place the mask in the DOM
      // If a placement has been provided, the popup is appended to that element,
      // otherwise the popup is appended to the body element.
      $(opts.placement)[opts.placement === 'body' ? 'append' : 'after'](this.$mask);

      // callback func
      if (opts.beforeOpen && typeof(opts.beforeOpen) === "function") {
        opts.beforeOpen();
      }

      // Fade in the mask
      this.$mask.fadeTo(200, 1);

      // Center and fase in the popup
      this.$popup.delay(100).fadeIn(200, function () {
        self.$popup.find('h2').attr('tabindex', -1);
        self.$popup.find('#lightboxclose').focus(); // for accessibility

        // set tabs
        self.loopTabKeys(self.$popup);

        // callback func
        if (opts.onOpen && typeof(opts.onOpen) === "function") {
          opts.onOpen();
        }
      });
    },

    close: function () {
      // make sure there is a popup to close
      if($('#popup').length > 0){
        var self = this,
            opts = $('#popup').data('settings');

        // Re-enable scrolling of rest of page
        var scrollTop = parseInt($('html').css('top'));
        $('html').removeClass('noscroll');
        $('html,body').scrollTop(-scrollTop);

        self.$popup.fadeOut(400, function () {
          self.$mask.fadeOut(200, function () {
            // focus on previous element
            if(typeof opts.source !== 'undefined' && opts.source){
              opts.source.focus();
            }
            // clear out any hash locations
            window.location.hash = '';
            history.pushState('', document.title, window.location.pathname);

            // callback func
            if (opts.onClose && typeof(opts.onClose) === "function") {
              opts.onClose();
            }

            // Remove the popup from the DOM
            $(this).remove();
          });
        });
      }
    },

    loopTabKeys: function (wrap) {
      var tabbable = 'a, area, button, input, object, select, textarea, [tabindex]',
          first = wrap.find(tabbable).filter(':first'),
          last = wrap.find(tabbable).filter(':last');

      first.add(last).keydown(function (e) {

        var code = (e.keyCode ? e.keyCode : e.which),
            shift = e.shiftKey,
            self = $(this)[0],
            down = (self == last[0] && !shift),
            up = (self == first[0] && shift),
            focusOn = down ? first : (up ? last : null);

        if (code === 9 && (down || up)) {
          e.preventDefault();
          focusOn.focus();
        }
      });
    }
  };

  // Add module to MOJ namespace
  lpa.Modules.Popup = new Popup();
}());