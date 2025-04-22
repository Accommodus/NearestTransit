import std/[tables]
import linked_list_queue
include kdtree


type
  StaticKdNode*[T] = object
    left*, right*: int
    point*: KdPoint
    data*: T
    splitDimension*: int

  StaticKdTree*[T] = seq[StaticKdNode[T]]

func toStatic[T](node: KdNode[T], left, right: int): StaticKdNode[T] =
  ## Converts a kd-node to a static representation.
  
  result = StaticKdNode[T](
    left: left,
    right: right,
    point: node.point,
    data: node.data,
    splitDimension: node.splitDimension
  )

func toStatic*[T](tree: KdTree[T]): StaticKdTree[T] =
  var
    queue = llQueue[KdNode[T]]()
    nodeMap = initTable[pointer, int]()   # ← key is raw pointer
    nodes: seq[KdNode[T]]

  queue.enqueue(tree.root)
  while queue.len > 0:
    let cur = queue.dequeue()
    if cur == nil: continue

    let p = cast[pointer](cur)
    nodeMap[p] = nodes.len
    nodes.add(cur)

    if cur.left  != nil: queue.enqueue(cur.left)
    if cur.right != nil: queue.enqueue(cur.right)

  result = newSeqOfCap[StaticKdNode[T]](nodes.len)
  for i, node in nodes:
    var l = -1; var r = -1
    let lp = cast[pointer](node.left)
    let rp = cast[pointer](node.right)
    if node.left  != nil and nodeMap.hasKey(lp): l = nodeMap[lp]
    if node.right != nil and nodeMap.hasKey(rp): r = nodeMap[rp]
    result.add(node.toStatic(l, r))

func toDynamic*[T](staticTree: StaticKdTree[T]; distFunc: DistFunc = sqrDist): KdTree[T] =
  ## Converts a static KdTree representation back into a dynamic KdTree.
  
  var tree: KdTree[T]
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