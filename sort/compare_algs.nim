import ../information/types
import ../process_data/static_tree
import std/[monotimes, times]

#proc quickSortDistData*(inputArray: var seq[DistData]) =
  

proc KNNSort*(tree: var KdTree[TranSeq], kPoint: Coord, k: Natural, sortPoint: Coord, algs: openArray[sortAlgInPlace]): seq[Duration] =

  var inputArray: seq[DistData]

  let nearestStops = tree.nearestNeighbours(kPoint, k)
  for i in nearestStops:
    let dd = DistData(
      distance: haversineDist(i[0], sortPoint),
      data: i[1],
      coord: i[0]
    )
    inputArray.add(dd)

  for alg in algs:
    var iCopy = @inputArray

    let start = getMonoTime()
    alg(iCopy)
    let finish = getMonoTime()

    result.add(finish - start)