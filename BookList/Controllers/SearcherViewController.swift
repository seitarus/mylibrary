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

class SearcherViewController: UIViewController {

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
  
  let searchController = UISearchController(searchResultsController: nil)
  
  override func viewDidLoad() {
    
    super.viewDidLoad()

    title = "Mi Biblioteca"
    
    let cancelButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(close))
    self.navigationItem.leftBarButtonItem = cancelButton
    
    tableView.register(UINib(nibName: "BookCell", bundle: nil), forCellReuseIdentifier: "BookCell")
    tableView.separatorStyle = .none
    
    // 1
    //searchController.searchResultsUpdater = self
    // 2
    searchController.obscuresBackgroundDuringPresentation = false
    // 3
    searchController.searchBar.placeholder = "Buscar titulo o autor"
    // 4
    navigationItem.searchController = searchController
    // 5
    definesPresentationContext = true
    
    searchController.searchBar.delegate = self
    
  }

  override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
    
  }
  
  @objc func close() {
   
    self.dismiss(animated: true, completion: nil)
  }
  
  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  var isFiltering: Bool {
    let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
    return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
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
    
    self.fetchedResultsController = Book.mr_fetchAllSorted(by: "finished_on:0,added_at:0", ascending: false, with: nil, groupBy: nil, delegate: nil, in: NSManagedObjectContext.mr_default())
    
  }
  
  func filterContentForSearchText(_ searchText: String ) {
    
    let predicate = NSPredicate(format: "title CONTAINS[cd] %@ OR ANY authors.name CONTAINS[cd] %@", searchText, searchText)
    
    self.fetchedResultsController = Book.mr_fetchAllSorted(by: "finished_on:0,added_at:0", ascending: false, with: predicate, groupBy: nil, delegate: nil, in: NSManagedObjectContext.mr_default())
        
  }
  
}



// MARK: - UITableViewDataSource
extension SearcherViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
      
    return 1
    //return (fetchedResultsController?.sections!.count)!
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
    return fetchedResultsController?.fetchedObjects?.count ?? 0
    
//     return ((fetchedResultsController?.sections?[section])?.numberOfObjects ?? 0)
    
  }

//  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//    if let finished_on = (fetchedResultsController?.sections?[section])?.name , finished_on != "" {
//
//      let dateFormatter = DateFormatter()
//      dateFormatter.locale = Locale(identifier: "es_ES")
//      dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
//      let date = dateFormatter.date(from:finished_on)!
//
//      let dateFormatterPrint = DateFormatter()
//      dateFormatterPrint.locale = Locale(identifier: "es_ES")
//      dateFormatterPrint.dateFormat = "d 'de' MMMM 'de' yyyy"
//
//      return dateFormatterPrint.string(from: date)
//    }
//    return "No Leido"
//  }
  
//  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//      if let title = self.tableView(tableView, titleForHeaderInSection: section), title != "" {
//          return 25
//      }
//      else{
//          return 0
//      }
//  }
  
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
  
}

extension SearcherViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    filterContentForSearchText(searchBar.text!)
  }

}
