import UIKit

// First example
class Animal
{
    func makeNoise()
    {
        print("Durrr")
    }
}

class Cat : Animal
{
    override func makeNoise()
    {
        print("Meoooowwwww")
    }
}

class Dog : Animal
{
    override func makeNoise()
    {
        print("Woooooof")
    }
}

class Cow : Animal
{
    override func makeNoise()
    {
        print("Mooooo")
    }
}

var animal: Animal
animal = Cat()
print(animal.makeNoise())

animal = Dog()
print(animal.makeNoise())

animal = Cow()
print(animal.makeNoise())



// Second example

protocol Bar {
    func getDrink() -> Drink
}

protocol Drink {
    func getName() -> String
}

class Coffe: Drink {
    func getName() -> String {
        return "coffe"
    }
}

class Margarita: Drink {
    func getName() -> String {
        return "margarita"
    }
}

class NonAlcoholicBar: Bar {
    func getDrink() -> Drink {
        return Coffe()
    }
    
}

class AlcoholicBar: Bar {
    func getDrink() -> Drink {
        return Margarita()
    }
    
}

class Barman {
    
    private var bar: Bar!
    
    init(bar: Bar) {
        self.bar = bar
    }
    
    func purposeDrink() -> Drink {
        return bar.getDrink()
    }
}

var barmen: Barman = Barman(bar: AlcoholicBar())
barmen.purposeDrink()
