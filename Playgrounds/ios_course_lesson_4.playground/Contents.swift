import UIKit

// MARK: - Enumerations

// Enumeration Syntax

/*
 To create a simple enumeration just type ‘enum’.
 
 Here’s an example with email validation error
 */

enum EmailValidationError {
    // TODO: - Cases
    case empty
    // TODO: - Cases can be declared on a single line
    case noDomain, invalid
}

/*
 NOTE
 Unlike C and Objective-C, Swift enumeration cases are not assigned a default integer value when they are created.
 
 Each enum defines a new type. Their names must start with a capital letter.
 */


// TODO: - Create a new error
var error = EmailValidationError.empty
// TODO: - OR type-inferred
var signupError: EmailValidationError = .invalid
error = .noDomain

// Matching enum values

/*
 You can match enum using switch statement or if condition.
 */

switch error {
case .empty:
    print("Please provide email")
case .noDomain:
    print("Add domain")
case .invalid:
    print("Entered email looks like invaid")
}

if signupError == .invalid {
    print("Entered email looks like invaid")
}

// Iterating over enum cases

extension EmailValidationError: CaseIterable {}

print("All cases: \(EmailValidationError.allCases)")
// TODO: - Just print all enum cases

// Associated Values

/*
 You can define Swift enumerations to store associated values of any given type, and the value types can be different for each case of the enumeration if needed. Enumerations similar to these are known as discriminated unions, tagged unions, or variants in other programming languages.
 */

enum ValidationError {
    // TODO: - Cases
    case empty
    // TODO: - Cases can be declared on a single line
    case noDomain(String)
    case invalid(String)
}

// TODO: - Create a new error
var validationError = ValidationError.empty
// TODO: - OR type-inferred
var signupValidationError: ValidationError = .invalid("maxxxxxxx.com")
validationError = .noDomain("max@")

// MARK: - Matching
switch validationError {
case .empty:
    print("Please provide email")
case .noDomain(let email):
    print("Add domain: \(email)")
case .invalid(let email):
    print("Entered email looks like invaid: \(email)")
}

if case let .invalid(email) = signupValidationError {
    print("Entered email looks like invaid: \(email)")
}

// Raw Values and Computed Properties

/*
 A value (known as a “raw” value) is provided for each enumeration case, the value can be a string, a character, or a value of any integer or floating-point type.
 */

enum Weekday: Int {
    case sun
    case mon
    case tue
    case wed
    case thur
    case fri
    case sat
    
    var value: String {
        switch self {
        case .sun:
            return "sun"
        case .mon:
            return "mon"
        case .tue:
            return "tue"
        case .wed:
            return "wed"
        case .thur:
            return "thur"
        case .fri:
            return "fri"
        case .sat:
            return "sat"
        }
    }
}

let dayNumber = 1
let weekday = Weekday(rawValue: dayNumber)
print("weekday name: \(String(describing: weekday?.value))")

// Protocols support and Extensions

/*
 The most simple example is Error protocol conformance and extension for LocalizedError protocol.
 */

extension EmailValidationError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .invalid:
            return "This email is incorrect. Please, try again"
        case .empty:
            return "This email is empty. Please, fill it"
        case .noDomain:
            return "This email without domain. Please, try again"
        }
    }
    
}

print("error: \(error.localizedDescription)")

// MARK: - Structures / Classes
// ref: https://medium.com/@vialyx/swift-course-structures-classes-2f825714ed63

/*
 Flexible constructions that help you to build your programm.
 */


// Definition Syntax
struct YourStructure {
    // Definition
}
class YourClass {
    // Definition
}

class ChildYourClass: YourClass {}


// Example
struct Fine {
    
    var id: String = UUID().uuidString
    var date: Date? = Date()
    var number: String = ""
    var amount: NSNumber = NSNumber(value: 0.0)
    
    func doSmth() {}
    
}

typealias IAPServiceRetriveResult = () -> Void
typealias IAPServicePurchaseResult = () -> Void
typealias IAPServiceRestoreResult = () -> Void

class IAPService {
    
    var serviceName: String = ""
    let constant: String = ""
    
    func loadProducts() {}
    func loadProducts(completion: @escaping IAPServiceRetriveResult) {}
    func purchase(productID: String, completion: @escaping IAPServicePurchaseResult) {}
    func restore(completion: @escaping IAPServiceRestoreResult) {}
    
}

extension Fine {
    
    func donsmth() {}
    
}

extension IAPService {
    
    func dosmth() {}
    
}


// Structure and Class Instances
let fine = Fine()
let iabService = IAPService()


// Accessing Properties
print("fine id: \(fine.id)")



iabService.loadProducts()


// Memberwise Initializers for Structure Types
let newFine = Fine(id: UUID().uuidString, date: Date(), number: "104520", amount: NSNumber(value: 12.5))

// Structures and Enumerations Are Value Types
let speedCamFine = Fine(id: UUID().uuidString, date: Date(), number: "104520", amount: NSNumber(value: 12.5))
var highSpeedFine = speedCamFine
highSpeedFine.id = UUID().uuidString
highSpeedFine.number = "708908"

print("speedCamFine number: \(speedCamFine.number)")
print("highSpeedFine number: \(highSpeedFine.number)")


// Classes Are Reference Types
class User: Equatable {
    var name: String?
    var source: String?
    
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name
    }
    
}

let guest = User()
guest.source = "Facebook"

let newUser = guest
newUser.name = "Medusa"

print("guest name: \(String(describing: guest.name))")
print("newUser name: \(String(describing: newUser.name))")
print("\(newUser.name == guest.name)")


// Identity Operators
let existedUser = User()
let adminUser = User()
let superUser = existedUser

if existedUser !== adminUser {
    print("existedUser, adminUser both refer to same instance")
}

if existedUser === superUser {
    print("existedUser, superUser both refer to same instance")
}

/*
 ****************************************************************************************************************************************************************
 */

// TODO: - Your work

// MARK: - Enumerations

/*
 - Обявите произвольный enum
 - Создайте произвольную функцию в enum значение которой будет зависить от self case
 */

// Example
enum iOS {
    case ten
    case evelen
    case twelve
}

extension iOS {
    
    var title: String {
        switch self {
        case .evelen:
            return "evelen"
        case .twelve:
            return "Gotcha!"
        default:
            return "old"
        }
    }
    
}

/* RawValue
 - Используйте enum из предыдущего значения
 - Сделайте conform to Inte 'enum Name: Int'
 - Создайте enum case используя rawValue
 */

/* Associated Values
 - Используйте enum из первого задания для enum
 - К каждому case закрепите произвольное Associated Value
 - Сделайте Computed property 'var value: String { .... }' которая будет возвращать associated value в строковом значении
 */

// MARK: - Structures / Classes
// ref: https://medium.com/@vialyx/swift-course-structures-classes-2f825714ed63

/*
 - Создайте новый тип struct (пример StructType) с stored property (пример property) и method (пример method)
 - Объявить переменную экземпляра (пример variableStruct) типа созданного выше. Воспользоваться default конструктором
 - Создайте новый тип class (пример ClassType) с stored property (пример property) и method (пример method)
 - Объявить константу экземпляра (пример constantClass) типа созданного выше. Воспользоваться default конструктором
 - Выполнимо ли задание в каждом описанном выше шаге? Почему?
 */

/*
 - Объявить константу (пример constantStruct) в которую присвоить значение экземпляра variableStruct из предыдущего задания
 - Изменить значение property у константы constantStruct на любое значение
 - Изменить значение property у переменной variableStruct на любое значение
 - Сравнить значения property у переменной и константы. Будут ли они равны?
 - Выполнимо ли задание в каждом описанном выше шаге? Почему?
 */

/*
 - Объявить переменную (пример variableClass) в которую присвоить значение экземпляра constantClass из 1-го задания
 - Изменить значение property у константы constantClass на любое значение
 - Изменить значение property у переменной variableClass на любое значение
 - Сравнить значения property у переменной и константы. Будут ли они равны?
 - Применить Identity Operator для сравнения ссылок на экземпляр класса. Будут ли ссылаться на один и тот же экземпляр или каждая переменная/константа будут ссылаться на новый экземпляр. Почему?
 - Выполнимо ли задание в каждом описанном выше шаге? Почему?
 */
