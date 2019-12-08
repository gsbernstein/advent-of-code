var count: Int = 0
for num in 153517...630395 {
    let numString = String(num)
    guard String(numString.sorted()) == numString else { continue }
    var charCount: [Character: Int] = [:]
    
    charCount = numString.reduce(into: charCount, { (result, element) in
        result[element] = (result[element] ?? 0) + 1
    })
    let hasExactDouble: Bool = charCount.contains(where: { (_, count) -> Bool in
        count == 2
    })
    guard hasExactDouble else { continue }

    // guard Set(numString).count < 6 else {continue }
    print("Hit! \(num)")
    count += 1
}
print(count)
