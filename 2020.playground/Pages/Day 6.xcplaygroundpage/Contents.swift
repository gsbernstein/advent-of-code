//: [Previous](@previous)

import Foundation

func parse(input: String) -> Int {
    return input
        .components(separatedBy: "\n\n")
        .map(answers)
        .map { $0.count }
        .reduce(0, +)
}

func answers(_ input: String) -> Set<Character> {
    input.components(separatedBy: "\n")
        .reduce(into: Set("abcdefghijklmnopqrstuvwxyz")) { (result, string) in
            let set = Set(string)
            result.formIntersection(set)
        }
}

print(parse(input: input1))

//: [Next](@next)
