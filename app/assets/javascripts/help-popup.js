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
          $(html).appendTo('#content').hide();

          // Remove the popup from the DOM
          $(this).remove();
        });
      });

      $(source).focus();

      // clear out any hash locations
      window.location = '';
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
    $popup.prepend($close).append(html).appendTo($mask);

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


var GOVUK = window.GOVUK || {};

GOVUK.helpPopup = {
  loadOverlay: function (callback) {
    var lightBox;
    localStorage.removeItem("guidanceHTML");

    // check to see if browser supports localstorage & something exists
    // TODO: Have alternative 'cached' fallback for non-localstorage (maybe insert div into DOM)
    if (html5_storage() && typeof localStorage["guidanceHTML"] != 'undefined' && localStorage["guidanceHTML"] != '') {
      lightBox = OPGPopup.popup(localStorage["guidanceHTML"], "help-system", $(this));
      // callback func
      if (callback && typeof(callback) === "function") {
        callback();
      }
    } else {
      // load lightbox with loading message
      // TODO: Use JS template rather than markup here...
      lightBox = OPGPopup.popup('<div id="pop-content"><p>Loading...</p></div>', "help-system", $(this));

      // load view into popup content with ajax
      $("#pop-content").load('/guidance', function(response) {
        // store markup in localstorage once complete
        if (html5_storage()){
          localStorage["guidanceHTML"] = response;
        }
        // callback func
        if (callback && typeof(callback) === "function") {
          callback();
        }
      });
    }
  },
  selectHelpTopic: function (topic) {
    var instObj = this;

    // if the overlay is present, set topic immediately
    if($('#popup.help-system').length > 0){
      instObj.setTopic(topic);
    } else {
    // otherwise, load in the overlay first and set in callback
      this.loadOverlay(function(){
        instObj.setTopic(topic);
      });
    }
  },
  setTopic: function (slug) {
    // set hash for current topic
    window.location.hash = '/guidance/' + slug;

    // Set nav item as active
    $('.help-navigation a[href="/guidance/#' + slug + '"]').parent()
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
  init : function () {
    var hash = window.location.hash,
        instObj = this;

    // nav click event
    $('body').on('click', 'a.js-guidance', function (e){
      var href = $(this).attr('href'),
          topic = href.substring(href.lastIndexOf("#")+1);
      // select topic
      instObj.selectHelpTopic(topic);
      return false;
    });

    if (hash !== '' && hash !== '#/') {
      // on page load parse hash
      topic = hash.replace('#/guidance/', '');
      // set topic
      this.selectHelpTopic(topic);
    }
  }
};

$(document).ready(function() {
  GOVUK.helpPopup.init();
});
