var geocoder = new google.maps.Geocoder();
var map;

function geocodePosition(pos) {
  geocoder.geocode({
                       latLng: pos
                   }, function(responses) {
    if (responses && responses.length > 0) {
        updateMarkerAddress(responses[0].formatted_address);
    } else {
        updateMarkerAddress('Cannot determine address at this location.');
    }
    });
    }

    function updateMarkerStatus(str) {
      document.getElementById('markerStatus').innerHTML = str;
    }

    function updateMarkerPosition(latLng) {
      document.getElementById('info').innerHTML = [
          latLng.lat().toFixed(3),
          latLng.lng().toFixed(3)
      ].join(', ');
      document.getElementById('gpscoordset_lat').value = latLng.lat().toFixed(6);
      document.getElementById('gpscoordset_long').value = latLng.lng().toFixed(6);	
    }

    function updateMarkerAddress(str) {
      document.getElementById('address').innerHTML = str;

    }

    function initialize() {
      var myLatlng = new google.maps.LatLng(48.202, 16.368);
      var myOptions = {
          zoom: 13,
          center: myLatlng,
          mapTypeId: google.maps.MapTypeId.ROADMAP
      }
      map = new google.maps.Map(document.getElementById("mapCanvas"), myOptions);

      google.maps.event.addListenerOnce(map, 'click', function(event) {
        placeMarker(event.latLng);
      });



    }

    function placeMarker(location) {
      var marker = new google.maps.Marker({
                                              position: location,
                                              draggable:true,
                                              map: map
                                          });
      // Update current position info.
                                     updateMarkerPosition(location);
      geocodePosition(location);

      // Add dragging event listeners.
                                google.maps.event.addListener(marker, 'dragstart', function() {
        updateMarkerAddress('Dragging...');
      });

      google.maps.event.addListener(marker, 'drag', function() {
        updateMarkerStatus('Dragging...');
        updateMarkerPosition(marker.getPosition());
      });

      google.maps.event.addListener(marker, 'dragend', function() {
        updateMarkerStatus('Drag ended');
        geocodePosition(marker.getPosition());
      });
    }




    // Onload handler to fire off the app.