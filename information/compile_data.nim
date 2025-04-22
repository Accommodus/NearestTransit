import std/[dirs, paths, files, httpclient]
from settings import dataDir, dataFile, dataUrl, treeFile
import ../process_data/[save_tree, parse_csv, construct_tree]

when defined(download):
  discard existsOrCreateDir(dataDir.Path)

  if not fileExists(dataFile.Path):
    var client = newHttpClient()
    try:
      client.downloadFile(dataUrl, $dataFile)
    finally:
      client.close()

  else:
    echo "Data file already exists. Skipping Download."

when defined(save_tree):
  discard existsOrCreateDir(dataDir.Path)

  if not fileExists(treeFile.Path):
    var tree = constructTree(getLocationPoints(dataFile))
    saveTree(tree, treeFile)

  else:
    echo "Tree file already exists. Skipping tree construction."
    