/**
 * Radios with Conditional Content plugin
 *
 * @copyright MOJ Digital Services Division
 * @author Dom Smith <dom.smith@digital.justice.gov.uk>
 */

;(function ($, window, document, undefined) {

  // Create the defaults once
  var pluginName = 'conditionalContent',
      defaults = {};

  // The actual plugin constructor
  function Plugin(element, options) {
    // Merge options with defaults
    this.options = $.extend({}, defaults, options);

    // Cache vars
    this.$el = $(element);
    this.elName = this.$el.attr('name');

    // kick off plugin
    this.init();
  }

  Plugin.prototype = {
    init: function() {
      // hide element initially
      $('[id^="toggle-' + this.elName + '"]').hide();
      // attach change event and trigger to see if an option should already be visible
      this.$el.change($.proxy(this.elChanged, this)).change();
    },

    elChanged: function (e) {
      var $option = $(e.target);
      // hide all other elements
      $('[id^="toggle-' + this.elName + '"]').hide();

      if($option.is(':checked')){
        // attempt to show only one associated with this option
        $('[id="toggle-' + this.elName + '-' + $option.attr('id') + '"]').show();
      }
    }
  };

  // Plugin wrapper
  $.fn[pluginName] = function (options) {
    return this.each(function () {
      var data = $.data(this),
          plugin = 'plugin_' + pluginName;

      // add plugin to element
      if (!data[plugin]) {
        $.data(this, plugin, new Plugin(this, options));
      }
    });
  };

})(jQuery, window, document);