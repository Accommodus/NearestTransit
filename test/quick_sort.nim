import random
import ../sort/quick_sort

const N = 10000
var inputList: seq[float] = @[]
for _ in 0..<N:
  let num = rand(100.0)
  inputList.add(num)

var size = inputList.len
quickSort(inputList, 0, size - 1)  # We use size - 1 to avoid out-of-bounds

for i in 0..<inputList.len - 1:
  assert inputList[i] <= inputList[i + 1], "Sequence properly sorted"
echo "Test Passed!"