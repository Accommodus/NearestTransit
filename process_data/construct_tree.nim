import kdtree as kd
import ../information/types
import std/[tables, marshal, syncio]
from ../information/settings import treeFile


proc constructTree*[T](table: Table[Coord, T]): kd.KdTree[T] =
  ## Constructs a KdTree from a table of coordinates and their associated TransitPoints.
  ## Time complexity: O(n log n) where n is the number of items in the dataset.

  var holder: seq[(Coord, T)]
  for k, v in table.pairs: # O(n)
    let rad_k = k.asRad()
    holder.add((rad_k, v))

  result = kd.newKdTree[T](holder, haversineDist) # O(n log n)
