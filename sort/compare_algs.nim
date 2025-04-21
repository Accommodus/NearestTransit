import ../information/types
import kdtree
import std/[monotimes, times]

proc KNNSort(tree: var tranTree, kPoint: Coord, k: Natural, sortPoint: Coord, algs: openArray[sortAlgInPlace]): seq[Duration] =

  var inputArray: seq[distData]

  let nearestStops = tree.nearestNeighbours(kPoint, k)
  for i in nearestStops:
    let dd = distData(
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