type
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

  LocationPoint* = object
    lat, lon: float
    transits: seq[TransitPoint]