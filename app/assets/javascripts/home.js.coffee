$ = jQuery

$ ->
  map = L.map('map').setView([6.1750, 106.8283], 5)

  cloudmade_api = $("#map").data("cloudmadekey")
  L.tileLayer("http://{s}.tile.cloudmade.com/#{cloudmade_api}/997/256/{z}/{x}/{y}.png", {
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
      maxZoom: 18
  }).addTo(map)
  // markers = new L.MarkerClusterGroup()
  for subdistrict in $(".subdistrict")
    $subdistrict = $(subdistrict)
    lat = $subdistrict.data("latitude")
    lon = $subdistrict.data("longitude")
    name = $subdistrict.data("name")
    // m = L.marker([lat, lon])
    // m.bindPopup("<b>#{name}</b><br>Subproyek:")
    marker = L.marker([lat, lon]).addTo(map)
    marker.bindPopup("<b>#{name}</b><br>#{details}")
  //   markers.addLayer(m)
  // map.addLayer(markers)