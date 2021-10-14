//
//  AddBookViewController.swift
//  BookList
//
//  Created by Alejandro Prieto Beltrán on 02/01/2021.
//  Copyright © 2021 Razeware. All rights reserved.
//
import UIKit
import Foundation
import Eureka
import MagicalRecord
import SCLAlertView

class EditBookViewController: FormViewController {

  var controller: ViewController? = nil
  
  var currentBook: Book!
  
  var imageUrl: String?
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    self.navigationController?.navigationBar.prefersLargeTitles = false
    
    title = "Editar libro"
    
    let cancelButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(close))
    self.navigationItem.leftBarButtonItem = cancelButton
    
    let saveButton = UIBarButtonItem(title: "Guardar", style: .plain, target: self, action: #selector(save))
    self.navigationItem.rightBarButtonItem = saveButton
    
    // Autores
    let authors = (Author.mr_findAllSorted(by: "name", ascending: true) as! [Author])
    
    // Genero
    let categories = (Category.mr_findAllSorted(by: "name", ascending: true) as! [Category])
    
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
        print(publishers)
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
        if let book = self.currentBook{
          
          cell.textview.text = book.title
          
          if let bookImage = book.image {
            let url = URL(string: bookImage)
            cell.icon.kf.setImage(with: url)
          }
          
          cell.controller = self
          
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
      
      <<< MultipleSelectorRow<Author>() {
        $0.title = "Autor"
        $0.tag = "authors"
        $0.options = authors
        if let book = currentBook {
          $0.value = Set(_immutableCocoaSet: book.authors)
        }
      }
      
      <<< PushRow<String>() {
        $0.title = "Editorial"
        $0.tag = "publisher"
        $0.options = publishers
        if let book = currentBook {
          $0.value = book.publisher
        }
      }
      
      <<< MultipleSelectorRow<Category>() {
        $0.title = "Genero"
        $0.tag = "categories"
        $0.options = categories
        if let book = currentBook {
          $0.value = Set(_immutableCocoaSet: book.categories)
        }
      }
      
      <<< IntRow() {
          $0.title = "Páginas"
          $0.tag = "pages"
          //$0.disabled = true
          if let book = currentBook {
            $0.value = Cell<Int>.Value(book.pages)
          }
      }
      
      +++ Section()
      
      <<< TextAreaRow() {
          if let book = currentBook {
            $0.value = book.text
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
        if let book = self.currentBook {
          cell.cosmosView.rating = book.rate
        }else{
          cell.cosmosView.rating = 0.0
        }
        cell.update()
      }
      
      <<< PushRow<String>() {
        $0.title = "Estado de lectura"
        $0.tag = "readingSate"
        $0.options = readingState
        if let book = currentBook {
          $0.value = book.reading_state
        }else{
          $0.value = "No leido"
        }
      }.onPresent { from, to in
        to.dismissOnSelection = true
        to.dismissOnChange = true
      }
    
      <<< DateInlineRow() {
        $0.title = "Empezado el"
        $0.tag = "started_on"
        if let started_on = currentBook.started_on {
          $0.value = started_on
        }
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
        if let finished_on = currentBook.finished_on {
          $0.value = finished_on
        }
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
      
      if let currentBook = currentBook {
        // A book exists.  EDIT Mode.
        
        currentBook.removeAuthors( currentBook.authors ) //Set<Author>() as NSSet
        currentBook.removeCategories( currentBook.categories ) // = Set<Category>() as NSSet
          
      } else {
        // A book does NOT exist.  ADD Mode.
        currentBook = Book.mr_createEntity(in: NSManagedObjectContext.mr_default())
        currentBook.added_at = Date()
        
      }
      
      currentBook.title = valuesDictionary["title"] as? String
      currentBook.publisher = valuesDictionary["publisher"] as? String
      
      if let imageUrl = imageUrl {
        currentBook.image = imageUrl
      }
      
      let selectedAuthors = Array(valuesDictionary["authors"] as! Set<Author>) as [Author]
      let authors = Author.mr_findAll(with: NSPredicate( format: "SELF IN %@", selectedAuthors )) as! [Author]
      if authors.count > 0 {
        currentBook.authors = Set(authors) as NSSet
      }
      
      let selectedCategories = Array(valuesDictionary["categories"] as! Set<Category>) as [Category]
      let categories = Category.mr_findAll(with: NSPredicate( format: "SELF IN %@", selectedCategories)) as! [Category]
      if categories.count > 0 {
        currentBook.categories = Set(categories) as NSSet
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
            
  //    ["readingSate": Optional("Se está leyendo"), "rating": Optional(4.0), "publishers": Optional(Set([])), "categories": Optional(Set(["Ficción"])), "author": Optional(Set(["Juan Gomez Jurado"])), "title": Optional("Añalala")]
      
      controller?.save()
      
      self.navigationController?.dismiss(animated: true, completion: nil)
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
