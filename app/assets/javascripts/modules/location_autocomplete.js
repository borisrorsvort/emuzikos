LocationAutocomplete = {
  init: function(initplaceholder) {
    function locationFormatResult(location) {
      return location.name + ", " + location.countryName;
    }
    function locationFormatSelection(location) {
      return location.name + ", " + location.countryName;
    }

    LocationAutocomplete.placeholder = initplaceholder;

    $('#zip_autocomplete').select2({
      id: function(e) { return e.name + ', ' + e.countryName},
      width: '100%',
      placeholder: LocationAutocomplete.placeholder,
      minimumInputLength: 4,
      ajax: {
        url: 'http://ws.geonames.org/searchJSON',
        dataType: 'jsonp',
        data: function (term) {
          return {
            featureClass: "P",
            style: "medium",
            isNameRequired: "true",
            q: term
          };
        },
        results: function (data) {
          return {
            results: data.geonames
          };
        }
      },
      initSelection : function (element, callback) {
        var elValArray = element.val().split(',');
        callback({'id': element.val(),"name": elValArray[0], 'countryName': elValArray[1]});
      },
      formatResult: locationFormatResult,
      formatSelection: locationFormatSelection,
      escapeMarkup: function (m) { return m; }
    });
  }
};
