//
//  BookCell.swift
//  Biblioteca
//
//  Created by Alejandro Prieto Beltrán on 05/01/2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import Foundation
import UIKit
import Cosmos

class BookTableViewCell: UITableViewCell {

  @IBOutlet weak var bookImage: UIImageView!
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var author: UILabel!
  @IBOutlet weak var readingState: UILabel!
  @IBOutlet weak var cosmosView: CosmosView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setup()
  }
  
  override func prepareForReuse() {
    
    super.prepareForReuse()
    
    setup()
  }
  
  func setup()
  {
    bookImage.image = UIImage(named: "no-img")
    title.text = ""
    author.text = ""
    readingState.text = ""
    
    cosmosView.rating = 0.0
    
  }
}
