// require turbolinks

//===== Bower packages - /vendor/assets/components/ =====\\
//= require jquery
//= require jquery-ujs
//= require parsleyjs/parsley
//= require handlebars
//= require lodash

//===== Configs for Plugins =====\\
//= require config.parsley

//===== Vendor scripts - /vendor/assets/javascripts/ =====\\
//= require jquery.details
// require jquery.tools.min

//===== MOJ boilerplate object and modules - [moj_boilerplate] Gem =====\\
//= require moj

//===== LPA app object and modules - /app/assets/javascripts/ =====\\
//= require lpa.helpers
//= require lpa.templates
//= require modules/lpa.dialog
//= require modules/lpa.popup
//= require modules/lpa.help-system
//= require modules/lpa.form-popup
//= require modules/lpa.use-details
//= require modules/lpa.form
//= require modules/lpa.poller
//= require modules/lpa.validation
//= require modules/lpa.title-switch
//= require modules/lpa.conditional-forms.js

//===== Existing app plugins and js - /app/assets/javascripts/ =====\\
//= require_tree ./jquery-plugin/opg
//= require form
//= require date-picker
//= require pwstrength

$( moj.init );