// Popup module for LPA
// Dependencies: moj, jQuery

/*jshint unused: false */

(function () {
  'use strict';

  // Define the class
  var PostcodeLookup = function (el, options) {
    moj.log('pcode init');
    _.bindAll(this, 'searchClicked', 'toggleClicked', 'resultsChanged', 'postcodeSuccess', 'addressSuccess', 'populateFields');
    this.cacheEls(el);
    this.bindEvents();
    this.init();
  };

  PostcodeLookup.prototype = {
    settings: {
      //=================================
      // TODO: Replace with correct URLs
      //=================================
      postcodeSearchUrl: '/assets/test-data/postcode-data.json',
      addressSearchUrl: '/assets/test-data/address-data.json',
      // used to populate fields
      // key is the key name sent in response and value is name of app's field
      fieldMappings: {
        lineOne: 'address_line1',
        lineTwo: 'address_line2',
        lineThree: 'address_line3',
        lineFour: null,
        lineFive: null,
        city: 'town',
        county: 'county',
        postcode: 'post_code'
      }
    },

    cacheEls: function (wrap) {
      this.$wrap = wrap;
      this.$form = this.$wrap.closest('form');
      this.$postalFields = this.$wrap.find('.js-PostcodeLookup__postal-add');
      this.$dxFields = this.$wrap.find('.js-PostcodeLookup__dx-add');

      this.searchTpl = lpa.templates['postcodeLookup.search-field'];
      this.toggleTpl = lpa.templates['postcodeLookup.address-toggle'];
      this.resultTpl = lpa.templates['postcodeLookup.search-result'];
    },

    bindEvents: function () {
      this.$wrap.on('click.moj.Modules.PostcodeLookup', '.js-PostcodeLookup__search-btn', this.searchClicked);
      this.$wrap.on('click.moj.Modules.PostcodeLookup', '.js-PostcodeLookup__toggle-address', this.toggleClicked);
      this.$wrap.on('change.moj.Modules.PostcodeLookup', '.js-PostcodeLookup__search-results', this.resultsChanged);
    },

    init: function () {
      this.$postalFields.before(this.searchTpl() + this.toggleTpl()).addClass('hidden');
      this.$dxFields.addClass('hidden');
    },

    searchClicked: function (e) {
      var $el = $(e.target);

      // store the current query
      this.query = this.$wrap.find('.js-PostcodeLookup__query').val();

      if (!$el.hasClass('disabled')) {
        if (this.query !== '') {
          $el.spinner();
          this.findPostcode(this.query);
        } else {
          alert('Please enter a postcode');
        }
      }
      return false;
    },

    toggleClicked: function (e) {
      var $el = $(e.target);

      this.toggleAddressType($el.data('addressType'));
      return false;
    },

    resultsChanged: function (e) {
      var $el = $(e.target),
          val = $el.val();

      $el.spinner();
      this.findAddress(val);
    },

    findPostcode: function (query) {
      $.ajax({
        url: this.settings.postcodeSearchUrl,
        data: {postcode: query},
        dataType: 'json',
        timeout: 5000,
        cache: true,
        error: this.postcodeError,
        success: this.postcodeSuccess
      });
    },

    postcodeError: function (jqXHR, textStatus, errorThrown) {
      var errorText = 'There was a problem: ';

      this.$wrap.find('.js-PostcodeLookup__search-btn').spinner('off');

      if (textStatus === 'timeout') {
        errorText+= 'the service did not respond in the allotted time';
      } else {
        errorText+= errorThrown;
      }

      alert(errorText);
    },

    postcodeSuccess: function (response) {
      // not successful
      if (!response.success || response.addresses === null) {
        if (response.isPostcodeValid) {
          if (confirm('No addresses were found for the postcode ' + this.query + '.  Would you like to enter the address manually?')) {
            $('.address-hideable').show();
          }
        } else {
          alert('Please enter a valid UK postcode');
        }
      } else {
      // successful
        if (this.$wrap.find('.js-PostcodeLookup__search-results').length > 0) {
          this.$wrap.find('.js-PostcodeLookup__search-results').parent().replaceWith(this.resultTpl({results: response.addresses}));
        } else {
          this.$wrap.find('.js-PostcodeLookup__search').after(this.resultTpl({results: response.addresses}));
        }
        this.$wrap.find('.js-PostcodeLookup__search-results').focus();
      }
      this.$wrap.find('.js-PostcodeLookup__search-btn').spinner('off');
    },

    findAddress: function (query) {
      $.ajax({
        url: this.settings.addressSearchUrl,
        data: {addressid: $.trim(query)},
        dataType: 'json',
        timeout: 5000,
        cache: true,
        success: this.addressSuccess
      });
    },

    addressSuccess: function (response) {
      this.$wrap.find('.js-PostcodeLookup__search-results').spinner('off');

      this.populateFields(response);
    },

    populateFields: function (data) {
      _.each(this.settings.fieldMappings, function (value, key) {
        if (value !== null) {
          this.$wrap.find('[name*="' + value + '"]').val(data[key]);
        }
      }, this);
      this.toggleAddressType('postal');
      // remove result list
      this.$wrap.find('.js-PostcodeLookup__search-results').parent().remove();
    },

    toggleAddressType: function (show) {
      if (show === 'dx') {
        this.$dxFields.removeClass('hidden');
        this.$postalFields.addClass('hidden');
      } else {
        var $search = this.$wrap.find('.js-PostcodeLookup__query'),
            $pcode = this.$wrap.find('[name*="' + this.settings.fieldMappings.postcode + '"]');
        // popuplate postcode field
        if ($search.val() !== '' && $pcode.val() === '') {
          $pcode.val($search.val());
        }
        this.$postalFields.removeClass('hidden');
        this.$dxFields.addClass('hidden');
      }
      // toggle class
      this.$wrap.find('.js-PostcodeLookup__toggle-address').removeClass('text-style').filter('[data-address-type="' + show + '"]').addClass('text-style');
    }
  };

  // Add module to LPA namespace
  moj.Modules.PostcodeLookup = {
    init: function () {
      sessionStorage.clear();
      $('.js-PostcodeLookup').each(function () {
        if (!$(this).data('moj.PostcodeLookup')) {
          $(this).data('moj.PostcodeLookup', new PostcodeLookup($(this), $(this).data()));
        }
      });

      moj.Events.on('PostcodeLookup.render', this.render);
    },

    render: function (e, params) {
      $('.js-PostcodeLookup', params.wrap).each(function () {
        if (!$(this).data('moj.PostcodeLookup')) {
          $(this).data('moj.PostcodeLookup', new PostcodeLookup($(this), $(this).data()));
        }
      });
    }
  };
}());