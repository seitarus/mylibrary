import Foundation

@objc(Category)
open class Category: _Category {
	
  override open var description: String {
      get {
          return self.name!
      }
  }
  
}
