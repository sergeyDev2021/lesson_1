import UIKit

// MARK: - ARC — automatic reference counting
// MRC
// retainCount
// init = 1
// striong reference
var classInts = NSObject()
// retaint count 1
var secondInts = classInts
// retaint count 2

var buf: NSObject? = nil

func release() {
    var inst = NSObject()
    // retaintCount = 1
//    buf = inst
    // retaintCount = 2
//    inst.release()
    // retaintCount = 1
}

release()

class Customer {
    
    let udid: String
    let name: String
    
    init(udid: String, name: String) {
        self.udid = udid
        self.name = name
        
        print("\(udid) initialized")
    }
    
    deinit {
        print("\(udid) deinitialized")
    }
    
}

// MARK: - Global strong reference. It'll be free up at the end of programm cycle.
var customer: Customer? = nil
customer = Customer(udid: "global reference", name: "Jo Mock")
/*
 print: global reference initialized
 */
customer = nil

// MARK: - Functin local reference. It'll be free up at the end of function.
func printCustomer() {
    let customer = Customer(udid: "function printCustomer", name: "Jo Mock")
    /*
     print: function printCustomer initialized
     */
    print("print customer: \(customer.udid)")
    /*
     print: function printCustomer deinitialized
     */
}

printCustomer()

// MARK: - Loop local reference. It'll be free up at the end of loop cycle.
for i in 0..<5 {
    _ = Customer(udid: "loop \(i)", name: "Jo Mock")
    /*
     print: loop {i} initialized
     print: loop {i} deinitialized
     */
}

/*
 print: global reference deinitialized
 */

var classInst = NSObject()
let classConst = NSObject()
/*
 strong, unowned, weak references
 strong — that is default reference type. When you assign class instance to a variable (var), constant (let) that makes a strong reference to the instance.
 The “strong” reference doesn't allow instance to be deallocated for as long as that reference remains.
 */

// MARK: - strong reference counting
var customer1stRef: Customer? = nil
var customer2ndRef: Customer? = nil

customer1stRef = Customer(udid: "1st", name: "Maxim")
/*
 print: 1st initialized
 */
customer2ndRef = customer1stRef
customer1stRef = nil

/*
 Customer class instance don't deallocated after nil set to customer1stRef.
 That happened because it has a strong reference in customer2ndRef
 */

customer2ndRef = nil
/*
 print: 1st deinitialized
 */

/*
 weak — That reference desn’t keep a strong hold on the instance if refers to.
 The weak reference prevents strong reference cycles between class instances.
 The ARC automatically sets weak reference to nil when the instance that it refers to is deallocated.
 Weak reference always declared as variables because that needs possibility to be changed to nil at runtime.
 */

// MARK: - weak reference
weak var weakCustomer1stRef: Customer? = nil
weak var weakCustomer2stRef: Customer? = nil

weakCustomer1stRef = Customer(udid: "weak 1", name: "Jacob")
/*
 print: weak 1 initialized
 print: weak 1 deinitialized
 */

/*
 That is deallocated right after initialization because haven't any strong reference.
 weakCustomer1stRef is nil
 */

var strongCustomerRef: Customer? = Customer(udid: "strong 1", name: "Klo")
/*
 strong 1 initialized
 */
weakCustomer1stRef = strongCustomerRef
weakCustomer2stRef = weakCustomer1stRef

print("weak 1st: \(String(describing: weakCustomer1stRef))")
print("weak 2nd: \(String(describing: weakCustomer2stRef))")
/*
 Both weak references are not nil
 */

strongCustomerRef = nil
/*
 print: strong 1 deinitialized
 */
print("weak 1st: \(String(describing: weakCustomer1stRef))")
print("weak 2nd: \(String(describing: weakCustomer2stRef))")
/*
 strongCustomerRef is setup to nil
 Both weak references will be setup to nil at runtime
 */

/*
 unowned — That does not keep a strong hold on the instance it refers to. Similar like a weak reference.
 Unowned reference always have a value. ARC never sets value of unowned reference to nil. Unowned reference defined using nonoptional types.
 */

// MARK: - Strong reference cycle
class Owner {
    
    let udid: String
    let iin: String
    let name: String
    var business: Business!
    
    init(udid: String, iin: String, name: String) {
        self.udid = udid
        self.iin = iin
        self.name = name
    }
    
    deinit {
        print("owner was deitialized")
    }
    
}

class Business {
    
    let title: String
    weak var owner: Owner? // <- place where we has been mistaken. It must be resoled using 'unowned' reference
    
    init(title: String, owner: Owner) {
        self.title = title
        self.owner = owner
    }
    
    deinit {
        print("business was deitialized")
    }
    
}

var owner: Owner = Owner(udid: "1st owner", iin: "1", name: "Mike")
let business = Business(title: "1st Corp", owner: owner)

owner.business = business

business.owner = owner


business.owner?.iin
/*
 Do some work with owner
 */
owner.business = nil
/*
 No outputs about deinitialization.
 What happend?
 Owner has strong reference to Business.
 Business has strong reference to Owner.
 
 !!! This is strong reference cycle. !!!
 
 We have memory leak now!
 */

/*
 Strong reference cycle for closures
 Strong reference cycle can also occur when closure is an class instance property and the body of closure captures the instance.
 */

// MARK: - Strong reference cycle for closures
class ViewController: UIViewController {
    
    lazy var loginCompletion: (Bool) -> Void = { success in // <- place where we has been mistaken. It must be resolved using capture list with 'unowned' reference
        if success {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    deinit {
        print("ViewController was deinitialized")
    }
    
}

var viewController: ViewController? = ViewController()
viewController!.loginCompletion

viewController = nil
/*
 !!! This is strong reference cycle for closure. !!!
 We have memory leak now!
 */

/*
 Solution after fixes
 */

// MARK: - Resolve strong reference cycle using closure capture list
class ViewControllerCap: UIViewController {
    
    lazy var loginCompletion: (Bool) -> Void = { [weak self] success in // We resolve memary leak just adding [weak self]
        if let `self` = self, success {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    deinit {
        print("ViewController was deitialized")
    }
    
}

var viewControllerCap: ViewControllerCap? = ViewControllerCap()
viewControllerCap!.loginCompletion

viewControllerCap = nil
/*
 print: ViewController was deinitialized
 */

/*
 Autorelease Pools
 Info from Apple Developer
 Autorelease pool blocks allow objects to relinquish ownership without being deallocated immediately. Typically, you don’t need to create your own autorelease pool blocks, but there are some situations in which either you must — such as when spawning a secondary thread — or it is beneficial to do so — such as when writing a loop that creates many temporary objects.
 In Objective-C, autorelease pool blocks are marked using @autoreleasepool. In Swift, you can use the autoreleasepool(_:) function to execute a closure within an autorelease pool block.
 */

// MARK: - Autorelease pool
// Reduce device memory usage
for i in 0...1 {
    autoreleasepool {
        let image = UIImage(named: "\(i)")
        print("image: \(String(describing: image?.size))")
    }
}

/*
 ****************************************************************************************************************************************************************
 */

// TODO: - Your work

// MARK: - ARC

/*
 - Обьявить strong var
 - Объявить weak var
 - Объявить unowned var
 */

/*
 - Создать Strong reference cycle между 2 взаимосвязанными классами (пример card <> task)
 - Решить проблему путем использования unowned
 - Можно ли решить с помощью weak?
 - В чем различие unowned / weak
 */

/*
 - Создать Strong reference cycle for closures между классом и closure внутри класса
 - Решить проблему путем использования capture list с weak reference
 - Можно ли решить с помощью unowned?
 */

/*
 - Опробовать использование autoreleasepool
 - В каких целях нужно использовать autoreleasepool?
 */
