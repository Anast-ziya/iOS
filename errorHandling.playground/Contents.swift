import UIKit

enum ItemError: Error {
    case invalidSelection
    case insufficientFunds(needed: Int)
    case outOfStock
}

struct Item {
    var price: Int
    var count: Int
}

class Lipstick {
    var lipctickStorage = [
        "Red": Item(price: 10, count: 7),
        "Pink": Item(price: 15, count: 4),
        "Black": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    
    func buy(itemNamed name: String) throws {
        guard let item = lipctickStorage[name] else {
            throw ItemError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw ItemError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw ItemError.insufficientFunds(needed: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        lipctickStorage[name] = newItem
        
        print("Sold \(name)")
    }
}

let favoriteLipstickColor = [
    "Alice": "Red",
    "Emma": "Pink",
    "Eve": "Black"
]

func buyFavoriteLipstick(person: String, lipstick: Lipstick) throws {
    let lipstickColor = favoriteLipstickColor[person] ?? "Red"
    try lipstick.buy(itemNamed: lipstickColor)
}

var lipstick = Lipstick()
lipstick.coinsDeposited = 8

do {
    try buyFavoriteLipstick(person: "Emma", lipstick: lipstick)
} catch ItemError.invalidSelection {
    print("Selection error.")
} catch ItemError.outOfStock {
    print("Not available.")
} catch ItemError.insufficientFunds(let needed) {
    print("Insufficient funds. You need to add \(needed) coins.")
} catch {
    print("Unexpected error: \(error).")
}

func sqrtFunction(_ x: Double) throws -> Double {
    return sqrt(x)
}
 
let x = try? sqrtFunction(81)
 
let y: Double?
do {
    y = try sqrtFunction(121)
} catch {
    y = nil
    print("Error")
}

func deferMulti() {
    defer {print ("3")}
    defer {print ("2")}
    do {print ("1")}
}
deferMulti()
