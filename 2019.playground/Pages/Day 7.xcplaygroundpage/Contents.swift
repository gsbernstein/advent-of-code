let real = [    3,8,1001,8,10,8,105,1,0,0,21,34,47,72,93,110,191,272,353,434,99999,3,9,102,3,9,9,1001,9,3,9,4,9,99,3,9,102,4,9,9,1001,9,4,9,4,9,99,3,9,101,3,9,9,1002,9,3,9,1001,9,2,9,1002,9,2,9,101,4,9,9,4,9,99,3,9,1002,9,3,9,101,5,9,9,102,4,9,9,1001,9,4,9,4,9,99,3,9,101,3,9,9,102,4,9,9,1001,9,3,9,4,9,99,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,99,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,99,3,9,1001,9,1,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,99,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,99]
let test1 = [3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0]
let test2 = [3,23,3,24,1002,24,10,24,1002,23,-1,23,101,5,23,23,1,24,23,23,4,23,99,0,0]
let test3 = [3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0]

let ampSoftware = real
let debug = false

class IntcodeComputer {
    var program: [Int]
    var position: Int = 0
    var `continue` = true
    var input: [Int] = []
    var output: [Int] = []
    var outputHandler: ((Int) -> ())? = nil
    init(program: [Int]) {
        self.program = program
    }
    
    func add(x: Int?, y: Int?, destination: Int?) -> Bool {
        let output = program[x!]+program[y!]
        program[destination!] = output
        return false
    }

    func mul(x: Int?, y: Int?, destination: Int?) -> Bool {
        let output = program[x!]*program[y!]
        program[destination!] = output
        return false
    }

    func store(_ destination: Int?, _: Int?, _: Int?) -> Bool {
//        print("taking input")
//        guard let input = self.input else { self.continue = false; return true }
        program[destination!] = input[0]
        input.removeFirst()
        return false
    }

    func output(_ position: Int?, _: Int?, _: Int?) -> Bool {
        output.append(program[position!])
//        outputHandler?(program[position!])
        return false
    }

    func jumpIfTrue(_ condition: Int?, _ value: Int?, _: Int?) -> Bool {
        if program[condition!] != 0 {
            position = program[value!]
            return true
        }
        else { return false }
    }

    func jumpIfFalse(_ condition: Int?, _ value: Int?, _: Int?) -> Bool {
        if program[condition!] == 0 {
            position = program[value!]
            return true
        }
        else { return false }
    }

    func lessThan(_ p1: Int?, _ p2: Int?, _ destination: Int?) -> Bool {
        program[destination!] = program[p1!] < program[p2!] ? 1 : 0
        return false
    }

    func equals(_ p1: Int?, _ p2: Int?, _ destination: Int?) -> Bool {
        program[destination!] = program[p1!] == program[p2!] ? 1 : 0
        return false
    }
    
    static func printInt(_ int: Int) {
        print("out: \(int)")
    }
    
    func run(with outputHandler: (Int) -> () = printInt) {
        loop: while self.continue {
            let instruction = String(program[position]).leftPad(to: 5, with: "0")
            let opcode = Int(String(instruction[3...4]))!
            let param1mode = Int(String(instruction[2]))!
            let param2mode = Int(String(instruction[1]))!
            let param3mode = Int(String(instruction[0]))!
            var maybeoperation: ((Int?, Int?, Int?) -> Bool)? = nil
            var length: Int = 1
            
            switch opcode {
            case 1: maybeoperation = add(x:y:destination:); length = 4//; param3mode = 0
            case 2: maybeoperation = mul(x:y:destination:); length = 4//; param3mode = 0
            case 3: maybeoperation = store;                 length = 2
            case 4: maybeoperation = output;                length = 2
            case 5: maybeoperation = jumpIfTrue;            length = 3
            case 6: maybeoperation = jumpIfFalse;           length = 3
            case 7: maybeoperation = lessThan;              length = 4
            case 8: maybeoperation = equals;                length = 4
            case 99: /*print("halt");*/ break loop
            default: print("error, opcode was \(instruction)"); break loop
            }
            
            if debug {
                print(program)
                print(String(position).leftPad(to: 4) + ": " +
                    (position..<position+length)
                        .map{String(program[$0]).leftPad(to: 4)}
                        .joined(separator:",")
                )
            }
            
            if let operation = maybeoperation {
                var input1: Int? = position+1
                if param1mode == 0 {
                    input1 = program[safe: input1!]
                }
                var input2: Int? = position+2
                if param2mode == 0 {
                    input2 = program[safe: input2!]
                }
                var input3: Int? = position+3
                if param3mode == 0 {
                    input3 = program[safe: input3!]
                }
                let result = operation(input1,input2,input3)
                if result { continue loop }
            }
            position += length
        }
    }
}

class Amp: IntcodeComputer {
    init(phaseSetting: Int, input: Int) {
        super.init(program: ampSoftware)
        self.input.append(phaseSetting)
        self.input.append(input)
    }
}

public extension String {
    func leftPad(to width: Int, with paddingString: String = " ") -> String {
        if count >= width { return self }
        let remainingLength: Int = width - count
        let padString: [String] = (0..<remainingLength).map{ _ in paddingString }
        return (padString + [self]).joined()
    }
    
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

extension Array {
    public subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}

func permuteWirth<T>(_ a: [T], _ n: Int) -> [[T]] {
    var output = [[T]]()
    if n == 0 {
        output.append(a)
    } else {
        var a = a
        output.append(contentsOf: permuteWirth(a, n - 1))
        for i in 0..<n {
            a.swapAt(i, n)
            output.append(contentsOf: permuteWirth(a, n - 1))
            a.swapAt(i, n)
        }
    }
    return output
}

let phaseSettings = [0,1,2,3,4]
let phasePermutations = permuteWirth(phaseSettings, phaseSettings.count - 1)
//print(phasePermutations)

func evalSettings(settings: [Int]) -> Int {
    var input = 0
    for setting in settings {
        let amp = Amp(phaseSetting: setting, input: input)
        amp.run()
        input = amp.output.first!
    }
    return input
}

var currentMax = 0
var currentBestSettings: [Int]?

for settings in phasePermutations {
    let score = evalSettings(settings: settings)
//    print(settings,score)
    if score > currentMax {
        currentMax = score
        currentBestSettings = settings
    }
}

print(currentMax, currentBestSettings!)
