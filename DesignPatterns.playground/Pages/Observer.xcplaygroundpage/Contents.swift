
// MARK: Protocols

protocol Observable {
    func add(observer: Observer)
    func remove(observer: Observer)
    func notifyObservers()
}

protocol Observer {
    var id: String { get set }
    func update(value: Int?)
}


// MARK: Classes

final class NewsResource: Observable {
    
    var value: Int? {
        didSet {
            notifyObservers()
        }
    }
    
    private var observers: [Observer] = []
    
    func add(observer: Observer) {
        observers.append(observer)
    }
    
    func remove(observer: Observer) {
        guard let index = observers.enumerated().first(where: { $0.element.id == observer.id })?.offset else { return }
        observers.remove(at: index)
    }
    
    func notifyObservers() {
        observers.forEach { $0.update(value: value) }
    }
}

final class NewsAgency: Observer {
    var id = "newsAgency"
    
    func update(value: Int?) {
        guard let value = value else { return }
        print("New Agency handles updated value \(value)")
    }
}

final class Reporter: Observer {
    var id = "reporter"
    
    func update(value: Int?) {
        guard let value = value else { return }
        print("Reporter says updated value \(value)")
    }
}

final class Blogger: Observer {
    var id = "blogger"
    
    func update(value: Int?) {
        guard let value = value else { return }
        print("Blogger writes updated value \(value)")
    }
}


// MARK: -

print("start")

let appleCompany = NewsResource()
let appleInsider = NewsAgency()
let reporterTimes = Reporter()
let ipadStory = Blogger()

appleCompany.add(observer: appleInsider)
appleCompany.value = 3

appleCompany.add(observer: reporterTimes)
appleCompany.add(observer: ipadStory)

appleCompany.value = 2
appleCompany.value = 5

appleCompany.remove(observer: reporterTimes)
appleCompany.value = 1




