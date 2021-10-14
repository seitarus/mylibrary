/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import CoreData
import Alamofire
import MagicalRecord
import Kingfisher
import SCLAlertView

class SearchBookViewController: UIViewController {

  @IBOutlet var tableView: UITableView!
  @IBOutlet var searchFooter: SearchFooter!
  @IBOutlet var searchFooterBottomConstraint: NSLayoutConstraint!
  
  var controller: ViewController? = nil
  
  var books: [Item] = []
  let searchController = UISearchController(searchResultsController: nil)
  var filteredBooks: [Item] = []
  
  
  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Buscador"
    
    tableView.register(UINib(nibName: "SearchBookCell", bundle: nil), forCellReuseIdentifier: "SearchBookCell")
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
    
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification,
                                   object: nil, queue: .main) { (notification) in
                                    self.handleKeyboard(notification: notification) }
    notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                   object: nil, queue: .main) { (notification) in
                                    self.handleKeyboard(notification: notification) }
  }
  
  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  var isFiltering: Bool {
    let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
    return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
  }
  
  func filterContentForSearchText(_ searchText: String ) {
    
    self.findBookInGoogle(term: searchText) { (bookResult) in
      
      if let result = bookResult {
        
        if result.totalItems > 0 {
          
          if let items = result.items {
            self.filteredBooks = items
            
            self.tableView.reloadData()
          }
        }
      }
    }
  }
  
  func handleKeyboard(notification: Notification) {
    // 1
    guard notification.name == UIResponder.keyboardWillChangeFrameNotification else {
      searchFooterBottomConstraint.constant = 0
      view.layoutIfNeeded()
      return
    }
    
    guard
      let info = notification.userInfo,
      let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
      else {
        return
    }
    
    // 2
    let keyboardHeight = keyboardFrame.cgRectValue.size.height
    UIView.animate(withDuration: 0.1, animations: { () -> Void in
      self.searchFooterBottomConstraint.constant = keyboardHeight
      self.view.layoutIfNeeded()
    })
  }


  func findBookInGoogle( term: String, completion: @escaping (BooksResponse?) -> Void) {
    
    let GOOGLE_KEY = "AIzaSyAiqVMaBK3Hklg0udMbKyYr66poAEGtNj4"
    
    let urlString = "https://www.googleapis.com/books/v1/volumes?q=" + term.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil) + "&key=" + GOOGLE_KEY
    
    Alamofire.request(urlString, method: .get, encoding: JSONEncoding.default)
                .responseJSON { response in
                    
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
  
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    self.title = ""
    
    if segue.identifier == "AddSearchedBookSegue" {
      
      let destinationVC = segue.destination as! AddBookViewController
      destinationVC.controller = controller
      
      if let book = sender as? Item {
        
        destinationVC.currentBook = book
      }
      
      title = "Buscador"
    
    }
  }
  
}



// MARK: - UITableViewDataSource
extension SearchBookViewController: UITableViewDataSource {
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    if isFiltering {
      searchFooter.setIsFilteringToShow(filteredItemCount:
        filteredBooks.count)
      return filteredBooks.count
    }
    
    searchFooter.setNotFiltering()
    return books.count
    
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
      return 120
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "SearchBookCell", for: indexPath) as! SearchBookTableViewCell
    cell.selectionStyle = .none
    let book: Item
    if isFiltering {
      book = filteredBooks[indexPath.row]
    } else {
      book = books[indexPath.row]
    }
    
    cell.title.text = book.volumeInfo.title
      
    if let authors = book.volumeInfo.authors, authors.count > 0 {
        cell.author.text = authors.joined(separator: ", ")
    }
      
    if let imageLinks = book.volumeInfo.imageLinks {
      let url = URL(string: imageLinks.thumbnail)
      cell.bookImage.kf.setImage(with: url, placeholder: UIImage(named:"no-img"))
    }
    
    return cell
  }
  
}

extension SearchBookViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let book: Item
    if isFiltering {
      book = filteredBooks[indexPath.row]
    } else {
      book = books[indexPath.row]
    }

    self.performSegue(withIdentifier: "AddSearchedBookSegue", sender: book)
    
  }
  
}

//extension SearchBookViewController: UISearchResultsUpdating {
////  func updateSearchResults(for searchController: UISearchController) {
////    let searchBar = searchController.searchBar
////
////    filterContentForSearchText(searchBar.text!)
////  }
//}

extension SearchBookViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    filterContentForSearchText(searchBar.text!)
  }
  
//  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//
//    filterContentForSearchText(searchBar.text!)
//  }
}
