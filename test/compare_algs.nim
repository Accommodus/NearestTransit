import ../sort/[quick_sort, heap_min, compare_algs]
import ../information/types
import ../process_data/construct_tree
from ../information/settings import treeFile
import std/random

const N = 10000
var inputList: seq[float] = @[]
var multList: seq[float] = @[]
for _ in 0..<N:
  let num = rand(100.0)
  let mult = rand(10)
  inputList.add(num)
  for i in 0..<mult:
    multList.add(num)

proc assertSortAlg(fn: proc(x: var openArray[float]) {.nimcall.}, iL: var openArray[float]) =
  fn(iL)
  let o = isSorted[float](iL)
  assert o, "properly sorted"

# verify that it can handle singles and duplicates
var l1 = inputList
var l2: seq[float]
for i in l1:
    l2.add(i)

var m1 = multList
var m2: seq[float]
for i in m1:
    m2.add(i)

assertSortAlg(quickSortEntry, l1)
assertSortAlg(quickSortEntry, m1)

assertSortAlg(heapSortEntry, l2)
assertSortAlg(heapSortEntry, m2)

let
  tree = loadTree[TranSeq](treeFile)
  cord = newCoord(0, 0)
  k = 5
  sortPoint = newCoord(0.15, 0.15)
  #algs = [quickSortEntry[DistData], heapSortEntry[DistData]]

#KNNSort(tree, cord, k, sortPoint, algs)