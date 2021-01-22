let sum = 2020

//array.partition(by: { $0 > sum/2})

loop: for i in array {
    for j in array {
        for k in array {
            if i + j + k == sum {
//                print("\(i) and \(j)")
                print(i*j*k)
                break loop
            }
        }
    }
}
