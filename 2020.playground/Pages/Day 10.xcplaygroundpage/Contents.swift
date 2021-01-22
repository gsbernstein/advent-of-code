//: [Previous](@previous)

import Foundation

func joltageGaps(_ input: [Int]) -> [Int: Int] {
    let sorted = input.sorted()
    var joltages: [Int: Int] = [3: 1]
    joltages[sorted.first!] = joltages[sorted.first!] ?? 0 + 1
    for (index, joltage1) in sorted.enumerated() {
        guard index + 1 < sorted.count else { continue }
        let joltage2 = sorted[index+1]
        let diff = joltage2-joltage1
        joltages[diff] = (joltages[diff] ?? 0) + 1
    }
    return joltages
}

joltageGaps(input1)

//: [Next](@next)
