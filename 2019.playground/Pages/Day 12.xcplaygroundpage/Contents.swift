struct Point: Hashable { let x, y, z: Int }

extension Point {
    public static func + (lhs: Point, rhs: Point) -> Point {
        let x = lhs.x + rhs.x
        let y = lhs.y + rhs.y
        let z = lhs.z + rhs.z
        return Point(x: x, y: y, z: z)
    }
    
    public static func - (lhs: Point, rhs: Point) -> Point {
        let x = lhs.x - rhs.x
        let y = lhs.y - rhs.y
        let z = lhs.z - rhs.z
        return Point(x: x, y: y, z: z)
    }
    
    public static func += (lhs: inout Point, rhs: Point) {
        lhs = lhs + rhs
    }
    
    public var length: Double {
        Double(x*x + y*y + z*z).squareRoot()
    }
    
//    public var slope: Double {
//        Double(y)/Double(x)
//    }
    
//    public var angleDeg: Double {
//        angleBetween(Point.zero, self)
//    }
    
    public static var zero: Point {
        Point(x: 0, y: 0, z: 0)
    }
}

extension Point: CustomStringConvertible {
    var description: String {
        return "(\(x), \(y), \(z))"
    }
}

let input1 = """
<x=-1, y=0, z=2>
<x=2, y=-10, z=-7>
<x=4, y=-8, z=8>
<x=3, y=5, z=-1>
"""

let input2 = """
<x=-8, y=-10, z=0>
<x=5, y=5, z=10>
<x=2, y=-7, z=3>
<x=9, y=-8, z=-3>
"""

let inputReal = """
<x=16, y=-8, z=13>
<x=4, y=10, z=10>
<x=17, y=-5, z=6>
<x=13, y=-3, z=0>
"""

func makePoints(from string: String) -> [Point] {
    let array = string.split{ $0.isNewline }
    let coords = array.map{
        $0.split{ $0 == "," }
            .map{
                $0.dropFirst(3).filter{ $0 != ">" }
        }
    }
    return coords.map {
        Point(x: Int($0[0])!, y: Int($0[1])!, z: Int($0[2])!)
    }
}
let points = makePoints(from: inputReal)

struct State: Hashable { let position, velocity: Point}

var states: [State] = points.map { (position) -> State in
    State(position: position, velocity: Point.zero)
}

func deltaV(o1: Int, o2: Int) -> Int {
    if o1 < o2 { return 1 }
    else if o1 > o2 { return -1 }
    else { return 0 }
}

extension Point {
    var energy: Int {
        return abs(x)+abs(y)+abs(z)
    }
}

func totalEnergy(state: State) -> Int {
    state.position.energy * state.velocity.energy
}

var previousStates: [[State]:Int] = [states:0]

//var previousIndividualStates: [Set<State>] = [[states[0]],[states[1]],[states[2]],[states[3]]]


for n in 0..<Int.max {

    var newStates = [State]()
    for (objNo, object) in states.enumerated() {
        var vx = object.velocity.x
        var vy = object.velocity.y
        var vz = object.velocity.z
        for (obj2No, object2) in states.enumerated() {
            guard obj2No != objNo else { continue }
//            vx += deltaV(o1: object.position.x, o2: object2.position.x)
//            vy += deltaV(o1: object.position.y, o2: object2.position.y)
            vz += deltaV(o1: object.position.z, o2: object2.position.z)
        }
        let velocity = Point(x: vx, y: vy, z: vz)
        let newState = State(position: object.position+velocity, velocity: velocity)
        newStates.append(newState)
//        if previousIndividualStates[objNo].contains(newState) { print("\(objNo): at \(n+1)") }
//        previousIndividualStates[objNo].insert(newState)
    }
    states = newStates
//    print("step: \(n+1)")
//    print(states)
    if let previous = previousStates[states] { print(n+1,previous,n+1-previous) }
    previousStates[states] = n+1
}

//print(states.map{totalEnergy(state:$0)}.reduce(0, +))

