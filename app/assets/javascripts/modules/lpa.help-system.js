/*jslint browser: true, evil: false, plusplus: true, white: true, indent: 2 */
/*global moj, lpa, $ */

// Help System module for LPA
// Dependencies: popup, lpa, moj, jQuery

(function (){
  "use strict";

  // Define the class
  var HelpSystem = function (options) {
    this.settings = $.extend({}, this.defaults, options);
    this._cacheEls();
    this._bindEvents();

    // open popup if hash is present in url
    var hash = window.location.hash;
    if (hash !== '' && hash !== '#/') {
      // on page load parse hash
      var topic = hash.substring(hash.lastIndexOf("/")+1);
      // set topic
      this._selectHelpTopic(topic);
    }
  };

  HelpSystem.prototype = {
    defaults: {
      guidancePath: "guidance",
      selector: "a.js-guidance",
      overlayIdent: "help-sytem",
      overlaySource: "#content"
    },

    _cacheEls: function () {
      // TODO: Use JS template rather than markup here...
      this.loadingContent = '<p>Loading...</p>';
      this.topic = false;
    },

    _bindEvents: function () {
      var self = this;

      // nav click event
      $('body').on('click', this.settings.selector, function (e){
        var href = $(this).attr('href'),
            topic = href.substring(href.lastIndexOf("#")+1);
        // select topic
        self._selectHelpTopic(topic);
        return false;
      });

      $(window).on('hashchange', function() {
        var hash = window.location.hash;
        moj.log(hash);
        if (hash !== '' && hash !== '#/') {
          var topic = hash.substring(hash.lastIndexOf("/")+1);
          // self._selectHelpTopic(topic);
        }
      });

      // add listener to state change to change contents
      // window.addEventListener("popstate", function(e) {
      //   var hash = window.location.hash;
      //   moj.log("state change");

      //   if (hash !== '' && hash !== '#/') {
      //     // on page load parse hash
      //     var topic = hash.substring(hash.lastIndexOf("/")+1);
      //     // set topic
      //     if (topic !== self.topic) {
      //       moj.log(self.topic);
      //       // self._selectHelpTopic(topic);
      //     }
      //   }
      // });
    },

    _selectHelpTopic: function (topic) {
      var self = this;

      // if the overlay is present, set topic immediately
      if($('#popup.help-system').length > 0){
        self._setTopic(topic);
        // set topic to global obj
        self.topic = topic;
      } else {
      // otherwise, load in the overlay first and set in callback
        this._loadOverlay(function(){
          self._setTopic(topic);
          // set topic to global obj
          self.topic = topic;
        });
      }
    },

    _setTopic: function (slug) {
      // moj.log("_setTopic");
      // make sure we're not resetting the hash and adding to the history if we don't need to
      if ('#/' + this.settings.guidancePath + '/' + slug !== window.location.hash){
        window.location.hash = '#/' + this.settings.guidancePath + '/' + slug;
        // history.pushState('', document.title, '#/' + this.settings.guidancePath + '/' + slug);
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

    _loadOverlay: function (ajaxCallback) {
      var lightBox;
      // localStorage.removeItem("guidanceHTML");

      // check to see if browser supports localstorage & something exists
      if(html5_storage()) {
        if (localStorage["guidanceHTML"] != '') {
          lightBox = OPGPopup.popup(localStorage["guidanceHTML"], this.settings.overlayIdent, this.settings.overlaySource);
        } else {
          lightBox = OPGPopup.popup(this.loadingContent, this.settings.overlayIdent, this.settings.overlaySource);

          // load view into popup content with ajax
          $("#popup").find("*:nth-child(2)").load('/' + this.settings.guidancePath, function(response) {
            // store markup in localstorage once complete
            localStorage["guidanceHTML"] = response;
            // callback func
            if (ajaxCallback && typeof(ajaxCallback) === "function") {
              ajaxCallback();
            }
          });
        }
      } else {
        if($('#help-placeholder').length > 0) {
          moj.log("present");
        } else {
          // moj.log("loading...");
          lightBox = OPGPopup.popup(this.loadingContent, this.settings.overlayIdent, this.settings.overlaySource);

          // load view into popup content with ajax
          $("#popup-content").load('/' + this.settings.guidancePath, function(response) {
            // moj.log("loaded");
            // callback func
            if (ajaxCallback && typeof(ajaxCallback) === "function") {
              ajaxCallback();
            }
          });
        }
      }



      // // TODO: Have alternative 'cached' fallback for non-localstorage (maybe insert div into DOM)
      // if (html5_storage() && typeof localStorage["guidanceHTML"] != 'undefined' && localStorage["guidanceHTML"] != '') {
      //   lightBox = OPGPopup.popup(localStorage["guidanceHTML"], "help-system", $(this));
      //   // callback func
      //   if (callback && typeof(callback) === "function") {
      //     callback();
      //   }
      // } else {
      //   // load lightbox with loading message
      //   lightBox = OPGPopup.popup(this.loadingContent, "help-system", $(this));

      //   if(){

      //   }

      //   // load view into popup content with ajax
      //   $("#popup").find("*:nth-child(2)").load('/' + this.settings.guidancePath, function(response) {
      //     // store markup in localstorage once complete
      //     if (html5_storage()){
      //       localStorage["guidanceHTML"] = response;
      //     }
      //     // callback func
      //     if (callback && typeof(callback) === "function") {
      //       callback();
      //     }
      //   });
      // }
    }
  };

  // Add module to MOJ namespace
  lpa.Modules.helpSystem = {
    init: function () {
      moj.log("lpa.Modules.helpSystem#init");
      new HelpSystem();
    }
  };
}());