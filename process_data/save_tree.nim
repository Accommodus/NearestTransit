import std/[tables, deque]
include kdtree
import kdtree as kd

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
    queue: initDeque[ref KdNode[T]]
    nodeMap = initTable[KdNode[T], int]()  # map from node ref to index
    nodes: seq[KdNode[T]]

  let root: ref KdNode[T] = tree.root
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
      nodes[i].right = nodes[s.rright]

  tree.root = nodes[0]
  return tree
