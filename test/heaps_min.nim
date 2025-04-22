import ../sort/heapMin
import random

var heap = constructMinHeap[float]()
  #Generate random inserts
  
const N = 10000
var inputList: seq[float] = @[]
for _ in 0..<N:
    let num = rand(100.0)
    inputList.add(num)
    heap.insert(num)

var extracted: seq[float] = @[]
while heap.arr.len > 0:
    extracted.add(heap.extractMin())

for i in 0..<extracted.len - 1:
  assert extracted[i] <= extracted[i + 1], "Heap property violated"
echo "Test Passed!"
