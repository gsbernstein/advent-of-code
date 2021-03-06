//: [Previous](@previous)

func treesHit(right: Int, down: Int) -> Int {
    
    var count = 0
    var x = 0
    
    for (i, row) in map1.enumerated() {
        
        guard i % down == 0 else { continue }
        let array = Array(row)
        if array[x] == "#" {
            count += 1
        }
        x += right
        if x >= row.count {
            x -= row.count
        }
    }
    
    return count
}

let slopes = [
    (1,1),
    (3,1),
    (5,1),
    (7,1),
    (1,2)
]

for slope in slopes {
    print(treesHit(right: slope.0, down: slope.1))
}

//: [Next](@next)
