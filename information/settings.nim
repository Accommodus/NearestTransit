const
  earthRadius* = 6_371_000 # mean radius in meters, from https://nssdc.gsfc.nasa.gov/planetary/factsheet/earthfact.html

  treeFileName* = "tree.json"
  dataDir* = "data"
  dataFileName* = "NTAD_Stops.csv"
  dataUrl* = "https://github.com/Accommodus/NearestTransit/releases/download/data/NTAD_National_Transit_Map_Stops_6633473857343365838.csv"

let 
  dataFile* = dataDir & "/" & dataFileName
  treeFile* = dataDir & "/" & treeFileName