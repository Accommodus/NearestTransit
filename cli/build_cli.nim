include ../information/settings
import strutils, os
import ../sort/[compare_algs, quick_sort, heap_min]
import ../process_data/construct_tree
import ../information/types

when isMainModule:
  const treeData = staticRead(treeFileRelative)
  var tree = loadTreeJsonStr[TranSeq](treeData)

  while true:
    echo "\nEnter latitude (or 'exit' to quit): "
    let latInput = readLine(stdin)
    if latInput.strip.toLowerAscii == "exit":
      break

    echo "Enter longitude: "
    let lonInput = readLine(stdin)
    echo "Enter k: "
    let kInput = readLine(stdin)

    try:
      let
        lat = parseFloat(latInput)
        lon = parseFloat(lonInput)
        k = parseInt(kInput)

        coord = newCoord(0, 0)
        sortPoint = newCoord(lat, lon)
        durations = KNNSort(tree, sortPoint, k, coord, [quickSortEntry[DistData], heapSort[DistData]])

      echo "QuickSort took: ", durations[0][0]
      echo "HeapSort took: ", durations[0][1]

      echo "Closest ", k, " Stops: "
      for disData in durations[1]:
        echo "  Distance: ", disData.distance, "  Coords: ", disData.coord
        for stop in disData.data:
            echo "      Name: ", stop.stop_name
    except ValueError:
      echo "Invalid input. Please try again."

  echo "Exited program."
