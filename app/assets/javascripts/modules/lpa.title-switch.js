// Title Switch module for LPA
// Dependencies: moj, _, jQuery

(function () {
  'use strict';

  moj.Modules.TitleSwitch = {
    selector: '.js-TitleSwitch',

    options: {
      'choose': '',
      'Mr': 'Mr',
      'Mrs': 'Mrs',
      'Miss': 'Miss',
      'Ms': 'Ms',
      'Dr': 'Dr',
      'Other': 'Other'
    },

    init: function () {
      // bind 'this' as this in following methods
      _.bindAll(this, 'render', 'selectChanged', 'switchTitle');
      this.bindEvents();
    },

    bindEvents: function () {
      $('body').on('change.moj.Modules.TitleSwitch', '.js-TitleSwitch-select', this.selectChanged);
      // default moj render event
      moj.Events.on('render', this.render);
      // custom render event
      moj.Events.on('TitleSwitch.render', this.render);
    },

    render: function (e, params) {
      var wrap = params !== undefined && params.wrap !== undefined ? params.wrap : 'body';
      $(this.selector, wrap).each(this.switchTitle);
    },

    switchTitle: function (i, el) {
      var $text = $(el),
          value = $text.val(),
          $select;

      // if the current value is not one of our options
      // or if element has already been replaced
      if (!_.contains(this.options, value) || $text.data('moj.TitleSwitch') !== undefined) {
        return;
      }
      // build select box
      $select = $('<select>', {
        'id': $text.attr('id') + '__select',
        'name': $text.attr('id') + '__select',
        'class': 'js-TitleSwitch-select'
      });
      // add options
      $.each(this.options, function (name, value) {
        $select.append($('<option>', { value: value }).text(name));
      });
      // check if current value matches an option
      if (_.contains(this.options, value)) {
        $text.hide();
        $select.val(value);
      }
      // add select box after element
      $text.data('moj.TitleSwitch', true).after($select);
    },

    selectChanged: function (e) {
      var $select = $(e.target),
          $text = $select.prev(),
          value = $select.val();

      if (value === 'Other') {
        $text.val('').show().focus();
        $select.remove();
      } else {
        $text.val(value);
      }
    }
  };

})();