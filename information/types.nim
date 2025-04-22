import std/math
from settings import earthRadius

type
  Coord* = array[2, float] # compatable with KdPoint

  TransitPoint* = object
    ntd_id*: string
    stop_id*: string
    stop_name*: string
    stop_desc*: string
    zone_id*: string
    stop_url*: string
    stop_code*: string
    location_type*: string
    parent_station*: string
    stop_timezone*: string
    wheelchair_boarding*: string
    level_id*: string
    platform_code*: string
    agency_id*: string
    download_date*: string

  TranSeq* = seq[TransitPoint]

  DistData* = object
    distance*: float = 0
    data*: seq[TransitPoint]
    coord*: Coord = [0, 0]

  sortAlgInPlace* = proc (i: var seq[DistData]) {.nimcall.}

proc `<`*(a, b: DistData): bool =
  a.distance < b.distance

proc `<=`*(a, b: DistData): bool =
  a.distance <= b.distance

proc `>`*(a, b: DistData): bool =
  a.distance > b.distance

proc `>=`*(a, b: DistData): bool =
  a.distance >= b.distance

proc `==`*(a, b: DistData): bool =
  a.distance == b.distance

proc `!=`*(a, b: DistData): bool =
  a.distance != b.distance

proc lat*(c: Coord): float =
  return c[0]

proc lon*(c: Coord): float =
  return c[1]

proc toRad*(c: var Coord): float =
  c[0] = degToRad(c.lat)
  c[1] = degToRad(c.lon)

proc asRad*(c: Coord): Coord =
  result[0] = degToRad(c.lat)
  result[1] = degToRad(c.lon)

proc newCoord*(lat, lon: float): Coord =
  result[0] = lat
  result[1] = lon

proc haversineDist*(a, b: Coord): float =
  ## Calculates the Haversine distance between two points on the Earth.
  ## Inputs are in radians; output is in meters.
  ## based on: https://community.esri.com/t5/coordinate-reference-systems-blog/distance-on-a-sphere-the-haversine-formula/ba-p/902128
  
  let
    dLat = b.lat - a.lat
    dLon = b.lon - a.lon
    sinDLat = sin(dLat / 2)
    sinDLon = sin(dLon / 2)
    h = sinDLat * sinDLat + cos(a.lat) * cos(b.lat) * sinDLon * sinDLon
    c = 2 * arcsin(sqrt(h))

  return earthRadius * c

func isSorted*[T](s: openArray[T]): bool =
  for i in 1..<s.len:
    if s[i - 1] > s[i]:
      return false
  return true
