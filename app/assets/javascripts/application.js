// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require turbolinks

//===== Bower packages - /vendor/assets/components/ =====\\
//= require jquery
//= require mustache/mustache

//===== Vendor scripts - /vendor/assets/javascripts/ =====\\
//= require jquery.details
//= require jquery.tools.min

//===== MOJ boilerplate object and modules - [moj_boilerplate] Gem =====\\
//= require moj

//===== LPA app object and modules - /app/assets/javascripts/ =====\\
//= require lpa
//= require_tree ./modules

//===== Existing app plugins and js - /app/assets/javascripts/ =====\\
//= require_tree ./jquery-plugin/opg
//= require form
//= require date-picker
//= require help-popup
//= require pwstrength