# webServer.nim

include karax/prelude   # brings in buildHtml, tdiv, h3, ul, li, setRenderer, etc.
import dom              # for JS interop via importjs
import strutils         # for string.split

var points: seq[(float, float)] = @[]  # store clicked points

proc setupMap() {.importjs: """
  setTimeout(function() {
    var map = L.map('map').setView([51.505, -0.09], 13);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {maxZoom: 19}).addTo(map);
    map.on('click', function(e) {
      L.marker([e.latlng.lat, e.latlng.lng]).addTo(map);
      __karax_callback__("mapClicked", e.latlng.lat + "," + e.latlng.lng);
    });
  }, 100);
""".}

proc render(): VNode =
  result = buildHtml(tdiv):
    tdiv(id = "map")
    h3: text "Points Clicked:"
    ul:
      for lat, lon in points:
        li: text "(" & $lat & ", " & $lon & ")"
  setupMap()

proc mapClicked(data: cstring) {.exportc.} =
  # convert cstring → Nim string, then split on the string ","
  let parts = ($data).split(",")
  if parts.len == 2:
    points.add((parseFloat(parts[0]), parseFloat(parts[1])))
    setRenderer(render, "karaxContainer")  # re‑render with the new point

proc main() =
  setRenderer(render, "karaxContainer")

main()
