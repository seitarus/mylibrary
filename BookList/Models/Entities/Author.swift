import Foundation

@objc(Author)
open class Author: _Author {
	
  override open var description: String {
      get {
          return self.name!
      }
  }
  
}
