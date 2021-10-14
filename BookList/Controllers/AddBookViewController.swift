//
//  AddBookViewController.swift
//  BookList
//
//  Created by Alejandro Prieto Beltrán on 02/01/2021.
//  Copyright © 2021 ACME SL. All rights reserved.
//
import UIKit
import Foundation
import Eureka
import MagicalRecord
import SCLAlertView

class AddBookViewController: FormViewController {

  var controller: ViewController? = nil
  
  var currentBook: Item!
  
  var imageUrl: String?
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    title = "Nuevo libro"
    
    let cancelButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(close))
    self.navigationItem.leftBarButtonItem = cancelButton
    
    let saveButton = UIBarButtonItem(title: "Guardar", style: .plain, target: self, action: #selector(save))
    self.navigationItem.rightBarButtonItem = saveButton
    
    if let book = currentBook, let imageLinks = book.volumeInfo.imageLinks {
      
      imageUrl = imageLinks.thumbnail
      
    }
    
    // Autores
    let authors = (Author.mr_findAllSorted(by: "name", ascending: true) as! [Author])
    var bookAuthors : [Author]? = [Author]()
    if let book = currentBook, let authors = book.volumeInfo.authors {
      
      for author in authors {
        if let author = Author.mr_findFirst(with: NSPredicate( format: "name CONTAINS[cd] %@", author) ) {
          bookAuthors?.append ( author )
        }
      }
    }
    
    // Genero
    let categories = (Category.mr_findAllSorted(by: "name", ascending: true) as! [Category])
    var bookCategories : [Category]? = [Category]()
    if let book = currentBook, let categories = book.volumeInfo.categories {
      for category in categories {
        if let category = Category.mr_findFirst(with: NSPredicate( format: "name CONTAINS[cd] %@", category) ) {
          bookCategories?.append ( category )
        }
      }
    }
    
    
    // Estado de lectura
    let readingState  = ["No leido", "Se está leyendo", "Terminado"]
    
    // Editorial
    let fetchRequest = NSFetchRequest<NSDictionary>(entityName:"Book")
    fetchRequest.returnsDistinctResults = true
    fetchRequest.resultType = .dictionaryResultType
    fetchRequest.propertiesToFetch = [ "publisher"]

    var publishers = [String]()
    
    do {
        let records = try NSManagedObjectContext.mr_default().fetch(fetchRequest)
        publishers = records.compactMap { $0["publisher"] as? String }
    } catch {
        print("Core Data fetch failed:", error.localizedDescription)
    }
        
    LabelRow.defaultCellUpdate = { cell, row in
        cell.contentView.backgroundColor = .red
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        cell.textLabel?.textAlignment = .right
    }

    TextRow.defaultCellUpdate = { cell, row in
        if !row.isValid {
            cell.titleLabel?.textColor = .red
        }
    }
    
    
    form +++ Section()
      
      <<< ImageAndTextRow(){
        $0.title = ""
        $0.tag = "title"
        $0.add(rule: RuleRequired())
        $0.validationOptions = .validatesOnChange
      }
      .cellSetup { (cell, row) in
        cell.height = { 199 }
        
        cell.controller = self
        
        if let book = self.currentBook{
          
          cell.textview.text = book.volumeInfo.title
          
          if let imageLinks = book.volumeInfo.imageLinks {
            let url = URL(string: imageLinks.thumbnail)
            cell.icon.kf.setImage(with: url)
          }
          
          cell.update()
        }
      }
      .onRowValidationChanged { cell, row in
          let rowIndex = row.indexPath!.row
          while row.section!.count > rowIndex + 1 && row.section?[rowIndex  + 1] is LabelRow {
              row.section?.remove(at: rowIndex + 1)
          }
          if !row.isValid {
              for (index, validationMsg) in row.validationErrors.map({ $0.msg }).enumerated() {
                  let labelRow = LabelRow() {
                      $0.title = validationMsg
                      $0.cell.height = { 30 }
                  }
                  let indexPath = row.indexPath!.row + index + 1
                  row.section?.insert(labelRow, at: indexPath)
              }
          }
      }
      
      <<< IntRow() {
          $0.title = "ISBN"
          $0.tag = "isbn"
          if let book = currentBook, let identifiers = book.volumeInfo.industryIdentifiers {
            for element in identifiers {
              
              if element.type == "ISBN_13" {
                $0.value = Int(element.identifier)
              }
            }
          }
          let formatter = NumberFormatter()
          formatter.locale = .current
          formatter.numberStyle = .none
          $0.formatter = formatter
      }
      
      
      <<< MultipleSelectorRow<Author>() {
        $0.title = "Autor"
        $0.tag = "authors"
        $0.options = authors
        if let bookAuthors = bookAuthors {
          $0.value = Set(bookAuthors)
        }
      }
      
      <<< PushRow<String>() {
        $0.title = "Editorial"
        $0.tag = "publisher"
        $0.options = publishers
        if let book = currentBook {
          $0.value = book.volumeInfo.publisher
        }
      }
      
      <<< MultipleSelectorRow<Category>() {
        $0.title = "Genero"
        $0.tag = "categories"
        $0.options = categories
        if let bookCategories = bookCategories {
          $0.value = Set(bookCategories)
        }
      }
      
      <<< IntRow() {
          $0.title = "Páginas"
          $0.tag = "pages"
          $0.disabled = true
          if let book = currentBook, let pages = book.volumeInfo.pageCount {
            $0.value = pages
          }
      }
      
      +++ Section()
      
      <<< TextAreaRow() {
          if let book = currentBook {
            $0.value = book.volumeInfo.volumeInfoDescription
          }
          $0.textAreaMode = .readOnly
          $0.textAreaHeight = .fixed(cellHeight: 110)
      }
      
      
      +++ Section()
      
      <<< RatingRow(){
        $0.title = "Valoración"
        $0.tag = "rating"
       
      }
      .cellSetup { (cell, row) in
        cell.cosmosView.rating = 0.0
        cell.update()
      }
      
      <<< PushRow<String>() {
        $0.title = "Estado de lectura"
        $0.tag = "readingSate"
        $0.options = readingState
        $0.value = "No leido"
      }.onPresent { from, to in
        to.dismissOnSelection = true
        to.dismissOnChange = true
      }
    
      <<< DateInlineRow() {
        $0.title = "Empezado el"
        $0.tag = "started_on"
        $0.hidden = "$readingSate == 'No leido'"
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        $0.dateFormatter = formatter
      }
      
      <<< DateInlineRow() {
        $0.title = "Terminado el"
        $0.tag = "finished_on"
        $0.hidden = "$readingSate == 'No leido'"
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        $0.dateFormatter = formatter
      }
    
    let section = form.last!
      
    section <<< TextAreaRow() {
        $0.title = "Notas"
        $0.placeholder = ""
        $0.textAreaHeight = .dynamic(initialTextViewHeight: 80)
        $0.tag = "notes"
    }
    
  }
  
  func validate( formValues: [String: Any?] ) -> Bool {
    
    guard let _ = formValues["title"] as? String else {
      
      SCLAlertView().showError("Error", subTitle: "El título es obligatorio")
      
      return false
    }
    
    return true
    
  }
  
  @objc func save() {
    
    let valuesDictionary = form.values()
    
    print(valuesDictionary);
    
    if self.validate(formValues: form.values()) {
      
      MagicalRecord.save { localContext in
        
        // A book does NOT exist.  ADD Mode.
        let currentBook = Book.mr_createEntity(in: localContext)!
        currentBook.added_at = Date()
         
        if let isbn = valuesDictionary["isbn"] as? Int64 {
          currentBook.isbn  = isbn
        }
        currentBook.title = valuesDictionary["title"] as? String
        currentBook.publisher = valuesDictionary["publisher"] as? String
        
        if let imageUrl = self.imageUrl {
          currentBook.image = imageUrl
        }
          
        if let _ = valuesDictionary["authors"] as? Set<Author> {
          let selectedAuthors = Array(valuesDictionary["authors"] as! Set<Author>) as [Author]
          
          let authors = Author.mr_findAll(with: NSPredicate( format: "SELF IN %@", selectedAuthors ), in: localContext) as! [Author]
          if authors.count > 0 {
            currentBook.authors = Set(authors) as NSSet
          }
        }
        
        if let _ = valuesDictionary["categories"] as? Set<Category> {
          let selectedCategories = Array(valuesDictionary["categories"] as! Set<Category>) as [Category]
          let categories = Category.mr_findAll(with: NSPredicate( format: "SELF IN %@", selectedCategories), in: localContext) as! [Category]
          if categories.count > 0 {
            currentBook.categories = Set(categories) as NSSet
          }
        }
        if let pages = valuesDictionary["pages"] as? Int {
          currentBook.pages = Int16(pages)
        }
        
        currentBook.rate = valuesDictionary["rating"] as? Double ?? 0.0
        
        currentBook.reading_state = valuesDictionary["readingSate"] as? String
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_ES")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        if let started_on = valuesDictionary["started_on"] as? Date {
          currentBook.started_on = started_on
        }
        
        if let finished_on = valuesDictionary["finished_on"] as? Date {
          currentBook.finished_on = finished_on
        }
        
        currentBook.notes = valuesDictionary["notes"] as? String
      }
      completion: { (sucess, error) in
        
        if let error = error {
          print("ERROR: ", error);
        }else{
          self.controller?.save()
          
          self.navigationController?.dismiss(animated: true, completion: nil)
        }
      }
    }
  }
  
  @objc func close() {
   
    self.dismiss(animated: true, completion: nil)
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    self.title = ""
    
    if segue.identifier == "SearchImageSegue" {
      
      let navigationController = segue.destination as! UINavigationController
      let destinationVC = navigationController.topViewController as! SearchImageViewController
      
      destinationVC.completion = { imageUrl in
        
        self.navigationController?.dismiss(animated: true, completion: nil)
                
        if let imageUrl = imageUrl {
          print(imageUrl)
          
          if let cell = self.form.allSections[0].allRows[0].baseCell as? ImageAndTextCell {
            let url = URL(string: imageUrl)
            cell.icon.kf.setImage(with: url)
            self.imageUrl = imageUrl
          }
        }
      }
    }
  }
}
  
