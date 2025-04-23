include ../information/settings
import strutils, os
import ../sort/[compare_algs, quick_sort, heap_min]
import ../process_data/construct_tree
import ../information/types
import std/math

const treeData = staticRead(treeFileRelative)
var tree = loadTreeJsonStr[TranSeq](treeData)

proc printHelp() =
  echo """
  K-Nearest Neighbors (KNN) Search CLI
  ------------------------------------
  This program finds the k nearest stops to a given point and sorts them by distance to a reference point using QuickSort and HeapSort.

  Instructions:
  1. Enter the latitude and longitude (in degrees) for the point to search from.
  2. Enter the latitude and longitude (in degrees) for the reference point to sort distances.
  3. Enter the number 'k' for the number of nearest neighbors to retrieve.
  4. The program will display the nearest stops and the time each sorting algorithm took.

  Notes:
  - Positive latitude: Northern Hemisphere
  - Negative latitude: Southern Hemisphere
  - Positive longitude: Eastern Hemisphere
  - Negative longitude: Western Hemisphere

  Type 'exit' at any prompt to quit the program.
  """

while true:
  echo "\nEnter latitude for KNN search point (or 'exit' to quit): "
  let latInput = readLine(stdin)
  if latInput.strip.toLowerAscii == "exit":
    break

  echo "Enter longitude for KNN search point: "
  let lonInput = readLine(stdin)
  if lonInput.strip.toLowerAscii == "exit":
    break

  echo "Enter latitude for sorting reference point: "
  let sortLatInput = readLine(stdin)
  if sortLatInput.strip.toLowerAscii == "exit":
    break

  echo "Enter longitude for sorting reference point: "
  let sortLonInput = readLine(stdin)
  if sortLonInput.strip.toLowerAscii == "exit":
    break

  echo "Enter k (number of nearest neighbors): "
  let kInput = readLine(stdin)
  if kInput.strip.toLowerAscii == "exit":
    break

  if latInput.strip.toLowerAscii == "help" or lonInput.strip.toLowerAscii == "help" or
     sortLatInput.strip.toLowerAscii == "help" or sortLonInput.strip.toLowerAscii == "help" or
     kInput.strip.toLowerAscii == "help":
    printHelp()
    continue

  try:
    let
      lat = parseFloat(latInput)
      lon = parseFloat(lonInput)
      sortLat = parseFloat(sortLatInput)
      sortLon = parseFloat(sortLonInput)
      k = parseInt(kInput)

      latRad = degToRad(lat)
      lonRad = degToRad(lon)
      sortLatRad = degToRad(sortLat)
      sortLonRad = degToRad(sortLon)

      kPoint = newCoord(latRad, lonRad)
      sortPoint = newCoord(sortLatRad, sortLonRad)

      durations = KNNSort(tree, kPoint, k, sortPoint, [quickSortEntry[DistData], heapSort[DistData]])

    echo "QuickSort took: ", durations[0][0]
    echo "HeapSort took: ", durations[0][1]

    echo "Closest ", k, " Stops:"
    for disData in durations[1]:
      echo "  Distance: ", disData.distance, "  Coords (radians): ", disData.coord
      for stop in disData.data:
        echo "      Name: ", stop.stop_name
      let latDir = if disData.coord.lat >= 0: "North" else: "South"
      let lonDir = if disData.coord.lon >= 0: "East" else: "West"
      echo "      Direction: Latitude is ", latDir, ", Longitude is ", lonDir

  except ValueError:
    echo "Invalid input. Please try again."

echo "Exited program."