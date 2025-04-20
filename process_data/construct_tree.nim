import kdtree
import transit_point
import std/[sequtils, tables]

proc constructTree*(table: Table[KdPoint, LocationPoint]): KdTree[LocationPoint] =
    let input = toSeq(table.pairs)
    result = newKdTree[LocationPoint](input)