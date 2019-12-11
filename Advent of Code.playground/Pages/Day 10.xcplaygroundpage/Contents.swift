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

let input = input5

struct Point: Hashable { let x, y: Int }

extension Point {
    public static func + (lhs: Point, rhs: Point) -> Point {
        let x = lhs.x + rhs.x
        let y = lhs.y + rhs.y
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

let array = input.split{ $0.isNewline }
var scores = [Point:Int]()
for (rowNo, row) in array.enumerated() {
    for (colNo, point) in row.enumerated() {
        if point == "#" {
            var canSee = 0
            prevPointLoop: for (point,_) in scores {
                let difX = Double(colNo - point.x)
                let difY = Double(rowNo - point.y)
                let dist = (difX*difX + difY*difY).squareRoot()
                let slope = difY/difX
                for (point2,_) in scores {
                    let difX2 = Double(colNo - point2.x)
                    let difY2 = Double(rowNo - point2.y)
                    let dist2 = (difX2*difX2 + difY2*difY2).squareRoot()
                    let slope2 = difY2/difX2
                    if slope2 == slope && dist2 < dist {
                        continue prevPointLoop
                    }
                }
                scores[point]! += 1
                canSee += 1
            }
            let point = Point(x: colNo, y: rowNo)
            scores[point] = /*(scores[point] ?? 0) +*/ canSee
        }
    }
}
//print(scores)
let max = scores.max(by: { (lhs, rhs) -> Bool in
    let (_, value1) = lhs
    let (_, value2) = rhs
    return value1 < value2
})!
print(max)
