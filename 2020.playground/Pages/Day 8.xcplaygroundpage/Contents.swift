//: [Previous](@previous)

import Foundation

enum Operation: String {
    case acc, jmp, nop
}

class Computer {
    var memory = 0
    var position = 0
    var visited = Set<Int>()
    let instructions: [(Operation, Int)]
    
    init(instructions: [(Operation, Int)]) {
        self.instructions = instructions
    }
    
    func run() -> Int? {
        while position < instructions.count {
            if visited.contains(position) { return nil }
            visited.insert(position)
            let instruction = instructions[position]
            switch instruction.0 {
            case .acc: memory += instruction.1; position += 1
            case .jmp: position += instruction.1
            case .nop: position += 1
            }
        }
        return memory
    }
}

func parse(input: String) -> Int {
    
    let instructions = input.components(separatedBy: "\n")
        .map { (string: String) -> (Operation, Int) in
            let op = Operation(rawValue: String(string.prefix(3)))!
            var paramString = string
            paramString.removeFirst(4)
            let param = Int(paramString)!
            return (op, param)
        }
    
    for (index, instruction) in instructions.enumerated() {
        guard instruction.0 != .acc else { continue }
        
        let newOp: Operation = instruction.0 == .jmp ? .nop : .jmp
        
        var newInstructions = instructions
        newInstructions[index].0 = newOp
        
        let computer = Computer(instructions: newInstructions)
        if let result = computer.run() {
            return result
        }
    }
    fatalError()
}

parse(input: input1)

//: [Next](@next)
