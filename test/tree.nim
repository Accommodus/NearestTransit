import ../process_data/[construct_tree, defs]
import kdtree

var tree = getTree()
echo tree.nearestNeighbours(newCoord(0, 0), 10) # dummy coordinate