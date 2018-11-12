/*
 Стратегия - поведенческий шаблон проектирования, который определяет семейство схожих алгоритмов и помещает каждый из них в собственный класс, обеспечивая их взаимозаменяемости.
 
 Позволяет использовать композицию, вместо наследования. Композиция - это связь типа “имеет”, а наследование - связь типа “является”.
*/

import UIKit

protocol FilterStrategy {
    func process(image: UIImage) -> UIImage
}

final class Filter {
    var concreteFilter: FilterStrategy?
    
    func applyFilter(image: UIImage) {
        concreteFilter?.process(image: image)
        print("Filter apllied")
    }
}

final class SepiaFilter: FilterStrategy {
    func process(image: UIImage) -> UIImage {
        print("Proccessing SEPIA filter...")
        return image
    }
}

final class HighContrastFilter: FilterStrategy {
    func process(image: UIImage) -> UIImage {
        print("Proccessing HIGH CONTRAST filter...")
        return image
    }
}

let filter = Filter()
let image = UIImage()

filter.concreteFilter = HighContrastFilter()
filter.applyFilter(image: image)

filter.concreteFilter = SepiaFilter()
filter.applyFilter(image: image)
