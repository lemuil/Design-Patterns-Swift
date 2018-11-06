/*
 Декоратор - структурный шаблон проектирования, который позволяет динамически добавлять объектам дополнительное поведение.
 
 Поддерживает принцип открытости/закрытости.
 
 Декоратор расширяет функциональность класса динамически и обеспечивает гибкую альтернативу наследования без определения подклассов. Декоратор по сути является обверткой вокруг класса с точно таким же интерфейсом.
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

protocol IceCream {
    func costs() -> Double
    func ingredients() -> String
}

final class WhiteIceCream: IceCream {
    func costs() -> Double {
        return 25
    }
    
    func ingredients() -> String {
        return "Plombir"
    }
}

class IceCreamDecorator: IceCream {
    private var iceCream: IceCream
    
    init(iceCream: IceCream) {
        self.iceCream = iceCream
    }
    
    func costs() -> Double {
        return iceCream.costs()
    }
    
    func ingredients() -> String {
        return iceCream.ingredients()
    }
}

final class VanillaIceCream: IceCreamDecorator {
    override func costs() -> Double {
        return super.costs() + 10
    }
    
    override func ingredients() -> String {
        return super.ingredients() + ", vanilla"
    }
}

final class FruitIceCream: IceCreamDecorator {
    override func costs() -> Double {
        return super.costs() + 20
    }
    
    override func ingredients() -> String {
        return super.ingredients() + ", fresh fruits"
    }
}

let plombir = WhiteIceCream()
let vanillaIceCream = VanillaIceCream(iceCream: plombir)
let fruitIceCream = FruitIceCream(iceCream: plombir)

print("Plombir costs = "+String(plombir.costs()))
print("Plombir ingredients "+plombir.ingredients())

print("Vanilla costs = "+String(vanillaIceCream.costs()))
print("Vanilla ingredients "+vanillaIceCream.ingredients())

print("Fruit ice cream costs = "+String(fruitIceCream.costs()))
print("Fruit ice cream ingredients "+fruitIceCream.ingredients())
