
final class Singleton {
    static let shared = Singleton()
    private init() {}
    
    var value = 0
    
    func changeValue() {
        print("value = \(value)")
    }
}

var object = Singleton.shared
var secondObject = Singleton.shared

object.value = 1000
secondObject.value = 2000

object.changeValue()
secondObject.changeValue()

//print(object === secondObject)

object.value = 200
secondObject.changeValue()


