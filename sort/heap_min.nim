import ../information/types
import std/sequtils

proc cmp(a, b: (float, Coord)): int =
  if a[0] < b[0]: return -1
  elif a[0] > b[0]: return 1
  else: return 0

type MinHeap*[T] = seq[T]

proc parent(i: int): int = (i-1) div 2
proc leftChild(i: int): int = 2*i + 1
proc rightChild(i: int): int = 2*i + 2

proc heapifyUp[T](self: var MinHeap[T]) = 
    var i = self.len - 1

    while i > 0 and cmp(self[parent(i)], self[i]) > 0: #swap with parent if parent is larger
      let dummy = self[i]
      self[i] = self[parent(i)]
      self[parent(i)] = dummy
      i = parent(i)

proc heapifyDown[T](self: var MinHeap[T]) =
  var i = 0

  while true:

    var smallest = i
    let left = leftChild(i)
    let right = rightChild(i)
 
    if left < self.len and cmp(self[left], self[smallest]) < 0: #find smallest
      smallest = left
    if right < self.len and cmp(self[right], self[smallest]) < 0:
      smallest = right

    if smallest == i:
      break

    let dummy = self[i] #swap with smallest
    self[i] = self[smallest]
    self[smallest] = dummy
    i = smallest

proc inject*[T](self: var MinHeap[T], key: T)=
    self.add(key)
    self.heapifyUp()

proc extractMin*[T](self: var MinHeap[T]): T = 
    result = self[0]
    self[0] = self[^1]
    discard self.pop()
    if self.len > 0:
        self.heapifyDown()

func heapSortEntry*[T](inp: var openArray[T]) =
  var input = toSeq(inp)

  for item in input:
    input.inject(item)

  for i in 0..<input.len:
    input[i] = input.extractMin()