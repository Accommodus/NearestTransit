import ../process_data/[construct_tree, static_tree, parse_csv]
from ../information/settings import dataFile
import ../information/types

var tree: KdTree[seq[TransitPoint]] = constructTree(getLocationPoints(dataFile))
let statTree: StaticKdTree[seq[TransitPoint]] = toStatic[seq[TransitPoint]](tree)
let newDynTree  = toDynamic[seq[TransitPoint]](statTree)

assert tree.len == newDynTree.len

let staticTree2 = toStatic[seq[TransitPoint]](newDynTree)

assert statTree.len == staticTree2.len
echo statTree.len

for i in 0..<statTree.len:
  let a = statTree[i]
  let b = staticTree2[i]

  if a.left != b.left:
    raise newException(AssertionDefect, "Left index mismatch at node " & $i)
  if a.right != b.right:
    raise newException(AssertionDefect, "Right index mismatch at node " & $i)
  if a.splitDimension != b.splitDimension:
    raise newException(AssertionDefect, "Split dimension mismatch at node " & $i)
  if a.point != b.point:
    raise newException(AssertionDefect, "Point mismatch at node " & $i)
  if a.data != b.data:
    raise newException(AssertionDefect, "Data mismatch at node " & $i)