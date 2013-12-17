/*jslint browser: true, evil: false, plusplus: true, white: true, indent: 2 */
/*global $ */

(function(){
  'use strict';

  // Define the class
  var Poller = function (options) {
    // moj.log('test');
    this.settings = $.extend({}, this.defaults, options);
  };

  Poller.prototype = {
    // number of failed requests
    failed: 0,

    // number of successful requests
    attempted: 0,

    // default timeout variable
    timeout: null,

    // default settings
    defaults: {
      interval: 2000, // starting interval - 2 seconds
      dataType: 'json',
      ajaxTimeout: 5000,
      maxAttempts: 10,
      onMaxAttempts: null,
      maxFails: 5,
      onMaxFails: null
    },

    // kicks off the setTimeout
    init: function(){
      this.timeout = setTimeout(
        $.proxy(this.getData, this), // ensures 'this' is the poller obj inside getData, not the window object
        this.settings.interval
      );
    },

    // get AJAX data + respond to it
    getData: function(){
      var self = this;

      $.ajax({
        url: this.settings.url,
        data: this.settings.data,
        dataType: this.settings.dataType,
        timeout: this.settings.ajaxTimeout,
        cache: false,
        context: this, // make sure context within callbacks is this obj
        // async: false,

        success: function(response){
          // if correct response
          if(response.pdfURL){
            // clear out setTimeout
            this.timeout = null;
            // redirect to PDF
            window.location = response.pdfURL;
          } else if (++this.attempted < this.settings.maxAttempts) {
            // recurse if not ready
            this.init(self.settings);
          } else {
            // clear out setTimeout
            this.timeout = null;
            // if too many attempts, run callback func
            if (this.settings.onMaxAttempts && typeof(this.settings.onMaxAttempts) === 'function') {
              this.settings.onMaxAttempts();
            }
          }
        },
        error: this.errorHandler
      });
    },

    // handle errors
    errorHandler: function(){
      if(++this.failed < this.settings.maxFails){
        // increase interval to give breathing room
        this.settings.interval += 250;
        // recurse
        this.init(this.settings);
      } else {
        // clear out setTimeout
        this.timeout = null;
        // if too many fails, run callback func
        if (this.settings.onMaxFails && typeof(this.settings.onMaxFails) === 'function') {
          this.settings.onMaxFails();
        }
      }
    }
  };

  window.Poller = Poller;
})();
