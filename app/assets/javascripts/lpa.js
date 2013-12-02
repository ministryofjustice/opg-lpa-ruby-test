/*jslint browser: true, evil: false, plusplus: true, white: true, indent: 2 */
/*global $ */

(function (){
  "use strict";

  var lpa = {
    Modules: {},

    Utilities: {},

    Events: $({}),

    init: function(){
      var x;

      for( x in lpa.Modules ) {
        if(lpa.Modules.hasOwnProperty(x)){
          lpa.Modules[x].init();
        }
      }
    }
  };

  window.lpa = lpa;
}());

$(function () {
  lpa.init();
});
