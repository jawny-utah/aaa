// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
//= xxxrequire("turbolinks").start()
require("jquery")
require("@rails/activestorage").start()
require("channels")

//= require jquery3
//= require popper
//= require bootstrap-sprockets
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
window.addEventListener("load", function(){
  jQuery('option').mousedown(function(e) {
    e.preventDefault();
    jQuery(this).toggleClass('selected');
    jQuery(this).prop('selected', !jQuery(this).prop('selected'));
    return false;
  });
});
