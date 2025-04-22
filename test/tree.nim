import ../process_data/[construct_tree, save_tree, parse_csv]
from ../information/settings import dataFile
import ../information/types
<<<<<<< HEAD
import kdtree as kd

var tree: kd.KdTree[seq[TransitPoint]] = constructTree(getLocationPoints(dataFile))

let staticTree: StaticKdTree[seq[TransitPoint]]  = toStatic[seq[TransitPoint]](tree)

let newDynTree  = toDynamic[seq[TransitPoint]](staticTree)

let staticTree2 = toStatic[seq[TransitPoint]](newDynTree)
=======

var tree = constructTree(getLocationPoints(dataFile))

let staticTree: StaticKdTree[tranSeq]  = toStatic[tranSeq](tree)

let newDynTree  = toDynamic[tranSeq](staticTree)

let staticTree2 = toStatic[tranSeq](newDynTree)
>>>>>>> refs/remotes/origin/save-tree

assert staticTree.len == staticTree2.len
check staticTree == staticTree2