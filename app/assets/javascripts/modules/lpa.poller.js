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
      firstInterval: 500,
      interval: 2000,
      ajaxDataType: 'json',
      ajaxTimeout: 5000,
      onSuccess: null,
      maxAttempts: 5,
      onMaxAttempts: null,
      maxFails: 5,
      onMaxFails: null
    },

    // kicks off the setTimeout
    init: function(){
      // use smaller interval for first poll
      this.newTimeout(this.settings.firstInterval);
    },

    // use this function with timeout for future polls
    newTimeout: function (interval) {
      this.timeout = setTimeout(
        $.proxy(this.getData, this), // ensures 'this' is the poller obj inside getData, not the window object
        interval
      );
    },

    // get AJAX data + respond to it
    getData: function(){
      moj.log(this.settings);

      $.ajax({
        url: this.settings.url,
        data: this.settings.data,
        dataType: this.settings.ajaxDataType,
        timeout: this.settings.ajaxTimeout,
        cache: false,
        context: this, // make sure context within callbacks is this obj
        success: function(response){
          // if correct response
          if(response.success === true){
            // clear out setTimeout
            this.timeout = null;
            // if successful, run callback
            if (this.settings.onSuccess && typeof(this.settings.onSuccess) === 'function') {
              this.settings.onSuccess(response);
            }
          } else if (++this.attempted < this.settings.maxAttempts) {
            // recurse if not ready
            this.newTimeout(this.settings.interval);
          } else {
            // clear out setTimeout
            this.timeout = null;
            // if too many attempts, run callback func
            if (this.settings.onMaxAttempts && typeof(this.settings.onMaxAttempts) === 'function') {
              this.settings.onMaxAttempts(response);
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
        this.newTimeout(this.settings.interval);
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