import std/[strutils]

task tree, "constructs the kd-tree and downloads the data set":
  selfExec("r -d:save_tree -d:download information/compile_data.nim")

task test, "runs the tests":
  treeTask()

  let testFiles = listFiles("test")
  for testFile in testFiles:
    if testFile.endsWith(".nim"):
      echo "Running test: ", testFile
      let command = "r -d:debugging " & testFile
      selfExec(command)
      