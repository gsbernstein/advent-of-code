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
                var canSee = 0
                var bestPerSlope = [Double:(Point,Double)]()
                for (point,_) in scores {
                    let difX = Double(colNo - point.x)
                    let difY = Double(rowNo - point.y)
                    let dist = (difX*difX + difY*difY).squareRoot()
                    let slope = difY/difX
                    if let (_, dist2) = bestPerSlope[slope],
                        dist2 < dist {
                        continue
                    }
                    bestPerSlope[slope] = (point,dist)
                }
                for (_,(point,_)) in bestPerSlope {
                    scores[point]! += 1
                    canSee += 1
                }
                let point = Point(x: colNo, y: rowNo)
                scores[point] = /*(scores[point] ?? 0) +*/ canSee
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
    var pointsBySlope = [Double:[Double:Point]]()
    for (rowNo, row) in array.enumerated() {
        for (colNo, point) in row.enumerated() {
            if point == "#" {
                let point = Point(x: colNo, y: rowNo)
                let difX = Double(station.x - point.x)
                let difY = Double(station.y - point.y)
                let dist = (difX*difX + difY*difY).squareRoot()
//                let slope = difY/difX
                let slope = angleBetween(station,point)
                if pointsBySlope[slope] != nil {
                    pointsBySlope[slope]![dist] = point
                } else {
                    pointsBySlope[slope] = [dist:point]
                }
            }
        }
    }
    let slopes = pointsBySlope.keys.sorted()
    var count = 0
    mainLoop: while true {
        for slope in slopes {
//            if count == 0 {
//                guard slope >= 0 else { continue }
//            }
//            print(slope)
//            print(pointsBySlope[slope])
            guard let target = pointsBySlope[slope]?
                .min(by: { $0.key < $1.key }) else { continue }
            count += 1
            print(count,target.value)
            if count >= 200 { return target.value }
            pointsBySlope[slope]!.removeValue(forKey: target.key)
        }
    }
}
let input = realInput
let station = findStation(input: input).0
//let station = Point(x: 11, y: 13)

print(nthToVaporize(input: input, station: station, n: 200))
