import UIKit

class Dog {
    let nikname: String
    init (nikname: String) {
        self.nikname = nikname
        print("\(nikname) is begin initialized")
    }
    deinit {
        print("\(nikname) is begin deinitialized")
    }
}

var firstDog: Dog?
var secondDog: Dog?

firstDog = Dog(nikname: "Jack")
secondDog = Dog(nikname: "Sam")

firstDog = nil
secondDog = nil

// Strong Reference Cycles

class Pet {
    let petName: String
    init(petName: String){
        self.petName = petName
        print("\(petName) is begin initialized")
    }
    var owner: Person?
    deinit {
        print("\(petName) is begin deinitialized")
    }
}
class Person {
    let ownerName: String
    init(ownerName: String) {
        self.ownerName = ownerName
        print("\(ownerName) is begin initialized")
    }
    weak var pet: Pet?
    deinit {
        print("\(ownerName) is begin deinitialized")
    }
}

var bobik: Pet?
var melissa: Person?

bobik = Pet(petName: "Moon")
melissa = Person(ownerName: "Melissa")

bobik!.owner = melissa
melissa!.pet = bobik

bobik = nil
melissa = nil

// Unowned References
class PersonID {
    let personName: String
    var certificateNumber: Certificate?
    init(personName: String) {
        self.personName = personName
        print("\(personName) is begin initialized")
    }
    deinit {
        print("\(personName) is begin deinitialized")
    }
}

class Certificate {
    let certificateNumber: Int
    unowned var customer: PersonID
    init(certificateNumber: Int, customer: PersonID) {
        self.certificateNumber = certificateNumber
        self.customer = customer
        print("Certificate #\(certificateNumber) is begin initialized")
    }
    deinit {
        print("Certificate #\(certificateNumber) is begin deinitialized")
    }
}

var martin: PersonID?

martin = PersonID(personName: "Martin")
martin!.certificateNumber = Certificate(certificateNumber: 1213_3431_6782_3, customer: martin!)

martin = nil

// Resolving Strong Reference Cycles for Closures
class HTMLElement {

    let name: String
    let text: String?

    lazy var likeHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }

}
var paragraph: HTMLElement? = HTMLElement(name: "h1", text: "hello, world")
print(paragraph!.likeHTML())

paragraph = nil

//self in methods

struct Gun {
    var series: String
    var magazine: Int

    static let maxMagazine = 20
    mutating func restoreMagazine() {
        magazine = Gun.maxMagazine
    }
}

func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}

extension Gun {
    mutating func shareMagazine(with teammate: inout Gun) {
        balance(&teammate.magazine, &magazine)
    }
}

var gun1 = Gun(series: "Gun First", magazine: 18)
var gun2 = Gun(series: "Gun Second", magazine: 8)
print(gun1.magazine)
print(gun2.magazine)
gun1.shareMagazine(with: &gun2)

print(gun1.magazine)
print(gun2.magazine)
