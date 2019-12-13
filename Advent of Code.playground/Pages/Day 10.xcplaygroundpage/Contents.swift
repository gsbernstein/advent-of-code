let input1 = """
.#..#
.....
#####
....#
...##
"""

let input2 = """
......#.#.
#..#.#....
..#######.
.#.#.###..
.#..#.....
..#....#.#
#..#....#.
.##.#..###
##...#..#.
.#....####
"""

let input3 = """
#.#...#.#.
.###....#.
.#....#...
##.#.#.#.#
....#.#.#.
.##..###.#
..#...##..
..##....##
......#...
.####.###.
"""

let input4 = """
.#..#..###
####.###.#
....###.#.
..###.##.#
##.##.#.#.
....###..#
..#.#..#.#
#..#.#.###
.##...##.#
.....#.#..
"""

let input5 = """
.#..##.###...#######
##.############..##.
.#.######.########.#
.###.#######.####.#.
#####.##.#.##.###.##
..#####..#.#########
####################
#.####....###.#.#.##
##.#################
#####.##.###..####..
..######..##.#######
####.##.####...##..#
.#####..#.######.###
##...#.##########...
#.##########.#######
.####.#.###.###.#.##
....##.##.###..#####
.#.#.###########.###
#.#.#.#####.####.###
###.##.####.##.#..##
"""

let realInput = """
.#....#.###.........#..##.###.#.....##...
...........##.......#.#...#...#..#....#..
...#....##..##.......#..........###..#...
....#....####......#..#.#........#.......
...............##..#....#...##..#...#..#.
..#....#....#..#.....#.#......#..#...#...
.....#.#....#.#...##.........#...#.......
#...##.#.#...#.......#....#........#.....
....##........#....#..........#.......#..
..##..........##.....#....#.........#....
...#..##......#..#.#.#...#...............
..#.##.........#...#.#.....#........#....
#.#.#.#......#.#...##...#.........##....#
.#....#..#.....#.#......##.##...#.......#
..#..##.....#..#.........#...##.....#..#.
##.#...#.#.#.#.#.#.........#..#...#.##...
.#.....#......##..#.#..#....#....#####...
........#...##...#.....#.......#....#.#.#
#......#..#..#.#.#....##..#......###.....
............#..#.#.#....#.....##..#......
...#.#.....#..#.......#..#.#............#
.#.#.....#..##.....#..#..............#...
.#.#....##.....#......##..#...#......#...
.......#..........#.###....#.#...##.#....
.....##.#..#.....#.#.#......#...##..#.#..
.#....#...#.#.#.......##.#.........#.#...
##.........#............#.#......#....#..
.#......#.............#.#......#.........
.......#...##........#...##......#....#..
#..#.....#.#...##.#.#......##...#.#..#...
#....##...#.#........#..........##.......
..#.#.....#.....###.#..#.........#......#
......##.#...#.#..#..#.##..............#.
.......##.#..#.#.............#..#.#......
...#....##.##..#..#..#.....#...##.#......
#....#..#.#....#...###...#.#.......#.....
.#..#...#......##.#..#..#........#....#..
..#.##.#...#......###.....#.#........##..
#.##.###.........#...##.....#..#....#.#..
..........#...#..##..#..##....#.........#
..#..#....###..........##..#...#...#..#..
"""

struct Point: Hashable { let x, y: Int }

extension Point {
    public static func + (lhs: Point, rhs: Point) -> Point {
        let x = lhs.x + rhs.x
        let y = lhs.y + rhs.y
        return Point(x: x, y: y)
    }
    
    public static func - (lhs: Point, rhs: Point) -> Point {
        let x = lhs.x - rhs.x
        let y = lhs.y - rhs.y
        return Point(x: x, y: y)
    }
    
    public static func += (lhs: inout Point, rhs: Point) {
        lhs = lhs + rhs
    }
    
    public static func * (lhs: Point, rhs: Int) -> Point {
        let x = lhs.x * rhs
        let y = lhs.y * rhs
        return Point(x: x, y: y)
    }
    
    public var length: Double {
        Double(x*x + y*y).squareRoot()
    }
    
    public var slope: Double {
        Double(y)/Double(x)
    }
    
    public var angleDeg: Double {
        angleBetween(Point.zero, self)
    }
    
    public static var zero: Point {
        Point(x: 0, y: 0)
    }
}

extension Point: CustomStringConvertible {
    var description: String {
        return "(\(x), \(y))"
    }
}

import CoreGraphics

func angleBetween(_ p1: Point, _ p2: Point) -> Double {
    let bearingPoint = p2-p1
    let radians = atan2(Double(bearingPoint.y),Double(bearingPoint.x))
    var degrees = radians * 180 / Double.pi
    degrees = degrees + 90
    return degrees >= 0 ? degrees : 360 + degrees
}

//print(angleBetween(Point(x: 0, y: 0), Point(x: 0, y: -1))) // expect 0
//print(angleBetween(Point(x: 0, y: 0), Point(x: 1, y: -1))) // expect 45
//print(angleBetween(Point(x: 0, y: 0), Point(x: 1, y: 0))) // expect 90

func findStation(input: String) -> (Point,Int) {
    let array = input.split{ $0.isNewline }
    var scores = [Point:Int]()
    for (rowNo, row) in array.enumerated() {
        for (colNo, point) in row.enumerated() {
            if point == "#" {
                var canSeeOfExisting = 0
                var bestPerSlope = [Double:(Point,Double)]()
                for (point,_) in scores {
                    let dif = Point(x: colNo, y: rowNo) - point
                    let dist = dif.length
                    let slope = dif.slope // good enough because we're only looking in one quadrant
                    if let (_, dist2) = bestPerSlope[slope],
                        dist2 < dist {
                        continue
                    }
                    bestPerSlope[slope] = (point,dist)
                }
                for (_,(point,_)) in bestPerSlope {
                    scores[point]! += 1
                    canSeeOfExisting += 1
                }
                let point = Point(x: colNo, y: rowNo)
                scores[point] = canSeeOfExisting
            }
        }
    }
    return scores.max(by: { (lhs, rhs) -> Bool in
        let (_, value1) = lhs
        let (_, value2) = rhs
        return value1 < value2
    })!
}

func nthToVaporize(input: String, station: Point, n: Int) -> Point {
    let array = input.split{ $0.isNewline }
    var pointsByAngle = [Double:[Double:Point]]()
    for (rowNo, row) in array.enumerated() {
        for (colNo, point) in row.enumerated() {
            if point == "#" {
                let point = Point(x: colNo, y: rowNo)
                let dif = point - station
                let dist = dif.length
                let angle = dif.angleDeg
                if pointsByAngle[angle] != nil {
                    pointsByAngle[angle]![dist] = point
                } else {
                    pointsByAngle[angle] = [dist:point]
                }
            }
        }
    }
    let angles = pointsByAngle.keys.sorted()
    var count = 0
    mainLoop: while true {
        for angle in angles {
              // only necessary if up isn't zero:
//            if count == 0 {
//                guard slope >= 0 else { continue }
//            }
            print(angle)
            print(pointsByAngle[angle]!)
            guard let target = pointsByAngle[angle]?
                .min(by: { $0.key < $1.key }) else { continue }
            count += 1
            print(count,target.value)
            if count >= 200 { return target.value }
            pointsByAngle[angle]!.removeValue(forKey: target.key)
        }
    }
}
let input = input5
//let calculatedStation = findStation(input: input).0
let input5Station = Point(x: 11, y: 13)
let realInputStation = Point(x: 28, y: 29)
let station = input5Station

print(nthToVaporize(input: input, station: station, n: 200))
