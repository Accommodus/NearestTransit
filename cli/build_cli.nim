import strutils, os
import ../sort/[compare_algs, quick_sort, heap_min]
import ../information/[settings, types]
from ../information/settings import treeFileRelative
import ../process_data/construct_tree

let
    lat = parseFloat(paramStr(1))
    lon = parseFloat(paramStr(2))
    k =parseInt(paramStr(3))
var
    tree = loadTree[TranSeq](treeFileRelative)
let
    coord = newCoord(0,0)
    sortPoint = newCoord(lat, lon)
    durations = KNNSort(tree, coord, k, sortPoint, [quickSortEntry[DistData], heapSort[DistData]])

echo "QuickSort took: ", durations[0]
echo "HeapSort took: ", durations[1]
