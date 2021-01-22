//: [Previous](@previous)

import Foundation

func check(_ input: [Int], preamble: Int) -> Int {
    var input = input
    var memory = input.prefix(preamble)
    input.removeFirst(preamble)
    for value in input {
        
        guard isValid(value, Array(memory)) else { return value }
        
        memory.removeFirst()
        memory.append(value)
    }
    fatalError()
}

func isValid(_ value: Int, _ memory: [Int]) -> Bool {
    for mem1 in memory {
        for mem2 in memory {
            if mem1 == mem2 { continue }
            if mem1 + mem2 == value { return true }
        }
    }
    return false
}

//check(testInput, preamble: 5)
//check(input1, preamble: 25)

let value = 22406676

let testVal = 127

func contig(value: Int, mem: [Int]) {
    outer: for (index, mem1) in mem.enumerated() {
        var sum = mem1
        var array = Set([mem1])
        for mem2 in mem[(index+1)...] {
            sum += mem2
            array.insert(mem2)
            if sum == value {
                let min = array.min()!
                let max = array.max()!
                print(min+max)
                break outer
            }
            if sum > value { continue outer }
        }
    }
}

contig(value: value, mem: input1)

//: [Next](@next)
