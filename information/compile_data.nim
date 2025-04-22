import std/[dirs, paths, files, httpclient]
from settings import dataDir, dataFile, dataUrl, treeFile
import ../process_data/[save_tree]

#[
proc saveTree() =
    discard existsOrCreateDir(dataDir.Path)
      
    if not fileExists(treeFile.Path):
      saveTree(constructTree(getLocationPoints(dataFile)), treeFile)
]#

when defined(download):
  discard existsOrCreateDir(dataDir.Path)

  if not fileExists(dataFile.Path):
    var client = newHttpClient()
    try:
      client.downloadFile(dataUrl, $dataFile)
    finally:
      client.close()

  #discard when defined(save_tree):
  # saveTree()
    
