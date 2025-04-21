import std/[strutils]

task data, "ensures the data set has been downloaded by executing download_data.nim":
  selfExec("r -d:ssl -d:download compile_data.nim")

task tree, "constructs the kd-tree from the data set":
  dataTask()
  selfExec("r -d:save_tree compile_data.nim")

task test, "runs the tests":
  treeTask()

  let testFiles = listFiles("test")
  for testFile in testFiles:
    if testFile.endsWith(".nim"):
      echo "Running test: ", testFile
      let command = "r -d:debugging " & testFile
      selfExec(command)
      