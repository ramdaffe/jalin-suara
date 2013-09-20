$ = jQuery

$ ->
  map = L.map('map').setView([6.1750, 106.8283], 5)

  cloudmade_api = $("#map").data("cloudmadekey")
  L.tileLayer("http://{s}.tile.cloudmade.com/#{cloudmade_api}/997/256/{z}/{x}/{y}.png", {
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
      maxZoom: 18
  }).addTo(map)
  markers = new L.MarkerClusterGroup()
  for post in $('#posts').data('url')
    lat = post.latitude
    lon = post.longitude
    title = post.title
    marker = L.marker([lat, lon])
    marker.bindPopup("<b>#{title}</b>")
    markers.addLayer(marker)
  map.addLayer(markers)