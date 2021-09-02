import UIKit

enum Size {
    case small
    case medium
    case large
}

enum Color {
    case red
    case green
    case blue
}

struct Product {

    var name: String
    var color: Color
    var size: Size

}

extension Product : CustomStringConvertible {
    var description: String {
        return "\(size) \(color) \(name)"
    }
}


/* struct ProductFilter {

    static func filterProducts(_ products: [Product], by size: Size) -> [Product] {

        var output = [Product]()

        for product in products where product.size == size {
            output.append(product)
        }b xnj
        return output
    }
} */


let tree = Product(name: "tree", color: .green, size: .large)
let frog = Product(name: "frog", color: .green, size: .small)
let strawberry = Product(name: "strawberry", color: .red, size: .small)

// let result = ProductFilter.filterProducts([tree, frog, strawberry], by: .small)
// print(result)



// Specification

protocol Specification {
    associatedtype T

    func isSatisfied(item: T) -> Bool
}

struct ColorSpecification: Specification {
    typealias T = Product

    var color: Color

    func isSatisfied(item: Product) -> Bool {
        return item.color == color
    }
}

struct SizeSpecification: Specification {
    typealias T = Product

    var size: Size

    func isSatisfied(item: Product) -> Bool {
        return item.size == size
    }
}

protocol Filter {
    associatedtype T

    func filter<Spec: Specification>(items: [T], specs: Spec) -> [T]
    where Spec.T == T
}

struct ProductFilter : Filter {
    typealias T = Product

    func filter<Spec: Specification>(items: [Product], specs: Spec) -> [Product]
        where ProductFilter.T == Spec.T {
            var output = [T]()
            for item in items {
                if specs.isSatisfied(item: item) {
                    output.append(item)
                }
            }
            return output
    }
}

let small = SizeSpecification(size: .small)

let result = ProductFilter().filter(items: [tree, frog, strawberry], specs: small)
print(result)



protocol Sized {
    var size: Size {get set}
}

protocol Colored {
    var color: Color {get set}
}

extension Product : Colored, Sized { }
