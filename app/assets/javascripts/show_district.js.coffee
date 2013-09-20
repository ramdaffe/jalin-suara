$ = jQuery

$ ->
  map = L.map('map').setView([6.1750, 106.8283], 5)

  cloudmade_api = $("#map").data("cloudmadekey")
  L.tileLayer("http://{s}.tile.cloudmade.com/#{cloudmade_api}/997/256/{z}/{x}/{y}.png", {
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
      maxZoom: 18
  }).addTo(map)
  bounds = new Array()
  markers = new L.MarkerClusterGroup()
  i = 0
  for activity in $('#activities').data('url')
    lat = activity.latitude
    lon = activity.longitude
    name = activity.name
    marker = L.marker([lat, lon])
    marker.bindPopup("<b>#{name}</b>")
    markers.addLayer(marker)
    bounds[i] = [lat, lon]
    i = i + 1
  map.addLayer(markers)
  map.fitBounds(bounds)