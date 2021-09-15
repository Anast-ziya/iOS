import UIKit

enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(6, 87543, 54398, 3)

switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check)")
case let .qrCode(productCode):
    print("QR code: \(productCode)")
}

// Array

let immutableArray = ["a", "b", "c"]
var mutableArray: Array<Int> = [1, 2, 3, 4]
var newArrayInt = Array(arrayLiteral: 5, 6, 7, 8)
mutableArray[1...2] = [9]
print(mutableArray)
print(mutableArray.suffix(1))

newArrayInt.count
var emptyArray: Array<Int> = []
if emptyArray.isEmpty {
    print("This array is empty")
} else {
    print("this array has \(emptyArray.count) elements")
}

let subArray = mutableArray.suffix(2)

emptyArray.append(7)
emptyArray.isEmpty
emptyArray.remove(at: 0)

newArrayInt.insert(150, at: 3)

if let i = mutableArray.firstIndex(of: 9) {
    mutableArray[i] = 5
}

var cast = ["Alicia", "Mark", "Akim", "Klim"]
let lowercaseNames = cast.map { $0.lowercased() }
lowercaseNames
let letterCounts = cast.map { $0.count }
letterCounts

let allHaveAtLeastFive = cast.allSatisfy({ $0.count >= 5 })

let letters = "abacbdddefggg"
let letterCount = letters.reduce(into: [:]) { counts, letter in
    counts[letter, default: 0] += 1
}

cast.sort()
print(cast)
cast.sort(by: >)
print(cast)

let sortedCast = cast.sorted()
print(sortedCast)

let numb = 0...11
let shuffledNumb = numb.shuffled()


//Sets
let ingredients: Set = ["pasta", "tomato sauce", "cheese", "salt", "pepper", "meet"]
if ingredients.contains("meet") {
    print("No thanks. I am a vegetarian.")
}

let subsetIngredients: Set = ["pasta", "tomato sauce", "cheese", "salt", "pepper"]
subsetIngredients.isSubset(of: ingredients)

ingredients.isSuperset(of: subsetIngredients)

let anotherSet: Set = ["cheese", "salt", "milk cream", "chicken", "champignon"]
print(ingredients.intersection(anotherSet))

for ingredient in anotherSet {
    print(ingredient)
}

let sortedSet = ingredients.sorted()

// Dictionary

var emptyDictionary: [String:String] = [:]

var dictionaryNumbers = ["one":"один", "two":"два", "three":"три"]

let starNames = ["Proxima Centauri", "Alpha Centauri A", "Alpha Centauri B"]
let starDistances = [4.24, 4.37, 4.37]
let starDictionary = Dictionary(uniqueKeysWithValues: zip(starNames, starDistances))

dictionaryNumbers["one"] = "Один"

let countryCodes = ["EUR": "Euro", "BYN": "Belarussian Ruble", "USD": "US Dollar"]
if let index = countryCodes.firstIndex(where: { $0.value == "Euro" }) {
    print(countryCodes[index])
    print("Euro code is '\(countryCodes[index].key)'.")
} else {
    print("Didn't find 'Euro' as a value in the dictionary.")
}


// lazy var

struct Calculator {
    static func calculateGamesPlayed() -> Int {
        var games: [Int] = []
        for i in 1...5000 { games.append(i) }
        return games.last!
    }
}

struct Player {
    var name: String
    var team: String
    var position: String
    
    lazy var gamesPlayed = {
        return Calculator.calculateGamesPlayed()
    }()
}

var maxim = Player(name: "Maxim Anisimov", team: "Berserkers", position: "Shooting Guard")

print(maxim.gamesPlayed)

// Optionals

//: Optional chaining
let names = ["Till Lindemann", "Richard Kruspe", "Paul Landers", "Oliver Riedel", "Christian Flake Lorenz", "Christoph Schneider"]
let rammstein = names.first?.uppercased()

//: Optional Binding
var name: String? = "Amina"
var height: Float? = 167.8
var weight: Float? = 55.2

if let name = name, let height = height, let weight = weight {
    print("Name: \(name)\nheight: \(height)\nweight: \(weight)")
}

//: Force unwrapping
var optString: String? = "Nikadim Andreev"
var unwrappingString = optString!
print("My name is \(unwrappingString)")

//: Implicitly unwrapping
var implUnwr: Double! = 3.14
implUnwr + 0.12

//: Nil coalescing

var optionalInt: Int? 
var mustHaveValue = optionalInt ?? 0
mustHaveValue

// Defer and guard

func printStringNumbers() {
    defer { print("1") }
    defer { print("2") }
    defer { print("3") }

    print("4")
}

printStringNumbers()

func calc(x: Double?, y: Double) {
    guard let x = x else { return }
    let rez = x + y
    print(rez)
}

calc(x: nil, y: 4.4)
calc(x: 5.6, y: 4.4)


