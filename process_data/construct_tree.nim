import kdtree
import defs
import std/[tables]

proc constructTree*(table: Table[Coord, seq[TransitPoint]]): KdTree[seq[TransitPoint]] =
  ## Constructs a KdTree from a table of coordinates and their associated TransitPoints.
  ## Time complexity: O(n log n) where n is the number of items in the dataset.

  var holder: seq[(Coord, seq[TransitPoint])]
  for k, v in table.pairs: # O(n)
    let rad_k = k.asRad()
    holder.add((rad_k, v))

  result = newKdTree[seq[TransitPoint]](holder, haversineDist) # O(n log n)