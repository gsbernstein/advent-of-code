var count: Int = 0
for num in 153517...630395 {
    let hasdouble = false
    let numString = String(num)
    guard String(numString.sorted()) == numString else { continue }
    let charCount = numString.reduce(into: [:], { result, element -> [Character:Int] in
        result[element] = result[element] ?? 0 + 1
    }
    guard charCount.contains(where: { _, count -> Bool in
        count == 2
    }) else { continue }

    // guard Set(numString).count < 6 else {continue }
    print("Hit! \(num)")
    count += 1
}
print(count)