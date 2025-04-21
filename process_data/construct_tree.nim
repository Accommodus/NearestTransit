import kdtree
import ../information/types
import std/[tables, marshal, syncio]
from ../information/settings import treeFile


proc constructTree*(table: Table[Coord, tranSeq]): tranTree =
  ## Constructs a KdTree from a table of coordinates and their associated TransitPoints.
  ## Time complexity: O(n log n) where n is the number of items in the dataset.

  var holder: seq[(Coord, tranSeq)]
  for k, v in table.pairs: # O(n)
    let rad_k = k.asRad()
    holder.add((rad_k, v))

  result = newKdTree[tranSeq](holder, haversineDist) # O(n log n)

proc saveTree*(tree: tranTree, filePath: string) =
  ## Saves the KdTree to a file using marshal.

  writeFile(filePath, $$tree)

proc getTree*(): tranTree =
  ## Loads the KdTree from a file using marshal.
  
  let data = readFile(treeFile) # have tried to avoid using hardcoded file paths outside of protected sections, but this is much cleaner
  return to[tranTree](data)