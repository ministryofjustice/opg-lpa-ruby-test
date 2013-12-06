/*jslint browser: true, evil: false, plusplus: true, white: true, indent: 2 */
/*global moj, lpa, $ */

// Help System module for LPA
// Dependencies: popup, lpa, moj, jQuery

(function (){
  'use strict';

  // Define the class
  var HelpSystem = function (options) {
    // only load if not on the static page
    if($('#help-system').length === 0){
      this.settings = $.extend({}, this.defaults, options);
      this._cacheEls();
      this._bindEvents();

      // open popup if hash is present in url
      var hash = window.location.hash;
      if (hash !== '' && hash !== '#/') {
        // on page load parse hash
        var topic = hash.substring(hash.lastIndexOf('/')+1);
        // set topic
        this._selectHelpTopic(topic);
      }
    }
  };

  HelpSystem.prototype = {
    defaults: {
      guidancePath: 'guidance',
      selector: 'a.js-guidance',
      overlayIdent: 'help-system',
      overlaySource: '#content',
      loadingContent: '<div id="help-system"><header><p>A guide to making your lasting power of attorney</p></header><div class="help-sections"><article><p><img src="/assets/ajax-loader.gif"> Loading guidance</p></article></div></div>', // TODO: Use JS template rather than markup here...
      popupOnClose: function () {
        lpa.Modules.helpSystem.topic = undefined;
      }
    },

    init: function (){
      moj.log('lpa.modules.helpSystem#init');
    },

    _cacheEls: function () {
      this.html = undefined;
      this.topic = false;
      this.source = false;
    },

    _bindEvents: function () {
      var self = this;

      // nav click event
      $('body').on('click', this.settings.selector, function (){
        var href = $(this).attr('href'),
            topic = href.substring(href.lastIndexOf('#')+1);
        // set the current click as the source
        self.source = $(this);
        // select topic
        self._selectHelpTopic(topic);
        return false;
      });

      // listen to hash changes in url
      $(window).on('hashchange', function() {
        var hash = window.location.hash;

        // if a change has been made, select the topic
        if (hash !== '' && hash !== '#/') {
          var topic = hash.substring(hash.lastIndexOf('/')+1);
          self._selectHelpTopic(topic);
        }
        // if the new hash is empty, clear out the popup
        else if (hash === '') {
          lpa.Modules.Popup.close();
        }
      });
    },

    _selectHelpTopic: function (topic) {
      var self = this;

      // make sure no duplicate calls are fired
      if (topic !== this.topic) {
        // if the overlay is present, set topic immediately
        if($('#popup.help-system').length > 0){
          self._setTopic(topic);
        } else {
        // otherwise, load in the overlay first and set in callback
          this._loadOverlay(topic);
        }
      }
    },

    _setTopic: function (slug) {
      // set topic to global obj
      this.topic = slug;

      // make sure we're not resetting the hash and adding to the history if we don't need to
      if ('#/' + this.settings.guidancePath + '/' + slug !== window.location.hash){
        window.location.hash = '#/' + this.settings.guidancePath + '/' + slug;
      }

      // Set nav item as active
      $('.help-navigation a[href$="#' + slug + '"]').parent() // use 'ends with' selector so don't have to define url slug
        .addClass('active')
        .siblings()
        .removeClass('active');

      // Show associated content
      $('#' + slug)
        .removeClass('hidden')
        .siblings()
        .addClass('hidden');

      // Scroll back to top of help
      $('#mask').scrollTop(0);
    },

    _hasCachedContent: function () {
      // first try to load from html5 storage
      if(html5_storage() && typeof localStorage.guidanceHTML !== 'undefined') {
        return localStorage.guidanceHTML;
      }
      // then try from this class
      else if(typeof this.html !== 'undefined') {
        return this.html;
      }
      // otherwise, return false
      else {
        return false;
      }
    },

    _loadOverlay: function (topic) {
      var self = this,
          html = this._hasCachedContent();

      // if content has been cached, load it straight in
      if(html !== false){
        lpa.Modules.Popup.open(html, {
          ident: this.settings.overlayIdent,
          source: this.source,
          beforeOpen: function () {
            // set topic
            self._setTopic(topic);
          },
          onClose: this.settings.popupOnClose
        });
      }
      // otherwise, AJAX it in and then switch the content in the popup
      else {
        // load overlay
        lpa.Modules.Popup.open(this.settings.loadingContent, {
          ident: self.settings.overlayIdent,
          source: this.source,
          beforeOpen: function () {
            $('#popup-content').load('/' + self.settings.guidancePath, function(html) {
              // cache content
              if (html5_storage()) {
                // save to html5 storage
                localStorage.guidanceHTML = html;
              } else {
                // save to obj
                self.html = html;
              }
              // set the topic now that all content has loaded
              self._setTopic(topic);
            });
          },
          onClose: this.settings.popupOnClose
        });
      }
    }
  };

  // Add module to MOJ namespace
  lpa.Modules.helpSystem = new HelpSystem();
}());