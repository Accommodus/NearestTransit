import std/[dirs, paths, files, httpclient]
from settings import dataDir, dataFile, dataUrl

proc downloadData() =
  discard existsOrCreateDir(dataDir.Path)

  if not fileExists(dataFile.Path):
    var client = newHttpClient()
    try:
      client.downloadFile(dataUrl, $dataFile)
    finally:
      client.close()

when isMainModule:
    downloadData()
    