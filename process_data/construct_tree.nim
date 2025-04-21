import kdtree
import defs
import std/[tables, marshal, syncio]
from ../settings import treeFile


proc constructTree*(table: Table[Coord, seq[TransitPoint]]): KdTree[seq[TransitPoint]] =
  ## Constructs a KdTree from a table of coordinates and their associated TransitPoints.
  ## Time complexity: O(n log n) where n is the number of items in the dataset.

  var holder: seq[(Coord, seq[TransitPoint])]
  for k, v in table.pairs: # O(n)
    let rad_k = k.asRad()
    holder.add((rad_k, v))

  result = newKdTree[seq[TransitPoint]](holder, haversineDist) # O(n log n)

proc saveTree*(tree: KdTree[seq[TransitPoint]], filePath: string) =
  ## Saves the KdTree to a file using marshal.

  writeFile(filePath, $$tree)

proc getTree*(): KdTree[seq[TransitPoint]] =
  ## Loads the KdTree from a file using marshal.
  
  let data = readFile(treeFile) # have tried to avoid using hardcoded file paths outside of protected sections, but this is much cleaner
  return to[KdTree[seq[TransitPoint]]](data)