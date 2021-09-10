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

let cast = ["Alice", "Mark", "Akim", "Klim"]
let lowercaseNames = cast.map { $0.lowercased() }
lowercaseNames
let letterCounts = cast.map { $0.count }
letterCounts

//Sets
let ingredients: Set = ["pasta", "tomato sauce", "cheese", "salt", "pepper", "meet"]
if ingredients.contains("meet") {
    print("No thanks. I am a vegetarian.")
}

let subsetIngredients: Set = ["pasta", "tomato sauce", "cheese", "salt", "pepper"]
subsetIngredients.isSubset(of: ingredients)

ingredients.isSuperset(of: subsetIngredients)

let anotherSet: Set = ["cheese","salt","milk cream", "chicken", "champignon"]
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

// lazy var

struct Dog {
    var isAGoodBoy: Bool?
    
    lazy var goodBoy: String = {
        return "Who is a good boy? You are a good boy."
    }()
    lazy var notGoodBoy: String = {
        return "Ugh, bad dog!"
    }()
}

var myDog = Dog()
myDog.isAGoodBoy = true

if myDog.isAGoodBoy! {
    print(myDog.goodBoy)
} else {
    print(myDog.notGoodBoy)
}

// Optionals

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

