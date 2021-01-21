//: [Previous](@previous)

import Foundation

typealias Passport = [String: String]

func parse(input: String) -> [Passport] {
    return input
        .components(separatedBy: "\n\n")
        .map { (string: String) -> Passport in
            string
                .components(separatedBy: CharacterSet(charactersIn: "\n "))
                .reduce(into: Passport()) { (dict, string) in
                    let array = string.split(separator: ":")
                    let key = String(array.first!)
                    let value = String(array[1])
                    dict[key] = value
                }
        }
}

func countValid(input: [Passport]) -> Int {
    return input.reduce(into: 0) { (result, passport) in
        if !reqd.contains(where: { (key: String, pred: (String) -> Bool) -> Bool in
            guard let value = passport[key] else { return true }
            return !pred(value)
        }) {
            result += 1
        }
    }
}

print(countValid(input: parse(input: input1)))

//: [Next](@next)
