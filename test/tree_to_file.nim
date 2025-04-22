import ../process_data/[construct_tree, save_tree, parse_csv]
from ../information/settings import dataFile, treeFile
import ../information/types
import std/[paths, files]
import ../process_data/construct_tree as ct

let testFile = treeFile & ".test"
removeFile(testFile.Path)

var oriTree: KdTree[seq[TransitPoint]] = constructTree(getLocationPoints(dataFile))
storeTree(oriTree, testFile)
var newTree = loadTree[seq[TransitPoint]](testFile)
removeFile(testFile.Path)

assert oriTree.len == newTree.len

let testPoints = @[[0.0, 0.0], [5.0, 5.0], [10.0, 10.0]]

for p in testPoints:
  let (pt1, dat1, d1) = oriTree.nearestNeighbour(p)
  let (pt2, dat2, d2) = newTree.nearestNeighbour(p)

  assert pt1 == pt2, "Nearest point mismatch"
  assert dat1 == dat2, "Associated data mismatch"
  assert abs(d1 - d2) < 1e-6, "Distance mismatch"