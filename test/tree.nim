import ../process_data/[construct_tree, save_tree, parse_csv]
from ../information/settings import dataFile
import ../information/types

import kdtree as kd

var tree: kd.KdTree[seq[TransitPoint]] = constructTree(getLocationPoints(dataFile))
let staticTree: StaticKdTree[seq[TransitPoint]]  = toStatic[seq[TransitPoint]](tree)
let newDynTree  = toDynamic[seq[TransitPoint]](staticTree)
let staticTree2 = toStatic[seq[TransitPoint]](newDynTree)

staticTree.len == staticTree2.len
check staticTree == staticTree2