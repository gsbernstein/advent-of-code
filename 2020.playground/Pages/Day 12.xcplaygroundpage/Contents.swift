//: [Previous](@previous)

import Foundation

enum Instruction: String {
    case N,S,E,W,L,R,F
}

enum Heading: Int {
    case N = 0, S = 180, E = 90, W = 270 // CW is +
    
    func turn(_ direction: Direction, deg: Int) -> Heading {
        let deltaDeg = direction.isPositive ? deg : -deg
        
        var newDeg = rawValue + deltaDeg
        
        while newDeg >= 360 {
            newDeg -= 360
        }
        
        while newDeg < 0 {
            newDeg += 360
        }
        
        return Heading(rawValue: newDeg)!
    }
}

enum Direction {
    case L, R // R is CW is +
    
    var isPositive: Bool {
        return self == .R
    }
}


func parse(_ string: String) -> (Instruction, Int) {
    var string = string
    let letter = string.removeFirst()
    let instruction = Instruction(rawValue: String(letter))!
    let number = Int(string)!
    return (instruction, number)
}

let input = input1.components(separatedBy: "\n")
    .map(parse)

var x = 0
var y = 0
var waypointX = 10
var waypointY = 1

func turn(_ direction: Direction, deg: Int) {
    var deltaDeg = direction.isPositive ? deg : -deg
    while deltaDeg >= 360 {
        deltaDeg -= 360
    }
    
    while deltaDeg < 0 {
        deltaDeg += 360
    }
    switch deltaDeg {
    case 90:
        let newWayptX = waypointY
        waypointY = -waypointX
        waypointX = newWayptX
    case 180:
        waypointX = -waypointX; waypointY = -waypointY
    case 270:
        let newWayptX = -waypointY
        waypointY = waypointX
        waypointX = newWayptX
    default:
        fatalError()
    }
}

for inst in input {
    switch inst.0 {
    case .N: waypointY += inst.1
    case .S: waypointY -= inst.1
    case .E: waypointX += inst.1
    case .W: waypointX -= inst.1
    case .L: turn(.L, deg: inst.1)
    case .R: turn(.R, deg: inst.1)
    case .F:
        x += waypointX * inst.1
        y += waypointY * inst.1
    }
//    print("\(inst.0.rawValue)\(inst.1): (\(x), \(y)), \(heading)")
}

print(abs(x)+abs(y))

//: [Next](@next)
