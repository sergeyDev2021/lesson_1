import UIKit

// MARK: - Optional Chaining & Force Unwrapping

class TransportStorage {
    
    var output: NSObject!
    
    let database: Any // <----- Constant
    var token: String?
    
    init(database: Any) {
        self.database = database
    }
    
}

let storage = TransportStorage(database: UserDefaults.standard)

// Optional with case .none -> nil
storage.token?.description

// this triggers a runtime error
//storage.token!.description

storage.token = UUID().uuidString

// Optional with case .some -> String
storage.token?.description //

// *** Crash!!! The output in currently nil ***
// this triggers a runtime error
//  storage.output.description
storage.output = NSObject()

// Output have with value. All work good
storage.output?.description

// MARK: - Error Handling Fundamentals
// ref: https://medium.com/@vialyx/swift-course-error-handling-fundamentals-88db73c1fc15

enum ArgError: Error {
    case nilValue
    case digits
}

extension ArgError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .digits:
            return "Plase use only letters"
        case .nilValue:
            return "Value is nil"
        }
    }
    
}

func name(arg1: String?, arg2: String?) throws -> String? {
    guard let value1 = arg1 else {
//        throw ArgError.nilValue
        return nil
    }
    let value2: String = arg2 ?? ""
    let characters = CharacterSet.decimalDigits
    let filtered: String = value1.filter({ character in
        characters.contains(character.unicodeScalars.first!)
    })
    print("filtered: \(filtered)")
    guard filtered.isEmpty else {
//        throw ArgError.digits
        return nil
    }
    return value1 + value2
}

do {
    let result = try name(arg1: "Lesson1", arg2: "1235")
    print("result: \(String(describing: result))")
} catch ArgError.nilValue {
    print("error nilValue")
} catch {
    print("error: \(String(describing: error.localizedDescription))")
}

let string1 = "1"
let int1 = Int(string1)

// MARK: - Type Casting

// MARK: - Checking Type

class Media {
    var url: String
    
    init(url: String) {
        self.url = url
    }
    
    func prepare() {
        
    }
    
}

protocol Playable {
    var url: String { get set }
    func play()
}

extension Playable {
    
    func play() {
        print("play \(url)")
    }
    
}

class Video: Media, Playable {
    var thumb: String
    
    init(url: String, thumb: String) {
        self.thumb = thumb
        super.init(url: url)
    }
    
}

class Audio: Media, Playable {
    var bitrate: Int
    
    init(url: String, bitrate: Int) {
        self.bitrate = bitrate
        super.init(url: url)
    }
    
}

func newMedia() -> Media {
    return arc4random() % 6 == 0
        ? Video(url: "http://www_123_@1x.png", thumb: "http://www_123_@1x.png")
        : Audio(url: "", bitrate: 0)
}

let media: Media = newMedia()

print("Media is Video? \(media is Video)")

switch media {
case is Video:
    print("video")
case is Audio:
    print("Audio")
default:
    break
}

// MARK: - Downcasting

let mediaSet: [Media] = [Video(url: "http://www_123_@1x.png", thumb: "http://www_123_@1x.png"),
                         Video(url: "http://www_123_@1x.png", thumb: "http://www_123_@1x.png"),
                         Media(url: "http://www_123_@1x.png")]



for item in mediaSet {
    item.prepare()
    
    // We don't sure about casting result
//    if let video = item as? Video {
//        print("Video: \(video)")
//    } else if audio = item as? Audio {
//        print("audio: \(audio)")
//    }
    
    switch item {
    case is Video:
        let video = item as! Video

        print("Video: \(video)")
    case is Audio:
        let audio = item as! Audio
        
        print("audio: \(audio)")
    default:
        break
    }
}

/*
 ****************************************************************************************************************************************************************
 */

// TODO: - Your work

// MARK: - Optional Chaining & Force Unwrapping
// ref: https://medium.com/@vialyx/swift-course-optional-chaining-force-unwrapping-dd1919fe88de

/*
 - Создайте класс в котором объявите property как force unwrap '!', safe unwrap '?'
 - Создать экземпляр класса с использованием пустого (default) инициализатора без установки значений в property
 - Попробовать обратиться к force unwrap property
 - Попробовать обратиться к safe unwrap property
 - В чем различие в поведение программы force / safe?
 - Обратиться к force unwrap property используя safe unwrap (optional chaining). Что изменилось в поведении программы
 */

// MARK: - Error Handling Fundamentals
// ref: https://medium.com/@vialyx/swift-course-error-handling-fundamentals-88db73c1fc15

/*
 - Объявить несколько enum Error (пример ValidationError: Error, SymantecError: Error)
 - Написать throwing функцию / метод, как угодно. Функция должна производить ошибку в зависимости от условий проверки (Ошибки должны генерироваться из различных типов, как описано в шаге выше)
 - Написать код который выполняет функцию с параметрами для получения всех возможных ошибок
    - использовать оператор try для демонстрации do try catch конструкции. Важно: catch должен быть описан отдельно под каждый тип Error см. Handling Errors Using Do-Catch
    - использовать оператор try? для демонстрации Converting Errors to Optional Values
    - использовать оператор try! для вызова функции с параметрами которые приведут к генерации Error
 - В чем отличие работы операторов try, try!, try?  ?
 - В каких случаях кнострукция do catch необходима? В каких модификациях try, do catch можно опустить?
 */

// MARK: - Type Casting
/*
 - Сделать Array Any
 - Сделать 2 произвольные структуры, например Car, Bike
 - Наполнить массив Int, String, структурами например Car, Bike
 - В цикле for in используя оператор switch is распечатать все Int
 - Используя функцию map (для Array) и оператор as получить отфильтрованный массив так чтобы там остались только Car и Bike.
 */
