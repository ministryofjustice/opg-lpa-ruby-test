// require turbolinks

//===== Bower packages - /vendor/assets/components/ =====\\
//= require jquery
//= require jquery-ujs
//= require parsleyjs/parsley
//= require handlebars

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
//= require modules/lpa.dialog.js
//= require modules/lpa.popup.js
//= require modules/lpa.help-system.js
//= require modules/lpa.form-popup.js
//= require modules/lpa.use-details.js
//= require modules/lpa.form.js
//= require modules/lpa.poller.js

//===== Existing app plugins and js - /app/assets/javascripts/ =====\\
//= require_tree ./jquery-plugin/opg
//= require form
//= require date-picker
//= require pwstrength

$( moj.init );