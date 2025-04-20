import std/[strutils]

task data, "ensures the data set has been downloaded by executing download_data.nim":
  selfExec("r -d:ssl download_data.nim")

task test, "runs the tests":
  dataTask()
  let testFiles = listFiles("test")
  for testFile in testFiles:
    if testFile.endsWith(".nim"):
      echo "Running test: ", testFile
      let command = "r " & testFile
      selfExec(command)
      