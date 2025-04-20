import std/[dirs, paths, files, httpclient]

const
  dataDir = "data".Path
  dataFileName = "NTAD_Stops".Path
  dataUrl = "https://github.com/Accommodus/NearestTransit/releases/download/data/NTAD_National_Transit_Map_Stops_6633473857343365838.csv"

let 
  dataFile = dataDir / dataFileName


proc downloadData() =
  discard existsOrCreateDir(dataDir)

  if not fileExists(dataFile):
    var client = newHttpClient()
    try:
      client.downloadFile(dataUrl, $dataFile)
    finally:
      client.close()

when isMainModule:
    downloadData()
    