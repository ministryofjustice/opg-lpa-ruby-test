/**
 * Radios with Conditional Content plugin
 *
 * Usage:
 *
 *
 *
 * @copyright MOJ Digital Services Division
 * @author Dom Smith <dom.smith@digital.justice.gov.uk>
 */

(function ($) {
  'use strict';

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
    this.$elGroup = $('[name="' + this.elName + '"]');

    // kick off plugin
    this.init();
  }

  Plugin.prototype = {
    init: function() {
      // trigger initial change
      this.elChanged();
      // attach change event and trigger to see if an option should already be visible
      this.$elGroup.change($.proxy(this.elChanged, this));
    },

    elChanged: function () {
      // hide all associated content
      this.$elGroup.each(function () {
        $($(this).data('toggle-el')).hide();
      });
      // show currently selected content pair
      $(this.$elGroup.filter(':checked').data('toggle-el')).show();
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

})(jQuery);