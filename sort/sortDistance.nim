import ../information/types
import quickSort
import heapMin
import std/tables
import ../process_data/parse_csv

proc cmp(a, b: (float, Coord)): int =
  if a[0] < b[0]: return -1
  elif a[0] > b[0]: return 1
  else: return 0


proc sortDistanceHeap(table: Table[Coord, tranSeq], position: Coord): MinHeap[(float, Coord)] = 
    result = constructMinHeap[(float, Coord)]()
    for coord in table.keys:
        let dist = haversineDist(coord, position)
        result.insert((dist, coord))

proc sortDistanceQuick(table: Table[Coord, tranSeq], position: Coord): seq[(float, Coord)] =
    result = @[]
    for coord in table.keys:
        result.add((haversineDist(coord, position), coord))
    quickSort(result, 0, result.high)

proc knnHeap[T](heap: var MinHeap[T], k: int): seq[T] =
    result = @[]
    for i in 0..<min(k, heap.arr.len):
        result.add(heap.extractMin())

proc knnQuick[T](arr: seq[T], k: int): seq[T] =
    result = @[]
    for i in 0..<min(k, arr.len):
        result.add(arr[i])


when isMainModule:
    const filename = "../process_data/NTAD_National_Transit_Map_Stops_6633473857343365838 (2).csv"
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