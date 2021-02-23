import UIKit

// MARK: - Functions & Closures

// What is?

/*
 Function is self-contained code that does a specific work.
 Every function in Swift has a type, consisting of the function’s parameter types and return type. You can use that type to pass functions as arguments or return functions as a result from other functions. Functions can be encapsulated to hide functionality in nested function scope.
 */

typealias FunctionResult = (typleNameArgument: String, typleCountArgument: Int)

func functionName(externalArgumentName internalArgumentName: String = "defaultValue") -> FunctionResult {
    return (internalArgumentName, 1)
}

// Multiple return value in functions

typealias ItemsAndErrorResult = (items: [String], error: Error?)

func download(from index: Int, with offset: Int) -> ItemsAndErrorResult {
    guard index < 100 else {
        return ([], NSError(domain: "com.vialyx.course", code: -987, userInfo: nil))
    }
    let items = Array(repeating: "result_\(index)", count: offset)
    return (items, nil)
}

// Arguments in functions

// External argument labels

/*
 To specify external label just write it before parameter name, separated by space.
 */

//func download(from index: Int, with offset: Int) -> [String] {
//    return ["result"]
//}
//
//download(from: 0, with: 10)

// Default parameter values

/*
 To define a default value just assign that value after parameter type.
 */

//func download(from index: Int, with offset: Int = 10) -> [String] {
//    return ["result"]
//}
//
//download(from: 20)

// Variadic parameter

/*
 Variadic parameter accepts zero or more values.
 Values from variadic parameter available as array in function body.
 Variadic parameter must be the last parameter in function declaration.
 */

typealias UserString = String

func getUsers(with ids: UUID...) -> [UserString] {
    return ["Maxim", "Nik"]
}

// In-Out parameters

/*
 In-out parameters cannot have default values, and variadic parameters cannot be marked as inout.
 Function values are constants by default. If you want a function that supports modifying the parameters you should declare parameter as inout.
 */

func update(user: inout UserString) -> Error? {
    user = "Mike"
    return nil
}

// Function types

/*
 As function is first level data class you can pass it as an argument and return as result in another function.
 */

//func getUsers(with ids: UUID...) -> [UserString] {
//    return ["Maxim", "Nik"]
//}

var downloadTask: (UUID...) -> [String] = getUsers

downloadTask(UUID())

// Nested functions

/*
 You can define functions inside the bodies of other functions, known as nested functions.
 Nested functions are hidden from the outside world by default, but can still be called and used by their enclosing function.
 */

typealias DownloadResult = (items: [String], error: Error?)

func load() -> DownloadResult {
    func dowload() -> DownloadResult {
        return (["Zips"], nil)
    }
    
    let nestedFunction = dowload()
    
    return nestedFunction
}

// Closure

/*
 What is closure
 Close is self-contained block of functionality that can be passed around.
 Closures can capture and store references to any constants and variables from the context in which they are defined.
 
 Closures take one of three forms:
 Global functions are closures that have a name and do not capture any values.
 Nested functions are closures that have a name and can capture values from their enclosing function.
 Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.
 Swift closure optimizations:
 Inferring parameter and return value types from context
 Implicit returns from single-expression closures
 Shorthand argument names
 Trailing closure syntax
 */

/*
 { (parameters) -> return type in
 statements
 }
 */

let BoolClosure: (Bool) -> Void = { parameter in
    print("\(parameter)")
}

/*
 Inferring Type From Context
 Because the sorting closure is passed as an argument to a method, Swift can infer the types of its parameters and the type of the value it returns.
 
 Implicit Returns from Single-Expression Closures
 Single-expression closures can implicitly return the result of their single expression by omitting the return keyword
 
 Shorthand Argument Names
 Swift automatically provides shorthand argument names to inline closures, which can be used to refer to the values of the closure’s arguments by the names $0, $1, $2, and so on.
 */

let integers = [1, 2, 3, 4, 5]
/*
 Inferring Type From Context
 Compile already know the result is String array
 */
/*
 Implicit Returns from Single-Expression Closures
 Just String($0)
 */
/*
 Shorthand Argument Names
 Just $0
 */
let result = integers.map { String($0) }

// Trailing closure

/*
 If you need to pass a closure expression to a function as the function’s final argument and the closure expression is long, it can be useful to write it as a trailing closure instead.
 */

/* The animate function
 UIView.animate(withDuration: TimeInterval, animations: () -> Void)
 */
// Can be
UIView.animate(withDuration: 0.25, animations: {
    
})
// Simpler, just use trailing
UIView.animate(withDuration: 0.25) {
    // statement
}

// Capturing values

/*
 A closure can capture constants and variables from the surrounding context in which it is defined.
 ------------------------------->>>>>>>
 If you assign a closure to a property of a class instance, and the closure captures that instance by referring to the instance or its members, you will create a strong reference cycle between the closure and the instance. Swift uses capture lists to break these strong reference cycles. For more information, see Strong Reference Cycles for Closures.
 */

// Escaping closures

/*
 Add@escaping before the parameter’s type to indicate that the closure is allowed to called after the function returns.
 
 Marking a closure with @escaping means you have to refer to self explicitly within the closure.
 */

final class Model {
    
    func load(completion: @escaping ([String]) -> Void) {
        // statement
    }
    
}

final class ViewController: UIViewController {
    
    var model: Model! = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.load { [unowned self] (items) in
            self.display(items: items)
        }
    }
    
    private func display(items: [String]) {
        // statement
    }
    
}

// Autoclosures

/*
 An autoclosure is a closure that is automatically created to wrap an expression that’s being passed as an argument to a function. It doesn’t take any arguments, and when it’s called, it returns the value of the expression that’s wrapped inside of it. This syntactic convenience lets you omit braces around a function’s parameter by writing a normal expression instead of an explicit closure.
 
 Overusing autoclosures can make your code hard to understand. The context and function name should make it clear that evaluation is being deferred.
 */

func patch(user: @autoclosure () -> UserString) {
    // statement
}

patch(user: "Maxim")


/*
 ****************************************************************************************************************************************************************
 */

// TODO: - Your Work

// MARK: - Functions & Closures

/* Multiple return value in functions, External argument labels
 - Написать произвольную функцию с параметрами использующие внешние и внутренние label
 - Результатом функции должен быть typle
 - Исключить явное обявление typle в декдарировании функции. Использовать typealiace для именования typle
 - Использовать alice для объявления возвращаемого значения функции
 */

/* Default parameter values
 - Написать произвольную функци с параметром [String]? и значением по умолчанию [Homework]
 - Используя guard let извлекать значение. В случае nil - возвращать значение функции "empty"
 - Функция должна возвращать склееные строки с использованием символа ',' как разделитель
 */

// Example
let defaultStrings = ["one", "two", "3"]
let defaultStringsResult = defaultStrings.joined(separator: "-")

/* Variadic parameter
 - Переписать функцию из предыдущего задания используя Variadic parameter
 */

// Example
func variadic(arg: String...) {}

/* Nested functions
 - Написать Nested function
 */

/* Closure
 - Обьявить переменную Closure с типом () -> Void
 */

/* Shorthand Argument Names
 - Изменить closure для использования Shorthand Argument Names ($0)
 */

// Task
let closure: (Int) -> String = { item in return String(item) }

/* Trailing closure
 - Создайте array Int
 - С помощью оператора .map трансформируйте array Int в array String
 - Выполните запись в стиле trailing closure
 */

// Example
let stringValues = ["98", "3", "1000"]
let intItems = stringValues.compactMap { (item) -> Int? in return Int(item) }
