proc partition(low:int,high:int, arr: var seq[float]): int =
    var pivot  = float(high)
    var i = (low - 1)
    for j in countup(low,(high -1)):
        if arr[j] <= pivot:
            i = i + 1
            let temp = arr[i]
            arr[i] = arr[j]
            arr[j] = temp
    let temp = arr[i+1]
    arr[i+1] = arr[high]
    arr[high] = temp

    return (i+1)

proc quickSort(arr: var seq[float], low:int, high:int): void = 
    if low < high:
        var index = partition(low, high, arr)
        quickSort(arr,low,(index-1))
        quickSort(arr,(index+1),high)

when isMainModule:
    import random
    
    const N = 10000
    var inputList: seq[float] = @[]
    for _ in 0..<N:
        let num = rand(100.0)
        inputList.add(num)
    
    var size = inputList.len
    quickSort(inputList, 0, size)

    for i in 0..<inputList.len - 1:
        doAssert inputList[i] <= inputList[i + 1], "Sequence properly sorted"

    echo "Test Passed!"