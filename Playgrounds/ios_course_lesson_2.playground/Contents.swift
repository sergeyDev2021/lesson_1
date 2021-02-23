import UIKit

// MARK: - Control Flow

// Loops, pattern matching

enum PersonalAccount {
    case credit(amount: Int64, id: UInt)
    case debit(amount: UInt64, id: UInt)
}

let accounts: [PersonalAccount] = [.credit(amount: -1000, id: 1),
                                   .debit(amount: 1000, id:2),
                                   .credit(amount: -1000000, id: 3)]

// MARK: Regular construction
for account in accounts {
    if case let .credit(amount, id) = account {
        print("amount: \(amount) id: \(id)")
    }
}

// MARK: Using pattern matching
for case let .credit(amount, id) in accounts {
    print("amount: \(amount) id: \(id)")
}

/*
 amount: -1000 id: 1
 amount: -1000000 id: 3
 */

// MARK: One more example using 'where' keyword
let views: [UIView] = [UIButton(), UILabel(), UIScrollView(), UILabel()]

for view in views where view is UILabel {
    print("view class: \(view.self)")
}

// Statements if, switch

enum Gender {
    case unknown
    case male
    case female
}

struct User {
    let name: String
    let gender: Gender
}

let users = [User(name: "Guest", gender: .unknown),
             User(name: "Maxim Vialyx", gender: .male),
             User(name: "Guest", gender: .unknown)]

for user in users where user.gender == .unknown {
    print("guest: \(user)")
}
/*
 In this example we used 'where' keyword to filter users collection.
 */

// MARK: Using switch
for user in users {
    switch user.gender {
    case .male:
        print("male: \(user)")
    case .female:
        print("female: \(user)")
    default:
        print("guest: \(user)")
    }
}
/*
 Simple switch usage example with enum switching
 */

// MARK: Using typle switching
for user in users {
    switch (user.gender, user.name) {
    case (.unknown, "Guest"):
        print("guest: \(user)")
    default:
        break
    }
}
/*
 Typle switching (Gender, String).
 Only users with .unknown gender and "Guest" name switched to guest case
 */

// Continue, break, throw

// MARK: Continue, break, throw
let numbers: [Int] = [1, 2, 3, 4, 5, 10, 11, 20]

// MARK: continue
var evenSum = 0
for number in numbers {
    if number % 2 != 0 { continue }
    
    evenSum += number
}
/*
 Calculate sum of even numbers.
 Skip not even numbers using 'continue' keyword.
 */

print("even summ: \(evenSum)")

// MARK: - break
var position = 0
let findNumber = 10
for (index, number) in numbers.enumerated() {
    if number == findNumber {
        position = index
        break
    }
}
/*
 Find number position in array.
 Stop loop using 'break' keyword when number has been found.
 */

print("number position: \(position)")

// MARK: return
enum MachingError: Error {
    case NotEnoughtCharacters(count: Int)
}

enum CollectionError: Error {
    case Empty
}

func joinKeys(lhs: String, rhs: String) throws -> String {
    let minCount = 5
    if lhs.isEmpty || rhs.isEmpty { throw CollectionError.Empty }
    if lhs.count < minCount || rhs.count < minCount { throw MachingError.NotEnoughtCharacters(count: minCount) }
    
    return lhs + rhs
}

do {
    try joinKeys(lhs: "", rhs: "")
} catch is CollectionError {
    print("empty")
} catch MachingError.NotEnoughtCharacters(let count) {
    print("maching error min count: \(count)")
}
/*
 That is better way than return nil value.
 - Throwing works faster
 - That is clear to understand when you receive CollectionError instead of nil result
 */

// guard powerful / limitations

typealias JSON = [String: Any?]

struct Account {
    let udid: String
    let token: String
}

extension Account {
    
    init?(json: JSON) {
        guard let udid = json["udid"] as? String,
            let token = json["token"] as? String else {
                return nil
        }
        
        self.udid = udid
        self.token = token
    }
    
}

let json: JSON = ["udid": "1234-adfsdfg-12312f-asfsa", "token": nil]
let account = Account(json: json)
/*
 That example demostrate how to work 'guard' construction.
 'guard' has inverse logic from if statement. store variables in context to use it after condition.
 Be attentive with guard. It's require more time for compile step.
 */

// API availability condition

var color: UIColor?

if #available(iOS 11, *) {
    // Use iOS 11 APIs on iOS
    color = UIColor(named: "green_color_from_asset_folder")
} else {
    // Fall back to earlier iOS APIs
    color = UIColor.green
}
/*
 Use this construction to check availability.
 Use modern APIs where it possible.
 */


/*
 ****************************************************************************************************************************************************************
 */

// TODO: - Your Work

// MARK: - Collection Types

/*
 ref: https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html
 */

/*
 - Объявить пустую структуру Plain
 - Создать пустой массив структур Plain
 - Добавить новый экземляр в массив используя команду append
 - Удалить последний элемент из массива
 - Добавить новый экземляр в массив используя команду append
 - Удалить первый элемент из массива
 - Добавить новый экземляр в массив используя команду append
 - Удалить все элементы из массива
 - Добавить новый экземляр в массив используя команду append
 - Удалить элемент по index 1 из массива
 */

/*
 - Объявить пустую структуру Object
 - Создать массив objArrray с 2мя Object
 - Создать массив itemsArrray с 1мя Object
 - Сложить 2 массива и результат записать в константу resultArray
 - Съитерировать (for in) массив и распечатать каждый элемент в консоль с помощью print
 */

/*
 - Проделать описанные выше шаги с конструкциями Set
 - Продемонстрировать команды intersection, isSubset, union, substractic
 */

/*
 - Проделать описанные выше шаги с конструкциями Dictionary
 - Продемонстрировать команды работу комманды get data with default value, grouping
 - Распечатать все ключи dictionary
 */

// MARK: - Control Flow

/* Loops, pattern matching
 - Создайте enum с 2 case (ios, android)
 - Создайте array enum содержащую 5 ios и 3 android enum чередующихся в порядке расстановки
 - Используя конструкцию 'for case' выполните print только значений с case ios
 - Распечатайте только значения с case android используя 'for case where' конструкцию
 */

/* Statements if, switch
 - Воспользуйтесь коллекцией из предыдущего задания и проделайте print значений с использованием 'switch case' внутри 'for in' конструкции
 - Воспользуйтесь функцией .enumerated() для получения коллекции typle (index, item) и постройте 'switch case' внутри 'for in' конструкции с завязкой на
    - typle c индексом 1 и типом ios
    - typle с любым индексом и типом android
    - typle с любыми значениями
 */

// Example
// TODO: - .enumerated() создает коллекцию typle (index, item) из оригинальной коллекции. Тип item не изменяется
for (index, number) in (Int.min...).enumerated() {
    switch (index, number) {
    case (_, Int.max):
        break
    default:
        break
    }
}

/* Continue, break, throw
 - Используя .enumerated коллекцию (index, item) из предыдущего задания посчитайте количество ios девайсам находящихся на четных позициях
 *Для решения воспользуйтесь 'for in' конструкцией и оператором continue
 */

// Example
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

let items: [Weekday] = [.mon, .fri]
for (index, item) in items.enumerated() {
    if case .mon = item, index % 2 == 0 {
        print("monday")
        continue
    }
}

/*
 - Воспользуйтесь коллекцией из предыдущего задачния
 - Найдите индексы первых 2х элементов с case ios с помощью 'for in' конструкции
 - Прервите выполнение for in c помощью break как только будет выполнено условие по поиску элементов
 */

/* return
 - Создайте функцию с параметром [Int]?, возвращаемым результатом String и возможной генерацией ошибки throw
 - Функция должна возвращать строку состоящую из последовательно склеиных строковых значений Int
 - В случае если значение параметра равняется nil функция должна генерировать ошибку
 */

// Example
// TODO: - Стандартное представление новой ошибки в swift. Error - протокол которому должен соответствовать enum чтобы обрабатываться в конструкциях 'do try catch'
enum AppendError: Error {
    case noValue
}

// TODO: = оператор throws проставленный перед возвращаемым значением функции сообщает компилятору что функция может генерировать ошибку и должна быть вызвана с оператором try
// try - обязательно должен быть внутри do catch
// try? - может выполняться без do catch. В случае генерации ошибки вернет Onpional == nil
// try! - может выполняться без dp catch на свой страх и риск. В случае ошибки произойдет fail программы т.к. ошибка не будет обработана
func pasteTogether(items: [Double]?) throws -> Int? {
    let value = false
    guard let `items` = items, value else {
        throw AppendError.noValue
    }
    if value {
        // possitive
    } else {
        //
    }
    return items.reduce(0) { next, result in return Int(result) + next }
}

do {
    // Попробуйте изменить входящие параметры функции и посмотретьч то распечатает консоль
    let pasteTogetherResult = try pasteTogether(items: nil)
    print("pasteTogether result: \(String(describing: pasteTogetherResult))")
} catch {
    print("pasteTogether error:\(error)")
}

/* guard powerful / limitations
 - Напишите функцию в которой будет 2 параметра с типом String?
 - Функция будет возвращать bool а также может генерировать Error
 - Задача функции возвращать Error в случае когда любой из параметров не имеет значения (nil)
    - Возвращаться bool true в случаем если длинна 1 параметра > 5, а второго не менее 3
 */

// Example
 // - Смотрите пример из предыдущего задачния

/* API availability condition
 - Создать константу класса INUIAddVoiceShortcutButton
 - Обезопасить вызов проверкой if #available
 - Класс INUIAddVoiceShortcutButton доступен начиная с iOS 12
 https://developer.apple.com/documentation/sirikit/inuiaddvoiceshortcutbutton
 */
