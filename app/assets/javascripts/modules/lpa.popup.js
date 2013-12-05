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
      source: "#content",
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
        var scrollTop = (this.$html.scrollTop()) ? this.$html.scrollTop() : this.$body.scrollTop();
        this.$html.addClass('noscroll').css('top', -scrollTop);
      }

      // Join it all together
      this.$popup.addClass(opts.ident).append(this.$close).append(this.$content.append(html)).appendTo(this.$mask);

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
      var self = this,
          scrollTop = parseInt(this.$html.css('top'));

      // Re-enable scrolling of rest of page
      this.$html.removeClass('noscroll');
      $('html, body').scrollTop(-scrollTop);

      self.$popup.fadeOut(400, function () {
        self.$mask.fadeOut(200, function () {
          // focus on previous element
          $(self.settings.source).focus();

          // clear out any hash locations
          window.location.hash = '';
          history.pushState('', document.title, window.location.pathname);

          // callback func
          if (self.settings.onClose && typeof(self.settings.onClose) === "function") {
            self.settings.onClose();
          }

          // Remove the popup from the DOM
          $(this).remove();
        });
      });
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






var OPGPopup = {
  /**
  * Modified from git@github.com:alphagov/static.git (app/assets/javascripts.popup.js)
  * @author Mat Harden (mat.harden@digital.justice.gov.uk)
  */

  popup: function (html, ident, source, placement) {

    // Defaults
    var source = source || '#header-global h1 a',
        placement = placement || 'body';

    // Create the HTML templates
    var $mask = $('#mask'), $popup, $close;
    // Re-use if already open
    if ($mask.length) {
      $popup = $('#popup', $mask);
      $close = $('.close', $mask);
    } else {
      $mask = $('<div id="mask" class="popover-mask" />');
      $popup = $('<div id="popup" class="' + ident + '" role="dialog" />');
      $popupContent = $('<div id="popup-content" />');
      $close = $('<p class="close"><a id="lightboxclose" href="#" title="Click or press escape to close this window">Close</a></p>');
    }

    // Get the window height and width
    var $win = $(window),
        winH = $win.height(),
        winW = $win.width();

    // Clear-up method
    var closePopup = function () {

      // Re-enable scrolling of rest of page
      var scrollTop = parseInt($('html').css('top'));
      $('html').removeClass('noscroll');
      $('html,body').scrollTop(-scrollTop);

      $popup.fadeOut(400, function () {
        $mask.fadeOut(200, function () {

          // Put popup contents back where you found it
          // $(html).appendTo('#content').hide();

          // Remove the popup from the DOM
          $(this).remove();
        });
      });

      $(source).focus();

      // clear out any hash locations
      window.location.hash = '';
      history.pushState('', document.title, window.location.pathname);
    };

    // Loop tab key
    var loopTabKeys = function (wrap) {
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
    };

    // Stop rest of page from scrolling when scrolling the popup
    if ($(document).height() > $(window).height()) {
      var scrollTop = ($('html').scrollTop()) ? $('html').scrollTop() : $('body').scrollTop(); // Works for Chrome, Firefox, IE...
      $('html').addClass('noscroll').css('top', -scrollTop);
    }

    // Apply close functions
    $popup
      .on('keydown', function (e) {
        if (e.which == 27) {
          closePopup();
        }
      })
      .on('click', '.close, .close-help', function (e) {
        e.preventDefault();
        closePopup();
      });

    // Join it all together
    $popup.append($close).append($popupContent.append(html)).appendTo($mask);

    // Place the mask in the DOM
    // If a placement has been provided, the popup is appended to that element,
    // otherwise the popup is appended to the body element.
    $(placement)[placement === 'body' ? 'append' : 'after']($mask);

    // Fade in the mask
    $mask.fadeTo(200, 1);

    // Center and fase in the popup
    $popup.delay(100).fadeIn(200, function () {
      $popup.find('h2').attr('tabindex', -1);
      $popup.find('#lightboxclose').focus(); // for accessibility

      loopTabKeys($popup);
    });

    return $popup;
  }
};