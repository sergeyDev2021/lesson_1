import UIKit

// MARK: - Properties / Methods
// ref: https://medium.com/@vialyx/swift-course-properties-methods-c6b776167e0a


// MARK: - Properties


// Stored Properties
struct Car {
    let vin: String
    var number: String?
}

var newCar = Car(vin: "ZNA123051252OK", number: nil)
newCar.number = "4440PX7"
// Error, vin is constant
// newCar.vin = ""
let car = newCar
// Error, car is constant of value type
// car.number = "0000MI7"


// Lazy Stored Properties
class EpayBillingProcessor {
    
    var view: UIView?
    private lazy var innerView: UIView? = { [unowned self] in
        guard let `view` = self.view else {
            return UIView(frame: .zero)
        }
        return view
        }()
    
    var value: String = ""
    lazy var lazyValue: String = {
        return "lazy"
    }()
    
    func pay() {
//        guard
//        innerView?.layer
//
//        innerView?.accessibilityIdentifier
//
//        innerView.su
    }
    
}

let service = EpayBillingProcessor()
service.value
service.value = ""
//service.lazyValue


// Computed Properties
extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
}

let view = UIView()
view.cornerRadius = 8.0

print("\(view.cornerRadius)")

// Read-Only Computed Properties
struct Payment {
    
    var amount: Float
    var comission: Float
    
    var totalAmount: Float {
        return amount + comission
    }
    
}


// Property Observers
struct Pin {
    
    var value: String {
        willSet {
            // old value
            if newValue.count == 4 {
                // clear cache
            }
            print("new pin value: \(newValue)")
        }
        didSet {
            // new value
            if value.count == 4 {
                // check
            }
            print("old pint value: \(oldValue)")
        }
    }
    
}

struct Wallet {
    
    var amount: Float {
        didSet {
            check()
        }
    }
    
    func check() {
        print("\(amount)")
    }
    
}

var wallet = Wallet(amount: 1.0)
wallet.amount = 10

// Global and Local Variables
var globalVariable = "globalString"

func fly() {
    var localVariable = "localString"
    print("\(localVariable)")
    localVariable = ""
}

struct Airplane {
    // Local Variable
    var number: String
}


// Type Properties
struct PropertyStruct {
    
    var type: String = ""
    
    static var storedTypeProperty: String = ""
    static var computedTypeProperty: Double {
        return 10.0
    }
    
}

PropertyStruct.computedTypeProperty

print("struct type property: \(PropertyStruct.storedTypeProperty)")
PropertyStruct.storedTypeProperty = "2"
print("struct type property: \(PropertyStruct.storedTypeProperty)")

enum PropertyEnum {
    
    static var storedTypeProperty = "1"
    static var computedTypeProperty: Double {
        return 10.0
    }
    
}

print("enum type property: \(PropertyEnum.storedTypeProperty)")
PropertyEnum.storedTypeProperty = "2"
print("enum type property: \(PropertyEnum.storedTypeProperty)")

class PropertyClass {
    
    static var storedTypeProperty = "1"
    static var computedTypeProperty: Double {
        return 10.0
    }
    class var overrideableComputedTypeProperty: Double {
        return 10.0
    }
    
}

class PropertyChildClass: PropertyClass {
    
    override class var overrideableComputedTypeProperty: Double {
        return 20.0
    }
    
}

PropertyClass.overrideableComputedTypeProperty
PropertyChildClass.overrideableComputedTypeProperty

print("class type property: \(PropertyClass.storedTypeProperty)")
PropertyClass.storedTypeProperty = "2"
print("class type property: \(PropertyClass.storedTypeProperty)")

typealias UserName = String

//let name: String = ""
//let name: UserName = ""

// MARK: - Methods


// Instance Methods
class Player {
    
    var playing: Bool = false
    
    init() {
//        super.init()
        self.playing = false
    }
    
    func play() {
        playing = true
    }
    
    func stop() {
        playing = false
    }
    
    func restore(playing: Bool) {
        self.playing = playing
        self.play()
    }
    
}

let playerInstance = Player()
playerInstance.play()
playerInstance.stop()
playerInstance.restore(playing: false)

func flobal() {
    
}


// The self Property
// Look at restore "self"


// Modifying Value Types from Within Instance Methods
struct NameComponents {
    
    var firstName: String
    var lastName: String
    
    mutating func change(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
}


// Type Methods
struct PropertyStructM {
    
    static func typeMethod() {
        print("\(self) typeMethod")
    }
    
}

PropertyStructM.typeMethod()

enum PropertyEnumM {
    
    static func typeMethod() {
        print("\(self) typeMethod")
    }
    
}

PropertyEnumM.typeMethod()

class PropertyClassM {
    
    static func typeMethod() {
        print("\(self) typeMethod")
    }
    class func overreadableTypeMethod() {
        print("\(self) overreadableTypeMethod")
    }
    
}

PropertyClassM.typeMethod()
PropertyClassM.overreadableTypeMethod()

/*
****************************************************************************************************************************************************************
*/

// TODO: - Your work

// MARK: - Properties / Methods
// ref: https://medium.com/@vialyx/swift-course-properties-methods-c6b776167e0a

/*
 - Создать произвольный новый тип struct c 2-мя stored properties
 - Что такое stored property?
 */

/*
 - Создать произвольный новый тип class с 2-мя stored properties let
 - Добавить lazy property, который будет вычисляться на основе значений stored properties
 - Что такое lazy property?
 */

/*
 - Создать произвольный новый тип с computed property Float
 - Задача computed property округлять значение и присваивать его в private stored property Int
 - Что такое computed property?
 */

/*
 - Используя тип из предыдущего задания расширить его и добавить read-only computed property
 - Что такое read-only computed property?
 */

/*
 - Применить property observers для типа который использовали в предыдущем задании. Имеет ли это смысл?
 - Продемонстрировать применение property observers. Задача: В типе с двумя stored property (пример firstSP, secondSP) выполнять перерассчет 3 stored property (пример thirdSP) вызывая внутренний метод (пример recalculate) на изменение willSet для firstSP (использовать новое значение), didSet для secondSP
 - В чем отличие willSet / didSet? Почему не получилось выполнить пункт 1 из задания?
 */

/*
 - Продемонстрировать global / local properties & func's
 - В чем их отличие?
 */

/*
 - Продемонстрировать Type properties & func's для struct, enum, class
 - В чем отличие instance от type properties & func's?
 - В чем отличие от static / class?
 - Какие по типу static property? Stored / Lazy / Computed?
 */

/*
 - Создать новый произвольный тип
 - Добавить в тип несколько методов
 - Продемонстрировать обращение с self property
 - Что это такое?
 */

/*
 - Продемонстрировать работу mutating method
 - Для какие целей он применим?
 - Необходимо ли его применять для class типов?
 */

/*
 - Произвольное задание на тему structures / classes / properties / methods
 - Напишите пример использования примеов не описаных в уроке, которые вы нашли самостоятельно
 */

// MARK: - Inheritance, Initialization & Deinitialization
// ref: https://medium.com/@vialyx/swift-course-inheritance-initialization-deinitialization-ef53ccb4cf92

/* Subclassing
 - Создайте произвольный класс (пример BaseClass) с несколькими property (пример rate, gross) и methods (пример send, flush)
 - Создайте производный класс (пример ChildClass) в качестве родительского класса укажите класс из предыдущего шага
 - Продемострируйте использование property и method из обоих классов (возмите к примеру наш любимый print)
 - Какими property и method обладает производный из шага 2? Что проишошло при наследовании Child от Parent класса?
 */

/* Overriding
 - Для родительского класса из предыдущего пример переопределите
    - у первого property - observers (добавьте will / did Set)
    - у второго property - getter / setter (сделайте его computed property)
    - у первого method - переопределите логику без обращения к super.method
    - у первого method - переопределите логику c обращенем к super.method
 */

/* Preventing Overrides
 - Создайте произвольный класс
 - Предотвратите наследование от данного класса
 */

/* Preventing Overrides
 - Создайте произвольный класс
 - Предотвратите переопределение его property и method
 */

/* Setting Initial Values for Stored Properties
 - Напишите класс с есколькими property
 - Напишите инициализатор в котором будете задачать все изначальные значения дл яproperty
 - Попробуйте проделить установку изначальный значение с помощью 'Default Property Values'
    - пример var property: Int = 0
 - Прокачайте функцию init:
    - Объявите для каждого параметра внешние label
    - Установите для каждого параметра значение по умолчанию
 */

/* Optional Property Types
 - Создайте класс
 - Объявите в нем несколько property, некоторые объявите как optional '?'
 - Напишите инициализатор для класса
 - Нужно ли заботиться об инициализации Optional? Почему?
 */

/* Class Inheritance and Initialization
 - Создайте произвольный класс
 - Напишите 2 инициализатора для класса
 - Напишите convenience инициализатор для класса
 - В чем отличие обязательного инициализатора от удобного?
 */

/*
 - Создайте производный класс от класса из предыдущего задания
 - Напишите convenience для класса
 - Переопределите инициализатор родительского класса
 - Напишите Failable инициализатор для класса
 - Что произошло при попытке переопределить инициализатор родительского класса?
 - В чем принцип работы Failable инициализатора?
 */

/* Deinitialization
 - Продемонстрируйте работу функции deinit
 - Задача: обнуление всех значений property класса
 */
