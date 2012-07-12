var map;
var markerList = {};

function initialize() {
  var myOptions = {
    zoom: 16,
    center: new google.maps.LatLng(42.367201, - 71.258851),
    disableDefaultUI: true,
    scaleControl: false,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    panControl: false,
    zoomControl: false,

  };
  map = new google.maps.Map(document.getElementById('map_canvas'),
  myOptions);
}

function update_positions(data) {
  //if marker exists, update its location, else create it
  var detectives = data.detectives;
  for (var i = 0; i < detectives.length; i++) {
    d = detectives[i];
    if (markerList.hasOwnProperty(d.user_id)) {
      moveMarker(markerList[d.user_id], d.latitude, d.longitude)
    } else {
      addMarker(d.latitude, d.longitude, d.user_id, d.name)
    }
  }
  var spy = data.spy;
  if (markerList.hasOwnProperty(spy.user_id)) {
    moveMarker(markerList[spy.user_id], spy.latitude, spy.longitude)
  } else {
    addMarker(spy.latitude, spy.longitude, spy.user_id, spy.name, true)
  }
}

function moveMarker(marker, lat, long) {
  marker.setPosition(new google.maps.LatLng(lat, long));
};

function addMarker(lat, long, id, name, is_spy) {
  var pinColor = is_spy ? "FF0000" : "00FFFF";
  var pinImage = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|" + pinColor,
  new google.maps.Size(21, 34),
  new google.maps.Point(0, 0),
  new google.maps.Point(10, 34));
  var pinShadow = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_shadow",
  new google.maps.Size(40, 37),
  new google.maps.Point(0, 0),
  new google.maps.Point(12, 35));
  var marker = new google.maps.Marker({
    position: new google.maps.LatLng(lat, long),
    map: map,
    title: name,
    icon: pinImage,
    shadow: pinShadow
  });
  markerList[id] = marker
  //DROP MARKER INFOWINDOW
  var latlng = new google.maps.LatLng(lat, long);
  google.maps.event.addListener(marker, 'click', function () {
    infowindow.open(map, this);
    marker = this
  });
  var infowindow = new google.maps.InfoWindow({
    content: name
  });
  //CLOSING MARKER INFOWINDOW
  google.maps.event.addListener(infowindow, 'closeclick', function () {
    infowindow.close(map, this); //removes the marker
  });
}
