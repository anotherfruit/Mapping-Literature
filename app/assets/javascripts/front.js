// This is a manifest file for the front subsite (which is your whole
// application if you don't have any subsites).  It will be compiled
// into including all the files listed below.  Add new
// JavaScript/Coffee code in separate files in the front directory and
// they'll automatically be included in the compiled file accessible
// from http://example.com/assets/front.js It's not advisable to add
// code directly here, but if you do, it'll appear at the bottom of
// the the compiled file.
//
//= require application
jQuery.fn.ui_button = jQuery.fn.button;
//= require bootstrap-all
jQuery.fn.bootstrap_button = jQuery.fn.button;
if(jQuery.fn.ui_button) jQuery.fn.button = jQuery.fn.ui_button;
//= require timemap/timemap
//= require timemap/param
//= require timemap/loaders/xml
//= require timemap/loaders/georss
//= require hobo_mapstraction
//= require_tree ./front

// $(document).ready(function(){
//     initialize();
//     });
