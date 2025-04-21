import ../process_data/[construct_tree, save_tree, parse_csv]
from ../information/settings import dataFile
import ../information/types

var tree = constructTree(getLocationPoints(dataFile))

let staticTree: StaticKdTree[tranSeq]  = toStatic[tranSeq](tree)

let newDynTree  = toDynamic[tranSeq](staticTree)

let staticTree2 = toStatic[tranSeq](newDynTree)

assert staticTree.len == staticTree2.len
check staticTree == staticTree2