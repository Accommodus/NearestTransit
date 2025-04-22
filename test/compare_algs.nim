import ../sort/[quickSort, heapMin, compare_algs]

const N = 10000
var inputList: seq[float] = @[]
for _ in 0..<N:
  let num = rand(100.0)
  inputList.add(num)

let iL2 = deepCopy(inputList)

quickSortEntry(inputList)
assert isSorted(inputList), "quickSort properly sorted"

heapSortEntry(iL2)
assert isSorted(iL2), "heapSort properly sorted"

