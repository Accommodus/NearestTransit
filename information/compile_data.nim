import std/[dirs, paths, files, httpclient]
from settings import dataDir, dataFile, dataUrl, treeFile
import ../process_data/[static_tree, parse_csv, construct_tree]

block:
  when defined(download):
    let parentDir = Path(dataFile).parentDir
    discard existsOrCreateDir(parentDir)

    if not fileExists(dataFile.Path):
      var client = newHttpClient()
      try:
        client.downloadFile(dataUrl, $dataFile)
      finally:
        client.close()

    else:
      echo "Data file already exists. Skipping Download."

block:
  when defined(save_tree):
    let parentDir = Path(treeFile).parentDir
    discard existsOrCreateDir(parentDir)

    if not fileExists(treeFile.Path):
      var tree = constructTree(getLocationPoints(dataFile))
      storeTree(tree, treeFile)

    else:
      echo "Tree file already exists. Skipping tree construction."
    