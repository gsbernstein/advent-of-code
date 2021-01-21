import Foundation

public let reqd: [String: (String) -> Bool] = [
    "byr": { Int($0).map { (1920...2002).contains($0) } ?? false }, // (Birth Year)
    "iyr": { Int($0).map { (2010...2020).contains($0) } ?? false }, // (Issue Year)
    "eyr": { Int($0).map { (2020...2030).contains($0) } ?? false }, // (Expiration Year)
    "hgt": validHeight, // (Height)
    "hcl": validHex, // (Hair Color)
    "ecl": ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains, // (Eye Color)
    "pid": validPID // (Passport ID)
//    "cid" // (Country ID)
]

func validHeight(_ string: String) -> Bool {
    var string = string
    if string.hasSuffix("in") {
        string.removeLast(2)
        guard let int = Int(string) else { return false }
        return (59...76).contains(int)
    } else if string.hasSuffix("cm") {
        string.removeLast(2)
        guard let int = Int(string) else { return false }
        return (150...193).contains(int)
    } else {
        return false
    }
}

let hexSet = CharacterSet(charactersIn: "01234567890ABCDEFabcdef")

func validHex(_ string: String) -> Bool {
    guard string.hasPrefix("#") else { return false }
    var string = string
    string.removeFirst()
    return string.rangeOfCharacter(from: hexSet.inverted) == nil
}

func validPID(_ string: String) -> Bool {
    return string.count == 9 && Int(string) != nil
}
