import kdtree
import transit_point
import std/[sequtils, tables, math]

proc constructTree*(table: Table[KdPoint, LocationPoint]): KdTree[LocationPoint] =
    let input = toSeq(table.pairs)

    for i in input: # convert to radians for easier calcs
        i[1].lat = degToRad(i.lat)
        i[1].lon = degToRad(i.lon)

    result = newKdTree[LocationPoint](input)