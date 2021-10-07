import UIKit

//Subscripts
class CarModel {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class CarService {
     
    var carModels: [CarModel] = [CarModel]()
     
    init() {
        carModels.append(CarModel(name: "Skoda"))
        carModels.append(CarModel(name: "BMW"))
        carModels.append(CarModel(name: "Audi"))
    }
     
    subscript(index: Int) -> CarModel {
        get{
            return carModels[index]
        }
        set(newValue){
            carModels[index] = newValue
        }
    }
}
 
var carInService: CarService = CarService()
var firstCarModel: CarModel = carInService[0]  // получаем элемент по индексу 0
print(firstCarModel.name)
 
carInService[2] = CarModel(name: "VW")    // установка элемента по индексу 2
print(carInService[2].name)

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}
let mars = Planet[1]
print(mars)

//Methods
struct MutatingFunc {
    var value: Int = 15
    mutating func change() {
        value = 19
    }
}

var someValue = MutatingFunc()
someValue.value = 510
someValue.change()

struct CourseLevelTracker {
    static var availableTutorial = 1
    var currentTutorial = 1
    
    static func unlock(_ tutorialNumber: Int) {
        if tutorialNumber > availableTutorial { availableTutorial = tutorialNumber }
    }
    
    static func isUnlocked(_ tutorialNumber: Int) -> Bool {
        return tutorialNumber <= availableTutorial
    }

    @discardableResult mutating func open(to tutorialNumber: Int) -> Bool {
        if CourseLevelTracker.isUnlocked(tutorialNumber) {
            currentTutorial = tutorialNumber
            return true
        } else {
            return false
        }
    }
}

class Member {
    var tracker = CourseLevelTracker()
    let memberName: String
    func complete(tutorialNumber: Int) {
        CourseLevelTracker.unlock(tutorialNumber + 1)
        tracker.open(to: tutorialNumber + 1)
    }
    init(name: String) {
        memberName = name
    }
}

var member = Member(name: "Ксения")
member.complete(tutorialNumber: 1)
print("Доступный урок сейчас под номером \(CourseLevelTracker.availableTutorial)")

if member.tracker.open(to: 5) {
    print("\(member.memberName) сейчас на 5 уроке")
} else {
    print("\(member.memberName) еще не прошла предыдущие уроки для разблокировки урока 5")
}

class ScoreCounter {
    var totalScore: Int = 0 {
        willSet(newTotalScore) {
            print("The score will be \(newTotalScore)")
        }
        didSet {
            if totalScore > oldValue  {
                print("Added \(totalScore - oldValue) points")
            }
        }
    }
}

let scoreCounter = ScoreCounter()
scoreCounter.totalScore = 130
scoreCounter.totalScore = 365
scoreCounter.totalScore = 510

//Property
@propertyWrapper
struct TenOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 10) }
    }
}

struct Rectangle {
    @TenOrLess var height: Int
    @TenOrLess var width: Int
}

var rectangle = Rectangle()

print(rectangle.height)
rectangle.height = 7
print(rectangle.height)
rectangle.height = 24
print(rectangle.height)

@propertyWrapper
struct Number {
    private var maximum: Int
    private var number: Int

    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }

    init() {
        maximum = 12
        number = 0
    }
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}

struct NarrowRectangle {
    @Number(wrappedValue: 2, maximum: 5) var height: Int
    @Number(wrappedValue: 3, maximum: 4) var width: Int
}

var narrowRectangle = NarrowRectangle()

print(narrowRectangle.height, narrowRectangle.width)
narrowRectangle.height = 100
narrowRectangle.width = 100
print(narrowRectangle.height, narrowRectangle.width)

class Account{
 
    var capital: Double
    var rate: Double
     
    static var usdRate: Double = 2.52
     
    init(capital: Double, rate: Double){
        self.capital = capital
        self.rate = rate
    }
     
    func convert() -> Double{
        return capital / Account.usdRate
    }
}

var myAccount: Account = Account(capital: 100, rate: 0.1)
var capitalInUsd = myAccount.convert()
Account.usdRate = 2.48
capitalInUsd = myAccount.convert()
