import std/[parsecsv, tables, strutils]
import ../information/types

proc getLocationPoints*(dataFilePath: string): Table[Coord, seq[TransitPoint]] =
  ## Parses a CSV of transit stops and groups TransitPoints by exact lat/lon.
  ## Time complexity: O(n) where n is the number of items in the dataset. 
  
  result = initTable[Coord, seq[TransitPoint]]()
  
  var parser: CsvParser

  parser.open(dataFilePath, quote='\0', escape='\0')
  parser.readHeaderRow()

  when defined(debugging):
    var skip_amount = 0

  while parser.readRow(): # O(n) 

    try: # attempt processing; if anything fails, it is malformed, so skip that row:
      let
        latF = parser.rowEntry("stop_lat").parseFloat
        lonF = parser.rowEntry("stop_lon").parseFloat
        key = [latF, lonF]

      let tp = TransitPoint(
        ntd_id: parser.rowEntry("ntd_id"),
        stop_id: parser.rowEntry("stop_id"),
        stop_name: parser.rowEntry("stop_name"),
        stop_desc: parser.rowEntry("stop_desc"),
        zone_id: parser.rowEntry("zone_id"),
        stop_url: parser.rowEntry("stop_url"),
        stop_code: parser.rowEntry("stop_code"),
        location_type: parser.rowEntry("location_type"),
        parent_station: parser.rowEntry("parent_station"),
        stop_timezone: parser.rowEntry("stop_timezone"),
        wheelchair_boarding: parser.rowEntry("wheelchair_boarding"),
        level_id: parser.rowEntry("level_id"),
        platform_code: parser.rowEntry("platform_code"),
        agency_id: parser.rowEntry("agency_id"),
        download_date: parser.rowEntry("download_date")
      )

      if result.hasKey(key):
        result[key].add tp
      else:
        result[key] = @[tp]

    except ValueError:
      when defined(debugging):
        skip_amount += 1
      continue
        
  when defined(debugging):
    echo "skipped ", skip_amount, " out of ", parser.processedRows, " rows"

  parser.close()
