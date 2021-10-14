//
//  ViewController.swift
//  BookList
//
//  Created by Alejandro Prieto Beltrán on 02/01/2021.
//  Copyright © 2021 ACME SL. All rights reserved.
//
import UIKit
import CoreData
import Alamofire
import MagicalRecord
import Kingfisher
import SCLAlertView

let controllerWillChangeContentViewControllerNotificationKey = "com.getapp.controllerWillChangeContent"
let controllerDidChangeContentViewControllerNotificationKey = "com.getapp.controllerDidChangeContent"

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>? {
      didSet {
          if let frc = fetchedResultsController {
              if frc != oldValue {
                  //frc.delegate = self
                  do {
                      try performFetch()
                  } catch {
                      print(error)
                  }
              }
          } else {
            tableView.reloadData()
          }
      }
  }
  
  var sectionIndexTitles : [String] = []
  
  var books: [NSManagedObject] = []

  override func viewDidLoad() {
    
    super.viewDidLoad()

    title = "Mi Biblioteca"
    
    tableView.register(UINib(nibName: "BookCell", bundle: nil), forCellReuseIdentifier: "BookCell")
    tableView.separatorStyle = .none
  }

  override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
            
    fetchData()
    
  }
  
  func performFetch() throws {
      if let frc = fetchedResultsController {
          defer {
            tableView.reloadData()
          }
          do {
              try frc.performFetch()
          } catch {
              throw error
          }
      }
  }
  
  func fetchData() {
    
    self.fetchedResultsController = Book.mr_fetchAllSorted(by: "finished_on:0,added_at:0", ascending: false, with: nil, groupBy: "finished_on", delegate: nil, in: NSManagedObjectContext.mr_default())
    
  }
  
  // MARK: - Actions
  
  @IBAction func addBook(_ sender: UIBarButtonItem) {
  
    let alert = UIAlertController(title: "Añadir nuevo libro", message: nil, preferredStyle: .actionSheet)
    
    alert.addAction(UIAlertAction(title: "Escanear código de barras", style: .default, handler: { action in

      self.performSegue(withIdentifier: "ScanBookSegue", sender: self)
      
    }))

    alert.addAction(UIAlertAction(title: "Añadir manualmente", style: .default, handler: { action in

      self.performSegue(withIdentifier: "AddBookSegue", sender: nil)
      
    }))
    
    alert.addAction(UIAlertAction(title: "Buscar en Internet", style: .default, handler: { action in

      self.performSegue(withIdentifier: "SearchBookSegue", sender: nil)
      
    }))
        
    alert.addAction(UIAlertAction(title: "Añadir Autor", style: .default, handler: { action in

      self.addAuthor()
      
    }))
    
    alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
    
    self.present(alert, animated: true)
    
  }
  
  @IBAction func search(_ sender: UIBarButtonItem) {
    
    self.performSegue(withIdentifier: "SearcherSegue", sender: nil)
    
  }
  
  func addAuthor() {
    
    let alert = UIAlertController(title: "Nuevo Autor",
                                  message: "Nombre del Autor",
                                  preferredStyle: .alert)
    
    let saveAction = UIAlertAction(title: "Guardar", style: .default) {
       action in
      
      guard let textField = alert.textFields?.first,
        let nameToSave = textField.text else {
          return
      }
      
      MagicalRecord.save { localContext in
      
        let myAuthor = Author.mr_createEntity(in: localContext)!
        myAuthor.name = nameToSave;
      
      }completion: { (sucess, error) in
        if let error = error {
          print("ERROR: ", error);
        }
      }
    }
    
    let cancelAction = UIAlertAction(title: "Cancelar",
                                     style: .cancel)
    
    alert.addTextField()
    
    alert.addAction(saveAction)
    alert.addAction(cancelAction)
    
    present(alert, animated: true)
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    self.title = ""
    
    if segue.identifier == "ScanBookSegue" {
      
      let destinationVC = segue.destination as! ScannerViewController
      destinationVC.controller = self
    }
    else if segue.identifier == "SearchBookSegue" {
      
      let navigationController = segue.destination as! UINavigationController
      let destinationVC = navigationController.topViewController as! SearchBookViewController
      destinationVC.controller = self
    }
    else if segue.identifier == "AddBookSegue" {
      
      let navigationController = segue.destination as! UINavigationController
      let destinationVC = navigationController.topViewController as! AddBookViewController
      destinationVC.controller = self
      
      if let book = sender as? Item {
        
        destinationVC.currentBook = book
      }
    }
    else if segue.identifier == "EditBookSegue" {
      
      let navigationController = segue.destination as! UINavigationController
      let destinationVC = navigationController.topViewController as! EditBookViewController
      destinationVC.controller = self
      
      if let book = sender as? Book {
        
        destinationVC.currentBook = book
      }
    }
//    else if segue.identifier == "SearcherSegue" {
//
//      let navigationController = segue.destination as! UINavigationController
//      let destinationVC = navigationController.topViewController as! SearcherViewController
//
//    }
    
    title = "Mi Biblioteca"
  }
  

  func didFinishScanCode( code: String ){
    
    self.findBookInGoogle(isbn: code) { (bookResult) in
      
      if let result = bookResult {
        
        if result.totalItems > 0 {
          
          if let bookItem: Item = result.items?[0] {
            
            if let authors = bookItem.volumeInfo.authors, authors.count > 0 {
              
              for author in authors {
                
                if let _ = Author.mr_findFirst(with: NSPredicate( format: "name CONTAINS[cd] %@", author) ) {
                }else{
                  MagicalRecord.save { localContext in
                  
                    let myAuthor = Author.mr_createEntity(in: localContext)!
                    myAuthor.name = author;
                  
                  }completion: { (sucess, error) in
                    if let error = error {
                      print("ERROR: ", error);
                    }
                  }
                }
              }
            }
            
            if let categories = bookItem.volumeInfo.categories, categories.count > 0 {
              
              for category in categories {
                
                if let _ = Category.mr_findFirst(with: NSPredicate( format: "name CONTAINS[cd] %@", category) ) {
                }else{
                  MagicalRecord.save { localContext in
                    let myCategory = Category.mr_createEntity(in: localContext)!
                    myCategory.name = category;
                  }completion: { (sucess, error) in
                    if let error = error {
                      print("ERROR: ", error);
                    }
                  }
                }
              }
            }
            
            self.performSegue(withIdentifier: "AddBookSegue", sender: bookItem)
            
          }
          
        }else{
          
          SCLAlertView().showWarning("Búsqueda", subTitle: "Libro no encontrado", closeButtonTitle: "OK")
          
        }
      }
    }
    
    self.dismiss(animated: true)
  }

  func findBookInGoogle( isbn: String, completion: @escaping (BooksResponse?) -> Void) {
    
    let GOOGLE_KEY = "AIzaSyAiqVMaBK3Hklg0udMbKyYr66poAEGtNj4"
    
    let urlString = "https://www.googleapis.com/books/v1/volumes?q=+isbn:" + isbn + "&key=" + GOOGLE_KEY
    
    Alamofire.request(urlString, method: .get, encoding: JSONEncoding.default)
                .responseJSON { response in
                    //print(response)
                    //to get status code
//                    if let status = response.response?.statusCode {
//                        switch(status){
//                        case 201, 200:
//                            print("Status 20X")
//                        default:
//                            print("error with response status: \(status)")
//                        }
//                    }
                    //to get JSON return value
                if let _ = response.result.value {
                    //let JSON = result as! NSDictionary
                    //print(JSON)
                  do{
                    let books: BooksResponse = try JSONDecoder().decode(BooksResponse.self, from: response.data!)
                    print(books)
                    completion( books )
                  }catch{
                    print("Unexpected error: \(error).")
                    completion( nil )
                  }
                
                }else{
                  completion( nil )
                }
            }
  }
  
  
  func save() {
    
    NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
    
    fetchData()
  }
  
}



// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
      
    return (fetchedResultsController?.sections!.count)!
  }
  
  func sectionIndexTitles(for tableView: UITableView) -> [String]? {
   
    var sectionTitle = Set<String>()
    var notReaded = false

    if let sections = fetchedResultsController?.sections {

      for section in sections {

        if section.name.isEmpty {

          notReaded = true

        }else{

          let dateFormatter = DateFormatter()
          dateFormatter.locale = Locale(identifier: "es_ES")
          dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
          let date = dateFormatter.date(from:section.name)

          let dateFormatterPrint = DateFormatter()
          dateFormatterPrint.locale = Locale(identifier: "es_ES")
          dateFormatterPrint.dateFormat = "yyyy"

          sectionTitle.insert( dateFormatterPrint.string(from: date!) )
        }
      }
    }

    var sectionIndexTitles = Array(sectionTitle)
    sectionIndexTitles.sort { (a, b) -> Bool in
      Int(a)! > Int(b)!
    }
    if notReaded {
      
      sectionIndexTitles.append( "N" )
    }
    
    return sectionIndexTitles
  }
  
  func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {

      
    if let sections = fetchedResultsController?.sections {

      var index = 0
      for section in sections {
        
        if section.name.isEmpty {

          return index

        }else{
        
          let dateFormatter = DateFormatter()
          dateFormatter.locale = Locale(identifier: "es_ES")
          dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
          let date = dateFormatter.date(from:section.name)

          let dateFormatterPrint = DateFormatter()
          dateFormatterPrint.locale = Locale(identifier: "es_ES")
          dateFormatterPrint.dateFormat = "yyyy"
          
          if ( dateFormatterPrint.string(from: date!) == title ){
            return index
          }
        }
        
        index += 1
      }
    }
    
    return 0
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
     return ((fetchedResultsController?.sections?[section])?.numberOfObjects ?? 0)
    
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      
    if let finished_on = (fetchedResultsController?.sections?[section])?.name , finished_on != "" {
 
      let dateFormatter = DateFormatter()
      dateFormatter.locale = Locale(identifier: "es_ES")
      dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
      let date = dateFormatter.date(from:finished_on)!
      
      let dateFormatterPrint = DateFormatter()
      dateFormatterPrint.locale = Locale(identifier: "es_ES")
      dateFormatterPrint.dateFormat = "d 'de' MMMM 'de' yyyy"
      
      return dateFormatterPrint.string(from: date)
    }
    return "No Leido"
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      if let title = self.tableView(tableView, titleForHeaderInSection: section), title != "" {
          return 25
      }
      else{
          return 0
      }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
      return 120
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookTableViewCell
    cell.selectionStyle = .none
    let book : Book? = self.fetchedResultsController?.object(at: IndexPath(row: indexPath.row, section: indexPath.section)) as! Book?
    
    if let book = book {
      cell.title.text = book.title
      
      if book.authors.count > 0 {
        let authorsnames = book.authors.compactMap({ ($0 as! Author).name })
        cell.author.text = authorsnames.joined(separator: ", ")
      }
      
      cell.readingState.text = book.reading_state
      
      cell.cosmosView.rating = book.rate
      
      if let bookImage = book.image {
        let url = URL(string: bookImage)
        cell.bookImage.kf.setImage(with: url, placeholder: UIImage(named:"no-img"))
      }
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
      return true
  }
  
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
      let delete = UITableViewRowAction(style: .destructive, title: "Borrar") { (action, indexPath) in
        
        let book : Book? = self.fetchedResultsController?.object(at: IndexPath(row: indexPath.row, section: indexPath.section)) as! Book?
        
        book?.mr_deleteEntity(in: NSManagedObjectContext.mr_default())
        
        self.save()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // Change `2.0` to the desired number of seconds.
          
          self.fetchData()
        }
      }

      return [delete]
  }
}

extension ViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let book : Book? = self.fetchedResultsController?.object(at: IndexPath(row: indexPath.row, section: indexPath.section)) as! Book?
    
    self.performSegue(withIdentifier: "EditBookSegue", sender: book)
    
  }
  
}
