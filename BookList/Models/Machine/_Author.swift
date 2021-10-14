// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Author.swift instead.

import Foundation
import CoreData

public enum AuthorAttributes: String {
    case id = "id"
    case name = "name"
}

public enum AuthorRelationships: String {
    case books = "books"
}

open class _Author: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Author"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<Author> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Author.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var id: Int32 // Optional scalars not supported

    @NSManaged open
    var name: String?

    // MARK: - Relationships

    @NSManaged open
    var books: NSSet

    open func booksSet() -> NSMutableSet {
        return self.books.mutableCopy() as! NSMutableSet
    }

}

extension _Author {

    open func addBooks(_ objects: NSSet) {
        let mutable = self.books.mutableCopy() as! NSMutableSet
        mutable.union(objects as Set<NSObject>)
        self.books = mutable.copy() as! NSSet
    }

    open func removeBooks(_ objects: NSSet) {
        let mutable = self.books.mutableCopy() as! NSMutableSet
        mutable.minus(objects as Set<NSObject>)
        self.books = mutable.copy() as! NSSet
    }

    open func addBooksObject(_ value: Book) {
        let mutable = self.books.mutableCopy() as! NSMutableSet
        mutable.add(value)
        self.books = mutable.copy() as! NSSet
    }

    open func removeBooksObject(_ value: Book) {
        let mutable = self.books.mutableCopy() as! NSMutableSet
        mutable.remove(value)
        self.books = mutable.copy() as! NSSet
    }

}

