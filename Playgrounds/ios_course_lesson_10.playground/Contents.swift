import UIKit

// MARK: Access Control

// ref: https://medium.com/@vialyx/swift-course-access-control-type-casting-39570d00e582

// enable entities to be used within any source file from their defining module, and also in a source file from another module that imports the defining module.
public var publicVariable = 0
// enables entities to be used within any source file from their defining module, but not in any source file outside of that module.
internal let internalConstant = 1
// access restricts the use of an entity to its own defining source file.
fileprivate var fileprivateVariable = 2
// restricts the use of an entity to the enclosing declaration, and to extensions of that declaration that are in the same file.
private let privateConstant = 3

class PrivateClass {
    
    fileprivate func run() {
        
    }
    
}

// NewType.swift

class PublicClass {
    
    var privateValue: PrivateClass = PrivateClass()
    
    func drive() {
        privateValue.run()
    }
    
}

// NewType+UIView.swift

extension PublicClass {
    
    func drive(on view: UIView) {
        
    }
    
}

// MARK: - Advanced Operators

postfix operator ~~~

struct Engine {
    var tank: Float
    var consumption: Float
    var distance: Float
    var consumptionTarget: Float?
    
    static prefix func ~ (engine: Engine) -> Engine {
        return Engine(tank: engine.tank,
                      consumption: engine.consumption,
                      distance: engine.distance,
                      consumptionTarget: engine.distance / engine.tank)
    }
    
    static postfix func ~~~ (engine: Engine) -> Engine {
        return Engine(tank: engine.tank,
                      consumption: engine.consumption,
                      distance: engine.tank / engine.consumption * 100,
                      consumptionTarget: engine.consumptionTarget)
    }
    
}

let truck = Engine(tank: 400.0, consumption: 20.0, distance: 1300.0, consumptionTarget: nil)
let calculatedTruck = ~truck

print("target: \(String(describing: calculatedTruck.consumptionTarget))")
/*
 target: Optional(3.25)
 */

let maxDistanceTruck = truck~~~

print("max distance: \(String(describing: maxDistanceTruck.distance))")
/*
 max distance: 2000.0
 */

infix operator +++: AdditionPrecedence

extension Engine {
    
    static func +++ (left: Engine, right: Engine) -> Engine {
        let tank = max(left.tank, right.tank)
        let consumption = min(left.consumption, right.consumption)
        return Engine(tank: tank,
                      consumption: consumption,
                      distance: tank / consumption * 100,
                      consumptionTarget: nil)
    }
    
}

let badTruck = Engine(tank: 100, consumption: 8, distance: 250, consumptionTarget: nil)
let goodTruck = Engine(tank: 500, consumption: 20, distance: 250, consumptionTarget: nil)
let bestTruck = badTruck+++goodTruck

print("The best truck is \(bestTruck)")
/*
 The best truck is Engine(tank: 500.0, consumption: 8.0, distance: 6250.0, consumptionTarget: nil)
 */

/*
 ****************************************************************************************************************************************************************
 */

// TODO: - Your work

// MARK: - Access Controll

/*
 - Сделать открытый класс BaseHandler с приватной функцией handle(string: address)
 - Сделать дочерний класс SocialHandler унаследованный от BaseHandler с переопределением функции handle(string: address)
 - Создать приватный в рамках одного файла класс SocialEngine и разместить его в
SocialHandler как приватный property.
 - Задействовать экземпляр SocialHandler в функции handle(string: address) для печати строки
 */

// MARK: - Advanced Operators

/*
 - Создать оператор prefix
 - Создать оператор postfix
 - Создать оператор infix
 */
