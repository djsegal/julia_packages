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

require("packs/monthpicker")

import ahoy from "ahoy.js";

require("chartkick")

import { autocompletePackageSearch } from '../javascripts/autocomplete_packages.js';
import { autocompleteCategorySearch } from '../javascripts/autocomplete_categories.js';

$(document).on("turbolinks:load", function () {
  autocompletePackageSearch();
  autocompleteCategorySearch();
});


$(window).on("resize", function() {
  $(".autocomplete-suggestions").css("display", "none");
});

$(document).on("turbolinks:load", function () {
    const mainElement = document.querySelector('main');
    
    // Define scroll amounts and multipliers
    const baseScrollAmount = 50; // Scroll amount for up/down arrows
    const leftRightMultiplier = 2; // Left/right arrows scroll 2x the base amount
    const pageMultiplier = 5; // Page up/down scrolls 5x the base amount
    
    document.addEventListener('keydown', function(event) {
        let scrollAmount = 0; // Initialize scroll amount to 0

        switch (event.key) {
            case 'ArrowUp':
                // Scroll up by base amount
                scrollAmount = -baseScrollAmount;
                break;
            case 'ArrowDown':
                // Scroll down by base amount
                scrollAmount = baseScrollAmount;
                break;
            case 'ArrowLeft':
                // Scroll up by a larger amount (2x base amount)
                scrollAmount = -baseScrollAmount * leftRightMultiplier;
                break;
            case 'ArrowRight':
                // Scroll down by a larger amount (2x base amount)
                scrollAmount = baseScrollAmount * leftRightMultiplier;
                break;
            case 'PageUp':
                // Scroll up by an even larger amount (5x base amount)
                scrollAmount = -baseScrollAmount * pageMultiplier;
                break;
            case 'PageDown':
                // Scroll down by an even larger amount (5x base amount)
                scrollAmount = baseScrollAmount * pageMultiplier;
                break;
            case 'Home':
                // Scroll to the top
                mainElement.scrollTo(0, 0);
                return; // No need to scroll further
            case 'End':
                // Scroll to the bottom
                mainElement.scrollTo(0, mainElement.scrollHeight);
                return; // No need to scroll further
            default:
                // Ignore other keys
                return;
        }

        // Apply the calculated scroll amount
        mainElement.scrollBy(0, scrollAmount);
    });
});

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
