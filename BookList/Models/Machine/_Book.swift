// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Book.swift instead.

import Foundation
import CoreData

public enum BookAttributes: String {
    case added_at = "added_at"
    case finished_on = "finished_on"
    case image = "image"
    case isbn = "isbn"
    case notes = "notes"
    case pages = "pages"
    case publisher = "publisher"
    case rate = "rate"
    case reading_state = "reading_state"
    case started_on = "started_on"
    case subtitle = "subtitle"
    case text = "text"
    case title = "title"
}

public enum BookRelationships: String {
    case authors = "authors"
    case categories = "categories"
}

open class _Book: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Book"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Book.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var added_at: Date?

    @NSManaged open
    var finished_on: Date?

    @NSManaged open
    var image: String?

    @NSManaged open
    var isbn: Int64 // Optional scalars not supported

    @NSManaged open
    var notes: String?

    @NSManaged open
    var pages: Int16 // Optional scalars not supported

    @NSManaged open
    var publisher: String?

    @NSManaged open
    var rate: Double // Optional scalars not supported

    @NSManaged open
    var reading_state: String!

    @NSManaged open
    var started_on: Date?

    @NSManaged open
    var subtitle: String?

    @NSManaged open
    var text: String?

    @NSManaged open
    var title: String!

    // MARK: - Relationships

    @NSManaged open
    var authors: NSSet

    open func authorsSet() -> NSMutableSet {
        return self.authors.mutableCopy() as! NSMutableSet
    }

    @NSManaged open
    var categories: NSSet

    open func categoriesSet() -> NSMutableSet {
        return self.categories.mutableCopy() as! NSMutableSet
    }

}

extension _Book {

    open func addAuthors(_ objects: NSSet) {
        let mutable = self.authors.mutableCopy() as! NSMutableSet
        mutable.union(objects as Set<NSObject>)
        self.authors = mutable.copy() as! NSSet
    }

    open func removeAuthors(_ objects: NSSet) {
        let mutable = self.authors.mutableCopy() as! NSMutableSet
        mutable.minus(objects as Set<NSObject>)
        self.authors = mutable.copy() as! NSSet
    }

    open func addAuthorsObject(_ value: Author) {
        let mutable = self.authors.mutableCopy() as! NSMutableSet
        mutable.add(value)
        self.authors = mutable.copy() as! NSSet
    }

    open func removeAuthorsObject(_ value: Author) {
        let mutable = self.authors.mutableCopy() as! NSMutableSet
        mutable.remove(value)
        self.authors = mutable.copy() as! NSSet
    }

}

extension _Book {

    open func addCategories(_ objects: NSSet) {
        let mutable = self.categories.mutableCopy() as! NSMutableSet
        mutable.union(objects as Set<NSObject>)
        self.categories = mutable.copy() as! NSSet
    }

    open func removeCategories(_ objects: NSSet) {
        let mutable = self.categories.mutableCopy() as! NSMutableSet
        mutable.minus(objects as Set<NSObject>)
        self.categories = mutable.copy() as! NSSet
    }

    open func addCategoriesObject(_ value: Category) {
        let mutable = self.categories.mutableCopy() as! NSMutableSet
        mutable.add(value)
        self.categories = mutable.copy() as! NSSet
    }

    open func removeCategoriesObject(_ value: Category) {
        let mutable = self.categories.mutableCopy() as! NSMutableSet
        mutable.remove(value)
        self.categories = mutable.copy() as! NSSet
    }

}

