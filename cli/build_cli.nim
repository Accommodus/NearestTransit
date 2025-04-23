include ../information/settings
const treeData = staticRead(treeFileRelative)

import strutils, os
import ../sort/[compare_algs, quick_sort, heap_min]
import ../process_data/construct_tree
import ../information/types

let
    lat = parseFloat(paramStr(1))
    lon = parseFloat(paramStr(2))
    k = parseInt(paramStr(3))
var
    tree = loadTreeJsonStr[TranSeq](treeData)
let
    coord = newCoord(0,0)
    sortPoint = newCoord(lat, lon)
    durations = KNNSort(tree, coord, k, sortPoint, [quickSortEntry[DistData], heapSort[DistData]])

echo "QuickSort took: ", durations[0][0]
echo "HeapSort took: ", durations[0][1]
