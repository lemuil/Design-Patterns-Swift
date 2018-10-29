
/*
 Декоратор - структурный шаблон проектирования, который позволяет динамически добавлять объектам дополнительное поведение.
 
 Декоратор расширяет функциональность класса динамически и обеспечивает гибкую альтернативу наследования без определения подклассов. Декоратор по сути является обверткой вокруг класса с точно таким же интерфейсом. Поддерживает принцип открытости/закрытости.
*/

protocol Coffee {
    func cost() -> Double
    func ingredients() -> String
}

final class Espresso: Coffee {
    func cost() -> Double {
        return 10
    }
    
    func ingredients() -> String {
        return "Espresso"
    }
}

class CoffeeDecorator: Coffee {
    private var coffee: Coffee
    
    init(coffee: Coffee) {
        self.coffee = coffee
    }
    
    func cost() -> Double {
        return coffee.cost()
    }
    
    func ingredients() -> String {
        return coffee.ingredients()
    }
}

final class Milk: CoffeeDecorator {
    
    override func cost() -> Double {
        return super.cost() + 5
    }
    
    override func ingredients() -> String {
        return super.ingredients() + ", Milk"
    }
}

final class Whip: CoffeeDecorator {
    
    override func cost() -> Double {
        return super.cost() + 7
    }
    
    override func ingredients() -> String {
        return super.ingredients() + ", Whip"
    }
}

final class Chocolate: CoffeeDecorator {
    
    override func cost() -> Double {
        return super.cost() + 10
    }
    
    override func ingredients() -> String {
        return super.ingredients() + ", Chocolate"
    }
}

let espresso = Espresso()
let capuccino = Whip(coffee: Milk(coffee: espresso))
let capuccinoWithChocolate = Chocolate(coffee: capuccino)

print("Espresso cost = "+String(espresso.cost()))
print("Espresso ingredients - "+espresso.ingredients())

print("Capuccino cost = "+String(capuccino.cost()))
print("Capuccino ingredients - "+capuccino.ingredients())

print("Capuccino with chocolate cost = "+String(capuccinoWithChocolate.cost()))
print("Capuccino with chocolate ingredients - "+capuccinoWithChocolate.ingredients())


// Repeat #1 - IceCream Example
print("")

protocol IceCreamProtocol {
    func cost() -> Double
    func ingredients() -> String
}

final class IceCream: IceCreamProtocol {
    func cost() -> Double {
        return 20
    }
    
    func ingredients() -> String {
        return "Ice Cream"
    }
}

class IceCreamDecorator: IceCreamProtocol {
    private var iceCream: IceCreamProtocol
    
    init(iceCream: IceCreamProtocol) {
        self.iceCream = iceCream
    }
    
    func cost() -> Double {
        return iceCream.cost()
    }
    
    func ingredients() -> String {
        return iceCream.ingredients()
    }
}

final class ChocolateIceCream: IceCreamDecorator {
    override func cost() -> Double {
        return super.cost() + 10
    }
    
    override func ingredients() -> String {
        return super.ingredients() + ", Chocolate"
    }
}

final class VanilaIceCream: IceCreamDecorator {
    override func cost() -> Double {
        return super.cost() + 10
    }
    
    override func ingredients() -> String {
        return super.ingredients() + ", Vanila"
    }
}

let iceCream = IceCream()
let chocolateIceCream = ChocolateIceCream(iceCream: iceCream)
let chocolateIceCreamWithVanila = VanilaIceCream(iceCream: chocolateIceCream)

print(iceCream.ingredients())
print(iceCream.cost())

print(chocolateIceCream.ingredients())
print(chocolateIceCream.cost())

print(chocolateIceCreamWithVanila.ingredients())
print(chocolateIceCreamWithVanila.cost())

// Repeat #1 - Cocktail Example: 
print("")
