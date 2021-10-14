import Foundation

// MARK: Routing
enum ReadingState : String {
    case notReaded = "No leido"
    case reading   = "Se está leyendo"
    case finised   = "Terminado"
}

@objc(Book)
open class Book: _Book {
	// Custom logic goes here.
}
