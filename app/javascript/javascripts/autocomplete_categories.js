import autocomplete from 'js-autocomplete';

const renderCategoryItem = function (item) {
  return `<div class="autocomplete-suggestion py-1">
    <div class="block px-4 py-2 text-sm leading-5 text-gray-700 hover:bg-gray-100 hover:text-gray-900 focus:outline-none focus:bg-gray-100 focus:text-gray-900">${item}</div>
  </div>`
};

const autocompleteCategorySearch = function() {
  const searchInput = document.getElementById('js-category-search');

  if (searchInput) {
    var curChoices = $.merge(
      Object.keys(suggestionCategoryMap),
      Object.keys(suggestionSubCategoryMap)
    ).sort();

    new autocomplete({
      selector: searchInput,
      minChars: 2,
      source: function(curTerm, suggest){
        curTerm = curTerm.toLowerCase();

        var curMatches = [];
        for (var i=0; i<curChoices.length; i++) {
          var curChoice = curChoices[i];

          if (~curChoice.toLowerCase().indexOf(curTerm)) {
            curMatches.push(curChoice);
          }
        }

        suggest(curMatches);
      },
      onSelect: function(e, term, item){
        var itemText = item.textContent.trim();
        $(document).trigger("categorySearchClick", itemText);
        searchInput.value = itemText;
      },
      renderItem: renderCategoryItem,
      menuClass: "mt-2 rounded-md bg-white shadow border border-gray-300 cs-category-autocomplete js-category-autocomplete"
    });
  }
};

export { autocompleteCategorySearch };
