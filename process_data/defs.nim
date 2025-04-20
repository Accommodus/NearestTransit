import std/math

type
  Coord* = array[2, float]

  TransitPoint* = object
    ntd_id: string
    stop_id: string
    stop_name: string
    stop_desc: string
    zone_id: string
    stop_url: string
    stop_code: string
    location_type: string
    parent_station: string
    stop_timezone: string
    wheelchair_boarding: string
    level_id: string
    platform_code: string
    agency_id: string
    download_date: string

proc lat*(c: Coord): float =
  return c[0]

proc lon*(c: Coord): float =
  return c[1]

proc `lat=`*(c: var Coord, value: float) =
  c[0] = value

proc `lon=`*(c: var Coord, value: float) =
  c[1] = value

proc toRad*(c: var Coord): float =
  c[0] = degToRad(c.lat)
  c[1] = degToRad(c.lon)

proc asRad*(c: Coord): Coord =
  result[0] = degToRad(c.lat)
  result[1] = degToRad(c.lon)