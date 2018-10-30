
/*
 Фасад (Facade) - структурный шаблон проектирования, который предоставляет простой интерфейс к сложной системе классов, библиотеке или фреймворку.
 
 Фасад позволяет скрыть сложную систему, библиотеку или фреймворк за более простым интерфейсом.
 Этот интерфейс предоставляет унифицированный функционал для решения конкретной задачи.
 
 Фасад или простой интерфейс для работы со сложной системой, сам знает, что нужно сделать, чтобы получить нужный результат. Какие объекты нужно создать, какие связи между ними настроить и какие методы вызвать.
 
 Например, для получения результата нужно создать некоторое количество объектов, правильно настроить связи между ними и вызвать их методы в определенной последовательности. В итоге, логика реализации приложения тесно переплетается с особенностями реализации этих объектов. Появляется сильная связанность. Введя дополнительный класс (фасад) с упрощенным интерфейсом, который позволяет достичь тот же самый результат, но обратившись только к одному методу решает нашу проблему.
 
 Например, в Amazon – покупка с одного клика – как много систем задействовано в операции покупки? И проверка платежной карточки, и проверка Вашего адреса, проверка товара на складе, проверка или возможна доставка данного товара в данную точку мира… В результате очень много действий которые происходят всего по одному клику.
 */

final class Machine {
    enum State {
        case notRunning
        case ready
        case running
    }
    
    private(set) var state: State = .ready
    
    func startMachine() {
        print("Process starting...")
        state = .ready
        state = .running
        print("Machine is running")
    }
    
    func stopMachine() {
        state = .notRunning
        print("Machine stopped")
    }
}

final class RequestManager {
    
    var isConnected: Bool = false
    
    func connectToTerminal() {
        print("Connecting to terminal...")
        isConnected = true
    }
    
    func disconnectToTerminal() {
        print("Disconnecting to terminal...")
        isConnected = false
    }
    
    func getStateRequest(for machine: Machine) -> Machine.State {
        print("Sending state request...")
        return machine.state
    }
    
    func sendStartRequest(for machine: Machine) {
        print("Sending request to start machine")
        machine.startMachine()
    }
    
    func sendStopRequest(for machine: Machine) {
        print("Sending request to stop machine")
        machine.stopMachine()
    }
}


// Basic implemention without Facade

let machine = Machine()
let manager = RequestManager()

if !manager.isConnected {
    manager.connectToTerminal()
}

if manager.getStateRequest(for: machine) == .ready {
    print("Machine is ready...")
    manager.sendStartRequest(for: machine)
}


// Implemention with Facade

protocol Facade {
    func startMachine()
}

final class ConcreteFacade: Facade {
    func startMachine() {
        let machine = Machine()
        let manager = RequestManager()
        
        if !manager.isConnected {
            manager.connectToTerminal()
        }
        
        if manager.getStateRequest(for: machine) == .ready {
            print("Machine is ready...")
            manager.sendStartRequest(for: machine)
        }
    }
}

let simpleInterfaceToStartMachine = ConcreteFacade()
simpleInterfaceToStartMachine.startMachine()


// Repeat #1 - Car Example
print("")

final class Car {
    enum State {
        case notRunning
        case ready
        case running
    }
    
    private(set) var state: State = .ready
    
    func startCar() {
        print("Car is ready to start...")
        state = .ready
        state = .running
        print("Car is running")
    }
    
    func stopCar() {
        state = .notRunning
        print("Car stopped")
    }
}

final class RemoteManager {
    var isConnected: Bool = false
    
    func connectTerminal() {
        print("Terminal is connecting...")
        isConnected = true
    }
    
    func disconnectTerminal() {
        print("Terminal is disconnecting...")
        isConnected = false
    }
    
    func getStateRequest(for car: Car) -> Car.State {
        print("Sending request for car state...")
        return car.state
    }
    
    func sendStartRequest(for car: Car) {
        print("Sending request to start a car...")
        car.startCar()
    }
    
    func sendStopRequest(for car: Car) {
        print("Sending request to stop a car...")
        car.stopCar()
    }
}

// Basic implemention
let car = Car()
let remote = RemoteManager()

if !remote.isConnected {
    remote.connectTerminal()
}

if remote.getStateRequest(for: car) == .ready {
    car.startCar()
}

// implement with DP Facade
print("")

protocol CarControl {
    func startCar()
}

final class SimpleControl: CarControl {
    func startCar() {
        let car = Car()
        let remote = RemoteManager()
        
        if !remote.isConnected {
            remote.connectTerminal()
        }
        
        if remote.getStateRequest(for: car) == .ready {
            car.startCar()
        }
    }
}

let carControl = SimpleControl()
carControl.startCar()

// Repeat #2 - TV Example
print("")

final class TV {
    enum State {
        case on
        case off
    }
    
    private(set) var state: State = .off
    
    func turnOn() {
        print("TV is turn on")
        state = .on
    }
    
    func turnOff() {
        print("TV is turn off")
        state = .off
    }
}

final class Remote {
    var isConnectedToTV: Bool = false
    
    func connectToTV() {
        print("Send request to connect...")
        isConnectedToTV = true
    }
    
    func disconnectToTV() {
        print("Send request to disconnect...")
        isConnectedToTV = false
    }
    
    func getStatus(for tv: TV) -> TV.State {
        print("Send request about TV status...")
        return tv.state
    }
    
    func sendTurnOnRequest(for tv: TV) {
        print("Sending request to turn TV on...")
        tv.turnOn()
    }
    
    func sendTurnOffRequest(for tv: TV) {
        print("Sending request to turn TV off...")
        tv.turnOff()
    }
}

// Basic implemention
let tv = TV()
let remoteForTV = Remote()

if !remoteForTV.isConnectedToTV {
    remoteForTV.connectToTV()
}

if remoteForTV.getStatus(for: tv) == .off {
    print("Try to turn TV on...")
    tv.turnOn()
    remoteForTV.disconnectToTV()
}

// Implement the same result with Facade
print("")

protocol ManageTV {
    func turnOnTV()
}

final class RemoteFacade: ManageTV {
    func turnOnTV() {
        let tv = TV()
        let remoteForTV = Remote()
        
        if !remoteForTV.isConnectedToTV {
            remoteForTV.connectToTV()
        }
        
        if remoteForTV.getStatus(for: tv) == .off {
            print("Try to turn TV on...")
            tv.turnOn()
            remoteForTV.disconnectToTV()
        }
    }
}

let remoteInterface = RemoteFacade()
remoteInterface.turnOnTV()
