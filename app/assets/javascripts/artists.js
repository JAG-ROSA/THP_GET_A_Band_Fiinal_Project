function showMoreFilters() {
  let dropdownButton = document.getElementById("headingOne");
  let i = 0;

  dropdownButton.addEventListener('click', function() {
    i += 1;
    if(i % 2 == 0) {
      document.getElementById("filter-icon").classList.add("fa-plus-square");
      document.getElementById("filter-icon").classList.remove("fa-minus-square");
      document.getElementById("more-filters").innerHTML = "Voir plus d'options de recherche";
    } else {
      document.getElementById("filter-icon").classList.remove("fa-plus-square");
      document.getElementById("filter-icon").classList.add("fa-minus-square");
      document.getElementById("more-filters").innerHTML = "Voir moins d'options de recherche";
    }
  });
};

function isDocumentReady() {
  if(document.getElementById("headingOne") != undefined) {
    showMoreFilters()
  };
};

document.addEventListener('DOMContentLoaded', isDocumentReady);
