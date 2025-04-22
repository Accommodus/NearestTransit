import ../sort/[sortDistance, heapMin]
import ../process_data/parse_csv
import ../information/types
from ../information/settings import dataFile

let filename = dataFile
let table = getLocationPoints(filename)

let position: Coord = [37.7749, -122.4194]  # Example: Coordinates for San Francisco

# Test QuickSort-based KNN
let sortedQuick = sortDistanceQuick(table, position)
let k = 10  # Number of nearest neighbors
let knnQ = knnQuick(sortedQuick, k)
echo "KNN using QuickSort: ", knnQ

# Test Heap-based KNN
var heapSorted = sortDistanceHeap(table, position)
var heapSortedCheck = sortDistanceHeap(table, position)
let knnH = knnHeap(heapSorted, k)
echo "KNN using Heap: ", knnH

if knnH == knnQ:
  echo "Matching KNN values"


echo "\nVerifying sorted order for Heap using extractMin:"
var heapSortedExtracted: seq[(float, Coord)] = @[]
while heapSortedCheck.arr.len > 0:
  heapSortedExtracted.add(heapSortedCheck.extractMin())

var isHeapSortedCorrect = true
for i in 1..<heapSortedExtracted.len:
  if heapSortedExtracted[i-1][0] > heapSortedExtracted[i][0]:
    isHeapSortedCorrect = false
    echo "Heap is not sorted at index ", i, ": ", heapSortedExtracted[i-1], " > ", heapSortedExtracted[i]
    break
if isHeapSortedCorrect:
  echo "Heap is sorted correctly!"

echo "\nVerifying sorted order for QuickSort:"
var isQuickSortedCorrect = true
for i in 1..<sortedQuick.len:
  if sortedQuick[i-1][0] > sortedQuick[i][0]:
    isQuickSortedCorrect = false
    echo "QuickSort is not sorted at index ", i, ": ", sortedQuick[i-1], " > ", sortedQuick[i]
    break

if isQuickSortedCorrect:
  echo "QuickSort is sorted correctly!"