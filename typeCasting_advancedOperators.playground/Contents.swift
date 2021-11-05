import UIKit

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class TVSeries: MediaItem {
    var seasonNumber: Int
    init(name: String, seasonNumber: Int) {
        self.seasonNumber = seasonNumber
        super.init(name: name)
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

let library = [
    TVSeries(name: "New Amsterdam", seasonNumber: 4),
    TVSeries(name: "Orange is the new black", seasonNumber: 7),
    Movie(name: "Man in black", director: "Barry Sonnenfeld"),
    TVSeries(name: "House", seasonNumber: 8),
    Movie(name: "Pirates of the Caribbean", director: "Jerry Bruckheimer")
]

// Check operator is
var movieCount = 0
var seriesCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is TVSeries {
        seriesCount += 1
    }
}

print("Media library contains \(movieCount) movies and \(seriesCount) TV series")

// downcasting

for item in library {
    if let movie = item as? Movie {
        print("Movie: \(movie.name), dir. \(movie.director)")
    } else if let series = item as? TVSeries {
        print("TV series: \(series.name), with \(series.seasonNumber) seasons")
    }
}

// Type casting for Any and AnyObject

var someArray: [Any] = []

someArray.append(73)
someArray.append((0.3, 4.7))
someArray.append(3.14159)
someArray.append("swift")
someArray.append(Movie(name: "Venom", director: "Ruben Fleischer"))
someArray.append({ (name: String) -> String in "Hello, \(name)" })

for thing in someArray {
    switch thing {
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double:
        print("a double value of \(someDouble)")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Arina"))
    default:
        print("unknown")
    }
}

//Advanced Operators

let initialBits: UInt8 = 0b110101
let invertedBits = ~initialBits

let a: UInt8 = 0b1100110
let b: UInt8  = 0b10110010
let andOperator  = a & b
let orOperator = a | b
let xorOperator = a ^ b

let shiftBits: UInt8 = 8
shiftBits << 1
shiftBits << 2
shiftBits >> 1

struct Point {
    var x = 0, y = 0, z = 0
    init(x: Int, y: Int, z: Int){
        self.x = x
        self.y = y
        self.z = z
    }
}

let firstPoint = Point(x: 1, y: 2, z: 3)
let secondPoint = Point(x: 5, y: 6, z: 7)

extension Point {
    static func + (left: Point, right: Point) -> Point {
        return Point(x: left.x + right.x, y: left.y + right.y, z: left.z + right.z)
    }
    
    static prefix func - (firstPoint: Point) -> Point {
        return Point(x: -firstPoint.x, y: -firstPoint.y, z: -firstPoint.z)
    }
    
    static func += (left: inout Point, right: inout Point) {
        left = left + right
    }
    
    static func == (left: Point, right: Point) -> Bool {
        return (left.x == right.x) && (left.y == right.y) && (left.z == right.z)
    }
}

var resultPoint = firstPoint + secondPoint

let negative = -firstPoint

var pointResult = Point(x: 1, y: 2, z: 3)
pointResult += resultPoint
print(pointResult)

let twoThree =  Point(x: 5, y: 6, z: 7)

if twoThree == secondPoint {
    print("These two vectors are equivalent.")
} else {
    print("These two vectors are not equivalent.")
}

prefix operator +++

extension Point {
    static prefix func +++ (vector: inout Point) -> Point {
        vector = vector + vector
        return vector
    }
}

var toBeDoubled = Point(x: 1, y: 4, z: 5)
let afterDoubling = +++toBeDoubled

@resultBuilder
struct StringBuilder {
    
    static func buildBlock(_ components: String...) -> String {
        let filtered = components.filter { $0 != "" }
        return filtered.joined(separator: "❤️‍🔥")
    }
    
    static func buildOptional(_ component: String?) -> String {
            return component ?? ""
        }
    static func buildEither(first component: String) -> String {
        return component
    }

    static func buildEither(second component: String) -> String {
        return component
    }
}

@StringBuilder func greet() -> String {
    "Hello"
    "World"
}

print(greet())

@StringBuilder func greet(name: String) -> String {
    "Hello"

    if !name.isEmpty {
        "to"
        name
    } else {
        "World"
    }
}

print(greet(name: "Michel Nalson"))
