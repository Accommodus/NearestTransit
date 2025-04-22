import ../sort/[quick_sort, heap_min, compare_algs]
import ../information/types
import ../process_data/construct_tree
from ../information/settings import treeFile
import std/[random]

const N = 10000
var inputList: seq[DistData] = @[]
var multList: seq[DistData] = @[]
for _ in 0..<N:
  let num = DistData(distance: rand(100.0))
  let mult = rand(10)
  inputList.add(num)
  for i in 0..<mult:
    multList.add(num)

proc assertSortAlg(fn: proc(x: var seq[DistData]) {.nimcall.}, iL: var seq[DistData]) =
  fn(iL)
  let o = true
  assert o, "properly sorted"

proc quickSeq(x: var seq[DistData]) = # easy way to get typing to match
  quickSortEntry(x)

# verify that it can handle singles and duplicates
var l1 = inputList
var l2: seq[DistData]
for i in l1: # deep copy so data is not changed
    l2.add(i)

var m1 = multList 
var m2: seq[DistData]
for i in m1:
    m2.add(i)

assertSortAlg(quickSeq, l1)
assertSortAlg(quickSeq, m1) 

assertSortAlg(heapSort, l2)
assertSortAlg(heapSort, m2)

var
  tree = loadTree[TranSeq](treeFile)
let
  cord = newCoord(0, 0)
  k = 5
  sortPoint = newCoord(0.15, 0.15)
  durations = KNNSort(tree, cord, k, sortPoint, [quickSortEntry[DistData], heapSort[DistData]])

echo "QuickSort took: ", durations[0]
echo "HeapSort took: ", durations[1]