import UIKit

// MARK: - Inheritance
// ref: https://medium.com/@vialyx/swift-course-inheritance-initialization-deinitialization-ef53ccb4cf92

// Base class
class Player {
  
  var playing: Bool = false
  
  func play() {
       playing = true
  }
  
  func stop() {
       playing = false
  }
  
  func restore(playing: Bool) {
       self.playing = playing
  }
  
}

// Subclass of Player
class VideoPlayer: Player {
  
     var file: String?
     var width: Int?
     var height: Int?
  
}

// Subclass with overridong parent properties/functions
class AudioPlayer: Player {
  
     // Overriding Property Observers
     override var playing: Bool {
          didSet {
               print("\(self) did set playing")
          }
     }
  
     // Overriding Methods
     override func restore(playing: Bool) {
          print("\(self) restore playing: \(playing)")
     }
  
}

// MARK: - Extensions
// ref: https://medium.com/@vialyx/swift-course-extensions-protocols-bc1c8b079238

// UIView class extension
extension UIView {
  
    // new functionality to add to SomeType goes here
  
}

// Protocol conformance in extension
extension Int: Hashable {
  
    // implementation of protocol requirements goes here
  
}

// MARK: - Protocols

protocol ActivityIndicatorProtocol: class {
    var activityIndicator: UIView? { get set }
}

// Default Implementation of protocol
extension ActivityIndicatorProtocol {
    
    var activityIndicator: UIView? {
        get {
            // getter code
            return nil
        }
        set {
            // setter code
            print("\(String(describing: newValue))")
        }
    }
    
}

/*
 ****************************************************************************************************************************************************************
 */

// TODO: - Your work

// MARK: - Inheritance
/*
 - Создать базовый класс Engine c функциями start, stop
 - Создать дочерний класс SmartEngine унаследованный от класса Engine в котором будет реализовать функция restart в реализации выполняющая функции stop, start.
 - Создать дочерний класс AutomaticEngine унаследованный от класса SmartEngine в котором будут переопределены функции start stop в которых будут учитываться колчичества обращений к этим функциям. Добавить функции printStartCount для вывода в консоль количество обращений к функции start. *Класс AutomaticEngine нельзя использовать для наследования - он финальный.
 */

// MARK: - Extensions
/*
 - Создать структуру Car с properties: color, model, id
 - Реализовать protocol Equatable в Car extension
 - Сделать Car extension для поддержки CustomStringConvertible для распечатки Car instance в формате '{color: $color, model: $model, id: $id}'
 */

// MARK: - Protocols
/*
 - Создать протокол Identifiable c computed property id
 - Создать структуру Person с реализацией протокола Identifiable
 - Создать протокол Printable c func print() с имплементацией по умолчанию в которой функция print() будет выводить в консоль self.
 */
