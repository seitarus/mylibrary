//
//  BookCell.swift
//  Biblioteca
//
//  Created by Alejandro Prieto Beltrán on 05/01/2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import Foundation
import UIKit

class SearchBookTableViewCell: UITableViewCell {

  @IBOutlet weak var bookImage: UIImageView!
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var author: UILabel!
  @IBOutlet weak var publisher: UILabel!
  
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
    publisher.text = ""
  }
}
