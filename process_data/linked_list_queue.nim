type
  qRefNode[T] = ref qNode[T]
  qNode[T] = object
    next: qRefNode[T] = nil
    data: T

  llQueue*[T] = object # needed because of issues with sink traces being lost in std queue implementation
    head: qRefNode[T]
    tail: qRefNode[T]
    size: int = 0

func enqueue*[T](q: var llQueue[T], data: T) =
  ## Adds an element to the end of the queue.
  ## Time complexity: O(1)

  var newNode= qRefNode[T](data: data)

  if q.tail == nil:
    q.head = newNode
    q.tail = newNode
  else:
    q.tail.next = newNode
    q.tail = newNode

  q.size.inc()

func dequeue*[T](q: var llQueue[T]): T =
  ## Removes and returns the first element from the queue.
  ## Time complexity: O(1)

  if q.head == nil:
    raise newException(ValueError, "Queue is empty")

  result = q.head.data
  q.head = q.head.next

  if q.head == nil:
    q.tail = nil

  q.size.dec()

func len*[T](q: llQueue[T]): Natural =    
  ## Returns queue size.
  ## Time complexity: O(1)

  return q.size

func peek*[T](q: llQueue[T]): T =
  ## Returns the first element from the queue without removing it.
  ## Time complexity: O(1)

  if q.head == nil:
    raise newException(ValueError, "Queue is empty")

  return q.head.data