// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()

require("jquery")
require("jquery-ui")

require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import $ from 'jquery';
window.jQuery = $;
window.$ = $;

require("alpinejs")
import '../stylesheets/application.scss'

import '../javascripts/pagy.js.erb'

require("packs/monthpicker")

import { autocompleteSearch } from '../javascripts/autocomplete';
$(document).on("turbolinks:load", autocompleteSearch);

$(window).on("resize", function() {
  $(".autocomplete-suggestions").css("display", "none");
});

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
