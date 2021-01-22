//: [Previous](@previous)

import Foundation

let testInput1 = "7,13,x,x,59,x,31,19"
let testInput2 = "17,x,13,19"
let testInput3 = "67,7,59,61"
let testInput4 = "67,x,7,59,61"
let testInput5 = "67,7,x,59,61"
let testInput6 = "1789,37,47,1889"
let input1 = "23,x,x,x,x,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,x,829,x,x,x,x,x,x,x,x,x,x,x,x,13,17,x,x,x,x,x,x,x,x,x,x,x,x,x,x,29,x,677,x,x,x,x,x,37,x,x,x,x,x,x,x,x,x,x,x,x,19"



func parse(_ input: String) -> Int {
    let buses = input.components(separatedBy: ",")
        .enumerated()
        .compactMap { bus -> (offset: Int, busID: Int)? in
            guard let busID = Int(bus.element) else { return nil }
            return (bus.offset, busID)
        }
        .sorted { $0.busID > $1.busID }
    print(buses)
    var time = -buses.first!.offset
    while true {
        if !buses[1...].contains(where: { (offset: Int, busID: Int) -> Bool in
            let expected = time + offset
            return expected % busID != 0
        }) {
            return time
        }
        time += buses.first!.busID
    }
    fatalError()
}

parse(testInput6)

/*
    2,3,4
 2*x = 3*y + 1
 x = 3/2y + 1/2
*/

/*
 Returns the Greatest Common Divisor of two numbers.
 */
func gcd(_ x: Int, _ y: Int) -> Int {
    var a = 0
    var b = max(x, y)
    var r = min(x, y)
    
    while r != 0 {
        a = b
        b = r
        r = a % b
    }
    return b
}

/*
 Returns the least common multiple of two numbers.
 */
func lcm(_ x: Int, _ y: Int) -> Int {
    return x / gcd(x, y) * y
}

//: [Next](@next)
