//
//  ImageSearcherViewController.swift
//  Biblioteca
//
//  Created by Alejandro Prieto Beltrán on 18/01/2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import UIKit
import Alamofire

class SearchImageViewController: UIViewController {

  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet var searchFooter: SearchFooter!
  @IBOutlet var searchFooterBottomConstraint: NSLayoutConstraint!
  
  var books: [ImageResult] = []
  let searchController = UISearchController(searchResultsController: nil)
  var filteredBooks: [ImageResult] = []
  
  var completion: (_ imageUrl: String?) -> Void = {imageUrl in}
  
  fileprivate let reuseIdentifier = "ImageCell"
  
  override func viewDidLoad() {
    
    super.viewDidLoad()

    title = "Buscador de Imagen"
    
    let cancelButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(close))
    self.navigationItem.leftBarButtonItem = cancelButton
    
    collectionView?.register(UINib(nibName: "SearchImageCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    
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
    return searchController.isActive && !isSearchBarEmpty
  }
  
  func filterContentForSearchText(_ searchText: String ) {
    
    self.findBookInGoogle(term: searchText) { (response) in
      
      if let response = response {
        
        if response.imageResults.count > 0 {
          
            self.filteredBooks = response.imageResults
            
            self.collectionView?.reloadData()
          
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
  
  func findBookInGoogle( term: String, completion: @escaping (ImagesResponse?) -> Void) {
    
    let GOOGLE_KEY = "2AB4F7FBBFB74B828A917A2C8FF1E6EA"
    
    let urlString = "https://api.serpwow.com/live/search?api_key=" + GOOGLE_KEY + "&q=" + term.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil) + "&search_type=images"
    
    searchFooter.setIsFilteringToShow(filteredItemCount:-1)
    
    Alamofire.request(urlString, method: .get, encoding: JSONEncoding.default)
                .responseJSON { response in
                    
                if let _ = response.result.value {
                    //let JSON = result as! NSDictionary
                    //print(JSON)
                  do{
                    let images = try JSONDecoder().decode(ImagesResponse.self, from: response.data!)
                    print(images)
                    completion( images )
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
      
//      let destinationVC = segue.destination as! AddBookViewController
//
//      if let image = sender as? ImageResult {
//
//        destinationVC.currentBook = image
//      }
      
      title = "Buscador"
    
    }
  }
  
  @objc func close() {
   
    self.dismiss(animated: true, completion: nil)
  }
  
}

// MARK: - UICollectionViewDatasource
extension SearchImageViewController: UICollectionViewDataSource {
    
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    if isFiltering {
      searchFooter.setIsFilteringToShow(filteredItemCount:
        filteredBooks.count)
      return filteredBooks.count
//    }
//
//    searchFooter.setNotFiltering()
//    return books.count
    
  }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SearchImageCollectionViewCell

    let image: ImageResult
//    if isFiltering {
      image = filteredBooks[indexPath.row]
//    } else {
//      image = books[indexPath.row]
//    }
          
    //if let imageLink = image.image {
    let url = URL(string: image.image)
    cell.bookImage.kf.setImage(with: url, placeholder: UIImage(named:"no-img"))
    //}
    
    return cell
  }
  
}

extension SearchImageViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let image: ImageResult
//    if isFiltering {
      image = filteredBooks[indexPath.row]
//    } else {
//      image = books[indexPath.row]
//    }
    
    self.completion(image.image)
        
  }
}

// MARK: UICollectionViewDelegateFlowLayout
extension SearchImageViewController : UICollectionViewDelegateFlowLayout {
    
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
  
//    return CGSize(width: Int(collectionView.frame.width/3)-10, height: 150)
    return CGSize(width: 100, height: 150)
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 0
  }
}

  
extension SearchImageViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      filterContentForSearchText(searchBar.text!)
    }
    
}
