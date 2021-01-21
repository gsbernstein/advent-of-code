//: [Previous](@previous)

import Foundation

func codeToID(_ input: String) -> Int {
    let inputs = Array(input)
    let rowStrings = inputs[0...6]
    let row = stringToBinary(String(rowStrings))
    let colStrings = inputs[7...9]
    let col = stringToBinary(String(colStrings))
    
    return row * 8 + col
}

func stringToBinary(_ input: String) -> Int {
    let inputBin: [Character] = input.map { char in
        switch char {
        case "B","R": return "1"
        default: return "0"
        }
    }
    return Int(String(inputBin), radix: 2)!
}

let taken = input1.map(codeToID(_:))

print(taken.max()!)

var allSeats = Array(0...947)

allSeats.removeAll { seatCode -> Bool in
    taken.contains(seatCode)
}
                       
print(allSeats)

//: [Next](@next)
