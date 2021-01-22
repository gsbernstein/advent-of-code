//: [Previous](@previous)

var count = 0

//for row in array2 {
//    let running = row.3.filter { $0 == row.2 }.count
//    if (row.0...row.1).contains(running) {
//        count += 1
//    }
//}

for row in array2 {
    let stringArray = Array(row.3)
    let isFirst = stringArray[row.0 - 1] == row.2
    let isSecond = stringArray[row.1 - 1] == row.2
    if isFirst != isSecond {
        count += 1
    }
}

print(count)

//: [Next](@next)
