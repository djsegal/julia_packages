import autocomplete from 'js-autocomplete';

const renderPackageItem = function (item) {
  if ( item.url.includes("/packages?search=") ) {
    return `<div class="border-t border-gray-100"></div>
    <div class="py-1">
      <a href="${item.url}" class="block px-4 py-2 text-sm leading-5 text-gray-700 hover:bg-gray-100 hover:text-gray-900 focus:outline-none focus:bg-gray-100 focus:text-gray-900">${item.name}</a>
    </div>`
  } else {
    return `<div class="autocomplete-suggestion py-1">
      <a href="${item.url}" class="block px-4 py-2 text-sm leading-5 text-gray-700 hover:bg-gray-100 hover:text-gray-900 focus:outline-none focus:bg-gray-100 focus:text-gray-900">${item.name}</a>
    </div>`
  }
};

const autocompletePackageSearch = function() {
  const searchInput = document.getElementById('search');

  if (searchInput) {
    new autocomplete({
      selector: searchInput,
      minChars: 3,
      source: function(term, suggest){
        var curForm = searchInput.closest("form");
        var initParams = {};

        $(curForm).children("input:not(#" + searchInput.id + ")").each(function (curIndex, curInput) {
          if ( curInput.type == "hidden" ) {
            initParams[curInput.name] = curInput.value;
          }
        })

        $.getJSON('/packages.json',
          Object.assign({ search: term }, initParams),
          function(data) {
            return data;
        }).then((data) => {
          const matches = []

          var maxCount = 6;
          data.slice(0, maxCount).forEach((item) => {
            matches.push({name: item.name, url: item.url});
          });
          if ( data.length > maxCount ) {
            matches.push({name: "View All", url: '/packages?search=' + term})
          }
          suggest(matches)
        });
      },
      renderItem: renderPackageItem,
      cache: false,
      onSelect: function(e, term, item){
        e.preventDefault();
        item.firstElementChild.click();
      },
      menuClass: "mt-2 rounded-md bg-white shadow border border-gray-300"
    });
  }
};

export { autocompletePackageSearch };
