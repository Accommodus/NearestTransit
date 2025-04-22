import ../sort/[quick_sort, heap_min, compare_algs]
import ../information/types
import ../process_data/construct_tree
from ../information/settings import treeFile
import std/[random, os]

const N = 10000
var inputList: seq[float] = @[]
var multList: seq[float] = @[]
for _ in 0..<N:
  let num = rand(100.0)
  let mult = rand(10)
  inputList.add(num)
  for i in 0..<mult:
    multList.add(num)

proc assertSortAlg(fn: proc(x: var seq[float]) {.nimcall.}, iL: var seq[float]) =
  fn(iL)
  let o = true
  assert o, "properly sorted"

proc quickSeq(x: var seq[float]) =
  quickSortEntry(x)

# verify that it can handle singles and duplicates
var l1 = inputList
var l2: seq[float]
for i in l1: # deep copy so data is not changed
    l2.add(i)

var m1 = multList 
var m2: seq[float]
for i in m1:
    m2.add(i)

assertSortAlg(quickSeq, l1)
assertSortAlg(quickSeq, m1) 

assertSortAlg(heapSort, l2)
assertSortAlg(heapSort, m2)

let
  tree = loadTree[TranSeq](treeFile)
  cord = newCoord(0, 0)
  k = 5
  sortPoint = newCoord(0.15, 0.15)
  