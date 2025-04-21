import std/[segfaults]
import ../process_data/[construct_tree, parse_csv, types]
import ../information/types
import kdtree
from ../information/settings import dataFile

var tree* = constructTree(getLocationPoints(dataFile))
echo tree.nearestNeighbours(newCoord(0, 0), 10) # dummy coordinate