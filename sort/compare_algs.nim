import ../information/types
import ../process_data/static_tree
import std/[monotimes, times]

#proc quickSortDistData*(inputArray: var seq[DistData]) =
  

proc KNNSort*(tree: var KdTree[TranSeq], kPoint: Coord, k: Natural, sortPoint: Coord, algs: openArray[sortAlgInPlace]): (seq[Duration], seq[DistData]) =

  var inputArray: seq[DistData]

  let nearestStops = tree.nearestNeighbours(kPoint, k)
  for i in nearestStops:
    let dd = DistData(
      distance: haversineDist(i[0], sortPoint),
      data: i[1],
      coord: i[0]
    )
    inputArray.add(dd)

  for a in 0..algs.high:
    if a == 0:
      result[1] = inputArray

    let alg = algs[a]

    var iCopy: seq[DistData] # deep copy so the array is not pre-sorted by ealier algs
    for i in inputArray:
      iCopy.add(i)

    let start = getMonoTime()
    alg(iCopy)
    let finish = getMonoTime()

    result[0].add(finish - start)