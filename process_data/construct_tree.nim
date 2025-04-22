import ../information/types
import std/[tables, marshal, syncio]
import save_tree

proc constructTree*[T](table: Table[Coord, T]): KdTree[T] =
  ## Constructs a KdTree from a table of coordinates and their associated TransitPoints.
  ## Time complexity: O(n log n) where n is the number of items in the dataset.

  var holder: seq[(Coord, T)]
  for k, v in table.pairs: # O(n)
    let rad_k = k.asRad()
    holder.add((rad_k, v))

  result = newKdTree[T](holder, haversineDist) # O(n log n)

proc storeTree*[T](tree: KdTree[T], file: string) =
  let s = toStatic(tree)

  let data = $$s
  file.writeFile(data)

proc loadTree*[T](file: string): KdTree[T] =
  let data = readFile(file)
  
  let s = to[StaticKdTree[T]](data)
  return toDynamic(s)