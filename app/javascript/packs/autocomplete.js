$(document).on('turbolinks:load', function () {
  function initializeAutocomplete(id) {
    let element = document.getElementById(id);
    if (element) {
      let autocomplete = new google.maps.places.Autocomplete(element, { types: ['geocode'] });
      google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
    }
  }

  function onPlaceChanged() {
    let place = this.getPlace();

    // console.log(place);  // Uncomment this line to view the full object returned by Google API.     

    for (let i in place.address_components) {
      let component = place.address_components[i];
      for (let j in component.types) {  // Some types are ["country", "political"]
        let type_element = document.getElementById(component.types[j]);
        if (type_element) {
          type_element.value = component.short_name;
        }
      }
    }
  }
  google.maps.event.addDomListener(window, 'load', function () {
    initializeAutocomplete('autocomplete_address');
  });
}); 

// cityを空にする
// document.getElementById('autocomplete_address').value = "";



//let country = document.getElementById('country');
//let locality = document.getElementById('locality');
//let latitude = document.getElementById('latitude');
//let longitude = document.getElementById('longitude');
//
//country.value = place.address_components[2].short_name;
//locality.value = place.address_components[0].long_name;

// if (latitude) {
//   latitude.value = place.geometry.location.lat();
// };
// if (longitude) {
//   longitude.value = place.geometry.location.lng();
// };
