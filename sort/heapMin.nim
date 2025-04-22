import ../information/types

proc cmp(a, b: (float, Coord)): int =
  if a[0] < b[0]: return -1
  elif a[0] > b[0]: return 1
  else: return 0

type
    MinHeap*[T] = object
        arr*: seq[T]

proc constructMinHeap*[T](): MinHeap[T] =
    result = MinHeap[T](arr: @[])

proc parent(i: int): int = (i-1) div 2
proc leftChild(i: int): int = 2*i + 1
proc rightChild(i: int): int = 2*i + 2

proc heapifyUp[T](self: var MinHeap[T]) = 
    var i = self.arr.len - 1

    while i > 0 and cmp(self.arr[parent(i)], self.arr[i]) > 0: #swap with parent if parent is larger
      let dummy = self.arr[i]
      self.arr[i] = self.arr[parent(i)]
      self.arr[parent(i)] = dummy
      i = parent(i)

proc heapifyDown[T](self: var MinHeap[T]) =
  var i = 0

  while true:

    var smallest = i
    let left = leftChild(i)
    let right = rightChild(i)
 
    if left < self.arr.len and cmp(self.arr[left], self.arr[smallest]) < 0: #find smallest
      smallest = left
    if right < self.arr.len and cmp(self.arr[right], self.arr[smallest]) < 0:
      smallest = right

    if smallest == i:
      break

    let dummy = self.arr[i] #swap with smallest
    self.arr[i] = self.arr[smallest]
    self.arr[smallest] = dummy
    i = smallest

proc insert*[T](self: var MinHeap[T], key: T)=
    self.arr.add(key)
    self.heapifyUp()

proc extractMin*[T](self: var MinHeap[T]): T = 
    result = self.arr[0]
    self.arr[0] = self.arr[^1]
    discard self.arr.pop()
    if self.arr.len > 0:
        self.heapifyDown()