//: [Previous](@previous)

import Foundation

let buses = input1.components(separatedBy: ",")
    .compactMap(Int.init(_:))

var soonestBusId = 0
var soonestDeparture = Int.max
let start = input1start

for bus in buses {
    var nextDeparture = 0
    while nextDeparture < start {
        nextDeparture += bus
    }
    if nextDeparture < soonestDeparture {
        soonestDeparture = nextDeparture
        soonestBusId = bus
    }
}

print(soonestBusId)
let wait = soonestDeparture-start
print(wait)
print(wait*soonestBusId)

//: [Next](@next)
