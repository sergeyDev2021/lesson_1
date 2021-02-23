import UIKit

// MARK: - Generics

// The Problem That Generics Solve

func swapTwo(_ a: inout Int, _ b: inout Int) {
    (a, b) = (b, a)
}

var x = 4
var y = 7

swapTwo(&x, &y)

// What about two string, double, etc. ???

print("x: \(x)")
print("y: \(y)")
/*
 x: 7
 y: 4
 */

// Generic solution
func swapTwoGenerics<T>(_ a: inout T, _ b: inout T) {
    (a, b) = (b, a)
}

swapTwoGenerics(&x, &y)

print("x: \(x)")
print("y: \(y)")
/*
 x: 4
 y: 7
 */

var first = "1"
var second = "2"

swapTwoGenerics(&first, &second)

print("first: \(first)")
print("second: \(second)")
/*
 first: 2
 second: 1
 */

// Generic Types

struct Buffer<Element> {
    
    enum BufferError: Error {
        case outOfBounds
    }
    
    private var items: [Element] = []
    
    mutating func add(_ item: Element) {
        items.append(item)
    }
    
    func get(index: Int) throws -> Element {
        guard index < items.count else {
            throw BufferError.outOfBounds
        }
        return items[index]
    }
    
}

var stringBuffer = Buffer<String>()
stringBuffer.add("New String")
stringBuffer.add("ViVa")

(0...3).forEach {
    do {
        let itemFromBuffer = try stringBuffer.get(index: $0)
        print("itemFromBuffer: '\(itemFromBuffer)' at index: \($0)")
    } catch {
        print("\(error) at index: \($0)")
    }
}
/*
 itemFromBuffer: 'New String' at index: 0
 itemFromBuffer: 'ViVa' at index: 1
 outOfBounds at index: 2
 outOfBounds at index: 3
 */

var intBuffer = Buffer<Int>()
intBuffer.add(1)
intBuffer.add(100)
intBuffer.add(3000)

(0...3).forEach {
    let intItem = try? intBuffer.get(index: $0)
    print("intItem: '\(String(describing: intItem))' at index: \($0)")
}
/*
 intItem: 'Optional(1)' at index: 0
 intItem: 'Optional(100)' at index: 1
 intItem: 'Optional(3000)' at index: 2
 intItem: 'nil' at index: 3
 */

// Extending a Generic Type

extension Buffer {
    
    var isEmpty: Bool {
        return items.isEmpty
    }
    
    var middle: Element? {
        return try? get(index: items.count / 2)
    }
    
}

var doubleBuffer = Buffer<Double>()
doubleBuffer.add(9.2)
doubleBuffer.add(3.54)
doubleBuffer.add(13.04)

print("middle: \(String(describing: doubleBuffer.middle))")
/*
 middle: Optional(3.54)
 */

// Generic Extension

protocol ReusableViewType: class {
    static var defaultReuseIdentifier: String { get }
    static var nib: UINib { get }
}

extension ReusableViewType where Self: UIView {
    
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self)
    }
    
    static var nib: UINib {
        let bundle = Bundle(for: Self.self)
        let nibName = NSStringFromClass(self).components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib
    }
    
}

extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableViewType {
        register(T.nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
}

class Cell: UITableViewCell, ReusableViewType {}

let tableView = UITableView()
// Regular Cell registration
tableView.register(UINib(nibName: "Nib", bundle: Bundle.main), forCellReuseIdentifier: "CellIdentifier")

// Constrainted generic extension in Action
tableView.register(Cell.self)

// Associated Type

protocol APIObjectMapping {
    associatedtype Object
    static func with(object: Object?) -> Self?
}

protocol ClientObjectMapping {
    associatedtype Object
    var object: Object? { get }
}

protocol MappingProtocol: APIObjectMapping, ClientObjectMapping {}


enum TaskType: String, Codable {
    case unknown
    case activity
}

func doubleOptional() throws -> String? {
    let string: String? = "1"
    return string
}

let optional = try? doubleOptional()

// MARK: - APIObjectMapping
extension TaskType: APIObjectMapping {
    
    typealias Object = String
    
    static func with(object: Object?) -> TaskType? {
        return TaskType(rawValue: object ?? "")
    }
    
}

/*
 ****************************************************************************************************************************************************************
 */

// TODO: - Your work

// MARK: - Generics

/*
 - Создать Generic функцию для random выбора элемента из коллекции
 - Входящие параметры: array
 - Результат: элемент массива
 */

/*
 - Создать новый Generic тип (enum, struct, class на выбор)
 - Сделать несколько функций и проперти
 - Как идею можно взять list, dictionary, array
 */

/*
 - Сделать Constrainted Generic Extension func compare
 - Функция должна работать с любыми типами реализующими protocol Numeric
 - Задача функции: сравнивать элементы
 */

/*
 - Сделать protocol с associatedtype и функцией возвращающей результат associatedtype
 - Имплементировать protocol для 2х структур и продемонстрировать работу протокола
 */
