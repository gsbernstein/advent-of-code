//: [Previous](@previous)

import Foundation

func parse(input: String) -> Int {
    return input
        .components(separatedBy: "\n\n")
        .map { Set($0.filter { $0 != "\n"}) }
        .map { $0.count }
        .reduce(0, +)
}

func answers(_ input: String) -> String {
    input.reduce(into: "") { (result, char) in
        if !result.contains(char) {
            result.append(char)
        }
    }
}

print(parse(input: input1))

//: [Next](@next)
