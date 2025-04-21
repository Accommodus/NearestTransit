import std/[deques, tables]
include kdtree

type
  StaticKdNode[T] = object
    left, right: int
    point: KdPoint
    data: T
    splitDimension: int

func toStatic[T](node: KdNode[T], left, right: int): StaticKdNode[T] =
  ## Converts a kd-node to a static representation.
  
  result(
    left: left,
    right: right,
    point: node.point,
    data: node.data,
    splitDimension: node.splitDimension
  )

func toStatic[T](tree: KdTree[T]): seq[StaticKdNode[T]] =
  ## Converts a KdTree into a flat static representation.
  ## Each node contains integer indices to its children.

  var 
    queue = initDeque[KdNode[T]]()
    nodeMap = initTable[KdNode[T], int]()  # map from node ref to index
    nodes: seq[KdNode[T]]

  queue.addLast(tree.root)

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
