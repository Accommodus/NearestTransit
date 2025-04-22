import std/[tables]
include kdtree
import kdtree as kd

type
  CircularQueue[T] = object
    data: seq[T]
    head, tail, count: int = 0

proc reserve[T](q: var CircularQueue[T], extraCap: Natural) =
  let oldLen = q.data.len
  let newLen = if oldLen > 0: oldLen + extraCap else: max(1, extraCap)
  var newData = newSeq[T](newLen)

  # copy all live elements starting at head, in order
  for i in 0..<q.count:
    newData[i] = q.data[(q.head + i) mod oldLen]

  q.data = newData
  q.head = 0
  q.tail = q.count mod newLen

func enqueue[T](q: var CircularQueue[T], item: T) =
  if q.count == q.data.high:
    q.reserve(q.data.len)

  q.data[q.tail] = item
  q.tail = (q.tail + 1) mod q.data.len
  inc q.count

func dequeue[T](q: var CircularQueue[T]): T =
  if q.count == 0:
    raise newException(IndexError, "Queue is empty")

  let item = q.data[q.head]
  q.head = (q.head + 1) mod q.data.len
  dec q.count
  return item


type
  StaticKdNode[T] = object
    left, right: int
    point: KdPoint
    data: T
    splitDimension: int

  StaticKdTree*[T] = seq[StaticKdNode[T]]

func toStatic[T](node: KdNode[T], left, right: int): StaticKdNode[T] =
  ## Converts a kd-node to a static representation.
  
  result(
    left: left,
    right: right,
    point: node.point,
    data: node.data,
    splitDimension: node.splitDimension
  )

func toStatic*[T](tree: var kd.KdTree[T]): StaticKdTree[T] =
  ## Converts a KdTree into a flat static representation.
  ## Each node contains integer indices to its children.

  var 
    queue: basicRefQueue[KdNode[T]]
    nodeMap = initTable[KdNode[T], int]()  # map from node ref to index
    nodes: seq[KdNode[T]]

  var root = tree.root
  queue.addLast(root)

  # assign indices to each node
  while queue.len > 0:
    let cur = queue.popFirst()
    if cur == nil: continue
    nodeMap[cur] = nodes.len
    nodes.add(cur)
    if cur.left != nil: queue.addLast(cur.left)
    if cur.right != nil: queue.addLast(cur.right)

  # build static representation
  var result = newSeqOfCap[StaticKdNode[T]](nodes.len)
  for i, node in nodes:
    var left = -1
    var right = -1

    if node.left != nil and nodeMap.hasKey(node.left):
      left = nodeMap[node.left]
    if node.right != nil and nodeMap.hasKey(node.right):
      right = nodeMap[node.right]

    result.add node.toStatic(left, right)

  return result

func toDynamic*[T](staticTree: StaticKdTree[T]; distFunc: DistFunc = sqrDist): kd.KdTree[T] =
  ## Converts a static KdTree representation back into a dynamic KdTree.
  
  var tree: kd.KdTree[T]
  tree.len = staticTree.len
  tree.distFunc = distFunc

  if staticTree.len == 0:
    tree.root = nil
    return tree

  var nodes: seq[KdNode[T]] = newSeqOfCap[KdNode[T]](staticTree.len)

  for s in staticTree:
    nodes.add newNode(s.point, s.data)

  for i, s in staticTree:
    nodes[i].splitDimension = s.splitDimension

    if s.left >= 0:
      nodes[i].left = nodes[s.left]
    if s.right >= 0:
      nodes[i].right = nodes[s.right]

  tree.root = nodes[0]
  return tree
