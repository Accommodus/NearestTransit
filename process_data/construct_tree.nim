import kdtree
import defs
import std/[tables]

proc constructTree*(table: Table[Coord, seq[TransitPoint]]): KdTree[seq[TransitPoint]] =

    var holder: seq[(Coord, seq[TransitPoint])]
    for k, v in table.pairs:
      let rad_k = k.asRad()
      holder.add((rad_k, v))

    result = newKdTree[seq[TransitPoint]](holder)