import ../information/types
import quickSort
import heapMin
import std/tables

proc cmp(a, b: (float, Coord)): int =
  if a[0] < b[0]: return -1
  elif a[0] > b[0]: return 1
  else: return 0


proc sortDistanceHeap*(table: Table[Coord, TranSeq], position: Coord): MinHeap[(float, Coord)] = 
    result = constructMinHeap[(float, Coord)]()
    for coord in table.keys:
        let dist = haversineDist(coord, position)
        result.insert((dist, coord))

proc sortDistanceQuick*(table: Table[Coord, TranSeq], position: Coord): seq[(float, Coord)] =
    result = @[]
    for coord in table.keys:
        result.add((haversineDist(coord, position), coord))
    quickSort(result, 0, result.high)

proc knnHeap*[T](heap: var MinHeap[T], k: int): seq[T] =
    result = @[]
    for i in 0..<min(k, heap.arr.len):
        result.add(heap.extractMin())

proc knnQuick*[T](arr: seq[T], k: int): seq[T] =
    result = @[]
    for i in 0..<min(k, arr.len):
        result.add(arr[i])
