(function () {
  'use strict';

  // test for html5 storage
  moj.Helpers.hasHtml5Storage = function() {
    try {
      return 'sessionStorage' in window && window.sessionStorage !== null;
    } catch (e) {
      return false;
    }
  };
}());