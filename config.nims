import std/[dirs, files, httpclient]

const
  dataDir  = "data"
  dataUrl = "https://stg-arcgisazurecdataprod.az.arcgis.com/exportfiles-273-8769/NTAD_National_Transit_Map_Stops_-7235353874239529355.geojson?sv=2018-03-28&sr=b&sig=pAm8DsxbSmgT9fHhDhuA2lyuH9UUTjxrGgiZi3CMJCM%3D&se=2025-04-20T02%3A33%3A45Z&sp=r"

proc download_data() =
  let dataFile = dataDir & "/NTAD_Stops.geojson"
  existsOrCreateDir(dataDir)

  if not fileExists(stopsFile):
    var client = newHttpClient()
    try:
      let fileContent = client.getContent(dataUrl)
    finally:
      client.close()

task build, "Compiles project to JS":
  download_data()
  setCommand "js"