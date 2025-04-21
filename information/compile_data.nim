import std/[dirs, paths, files, httpclient]
from settings import dataDir, dataFile, dataUrl, treeFile
import process_data/[construct_tree, parse_csv]

proc downloadData() =
  discard existsOrCreateDir(dataDir.Path)

  if not fileExists(dataFile.Path):
    var client = newHttpClient()
    try:
      client.downloadFile(dataUrl, $dataFile)
    finally:
      client.close()

proc saveTree() =
  discard existsOrCreateDir(dataDir.Path)
    
  if not fileExists(treeFile.Path):
    saveTree(constructTree(getLocationPoints(dataFile)), treeFile)

when isMainModule:
  when defined(download):
    downloadData()

  when defined(save_tree):
    saveTree()
    
