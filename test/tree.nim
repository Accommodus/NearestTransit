import ../process_data/[construct_tree, parse_csv, defs]
import kdtree
from ../settings import dataFile

var table = getLocationPoints(dataFile) 
var tree = constructTree(table)
echo tree.nearestNeighbours(newCoord(0, 0), 1) # dummy coordinate