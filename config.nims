import std/[strutils]

task data, "constructs the kd-tree and downloads the data set":
  selfExec("r -d:ssl -d:save_tree -d:download information/compile_data.nim")

task test, "runs the tests":
  dataTask()

  let testFiles = listFiles("test")
  for testFile in testFiles:
    if testFile.endsWith(".nim"):
      echo "Running test: ", testFile
      let command = "r -d:debugging " & testFile
      selfExec(command)
      
task cli, "builds the command line interface":
  dataTask()

  selfExec("c -d:release --opt:speed --parallelBuild:0 cli/build_cli.nim")