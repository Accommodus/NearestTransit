import os
import jester, json, strutils

routes:
  get "/":
    resp readFile("public/map.html")

  post "/api/mapclick":
    let data = parseJson(request.body)
    let lat = data["lat"].fnum
    let lng = data["lng"].fnum
    echo "Map clicked at: ", lat, ", ", lng

    # You could store it in a DB or file here
    resp "Click received at: " & $lat & ", " & $lng

  get "/static/@filename":
    let filePath = "public/" & @"filename"
    if fileExists(filePath):
      resp readFile(filePath)
    else:
      resp Http404, "File not found"

runForever()
