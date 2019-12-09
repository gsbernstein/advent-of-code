var program: [Int] = [
    3,225,1,225,6,6,1100,1,238,225,104,0,1102,91,92,225,1102,85,13,225,1,47,17,224,101,-176,224,224,4,224,1002,223,8,223,1001,224,7,224,1,223,224,223,1102,79,43,225,1102,91,79,225,1101,94,61,225,1002,99,42,224,1001,224,-1890,224,4,224,1002,223,8,223,1001,224,6,224,1,224,223,223,102,77,52,224,1001,224,-4697,224,4,224,102,8,223,223,1001,224,7,224,1,224,223,223,1101,45,47,225,1001,43,93,224,1001,224,-172,224,4,224,102,8,223,223,1001,224,1,224,1,224,223,223,1102,53,88,225,1101,64,75,225,2,14,129,224,101,-5888,224,224,4,224,102,8,223,223,101,6,224,224,1,223,224,223,101,60,126,224,101,-148,224,224,4,224,1002,223,8,223,1001,224,2,224,1,224,223,223,1102,82,56,224,1001,224,-4592,224,4,224,1002,223,8,223,101,4,224,224,1,224,223,223,1101,22,82,224,1001,224,-104,224,4,224,1002,223,8,223,101,4,224,224,1,223,224,223,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,8,226,677,224,102,2,223,223,1005,224,329,1001,223,1,223,1007,226,226,224,1002,223,2,223,1006,224,344,101,1,223,223,108,226,226,224,1002,223,2,223,1006,224,359,1001,223,1,223,107,226,677,224,102,2,223,223,1006,224,374,101,1,223,223,8,677,677,224,102,2,223,223,1006,224,389,1001,223,1,223,1008,226,677,224,1002,223,2,223,1006,224,404,101,1,223,223,7,677,677,224,1002,223,2,223,1005,224,419,101,1,223,223,1108,226,677,224,1002,223,2,223,1005,224,434,101,1,223,223,1108,226,226,224,102,2,223,223,1005,224,449,1001,223,1,223,107,226,226,224,102,2,223,223,1005,224,464,101,1,223,223,1007,677,677,224,102,2,223,223,1006,224,479,101,1,223,223,1007,226,677,224,102,2,223,223,1005,224,494,1001,223,1,223,1008,226,226,224,1002,223,2,223,1005,224,509,1001,223,1,223,1108,677,226,224,1002,223,2,223,1006,224,524,1001,223,1,223,108,677,677,224,1002,223,2,223,1005,224,539,101,1,223,223,108,226,677,224,1002,223,2,223,1005,224,554,101,1,223,223,1008,677,677,224,1002,223,2,223,1006,224,569,1001,223,1,223,1107,677,677,224,102,2,223,223,1005,224,584,1001,223,1,223,7,677,226,224,102,2,223,223,1005,224,599,1001,223,1,223,8,677,226,224,1002,223,2,223,1005,224,614,1001,223,1,223,7,226,677,224,1002,223,2,223,1006,224,629,101,1,223,223,1107,677,226,224,1002,223,2,223,1005,224,644,1001,223,1,223,1107,226,677,224,102,2,223,223,1006,224,659,1001,223,1,223,107,677,677,224,1002,223,2,223,1005,224,674,101,1,223,223,4,223,99,226]

public extension String {
    func leftPad(to width: Int, with paddingString: String = " ") -> String {
        if count >= width { return self }
        let remainingLength: Int = width - count
        let padString: [String] = (0..<remainingLength).map{ _ in paddingString }
        return (padString + [self]).joined()
    }
}

public extension String {
    
    subscript (i: Int) -> Character {
      return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }

    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}

func add(x: Int, y: Int, destination: Int) {
    let output = program[x]+program[y]
    program[destination] = output
}

func mul(x: Int, y: Int, destination: Int) {
    let output = program[x]*program[y]
    program[destination] = output
}

func store(_ destination: Int, _: Int, _: Int) {
    print("taking input")
    program[destination] = 1
}

func output(_ position: Int, _: Int, _: Int) {
    print("out: \(program[position])")
}

var position = 0
loop: while true {
    let instruction = String(program[position]).leftPad(to: 5, with: "0")
    let opcode = Int(String(instruction[3...4]))!
    let param1mode = Int(String(instruction[2]))!
    let param2mode = Int(String(instruction[1]))!
    var param3mode = Int(String(instruction[0]))!
    
    var maybeoperation: ((Int, Int, Int)->())? = nil
    var length: Int = 1
    
    switch opcode {
    case 1: maybeoperation = add(x:y:destination:); length = 4//; param3mode = 0
    case 2: maybeoperation = mul(x:y:destination:); length = 4//; param3mode = 0
    case 3: maybeoperation = store; length = 2
    case 4: maybeoperation = output; length = 2
    case 99: print("halt"); break loop
    default: print("error, opcode was \(instruction)"); break loop
    }
    
    print(String(position).leftPad(to: 4) + ": " + (position..<position+length)
        .map{String(program[$0]).leftPad(to: 4)}
        .joined(separator:","))
    
    if let operation = maybeoperation {
        var input1 = position+1
        if param1mode == 0 {
            input1 = program[input1]
        }
        var input2 = position+2
        if param2mode == 0 {
            input2 = program[input2]
        }
        var input3 = position+3
        if param3mode == 0 {
            input3 = program[input3]
        }
        operation(input1,input2,input3)
    }
    position += length
}
//print(program[0])
